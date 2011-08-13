<?php

// This is a temporary script until RetroCMS is ready for upload.
// This is a bit (very) hackish, so bear with me. Not suitable for live hotels. Then again, this is just a development release...

@ob_start();
session_start();

function err($errstr = 'unknown') { @ob_end_clean(); die('<h1>Error</h1><hr />' . $errstr . '<hr /><i>Snowlight login/reg script</i>'); }

define('SQL_SERVER', 'localhost');
define('SQL_USER', 'root');
define('SQL_PASS', 'changeme');
define('SQL_DB', 'snowdb');

mysql_connect(SQL_SERVER, SQL_USER, SQL_PASS) or err(mysql_error());
mysql_select_db(SQL_DB) or err(mysql_error());

define('USER_I', isset($_SESSION['USER_I']) ? intval($_SESSION['USER_I']) : 0);
define('USER_H', isset($_SESSION['USER_H']) ? $_SESSION['USER_H'] : '');

if (USER_H == '' || USER_I <= 0)
{
	isset($_GET['reg']) ? outputRegister() : outputLogin();
	exit;
}

outputClient();

function outputLogin()
{
	echo '<h1>Login</h1><hr />';

	if (isset($_POST['usr']) && isset($_POST['pwd']))
	{
		$usr = mysql_real_escape_string($_POST['usr']);
		$pwd = sha1($_POST['pwd'] . $usr);
		
		if (strlen($usr) > 0 && strlen($_POST['pwd']) > 0)
		{
			$d = mysql_query('SELECT auth_ticket,id FROM characters WHERE username = "' . $usr . '" AND auth_ticket = "' . $pwd . '" LIMIT 1') or err(mysql_error());
			
			if (mysql_num_rows($d) > 0)
			{
				$data = mysql_fetch_assoc($d);
			
				$_SESSION['USER_H'] = $data['auth_ticket'];
				$_SESSION['USER_I'] = $data['id'];
				
				header('Location: index.php?lg');
				exit;
			}
			
			echo '<h2>Invalid username or password!</h2>';
		}
	}	
	
	echo '<form method="post">';
	echo 'Username:<br /><input type="text" name="usr" value=""><br /><br />';
	echo 'Password:<br /><input type="password" name="pwd" value=""><br /><br />';
	echo '<input type="submit" value="Log in">&nbsp;<input type="button" onclick="document.location = \'index.php?reg\';" value="Register">';
	echo '</form>';
}

function outputRegister()
{
	echo '<h1>Register</h1><hr />';

	if (isset($_POST['usr']) && isset($_POST['pwd']))
	{
		$usr = mysql_real_escape_string($_POST['usr']);
		$pwd = sha1($_POST['pwd'] . $usr);
		
		if (strlen($usr) > 0 && strlen($_POST['pwd']) > 0)
		{
			$q = mysql_query('SELECT null FROM characters WHERE username = "' . $usr . '"') or die(mysql_error());
			
			if (mysql_num_rows($q) != 0)
			{
				echo '<h2>That name is taken, sorry.</h2>';
			}
			else
			{
				mysql_query('INSERT INTO characters (username,auth_ticket,moderation_muted_until_timestamp) VALUES ("' . $usr . '","' . $pwd . '",0)') or die(err(mysql_error()));
				echo '<h2>Account created, <a href="index.php">log in here</a></h2>';
			}
		}
	}	
	
	echo '<form method="post">';
	echo 'Username:<br /><input type="text" name="usr" value=""><br /><br />';
	echo 'Password:<br /><input type="password" name="pwd" value=""><br /><br />';
	echo '<input type="checkbox"> Yes, I\'ll be good (not required)<br /><br />';
	echo '<input type="submit" value="Register!">&nbsp;<input type="button" onclick="document.location = \'index.php\';" value="Back to login">';
	echo '</form>';
}

function outputClient()
{
	mysql_query('UPDATE characters SET auth_ticket = "' . USER_H . '" WHERE id = ' . USER_I . ' LIMIT 1');

	echo '
<!doctype html>
<html lang="en" dir="ltr">
<head>
<title>A client</title>
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
            "connection.info.host" : "127.0.0.1", 
            "connection.info.port" : "38101", 
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
            "sso.ticket" : "' . USER_H . '", 
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
</head>
<body>
<div id="client"></div>
</body>
</html>';
}