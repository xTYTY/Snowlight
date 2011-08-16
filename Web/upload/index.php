<?php

// SNOWLIGHT WEB PORTAL - VERSION 2
// 
// This is a temporary script for development on Snowlight Emulator.
// It is not intended to run in live hotel mode, but although you can use it to show your latest progress to some friends - it's running stable...
// More information at   http://www.retrodev.org/forum/threads/web-dev-only-snowlight-web.824/

@ob_start();
session_start();

// MySQL database credentials
define('SQL_SERVER', 'localhost');
define('SQL_USER', 'root');
define('SQL_PASS', 'changeme');
define('SQL_DB', 'snowdb');

// Emulator credentials
define('EMU_IP', '127.0.0.1');
define('EMU_PORT', '38101');

function err($errstr = 'unknown') { @ob_end_clean(); die('<h1>Error</h1><hr />' . $errstr . '<hr /><i>Snowlight login/reg script</i>'); }

mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS) or err(mysql_error());
mysql_select_db(SQL_DB) or err(mysql_error());

?>

<!doctype html>
<!--[if lt IE 7 ]><html class="ie ie6" lang="en"> <![endif]-->
<!--[if IE 7 ]><html class="ie ie7" lang="en"> <![endif]-->
<!--[if IE 8 ]><html class="ie ie8" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!--> 	<html lang="en"> <!--<![endif]-->
<head>

	<!-- Basic Page Needs
  ================================================== -->
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	<!-- Force Latest IE rendering engine -->
	<title>Snowlight Emulator</title>
	<meta name="description" content="">
	<meta name="author" content="">
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	
	<!-- Mobile Specific Metas
  ================================================== -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" /> 
	
	<!-- CSS
  ================================================== -->
	<link rel="stylesheet" href="stylesheets/base.css">
	<link rel="stylesheet" href="stylesheets/skeleton.css">
	<link rel="stylesheet" href="stylesheets/layout.css">
	
	<!-- Favicons
	================================================== -->
	<link rel="shortcut icon" href="images/favicon.ico">
	<link rel="apple-touch-icon" href="images/apple-touch-icon.png">
	<link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png" />
	<link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png" />
	
</head>
<body>
	
<?php

if (!isset($_SESSION['USER_S']) || !isset($_SESSION['USER_I']) || $_SESSION['USER_S'] != true || $_SESSION['USER_I'] <= 0)
{
	isset($_GET['reg']) ? outputRegister() : outputLogin();
	exit;
}

if (isset($_POST['clt']))
{
	outputClient((int)$_POST['clt']);
	exit;
}
elseif (isset($_POST['cch']))
{
	outputCreateCharacter();
	exit;
}

isset($_GET['lgt']) ? outputLogout() : outputPortal();

function outputLogin()
{
	if (isset($_POST['usr']) && isset($_POST['pwd']))
	{
		$usr = mysql_real_escape_string($_POST['usr']);
		$pwd = sha1($_POST['pwd'] . $usr);
		
		if (strlen($usr) > 0 && strlen($_POST['pwd']) > 0)
		{
			$d = mysql_query('SELECT id FROM accounts WHERE username = "' . $usr . '" AND password = "' . $pwd . '" LIMIT 1') or err(mysql_error());
			
			if (mysql_num_rows($d) > 0)
			{
				$data = mysql_fetch_assoc($d);
				mysql_query('UPDATE accounts SET session = "' . SESSION_ID() . '" WHERE id = "' . $data['id'] . '"');
				$_SESSION['USER_S'] = true;
				$_SESSION['USER_I'] = $data['id'];
				
				header('Location: index.php');
				exit;
			}
			
			echo '<div class="notice"><p class="warn">Whoops! We didn\'t recognise your username or password. Please try again.</p></div>';
		}
	}	
	
	echo '<div class="container">';
	echo '<div class="form-bg"><form method="post">';
	echo '<h2>Snowlight Emulator</h2>';
	echo '<p><input type="text" name="usr" value="" placeholder="Username"></p>';
	echo '<p><input type="password" name="pwd" value="" placeholder="Password"></p>';
	echo '<button type="submit">Login</button>';
	echo '</form></div>';
	echo '<p class="forgot">Not registered yet? <a href="index.php?reg">Click here to create an account.</a></p>';
	echo '</div>';
}

function outputRegister()
{

	if (isset($_POST['usr']) && isset($_POST['pwd']))
	{
		$usr = mysql_real_escape_string($_POST['usr']);
		$pwd = sha1($_POST['pwd'] . $usr);
		
		if (strlen($usr) > 0 && strlen($_POST['pwd']) > 0)
		{
			$q = mysql_query('SELECT null FROM accounts WHERE username = "' . $usr . '"') or die(mysql_error());
			
			if (mysql_num_rows($q) != 0)
			{
				echo '<div class="notice"><p class="warn">That name is taken, sorry.</p></div>';
			}
			else
			{
				mysql_query('INSERT INTO accounts (username,password) VALUES ("' . $usr . '","' . $pwd . '")') or die(err(mysql_error()));
				echo '<div class="notice"><p class="warn">Successfully registered, <a href="index.php">click here to login.</a></p></div>';
			}
		}
	}	
	
	echo '<div class="container">';
	echo '<div class="form-bg"><form method="post">';
	echo '<h2>Snowlight Emulator</h2>';
	echo '<p><input type="text" name="usr" value="" placeholder="Username"></p>';
	echo '<p><input type="password" name="pwd" value="" placeholder="Password"></p>';
	echo '<label for="good"><input type="checkbox" id="good"><span>Yes, I\'ll be good (not required)</span></label>';
	echo '<button type="submit">Register</button>';
	echo '</form></div>';
	echo '<p class="forgot">Already registered? <a href="index.php">Back to the frontpage.</a></p>';
	echo '</div>';
}

function outputCreateCharacter()
{
	if (isset($_POST['usr']))
	{
		$usr = mysql_real_escape_string($_POST['usr']);
		
		if (strlen($usr) > 0)
		{
			$q = mysql_query('SELECT null FROM characters WHERE username = "' . $usr . '"') or die(mysql_error());
			
			if (mysql_num_rows($q) != 0)
			{
				echo '<div class="notice"><p class="warn">That name is taken, sorry.</p></div>';
			}
			else
			{
				mysql_query('INSERT INTO characters (account_uid,username,moderation_muted_until_timestamp) VALUES ("' . $_SESSION['USER_I'] . '","' . $usr . '",0)') or die(err(mysql_error()));
				echo '<div class="notice"><p class="warn">Successfully created, <a href="index.php">click here to go back.</a></p></div>';
			}
		}
	}	
	
	echo '<div class="container">';
	echo '<div class="form-bg" style="height: 179px"><form method="post" style="height: 170px">';
	echo '<h2>Snowlight Emulator</h2>';
	echo '<p><input type="text" name="usr" value="" placeholder="Username"></p>';
	echo '<button name="cch" type="submit">Create Character</button>';
	echo '</form></div>';
	echo '<p class="forgot">Don\'t want to create a character? <a href="index.php">Back to the portal.</a></p>';
	echo '</div>';
}

function outputLogout()
{
	mysql_query('UPDATE accounts SET session = "" WHERE id = "' . $_SESSION['USER_I'] . '" AND session = "' . SESSION_ID() . '"');
	unset($_SESSION['USER_S']);
	unset($_SESSION['USER_I']);
	unset($_SESSION);
	session_unset();
	
	echo '<div class="notice"><p class="warn">You just logged out. <a href="index.php">Back to the frontpage.</a></p></div>';
}

function outputPortal()
{
	$div_height = mysql_num_rows(mysql_query('SELECT id FROM characters WHERE account_uid = "' . $_SESSION['USER_I'] . '"')) * 48 + 149;
	$frm_height = mysql_num_rows(mysql_query('SELECT id FROM characters WHERE account_uid = "' . $_SESSION['USER_I'] . '"')) * 48 + 140;
	$c = mysql_query('SELECT id, username FROM characters WHERE account_uid = "' . $_SESSION['USER_I'] . '"');
	if(mysql_num_rows($c) == 0) { $div_height += 40; $frm_height += 40; }
	
	echo '<div class="container">';
	echo '<div class="form-bg" style="height: ' . $div_height . 'px"><form method="post" style="height: ' . $frm_height . 'px">';
	echo '<h2>Snowlight Emulator</h2>';
	
	if (mysql_num_rows($c) > 0) {
		echo '<table width="100%">';
		while($character = mysql_fetch_assoc($c))
		{
			echo '<tr>';
			echo '<td style="vertical-align: top; padding-left: 25px">' . $character['username'] . '</td>';
			echo '<td><button name="clt" value="' . $character['id'] . '" type="submit">Enter Hotel</button></td>';
			echo '</tr>';
		}
		echo '</table>';
	}
	else
	{
		echo '<p style="padding-left: 25px">It seems you don\'t have any characters, yet.</p>';
	}
	
	echo '<br /><button name="cch" type="submit">Create Character</button>';
	echo '</form>';
	echo '</div>';
	echo '<p class="forgot">Done with everything? <a href="index.php?lgt">Click here to logout.</a></p>';
	echo '</div>';
}

function outputClient($character)
{
	define('SSO_TICKET', sha1(rand(1000, 9999) . $_SESSION['USER_I']));
	mysql_query('UPDATE characters SET auth_ticket = "' . SSO_TICKET . '" WHERE id = ' . $character . ' AND account_uid = ' . $_SESSION['USER_I'] . ' LIMIT 1') or err(mysql_error());

	echo '
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
<style type="text/css">
* { margin: 0; padding: 0; }
html, #client { height: 100%; text-align: left; background-color: black; }
#client { position: absolute; overflow: hidden; left: 0; top: 0; right: 0; bottom: 0; }
</style>
<script type="text/javascript">

	var BaseUrl = "http://cdn.uber.meth0d.org/localgordon";

    var flashvars =
	{
            "client.starting" : "Welcome to uberHotel BETA! Now loading.", 
            "client.allow.cross.domain" : "1", 
            "client.notify.cross.domain" : "0", 
            "connection.info.host" : "' . EMU_IP . '", 
            "connection.info.port" : "' . EMU_PORT . '", 
            "site.url" : "http://www.uberhotel.org", 
            "url.prefix" : "http://www.uberhotel.org", 
            "client.reload.url" : "http://www.uberhotel.org/index.php?page=client", 
            "client.fatal.error.url" : "http://www.uberhotel.org/index.php?page=client-error", 
            "client.connection.failed.url" : "http://www.uberhotel.org/index.php?page=client-disconnected", 
            "external.variables.txt" : "http://cdn.uber.meth0d.org/gamedata/external_variables", 
            "external.texts.txt" : "http://cdn.uber.meth0d.org/gamedata/external_flash_texts", 
            "external.override.texts.txt" : "http://www.uberhotel.org/extoverride.php", 
            "external.override.variables.txt" : "http://cdn.uber.meth0d.org/gamedata/external_override_variables", 
            "productdata.load.url" : "http://cdn.uber.meth0d.org/gamedata/productdata", 
            "furnidata.load.url" : "http://cdn.uber.meth0d.org/gamedata/furnidata", 
            "use.sso.ticket" : "1", 
            "sso.ticket" : "' . SSO_TICKET . '", 
            "processlog.enabled" : "0", 
            "flash.client.url" : BaseUrl, 
            "flash.client.origin" : "popup" 
    };

    var params =
	{
        "base" : BaseUrl + "/",
        "allowScriptAccess" : "always",
        "menu" : "false"                
    };
	
	swfobject.embedSWF(BaseUrl + "/Uber.swf", "client", "100%", "100%", "10.0.0", "http://cdn.uber.meth0d.org/expressInstall.swf", flashvars, params, null);	

</script>
<div id="client"></div>';
}

?>
	</div><!-- container -->

	<!-- JS
	================================================== -->
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.js"></script>
	<script>window.jQuery || document.write("<script src='javascripts/jquery-1.5.1.min.js'>\x3C/script>")</script>
	<script src="javascripts/app.js"></script>
	
<!-- End Document
================================================== -->
</body>
</html>