/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50510
Source Host           : localhost:3306
Source Database       : snowdb

Target Server Type    : MYSQL
Target Server Version : 50510
File Encoding         : 65001

Date: 2011-08-12 14:39:44
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `achievements`
-- ----------------------------
DROP TABLE IF EXISTS `achievements`;
CREATE TABLE `achievements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(64) NOT NULL DEFAULT 'ACH_',
  `category` varchar(255) NOT NULL DEFAULT 'identity',
  `level` int(11) NOT NULL DEFAULT '1',
  `reward_pixels` int(11) NOT NULL DEFAULT '100',
  `reward_points` int(11) DEFAULT '10',
  `progress_needed` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of achievements
-- ----------------------------
INSERT INTO `achievements` VALUES ('1', 'ACH_AvatarTags', 'identity', '1', '5', '5', '5');
INSERT INTO `achievements` VALUES ('2', 'ACH_AvatarLooks', 'identity', '1', '5', '5', '1');
INSERT INTO `achievements` VALUES ('3', 'ACH_Motto', 'identity', '1', '10', '10', '1');
INSERT INTO `achievements` VALUES ('4', 'ACH_EmailVerification', 'identity', '1', '20', '20', '1');
INSERT INTO `achievements` VALUES ('5', 'ACH_RespectGiven', 'social', '1', '100', '100', '100');
INSERT INTO `achievements` VALUES ('6', 'ACH_BasicClub', 'identity', '1', '25', '25', '1');
INSERT INTO `achievements` VALUES ('7', 'ACH_VipClub', 'identity', '1', '50', '50', '1');
INSERT INTO `achievements` VALUES ('8', 'ACH_BasicClub', 'identity', '2', '100', '100', '3');
INSERT INTO `achievements` VALUES ('9', 'ACH_BasicClub', 'identity', '3', '250', '250', '6');
INSERT INTO `achievements` VALUES ('10', 'ACH_BasicClub', 'identity', '4', '350', '350', '9');
INSERT INTO `achievements` VALUES ('11', 'ACH_BasicClub', 'identity', '5', '500', '500', '12');
INSERT INTO `achievements` VALUES ('12', 'ACH_VipClub', 'identity', '2', '200', '200', '3');
INSERT INTO `achievements` VALUES ('13', 'ACH_VipClub', 'identity', '3', '500', '500', '6');
INSERT INTO `achievements` VALUES ('14', 'ACH_VipClub', 'identity', '4', '700', '700', '9');
INSERT INTO `achievements` VALUES ('15', 'ACH_VipClub', 'identity', '5', '1000', '1000', '12');
INSERT INTO `achievements` VALUES ('16', 'ACH_RespectEarned', 'social', '1', '5', '5', '1');
INSERT INTO `achievements` VALUES ('17', 'ACH_RespectEarned', 'social', '2', '20', '20', '10');
INSERT INTO `achievements` VALUES ('18', 'ACH_RespectEarned', 'social', '3', '40', '40', '20');
INSERT INTO `achievements` VALUES ('19', 'ACH_RespectEarned', 'social', '4', '100', '100', '50');
INSERT INTO `achievements` VALUES ('20', 'ACH_RespectEarned', 'social', '5', '200', '200', '100');
INSERT INTO `achievements` VALUES ('21', 'ACH_RespectEarned', 'social', '6', '500', '500', '250');
INSERT INTO `achievements` VALUES ('22', 'ACH_RespectEarned', 'social', '7', '1000', '1000', '500');
INSERT INTO `achievements` VALUES ('23', 'ACH_RespectEarned', 'social', '8', '1300', '1300', '750');
INSERT INTO `achievements` VALUES ('24', 'ACH_RespectEarned', 'social', '9', '2000', '2000', '1000');
INSERT INTO `achievements` VALUES ('25', 'ACH_RespectEarned', 'social', '10', '3000', '3000', '1500');

-- ----------------------------
-- Table structure for `avatar_effects`
-- ----------------------------
DROP TABLE IF EXISTS `avatar_effects`;
CREATE TABLE `avatar_effects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `sprite_id` int(11) NOT NULL DEFAULT '0',
  `duration` double NOT NULL DEFAULT '3600',
  `activated` enum('0','1') NOT NULL DEFAULT '0',
  `timestamp_activated` double NOT NULL DEFAULT '0',
  `quantity` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of avatar_effects
-- ----------------------------

-- ----------------------------
-- Table structure for `badges`
-- ----------------------------
DROP TABLE IF EXISTS `badges`;
CREATE TABLE `badges` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `badge_id` int(10) unsigned NOT NULL DEFAULT '0',
  `source_type` enum('achievement','static') NOT NULL DEFAULT 'static',
  `source_data` varchar(64) NOT NULL,
  `slot_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of badges
-- ----------------------------
INSERT INTO `badges` VALUES ('1', '1', '11', 'static', '', '0');

-- ----------------------------
-- Table structure for `badge_definitions`
-- ----------------------------
DROP TABLE IF EXISTS `badge_definitions`;
CREATE TABLE `badge_definitions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `rights_sets` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of badge_definitions
-- ----------------------------
INSERT INTO `badge_definitions` VALUES ('1', 'ACH_BasicClub1', '10');
INSERT INTO `badge_definitions` VALUES ('2', 'ACH_BasicClub2', '10');
INSERT INTO `badge_definitions` VALUES ('3', 'ACH_BasicClub3', '10');
INSERT INTO `badge_definitions` VALUES ('4', 'ACH_BasicClub4', '10');
INSERT INTO `badge_definitions` VALUES ('5', 'ACH_BasicClub5', '10');
INSERT INTO `badge_definitions` VALUES ('6', 'ACH_VipClub1', '20');
INSERT INTO `badge_definitions` VALUES ('7', 'ACH_VipClub2', '20');
INSERT INTO `badge_definitions` VALUES ('8', 'ACH_VipClub3', '20');
INSERT INTO `badge_definitions` VALUES ('9', 'ACH_VipClub4', '20');
INSERT INTO `badge_definitions` VALUES ('10', 'ACH_VipClub5', '20');
INSERT INTO `badge_definitions` VALUES ('11', 'ADM', '10,20,50,100,200');
INSERT INTO `badge_definitions` VALUES ('12', 'HBA', '10,20,50,100,200');
INSERT INTO `badge_definitions` VALUES ('13', 'NWB', '10,20,50,100');
INSERT INTO `badge_definitions` VALUES ('14', 'VIP', '10,20,50');
INSERT INTO `badge_definitions` VALUES ('15', 'XXX', '50');
INSERT INTO `badge_definitions` VALUES ('16', 'ACH_EmailVerification1', '');
INSERT INTO `badge_definitions` VALUES ('17', 'ACH_Motto1', '');
INSERT INTO `badge_definitions` VALUES ('18', 'ACH_AvatarLooks1', '');
INSERT INTO `badge_definitions` VALUES ('19', 'ACH_AvatarTags1', '');
INSERT INTO `badge_definitions` VALUES ('20', 'ACH_RespectGiven1', '');
INSERT INTO `badge_definitions` VALUES ('21', 'NL087', '');
INSERT INTO `badge_definitions` VALUES ('22', 'CAA', '');
INSERT INTO `badge_definitions` VALUES ('23', 'ACH_RespectEarned1', '');
INSERT INTO `badge_definitions` VALUES ('24', 'ACH_RespectEarned2', '');
INSERT INTO `badge_definitions` VALUES ('25', 'ACH_RespectEarned3', '');
INSERT INTO `badge_definitions` VALUES ('26', 'ACH_RespectEarned4', '');
INSERT INTO `badge_definitions` VALUES ('27', 'ACH_RespectEarned5', '');
INSERT INTO `badge_definitions` VALUES ('28', 'ACH_RespectEarned6', '');
INSERT INTO `badge_definitions` VALUES ('29', 'ACH_RespectEarned7', '');
INSERT INTO `badge_definitions` VALUES ('30', 'ACH_RespectEarned8', '');
INSERT INTO `badge_definitions` VALUES ('31', 'ACH_RespectEarned9', '');
INSERT INTO `badge_definitions` VALUES ('32', 'ACH_RespectEarned10', '');
INSERT INTO `badge_definitions` VALUES ('33', 'Z63', '');

-- ----------------------------
-- Table structure for `bans`
-- ----------------------------
DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `remote_address` varchar(64) NOT NULL DEFAULT '',
  `timestamp_created` double NOT NULL DEFAULT '0',
  `timestamp_expire` double NOT NULL DEFAULT '0',
  `moderator_id` int(10) unsigned NOT NULL DEFAULT '0',
  `reason_text` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bans
-- ----------------------------

-- ----------------------------
-- Table structure for `bots`
-- ----------------------------
DROP TABLE IF EXISTS `bots`;
CREATE TABLE `bots` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ai_type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `look` varchar(255) NOT NULL,
  `motto` varchar(255) NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  `pos_start` varchar(16) NOT NULL DEFAULT '0|0|0',
  `pos_serve` varchar(16) NOT NULL DEFAULT '0|0|0',
  `pos_defined_range` text NOT NULL,
  `walk_mode` enum('stand','defined','freeroam') NOT NULL DEFAULT 'stand',
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  `kickable` enum('0','1') NOT NULL DEFAULT '1',
  `rotation` int(11) NOT NULL DEFAULT '-1',
  `effect` int(11) NOT NULL DEFAULT '0',
  `response_distance` int(11) NOT NULL DEFAULT '5',
  `pet_type_handler_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bots
-- ----------------------------
INSERT INTO `bots` VALUES ('1', 'pet', 'Dragon', '', '', '0', '0|0|0', '0|0|0', ' ', 'freeroam', '1', '1', '-1', '0', '500', '12');
INSERT INTO `bots` VALUES ('2', 'pet', 'other', ' ', ' ', '0', '0|0|0', '0|0|0', ' ', 'freeroam', '1', '1', '-1', '0', '500', '11');

-- ----------------------------
-- Table structure for `bots_speech`
-- ----------------------------
DROP TABLE IF EXISTS `bots_speech`;
CREATE TABLE `bots_speech` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bot_id` int(10) unsigned NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bots_speech
-- ----------------------------

-- ----------------------------
-- Table structure for `bot_responses`
-- ----------------------------
DROP TABLE IF EXISTS `bot_responses`;
CREATE TABLE `bot_responses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bot_id` int(10) unsigned NOT NULL DEFAULT '0',
  `triggers` text NOT NULL,
  `responses` text NOT NULL,
  `response_serve_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of bot_responses
-- ----------------------------

-- ----------------------------
-- Table structure for `catalog`
-- ----------------------------
DROP TABLE IF EXISTS `catalog`;
CREATE TABLE `catalog` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) NOT NULL DEFAULT '0',
  `order_num` int(11) NOT NULL DEFAULT '1',
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  `title` varchar(64) NOT NULL DEFAULT '',
  `icon` int(11) NOT NULL DEFAULT '0',
  `color` int(11) NOT NULL DEFAULT '0',
  `required_right` varchar(64) NOT NULL DEFAULT '',
  `visible` enum('0','1') NOT NULL DEFAULT '1',
  `dummy_page` enum('0','1') NOT NULL DEFAULT '0',
  `template` varchar(32) NOT NULL DEFAULT 'default_3x3',
  `page_strings_1` text COMMENT 'Delimiter: |',
  `page_strings_2` text COMMENT 'Delimiter: |',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of catalog
-- ----------------------------
INSERT INTO `catalog` VALUES ('1', '-1', '1', '1', 'Frontpage', '1', '0', '', '1', '0', 'frontpage3', 'catalog_frontpage_headline2_en|buildhotel.png?|', 'uberHotel BETA |Welcome to uberHotel - powered by Snowlight.|See our opening furniture|uberHotel Economy|The main currency in uberHotel is called pixels - these can be earnt through quests, competitions and just being online. You can buy most furniture with pixels, or you can exchange your pixels into credits to buy more exclusive  and limited edition furniture.  You can exchange pixels for credits under the \'Pixel Specials\' tab.|Redeem a voucher code here:|Limited Edition|#FEFEFE|#FEFEFE|Click here for information  >>|http://uberhotel.org/');
INSERT INTO `catalog` VALUES ('2', '-1', '4', '1', 'Pixel Furniture', '5', '5', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('3', '-1', '5', '1', 'Credit Furniture', '69', '5', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('5', '-1', '6', '1', 'Staff Furniture', '31', '5', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('6', '-1', '3', '1', 'Uber Club', '75', '4', '', '1', '0', 'club_buy', 'hc2_clubtitle', '');
INSERT INTO `catalog` VALUES ('7', '6', '1', '1', 'Club Shop', '75', '0', '', '1', '0', 'default_3x3', 'hc2_clubtitle|catalog_hc_teaser|catalog_special_txtbg2', 'As a member of Habbo Club or VIP, you can shop from this selection of exclusive items. Every now and then we will also be adding items that are currently unavailable in the regular Furni Shop as well!|Click on an item for details.|For Club members only!');
INSERT INTO `catalog` VALUES ('8', '2', '2', '1', 'Windows', '63', '0', '', '1', '0', 'default_3x3', 'ctlg_windows_headline1_en|ctlg_windows_teaser1_en', 'Let the sunshine in with one of our many window designs and give your room a unique, new feel. Don\'t forget to watch out for the window cleaner every Tuesday! I heard he\'s cheating on your Mum.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('9', '2', '3', '1', 'Teleporters', '58', '0', '', '1', '0', 'default_3x3', 'catalog_doors_headline1|catalog_door_a', 'A different dimension? Another world? A new universe? ...or maybe just to the other side of the room! You can do it all with our range of teleporters. When trading, make sure you get a linking pair!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('10', '3', '6', '1', 'Summer', '57', '0', '', '1', '0', 'default_3x3', 'catalog_limited_headline1_en|catalog_sum_teaser1', 'Are you a paddler, a swimmer or do you just like lazing on the side? It doesn\'t matter with this summer range because you can do it all from your very own room! Don\'t forget your sunscreen...|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('11', '3', '9', '1', 'Executive', '27', '0', '', '1', '0', 'default_3x3', 'catalog_exe_headline1_en|catalog_exe_teaser1_en', 'Looking for a professional, sophisticated working environment? You have arrived at the right page, sir. With our sleek range of real-leather furniture you can impress all of your customers and colleagues. Receptionist not included.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('12', '2', '8', '1', 'Lodge', '37', '0', '', '1', '0', 'default_3x3', 'catalog_lodge_headline1|catalog_lodge_teaser1', 'For that time-honoured cabin effect, try Lodge. This collection is perfect for those with a no-frills, no-spills attitude to décor. Come and appreciate the natural beauty of wood in all its splintered glory.|Click on an item for more details.\r\n');
INSERT INTO `catalog` VALUES ('13', '2', '4', '1', 'Mode', '39', '0', '', '1', '0', 'default_3x3', 'catalog_mode_headline1|catalog_mode_teaser1', 'Steely, cold and really quite uncomfortable. With so many colour choices Mode is no longer limited for use in the morgue! Although, after a nights sleep you sure can tell that’s where the beds came from.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('15', '2', '12', '1', 'Plants', '45', '0', '', '1', '0', 'default_3x3', 'catalog_plants_headline1|catalog_plants_teaser1', 'One of the most multifunctional ranges available – perhaps you need a hedge to divide your room? Or maybe a rose to brighten your day? Let\'s fight global warming together, buy a Vase of Flowers.|Click on an item for more details..');
INSERT INTO `catalog` VALUES ('16', '2', '9', '1', 'Plastic', '46', '0', '', '1', '0', 'plasto', 'catalog_plasto_headline1', 'Bring some colour into your puny, insignificant life (or not if you choose brown..) with our retro range of 70\'s furniture. Pick the piece you want and your favourite colour and you\'re ready to feel the vibes.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('17', '2', '10', '1', 'Bathroom', '17', '0', '', '1', '0', 'default_3x3', 'catalog_bath_headline1|catalog_bath_teaser1', 'Dedicate an area for you and your guests to perform your morning ablutions – couple this furniture range with \'Relax\' and you\'ll have a calm, modern and hygienic bathroom ready for.. well.. y\'know.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('18', '2', '11', '1', 'Kitchen', '43', '0', '', '1', '0', 'default_3x3', 'kitchen_header_en|kitchen_teaser_en', 'When the noodles hit the fan, you know what range to choose. Perfect for amateur cooks and professional chefs alike, we have everything you could want in your kitchen all under one roof. Don\'t worry, we\'ve got your splash-back covered.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('19', '2', '17', '1', 'Accessories', '11', '0', '', '1', '0', 'default_3x3', 'catalog_extra_headline1|catalog_extra_teaser1', 'However you place your prized possessions, it\'s the little bits that make the difference.  So, to make a difference, buy the little bits right here!|Click on an item for details.');
INSERT INTO `catalog` VALUES ('20', '2', '15', '1', 'Trophies', '60', '0', '', '1', '0', 'trophies', 'catalog_trophies_headline1', 'Are you a winner or just a little bit special? Buy yourself a trophy to reward your efforts! Whether you want gold, silver or bronze – it doesn\'t matter – we have every trophy in every metal!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('21', '2', '16', '1', 'Rollers (Coming Soon)', '96', '0', '', '1', '0', 'default_3x3', 'catalog_roller_headline1|catalog_teaser_rollers_en', 'Rollers make the world go round, literally. For queues, game or businesses we have the right colour choices for you! Rollers are also available in multipacks for discount prices! |Click on an item for more details.');
INSERT INTO `catalog` VALUES ('22', '2', '14', '1', 'Gallery', '47', '0', '', '1', '0', 'default_3x3', 'catalog_gallery_headline1\r\n', 'From Bonnie Blonde to the Queen Mother, we\'ve got every famous celebrity poster to complement our collection of scenery and other items of wall paraphernalia.|Click on an item for more information.');
INSERT INTO `catalog` VALUES ('23', '2', '13', '1', 'Rugs', '52', '0', '', '1', '0', 'default_3x3', 'catalog_rugs_headline1|catalog_rugs_teaser1', 'Remember that rug your Grandma used to have? Yeah, well, we\'re not on about that one you dirty pervert. All our rugs are non-slip, washable and totally lice free! Buy yours today while they\'re still soft and snuggly.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('27', '-1', '6', '1', 'Pixel Specials', '44', '3', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('28', '-1', '100', '1', 'Ecotron', '7', '3', '', '1', '0', 'default_3x3', ' ', '');
INSERT INTO `catalog` VALUES ('29', '-1', '8', '1', 'Games ', '87', '3', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('30', '27', '6', '1', 'Exchange', '6', '5', '', '1', '0', 'default_3x3', 'catalog_bank_headline1|catalog_bank_teaser', 'Exchange is where you can convert your Credits into a tradable currency. You can then use this currency to trade for Furni or just show off your riches in your room.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('31', '28', '1', '1', 'Ecotron', '26', '3', '', '1', '0', 'recycler', 'catalog_recycler_headline3|ctlg_ecotron_image', 'Had enough of an old bit of furniture but don\'t want to just trade it away? Get something more exciting and unique by placing 5 pieces of your old furniture in here. In return, you\'ll recieve a brand new piece of furniture!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('32', '28', '2', '1', 'Rewards', '71', '0', '', '1', '0', 'recycler_prizes', 'catalog_recycler_headline3', 'These are the current rewards you can recieve for recycling furniture in the Ecotron. \r\n');
INSERT INTO `catalog` VALUES ('34', '2', '8', '1', 'Hello', '35', '0', '', '1', '0', 'default_3x3', 'catalog_hello_header1_en|catalog_hello_teaser1_en', 'This our exclusive noob range - only buyable with pixels. Want a bad quality, trashly, newbie looking room? You my friend, have come to the right place. Fill your room with these pieces for that authentic new user look!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('35', '27', '3', '1', 'Rentals', '51', '0', '', '1', '0', 'default_3x3', 'catalog_pixelrent_headline1_en', 'Suprise your guests with one of our exciting effects you can rent for you very own room! With pixels, you can rent an effect for an hour (perfect for a party!) and it will automatically disappear when the time is up. Magic, and oh so very simple!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('36', '27', '4', '1', 'Special Effects', '61', '0', '', '1', '0', 'default_3x3', 'catalog_pixeleffects_headline1_en', 'Want to go rollerskating, hoverboarding or glow bright green? We can make your dreams come true with our amazingly noobish effects! Buy one here and enable it on your effects menu. |Click on an item for more details.');
INSERT INTO `catalog` VALUES ('37', '2', '14', '1', 'Automobiles', '16', '0', '', '1', '0', 'default_3x3', 'catalog_automobile_header1_en|catalog_automobile_teaser1_en', 'Build your own race track, motorway or giant carpark (just like the M25!) with the Automobile range. We have every sign, traffic cone and traffic light we could steal from the Highways Agency!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('38', '-1', '100', '1', 'Marketplace', '69', '3', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('39', '-1', '9', '1', 'Wired', '80', '3', '', '1', '0', 'default_3x3', '', '');
INSERT INTO `catalog` VALUES ('40', '39', '1', '1', 'Triggers (Coming Soon)', '81', '0', '', '1', '0', 'default_3x3', 'catalog_wired_header2_en', 'Triggers let you define what needs to happen for an Effect to take place. To program a Trigger, place it in a room, double click on it and set it up! You need to stack an Effect with the Trigger to make it work. Click on an item to see how the Trigger works!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('41', '39', '2', '1', 'Effects (Coming Soon)', '82', '0', '', '1', '0', 'default_3x3', 'catalog_wired_header3_en', ' Effects are what happens after you activate a Trigger. To program an Effect, place it in your room, double click on it and set it up! You will always need to stack a Trigger with the Effect to make it work.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('42', '39', '3', '1', 'Conditions (Coming Soon)', '83', '0', '', '1', '0', 'default_3x3', 'catalog_wired_header4_en', ' Conditions are specific things that need to be done before a Trigger will work. If you want to use a Condition, you will need to stack it with a Trigger and Effect.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('43', '39', '4', '1', 'Add-Ons (Coming Soon)', '85', '0', '', '1', '0', 'default_3x3', 'catalog_wired_header5_en', 'Use these simple Furni to bring extra spice to your Wired room. These are basic Furni, so you will still need Triggers, Effects and Conditions to make them work!|Click on an item for more details.|Use Triggers, Effects and Conditions to make these Furni work!');
INSERT INTO `catalog` VALUES ('44', '29', '2', '1', 'Ice Tag (Coming Soon)', '88', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'The fun is ON with our new game! Skate on ice and play Tag with your friends using the new Tag Pole and Ice Skating Patch! Not sure how to put on your skates? Step on an Ice Patch and you\'re good to go.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('45', '29', '1', '1', 'Roller Skating', '94', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'Show off your tricks on the rink, get your derby going or just invite your friends to a good ol\' roller party! PS. the rink looks great when dressed up with some Neon or Diner Furni!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('46', '29', '3', '1', 'Freeze! (Coming Soon)', '87', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', ' Freeze!.. and try the newest game to hit Habbo! Team up and plant snowball bombs to snap freeze your competitors. You could say it\'s so cool, it\'s frozen ;)|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('47', '29', '4', '1', 'Battle Banzai (Coming Soon)', '78', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'Bigger, Better, Bouncier - it\'s Battle Banzai! Now YOU set the rules for your own game, in your own room. You got the Banzai Power!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('48', '29', '5', '1', 'Uber Ball (Coming Soon)', '56', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en|football_teaser', 'Whether you call it soccer, football or futbol... you can enjoy the game right here in Habbo! Get a ball and kick it, bounce it, pass it, control it and steal it!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('49', '38', '0', '1', 'Offers (Coming Soon)', '70', '0', '', '1', '0', 'default_3x3', 'catalog_marketplace_header_en', 'This page lists all the current offers of furniture people are selling on the hotel. Anything you like the look of?|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('50', '38', '0', '1', 'My Sales (Coming Soon)', '71', '0', '', '1', '0', 'default_3x3', 'catalog_marketplace_header_en', 'This is a list of all the items you are currently selling on The Marketplace. |Click on an item for more details.');
INSERT INTO `catalog` VALUES ('60', '2', '1', '1', 'Look & Feel', '55', '0', '', '1', '0', 'spaces_new', 'look_feel_text', 'Floors, wallpapers, landscapes - get a groovy combination for your room. Use our virtual room preview below to test out the combinations before you buy. Select the design and color you like and click buy.');
INSERT INTO `catalog` VALUES ('61', '3', '999', '1', 'Valentines', '62', '0', '', '1', '0', 'default_3x3', 'catalog_love_headline1|catalog_love_teaser1', 'Love is in the air, love for the Valentines range that is! We have every essential item you\'ll need to make it feel like you actually have someone to love you. No more pretending to be a lonely geek - you can have a pixel love heart, love sofa or even love stickies - yay!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('62', '3', '3', '1', 'Bling', '64', '0', '', '1', '0', 'default_3x3', 'catalog_limited_headline1|catalog_limited_teaser1', 'Wanna be de big Daddy and live in a luxxxury penthouse suite? Yeah well, we all know that won\'t happen. bubble burst. How about you use some items from this range (if you can even afford them) to dress up your puny council flat instead?|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('63', '3', '999', '1', 'Easter', '25', '0', '', '1', '0', 'default_3x3', 'catalog_easter_headline1|catalog_easter_teaser1', 'Like chocolate? You\'ll love Easter. The Easter bunny is right here awaiting his time to shine and deliver some eggy goodness. If you can\'t wait, why dont you buy some sneaky Easter eggs anyway? I won\'t tell if you don\'t!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('64', '3', '7', '1', 'Flower Power', '73', '0', '', '1', '0', 'default_3x3', 'catalog_flowerpower_header_en|garden_teaser_en', 'Funny flowers at the ready people! These flowers may not look very good but atleast they smell like flowers... kinda... I wouldn\'t give these to your girlfriends, they might just eat her! (unless that\'s what you wanted, ofcourse...) |Click on an item for more details.');
INSERT INTO `catalog` VALUES ('65', '3', '999', '1', 'Halloween', '34', '0', '', '1', '0', 'default_3x3', 'catalog_halloween_headline1|catalog_halloween_teaser', 'Spooky... whohohohhoooooo. If you couldn\'t tell, that was my ghost impression. We all know ghouls, ghosts and vampies aren\'t real but for all the free sweets, is it not worth pretending for just one night?|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('66', '3', '999', '1', 'Virus', '42', '0', '', '1', '0', 'default_3x3', 'catalog_halloween_headline1', 'Popular to contrary belief, there was really no \"special epidemic\" going around and this furniture is really no different. This is just normal NHS standard equiptment! If your looking for something cleaner, go to the private ward and visit the \'Hospital\' page. |Click on an item for more details.');
INSERT INTO `catalog` VALUES ('67', '3', '999', '1', 'Voodoo', '79', '0', '', '1', '0', 'default_3x3', 'catalog_voodoo_header_en|catalog_voodoo_teaser', 'Have you always wondered about that strange man down the road who practices those suspicous rituals? or maybe that woman across the street who dances around her backgarden with a totem pole? Well, atleast you have some furniture to buy them for their next Birthday now.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('68', '3', '999', '1', 'Christmas', '64', '0', '', '1', '0', 'default_3x3', 'catalog_xmas_headline2_en', 'Ho, ho ho! Merry Christmas! With the Christmas range your room can have that festive feel 24/7, baby! We\'ve got everything for that authentic Christmas spirit - lights, trees and reindeer poo!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('69', '3', '1', '1', 'Celebration', '91', '0', '', '1', '0', 'default_3x3', 'catalog_limited_headline1|catalog_limited_teaser1', 'Throw a party, have a bash, join in the celebration! You can even buy some fantastic fireworks for special occassions, parties or just for lulz! Snowlight accepts no responsibilty for accidents caused by the misure of virtual fireworks.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('70', '3', '16', '1', 'Diner', '72', '0', '', '1', '0', 'default_3x3', 'catalog_diner_header_en|catalog_diner_teaser_en', 'Design your own 50\'s Diner with this restaurant range in every single colour you could think of! This collection also features many timeless (and tasteless...) dishes for that real greasy spooon atmosphere.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('71', '3', '13', '1', 'Grunge', '32', '0', '', '1', '0', 'default_3x3', 'catalog_grunge_headline1|catalog_grunge_teaser', 'Homeless, a tramp or maybe just a teenager? If you like laying on AIDS-riden mattresses you found behind your mate\'s council flat, why not do it online too? Just remember the 50 credit fine for graffiting the Welcome Lounge please!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('72', '3', '11', '1', 'Glass', '29', '0', '', '1', '0', 'default_3x3', 'catalog_glass_headline1|catalog_glass_teaser1', 'Recycled glass with rubber non-slip surfaces makes for a strange but professional look. Perfect for high rise buildings and offices to optimise lighting and the feel of openess and space. Don\'t worry, its shatterproof safety glass!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('73', '3', '999', '1', 'Gothic', '30', '0', '', '1', '0', 'default_3x3', 'catalog_gothic_headline1|catalog_gothic_teaser1', 'With this range you can recreate Doomsday, a medieval courtyard or just a really depressing church. This range suits those who lurk in the shadows and crawl out to start their day just as the sun sets. Dim candle light is perfect for those eyes that have never seen the bright light of day.|Click on an item for more details.\r\n|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('74', '3', '27', '1', 'Romantique', '50', '0', '', '1', '0', 'default_3x3', 'catalog_romantique_headline1|catalog_romantique_teaser1', 'Found in the back of an old French warehouse this furniture was stored long ago and forgotten about until found and restored to its former glory. This collection looks great in any budoir or boutique and comes in several different colours!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('75', '3', '2', '1', 'Neon', '41', '0', '', '1', '0', 'default_3x3', 'catalog_neon_header1_en|catalog_neon_teaser1_en', 'Start up the music and invite some friends over! Install some of our fabulous lights, dance floors and disco balls to get the party going. This is the right range for you party animals out there, so come and get some!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('76', '3', '17', '1', 'Sci-Fi', '53', '0', '', '1', '0', 'default_3x3', 'sf_header_en', 'Beep bip beeboo bop. Bipbipbip beep bopbop beeeeep bib bob bib. Beeeeb, bopbipbipbob beep, beep, beep.  Bipbipbip beep bopbop beeeeep bib. beep beep beep, boooohhhooooop. Transmission terminated.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('77', '3', '999', '1', 'Country', '21', '0', '', '1', '0', 'default_3x3', 'country_header1_en_001|country_teaser1_en', 'Red and white weather boards are a symbol of the good life out in the country, so go buy some. This range features all you need for a slow life in the middle of nowhere - crop patches, rain and a broken tractor.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('78', '3', '14', '1', 'Relax', '49', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'As one very knowledgeable singer once said - \"Relax, take it easy\". Take Mika\'s advice and do exactly that - build a sanctuary of peace away from your hectic lifestyle to finally take a break and calm down.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('79', '3', '12', '1', 'Urban', '26', '0', '', '1', '0', 'default_3x3', 'urban_header_en|urban_teaser_en', 'An extentsion of \'Grunge\' this range ties in perfectly for your streets, cities and council estates. Chain link fences are the future of modern British schools in rough areas - stock up before they\'ve all gone I tell you!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('80', '3', '5', '1', 'Runway', '74', '0', '', '1', '0', 'default_3x3', 'runway_header_en|runway_teaser_en', 'Set up a cat walk, fashion show or boutique with the Runway range. It has everything a budding designer needs to create some new threads. You could even use this range in a salon or hairdressers!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('81', '3', '15', '1', 'Hospital', '42', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'Despite the name, this range is suited to any dentists, doctors or vets clinic. Planning to perform a life saving operation, abortion or breast enlargement? This page is the starting point of your career.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('83', '3', '999', '1', 'Asian', '15', '0', '', '1', '0', 'default_3x3', 'catalog_asian_headline1|catalog_asian_teaser1', 'Chinese New Year or Chinese takeaway? Who cares when you can have a Chinese themed room every day and any day you want! Please do not disturb other guests or block the corridors with oversized Chinese dragons, thankyou.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('84', '3', '999', '1', 'Japanese', '36', '0', '', '1', '0', 'default_3x3', 'catalog_jap_headline1', 'You\'ll always feel calm, collected and very slightly fishy with this range. You can line your floors with mats, light the room with lanterns and eat sushi until your little heart is content with this authentic collection of orignal Japanese furniture exported straight to the hotel.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('85', '3', '999', '1', 'Alhambra', '12', '0', '', '1', '0', 'default_3x3', 'catalog_alh_headline2 ', 'For those Arabian nights in some far off country with lots of sand, choose Alhambra, atleast it has a tea tray and a pile of deserts to take with you. All our windows come with shutters and are guaranteed for 3 years under our warranty policy.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('86', '3', '999', '1', 'Tiki', '59', '0', '', '1', '0', 'default_3x3', 'catalog_tiki_header1_en|catalog_tiki_teaser1_en', 'Create a tropical island atmosphere with golden sand, crashing waves and blazing sun. We have all you need for your own tiki paradise or tropical retreat. Perfect the look with with a toucan or a pretty little group of butterflies.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('87', '3', '999', '1', 'Greek', '31', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'Ancient Greece was a civilisation of grand, impressive building delicately carved out of the finest stone. We strive to emulate this with this impressive range of well-built and well-made original stone pieces.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('88', '3', '999', '1', 'Shalimar', '54', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'This oddly royal collection features stunning floors, beautiful water features and silky soft drapes. If you want to feel like a Bollywood prince or princess just for a day dress up your palace with some Shalimar accessories.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('89', '3', '999', '1', 'Bensalem', '18', '0', '', '1', '0', 'default_3x3', 'catalog_lc_headline2_en', 'Looking to meet Spongebob, Patrick or maybe even Squidward? You\'ll need to plan an appropriate room for them to come and stay in - they\'re sea creatures, stupid, they can\'t live in the air! The Bensalem range and a moodlight should achieve this effect nicely!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('90', '3', '999', '1', 'Lost Tribe', '38', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'A forgotten land, a timeless island, an overlooked, ancient city. Recreate the feel of a Lost Tribe cut off from humanity and left to develop secret traditions and rituals. Enter the land that civilisation and time forgot with this collection of unique items.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('92', '3', '8', '1', 'Sports', '56', '0', '', '1', '0', 'default_3x3', 'catalog_sports_headline1|catalog_sports_teaser1', 'Starting a new excersice program? Planning to go the GYM? Why don\'t you build a fitness centre in your own home?! With the sports collection you can do exactly that - get fit without everyone laughing at you on the rowing machine!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('93', '3', '4', '1', 'Hollywood', '33', '0', '', '1', '0', 'default_3x3', 'ctlg_habbowood_headline1_en|ctlg_habbowood_teaser1_en', '3... 2... 1... You can be the star of the show when you buy a piece from this collection! Your friends will be amazed and it will look spectacular in your room just like those stunning celebrities on the big screen! The end.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('94', '5', '3', '1', 'Promotional Items', '28', '0', '', '1', '0', 'default_3x3', 'catalog_rares_headline1', 'These items may not all be functional - if you need an item setting please contact an administrator. Please do not give these out in mass - staff found abusing their access to rare furniture will be punished.|Click an item for more details.');
INSERT INTO `catalog` VALUES ('96', '5', '1', '1', 'Rares', '69', '0', '', '1', '0', 'default_3x3', 'catalog_rares_headline1', 'All general rares (for staff use only) are found in this catagory. Please do not give these out in mass - staff found abusing their access to rare furniture will be punished.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('97', '2', '5', '1', 'Iced', '72', '0', '', '1', '0', 'default_3x3', 'catalog_iced_headline1|catalog_iced_teaser1', 'Comfy, squidgy and very, very cool. Iced is all of these in one. With so many colours, all you need to worry about is which one you like the most! From shelves to gates, we have everything you need to make a snappy room.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('98', '2', '7', '1', 'Area', '14', '0', '', '1', '0', 'default_3x3', 'catalog_area_headline1|catalog_area_teaser1', 'Area is a traditionally fashioned, studious collection of furniture. It\'s natural woody feel tied with its functionality make for a rather pleasing and atmospheric room. Settle down and snuggle up in one of the sumptious sofas or sit up and buckle down on a stool - it\'s your choice with Area.|Click on an item for more details.\r\n|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('99', '2', '6', '1', 'Pura', '48', '0', '', '1', '0', 'default_3x3', 'catalog_pura_headline1|catalog_pura_teaser1', 'Simple and clean lines make up this beautifully defined but unobtrusive collection of furniture. Modern, sleek and perfect pieces make this range suitable for many applications in everyday life - the home and the workplace.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('100', '5', '5', '1', 'New Furniture', '10', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'New furniture that has been imported into the database and is ready for sorting. These item are not fully functional yet - please do not harass us about this, we know they are here and waiting to be set.|Click an item for details.');
INSERT INTO `catalog` VALUES ('101', '5', '2', '1', 'Rare Trophies', '60', '0', '', '1', '0', 'trophies', 'catalog_trophies_headline1', 'All rare trophies (for staff use only) are found in this catagory. Please do not give these out in mass - staff found abusing their access to rare furniture will be punished.|Click on an item for more details.\r\n\r\n');
INSERT INTO `catalog` VALUES ('102', '2', '5', '1', 'Cubie', '100', '0', '', '1', '0', 'default_3x3', 'catalog_cubie_header_en|catalog_cubie_teaser', 'A furturistic but oddly appealing range for younger generations. With bright, bold colours and a chunky, modern feel Cubie is Mode\'s big brother and he is here to stay.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('103', '3', '999', '1', 'City', '106', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'From the bright lights of skyscrapers to those charming, classical street corners. You can go to town on your city with this up market selection of metropolitan furniture.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('104', '3', '10', '1', 'Waasa', '99', '0', '', '1', '0', 'default_3x3', 'waasa_catalogue_header|waasa_teaser', 'A more traditional range that would blend perfectly into any home office or study. This range has all the essential tools for a professional proscratinator.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('105', '2', '7', '1', 'Kuurna', '104', '0', '', '1', '0', 'default_3x3', 'catalog_kuurna_headline_en|ctlg_kuurna_teaser', 'A new, clean and comfy range. Perfect for that first room with it\'s simple look but comfy, calm feel. Even better - you can buy it with pixels!|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('106', '2', '6', '1', 'Anna', '104', '0', '', '1', '0', 'default_3x3', 'catalog_anna_header|catalog_anna_teaser|catalog_special_txtbg2', 'Named after Anna, the russian computer virus, this furni range brings you extremely colorful, modern, soviet-built comfort at an affordable price.|Click on an item for more details.|In Soviet Russia, colorful sofa sits on you!');
INSERT INTO `catalog` VALUES ('107', '5', '4', '1', 'Promotional Posters', '28', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'These items may not all be functional - if you need an item setting please contact an administrator. Please do not give these out in mass - staff found abusing their access to rare furniture will be punished.|Click an item for more details.\r\n');
INSERT INTO `catalog` VALUES ('108', '5', '6', '1', 'System', '5', '0', '', '1', '0', 'default_3x3', 'catalog_frontpage_headline2_en', 'All internal furniture, broken furniture and currently un-used furniture. Furniture from this catagory should not be issued to users. If you believe a piece of furniture is here in error, contact an administrator.');
INSERT INTO `catalog` VALUES ('112', '-1', '2', '1', 'Limited Edition', '84', '4', '', '1', '0', 'default_3x3', 'catalog_limited_headline1_en|catalog_limited_teaser1_en\r\n', 'We\'d like to welcome you to uberHotel with these limited edition items! Throw a party and have some fun - quick, before it leaves the catalogue forever!');
INSERT INTO `catalog` VALUES ('113', '3', '999', '1', 'Drago', '110', '0', '', '1', '0', 'default_3x3', 'drago_catalog_header2|drago_catalog_teaser2', 'Deep underground, among secrets and treasures buried for ages and ages... discover the hidden world of Dragons!|Click on an item for details.');
INSERT INTO `catalog` VALUES ('114', '3', '999', '1', 'Frozen', '13', '0', '', '1', '0', 'default_3x3', 'catalog_xmas_headline2_en', 'Looking for a cold-hearted, icy Christmas feel? You\'ve come to right place . Freeze right there and take a look at this range. Please note: this range may melt when combined with heat.|Click on an item for more details.');
INSERT INTO `catalog` VALUES ('115', '5', '9999', '1', '<DND> Dragons', '109', '0', '', '1', '0', 'pets', 'catalog_pet_headline1|', 'Keepers of the Dragon, beware... their fire might be lethal, but win a Dragon\'s heart and it will be your most loyal companion forever!||Name your Dragon:|Pick a color/breed:');
INSERT INTO `catalog` VALUES ('117', '-1', '1', '1', 'Music Discs', '5', '3', '', '1', '0', 'soundmachine', 'catalog_djshop_headline1|catalog_djshop_teaser1', 'These are music discs.|Go listen!');

-- ----------------------------
-- Table structure for `catalog_items`
-- ----------------------------
DROP TABLE IF EXISTS `catalog_items`;
CREATE TABLE `catalog_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_id` int(11) NOT NULL,
  `base_id` int(10) unsigned NOT NULL,
  `preset_flags` varchar(32) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL,
  `cost_credits` int(11) NOT NULL,
  `cost_pixels` int(11) NOT NULL,
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL DEFAULT '1',
  `club_restriction` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50247 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of catalog_items
-- ----------------------------
INSERT INTO `catalog_items` VALUES ('1', '97', '1', '', 'shelves_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2', '13', '2', '', 'shelves_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3', '16', '3', '', 'table_plasto_4leg', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4', '107', '4', '', 'xm09_infotv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5', '98', '5', '', 'shelves_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('6', '13', '6', '', 'table_polyfon_small', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('7', '13', '7', '', 'chair_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('8', '97', '8', '', 'table_norja_med', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('9', '98', '9', '', 'table_silo_med', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('10', '16', '10', '', 'table_plasto_round', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('11', '16', '11', '', 'table_plasto_bigsquare', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('12', '13', '12', '', 'stand_polyfon_z', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('13', '98', '13', '', 'chair_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('14', '98', '14', '', 'sofa_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('15', '97', '15', '', 'couch_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('16', '97', '16', '', 'chair_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('17', '13', '17', '', 'table_polyfon_med', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('18', '23', '18', '', 'doormat_love', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('19', '23', '19', '', 'doormat_plain', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('20', '13', '20', '', 'sofachair_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('21', '13', '21', '', 'sofa_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('22', '98', '22', '', 'sofachair_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('23', '16', '23', '', 'chair_plasty', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('24', '16', '24', '', 'chair_plasto', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('25', '16', '25', '', 'table_plasto_square', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('26', '13', '26', '', 'bed_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('27', '13', '27', '', 'bed_polyfon_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('28', '94', '28', '', 'bed_trad_one', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('29', '94', '29', '', 'bed_trad', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('30', '98', '30', '', 'bed_silo_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('31', '98', '31', '', 'bed_silo_two', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('32', '98', '32', '', 'table_silo_small', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('33', '12', '33', '', 'bed_armas_two', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('34', '99', '34', '', 'bed_budget_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('35', '99', '35', '', 'bed_budget', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('36', '12', '36', '', 'shelves_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('37', '12', '37', '', 'bench_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('38', '12', '38', '', 'table_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('39', '12', '39', '', 'small_table_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('40', '12', '40', '', 'small_chair_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('41', '12', '41', '', 'fireplace_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('42', '12', '42', '', 'lamp_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('43', '12', '43', '', 'bed_armas_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('44', '23', '44', '', 'carpet_standard', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('45', '23', '45', '', 'carpet_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('46', '23', '46', '', 'carpet_polar', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('47', '13', '47', '', 'fireplace_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('48', '16', '48', '', 'table_plasto_4leg*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('49', '16', '49', '', 'table_plasto_bigsquare*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50', '16', '50', '', 'table_plasto_round*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('51', '16', '51', '', 'table_plasto_square*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('52', '16', '52', '', 'chair_plasto*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('53', '23', '53', '', 'carpet_standard*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('54', '23', '54', '', 'doormat_plain*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('55', '16', '55', '', 'table_plasto_4leg*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('56', '16', '56', '', 'table_plasto_bigsquare*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('57', '16', '57', '', 'table_plasto_round*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('58', '16', '58', '', 'table_plasto_square*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('59', '16', '59', '', 'chair_plasto*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('60', '23', '60', '', 'doormat_plain*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('61', '23', '61', '', 'carpet_standard*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('62', '16', '62', '', 'table_plasto_4leg*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('63', '16', '63', '', 'table_plasto_bigsquare*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('64', '16', '64', '', 'table_plasto_round*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('65', '16', '65', '', 'table_plasto_square*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('66', '16', '66', '', 'chair_plasto*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('67', '23', '67', '', 'carpet_standard*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('68', '23', '68', '', 'doormat_plain*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('69', '16', '69', '', 'table_plasto_4leg*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('70', '16', '70', '', 'table_plasto_bigsquare*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('71', '16', '71', '', 'table_plasto_round*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('72', '16', '72', '', 'table_plasto_square*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('73', '16', '73', '', 'chair_plasto*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('74', '23', '74', '', 'carpet_standard*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('75', '23', '75', '', 'doormat_plain*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('76', '23', '76', '', 'doormat_plain*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('77', '23', '77', '', 'doormat_plain*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('78', '23', '78', '', 'carpet_standard*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('79', '16', '79', '', 'table_plasto_4leg*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('80', '16', '80', '', 'table_plasto_bigsquare*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('81', '16', '81', '', 'table_plasto_round*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('82', '16', '82', '', 'table_plasto_square*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('83', '16', '83', '', 'chair_plasto*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('84', '16', '84', '', 'table_plasto_4leg*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('85', '16', '85', '', 'table_plasto_bigsquare*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('86', '16', '86', '', 'table_plasto_round*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('87', '16', '87', '', 'table_plasto_square*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('88', '16', '88', '', 'chair_plasto*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('89', '16', '89', '', 'table_plasto_4leg*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('90', '16', '90', '', 'table_plasto_bigsquare*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('91', '16', '91', '', 'table_plasto_round*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('92', '16', '92', '', 'table_plasto_square*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('93', '16', '93', '', 'chair_plasto*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('94', '16', '94', '', 'table_plasto_4leg*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('95', '16', '95', '', 'table_plasto_bigsquare*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('96', '16', '96', '', 'table_plasto_round*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('97', '16', '97', '', 'table_plasto_square*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('98', '16', '98', '', 'chair_plasto*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('99', '16', '99', '', 'table_plasto_4leg*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('100', '16', '100', '', 'table_plasto_bigsquare*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('101', '16', '101', '', 'table_plasto_round*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('102', '16', '102', '', 'table_plasto_square*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('103', '16', '103', '', 'chair_plasto*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('104', '23', '104', '', 'carpet_standard*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('105', '16', '105', '', 'chair_plasty*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('106', '19', '106', '', 'pizza', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('107', '19', '107', '', 'drinks', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('108', '16', '108', '', 'chair_plasty*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('109', '16', '109', '', 'chair_plasty*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('110', '16', '110', '', 'chair_plasty*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('111', '13', '111', '', 'bar_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('112', '96', '112', '', 'plant_cruddy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('113', '19', '113', '', 'bottle', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('114', '13', '114', '', 'bardesk_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('115', '13', '115', '', 'bardeskcorner_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('116', '108', '116', '', 'floortile', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('117', '12', '117', '', 'bar_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('118', '12', '118', '', 'bartable_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('119', '12', '119', '', 'bar_chair_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('120', '23', '120', '', 'carpet_soft', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('121', '23', '121', '', 'carpet_soft*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('122', '23', '122', '', 'carpet_soft*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('123', '23', '123', '', 'carpet_soft*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('124', '23', '124', '', 'carpet_soft*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('125', '23', '125', '', 'carpet_soft*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('126', '23', '126', '', 'carpet_soft*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('127', '19', '127', '', 'red_tv', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('128', '19', '128', '', 'wood_tv', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('129', '23', '129', '', 'carpet_polar*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('130', '16', '130', '', 'chair_plasty*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('131', '23', '131', '', 'carpet_polar*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('132', '23', '132', '', 'carpet_polar*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('133', '23', '133', '', 'carpet_polar*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('134', '16', '134', '', 'chair_plasty*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('135', '13', '135', '', 'table_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('136', '13', '136', '', 'smooth_table_polyfon', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('137', '13', '137', '', 'sofachair_polyfon_girl', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('138', '13', '138', '', 'bed_polyfon_girl_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('139', '13', '139', '', 'bed_polyfon_girl', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('140', '13', '140', '', 'sofa_polyfon_girl', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('141', '99', '141', '', 'bed_budgetb_one', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('142', '99', '142', '', 'bed_budgetb', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('143', '15', '143', '', 'plant_pineapple', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('144', '15', '144', '', 'plant_fruittree', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('145', '15', '145', '', 'plant_small_cactus', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('146', '15', '146', '', 'plant_bonsai', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('147', '15', '147', '', 'plant_big_cactus', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('148', '15', '148', '', 'plant_yukka', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('149', '23', '149', '', 'carpet_standard*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('150', '23', '150', '', 'carpet_standard*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('151', '23', '151', '', 'carpet_standard*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('152', '23', '152', '', 'carpet_standard*10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('153', '23', '153', '', 'carpet_standard*11', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('154', '15', '154', '', 'plant_sunflower', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('155', '15', '155', '', 'plant_rose', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('156', '19', '156', '', 'tv_luxus', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('157', '17', '157', '', 'bath', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('158', '17', '158', '', 'sink', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('159', '17', '159', '', 'toilet', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('160', '17', '160', '', 'duck', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('161', '17', '161', '', 'tile', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('162', '17', '162', '', 'toilet_red', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('163', '17', '163', '', 'toilet_yell', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('164', '17', '164', '', 'tile_red', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('165', '17', '165', '', 'tile_yell', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('166', '96', '166', '', 'prize1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('167', '96', '167', '', 'prize2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('168', '108', '168', '', 'present_gen', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('169', '108', '169', '', 'present_gen1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('170', '108', '170', '', 'present_gen2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('171', '108', '171', '', 'present_gen3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('172', '108', '172', '', 'present_gen4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('173', '108', '173', '', 'present_gen5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('174', '108', '174', '', 'present_gen6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('175', '99', '175', '', 'bar_basic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('176', '99', '176', '', 'shelves_basic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('177', '97', '177', '', 'soft_sofachair_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('178', '97', '178', '', 'soft_sofa_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('179', '99', '179', '', 'lamp_basic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('180', '12', '180', '', 'lamp2_armas', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('181', '99', '181', '', 'fridge', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('182', '9', '182', '', 'door', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('183', '9', '183', '', 'doorB', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('184', '9', '184', '', 'doorC', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('185', '65', '185', '', 'pumpkin', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('186', '65', '186', '', 'skullcandle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('187', '65', '187', '', 'deadduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('188', '65', '188', '', 'deadduck2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('189', '65', '189', '', 'deadduck3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('190', '68', '190', '', 'menorah', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('191', '68', '191', '', 'pudding', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('192', '68', '192', '', 'ham', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('193', '68', '193', '', 'turkey', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('194', '68', '194', '', 'xmasduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('195', '68', '195', '', 'house', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('196', '68', '196', '', 'triplecandle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('197', '68', '197', '', 'tree3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('198', '68', '198', '', 'tree4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('199', '68', '199', '', 'tree5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('200', '68', '200', '', 'ham2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('201', '68', '201', '', 'wcandleset', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('202', '68', '202', '', 'rcandleset', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('203', '61', '203', '', 'statue', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('204', '61', '204', '', 'heart', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('205', '61', '205', '', 'valeduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('206', '61', '206', '', 'heartsofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('207', '96', '207', '', 'throne', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('208', '96', '208', '', 'samovar', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('209', '15', '209', '', 'giftflowers', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('210', '19', '210', '', 'habbocake', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('211', '96', '211', '', 'hologram', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('212', '63', '212', '', 'easterduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('213', '63', '213', '', 'bunny', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('214', '63', '214', '', 'basket', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('215', '63', '215', '', 'birdie', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('216', '19', '216', '', 'edice', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('217', '96', '217', '', 'prize3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('218', '13', '218', '', 'divider_poly3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('219', '12', '219', '', 'divider_arm1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('220', '12', '220', '', 'divider_arm2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('221', '12', '221', '', 'divider_arm3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('222', '97', '222', '', 'divider_nor1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('223', '98', '223', '', 'divider_silo1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('224', '97', '224', '', 'divider_nor2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('225', '98', '225', '', 'divider_silo2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('226', '97', '226', '', 'divider_nor3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('227', '98', '227', '', 'divider_silo3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('228', '96', '228', '', 'typingmachine', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('229', '96', '229', '', 'spyro', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('230', '96', '230', '', 'redhologram', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('231', '108', '231', '', 'camera', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('232', '96', '232', '', 'joulutahti', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('233', '96', '233', '', 'hyacinth1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('234', '96', '234', '', 'hyacinth2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('235', '7', '235', '', 'club_sofa', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('236', '16', '236', '', 'chair_plasto*10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('237', '16', '237', '', 'chair_plasto*11', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('238', '13', '238', '', 'bardeskcorner_polyfon*12', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('239', '13', '239', '', 'bardeskcorner_polyfon*13', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('240', '16', '240', '', 'chair_plasto*12', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('241', '16', '241', '', 'chair_plasto*13', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('242', '16', '242', '', 'chair_plasto*14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('243', '16', '243', '', 'table_plasto_4leg*14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('244', '7', '244', '', 'mocchamaster', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('245', '92', '245', '', 'carpet_legocourt', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('246', '92', '246', '', 'bench_lego', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('247', '92', '247', '', 'legotrophy', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('248', '61', '248', '', 'valentinescreen', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('249', '7', '249', '', 'edicehc', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('250', '96', '250', '', 'rare_daffodil_rug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('251', '96', '251', '', 'rare_beehive_bulb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('252', '7', '252', '', 'hcsohva', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('253', '7', '253', '', 'hcamme', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('254', '96', '254', '', 'rare_parasol*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('255', '96', '255', '', 'rare_elephant_statue', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('256', '96', '256', '', 'rare_fountain', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('257', '96', '257', '', 'rare_stand', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('258', '96', '258', '', 'rare_globe', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('259', '96', '259', '', 'rare_hammock', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('260', '96', '260', '', 'rare_elephant_statue*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('261', '96', '261', '', 'rare_elephant_statue*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('262', '96', '262', '', 'rare_fountain*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('263', '96', '263', '', 'rare_fountain*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('264', '96', '264', '', 'rare_fountain*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('265', '96', '265', '', 'rare_beehive_bulb*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('266', '96', '266', '', 'rare_beehive_bulb*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('267', '96', '267', '', 'rare_xmas_screen', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('268', '96', '268', '', 'rare_parasol*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('269', '96', '269', '', 'rare_parasol*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('270', '96', '270', '', 'rare_parasol*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('271', '97', '271', '', 'soft_jaggara_norja', '0', '5', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('272', '68', '272', '', 'house2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('273', '96', '273', '', 'djesko_turntable', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('274', '108', '274', '', 'md_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('275', '96', '275', '', 'md_limukaappi', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('276', '16', '276', '', 'table_plasto_4leg*10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('277', '16', '277', '', 'table_plasto_4leg*15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('278', '16', '278', '', 'table_plasto_bigsquare*14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('279', '16', '279', '', 'table_plasto_bigsquare*15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('280', '16', '280', '', 'table_plasto_round*14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('281', '16', '281', '', 'table_plasto_round*15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('282', '16', '282', '', 'table_plasto_square*14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('283', '16', '283', '', 'table_plasto_square*15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('284', '16', '284', '', 'chair_plasto*15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('285', '16', '285', '', 'chair_plasty*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('286', '16', '286', '', 'chair_plasty*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('287', '16', '287', '', 'chair_plasty*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('288', '16', '288', '', 'chair_plasty*10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('289', '16', '289', '', 'chair_plasty*11', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('290', '16', '290', '', 'chair_plasto*16', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('291', '16', '291', '', 'table_plasto_4leg*16', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('292', '92', '292', '', 'hockey_score', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('293', '92', '293', '', 'hockey_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('294', '7', '294', '', 'doorD', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('306', '101', '306', '', 'a0 prizetrophy7_g', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('313', '101', '313', '', 'a0 prizetrophy7_s', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('315', '7', '315', '', 'hc_chr', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('316', '7', '316', '', 'hc_tbl', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('317', '7', '317', '', 'hc_lmp', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('318', '7', '318', '', 'hc_dsk', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('319', '108', '319', '', 'nest', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('320', '108', '320', '', 'petfood1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('321', '108', '321', '', 'petfood2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('322', '108', '322', '', 'petfood3', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('323', '108', '323', '', 'waterbowl*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('324', '108', '324', '', 'waterbowl*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('325', '108', '325', '', 'waterbowl*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('326', '108', '326', '', 'waterbowl*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('327', '108', '327', '', 'waterbowl*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('328', '108', '328', '', 'toy1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('329', '108', '329', '', 'toy1*1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('330', '108', '330', '', 'toy1*2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('331', '108', '331', '', 'toy1*3', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('332', '108', '332', '', 'toy1*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('333', '108', '333', '', 'goodie1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('334', '108', '334', '', 'goodie1*1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('335', '108', '335', '', 'goodie1*2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('336', '108', '336', '', 'goodie2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('337', '96', '337', '', 'scifiport*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('338', '96', '338', '', 'scifiport*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('339', '96', '339', '', 'scifiport*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('340', '96', '340', '', 'scifiport*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('341', '96', '341', '', 'scifiport*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('342', '96', '342', '', 'scifiport*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('343', '96', '343', '', 'scifiport*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('344', '96', '344', '', 'scifiport*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('345', '96', '345', '', 'scifiport*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('346', '96', '346', '', 'scifiport*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('347', '96', '347', '', 'scifirocket*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('348', '96', '348', '', 'scifirocket*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('349', '96', '349', '', 'scifirocket*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('350', '96', '350', '', 'scifirocket*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('351', '96', '351', '', 'scifirocket*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('352', '96', '352', '', 'scifirocket*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('353', '96', '353', '', 'scifirocket*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('354', '96', '354', '', 'scifirocket*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('355', '96', '355', '', 'scifirocket*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('356', '96', '356', '', 'scifirocket*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('357', '96', '357', '', 'scifidoor*10', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('358', '96', '358', '', 'scifidoor*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('359', '96', '359', '', 'scifidoor*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('360', '96', '360', '', 'scifidoor*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('361', '96', '361', '', 'scifidoor*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('362', '96', '362', '', 'scifidoor*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('363', '96', '363', '', 'scifidoor*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('364', '96', '364', '', 'scifidoor*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('365', '96', '365', '', 'scifidoor*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('366', '96', '366', '', 'scifidoor*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('367', '96', '367', '', 'pillow*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('368', '96', '368', '', 'pillow*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('369', '96', '369', '', 'pillow*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('370', '96', '370', '', 'pillow*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('371', '96', '371', '', 'pillow*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('372', '96', '372', '', 'pillow*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('373', '96', '373', '', 'pillow*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('374', '96', '374', '', 'pillow*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('375', '96', '375', '', 'pillow*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('376', '96', '376', '', 'pillow*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('377', '96', '377', '', 'marquee*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('378', '96', '378', '', 'marquee*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('379', '96', '379', '', 'marquee*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('380', '96', '380', '', 'marquee*10', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('381', '96', '381', '', 'marquee*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('382', '96', '382', '', 'marquee*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('383', '96', '383', '', 'marquee*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('384', '96', '384', '', 'marquee*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('385', '96', '385', '', 'marquee*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('386', '96', '386', '', 'marquee*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('387', '96', '387', '', 'wooden_screen*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('388', '96', '388', '', 'wooden_screen*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('389', '96', '389', '', 'wooden_screen*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('390', '96', '390', '', 'wooden_screen*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('391', '96', '391', '', 'wooden_screen*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('392', '96', '392', '', 'wooden_screen*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('393', '96', '393', '', 'wooden_screen*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('394', '96', '394', '', 'wooden_screen*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('395', '96', '395', '', 'wooden_screen*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('396', '96', '396', '', 'wooden_screen*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('397', '96', '397', '', 'pillar*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('398', '96', '398', '', 'pillar*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('399', '96', '399', '', 'pillar*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('400', '96', '400', '', 'pillar*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('401', '96', '401', '', 'pillar*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('402', '96', '402', '', 'pillar*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('403', '96', '403', '', 'pillar*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('404', '96', '404', '', 'pillar*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('405', '96', '405', '', 'pillar*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('406', '96', '406', '', 'pillar*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('407', '96', '407', '', 'rare_dragonlamp*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('408', '96', '408', '', 'rare_dragonlamp*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('409', '96', '409', '', 'rare_dragonlamp*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('410', '96', '410', '', 'rare_dragonlamp*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('411', '96', '411', '', 'rare_dragonlamp*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('412', '96', '412', '', 'rare_dragonlamp*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('413', '96', '413', '', 'rare_dragonlamp*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('414', '96', '414', '', 'rare_dragonlamp*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('415', '96', '415', '', 'rare_dragonlamp*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('416', '96', '416', '', 'rare_dragonlamp*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('417', '96', '417', '', 'rare_icecream*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('418', '96', '418', '', 'rare_icecream*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('419', '96', '419', '', 'rare_icecream*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('420', '96', '420', '', 'rare_icecream*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('421', '96', '421', '', 'rare_icecream*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('422', '96', '422', '', 'rare_icecream*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('423', '96', '423', '', 'rare_icecream*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('424', '96', '424', '', 'rare_icecream*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('425', '96', '425', '', 'rare_icecream*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('426', '96', '426', '', 'rare_icecream*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('427', '96', '427', '', 'rare_fan*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('428', '96', '428', '', 'rare_fan*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('429', '96', '429', '', 'rare_fan*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('430', '96', '430', '', 'rare_fan*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('431', '96', '431', '', 'rare_fan*0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('432', '96', '432', '', 'rare_fan*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('433', '96', '433', '', 'rare_fan*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('434', '96', '434', '', 'rare_fan*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('435', '96', '435', '', 'rare_fan*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('436', '96', '436', '', 'rare_fan*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('437', '21', '437', '', 'queue_tile1*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('438', '21', '438', '', 'queue_tile1*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('439', '21', '439', '', 'queue_tile1*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('440', '21', '440', '', 'queue_tile1*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('441', '21', '441', '', 'queue_tile1*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('442', '21', '442', '', 'queue_tile1*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('443', '21', '443', '', 'queue_tile1*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('444', '21', '444', '', 'queue_tile1*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('445', '21', '445', '', 'queue_tile1*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('446', '21', '446', '', 'queue_tile1*0', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('447', '108', '447', '', 'ticket', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('448', '96', '448', '', 'rare_snowrug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('449', '83', '449', '', 'cn_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('450', '83', '450', '', 'cn_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('451', '92', '451', '', 'sporttrack1*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('452', '92', '452', '', 'sporttrack1*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('453', '92', '453', '', 'sporttrack1*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('454', '92', '454', '', 'sporttrack2*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('455', '92', '455', '', 'sporttrack2*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('456', '92', '456', '', 'sporttrack2*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('457', '92', '457', '', 'sporttrack3*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('458', '92', '458', '', 'sporttrack3*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('459', '92', '459', '', 'sporttrack3*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('460', '92', '460', '', 'footylamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('461', '68', '461', '', 'tree1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('462', '98', '462', '', 'barchair_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('463', '97', '463', '', 'divider_nor4*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('464', '96', '464', '', 'traffic_light*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('465', '96', '465', '', 'traffic_light*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('466', '96', '466', '', 'traffic_light*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('467', '96', '467', '', 'traffic_light*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('468', '96', '468', '', 'traffic_light*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('469', '96', '469', '', 'rubberchair*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('470', '96', '470', '', 'rubberchair*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('471', '96', '471', '', 'rubberchair*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('472', '96', '472', '', 'rubberchair*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('473', '96', '473', '', 'rubberchair*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('474', '96', '474', '', 'rubberchair*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('475', '96', '475', '', 'barrier*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('476', '96', '476', '', 'barrier*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('477', '96', '477', '', 'barrier*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('478', '96', '478', '', 'rubberchair*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('479', '96', '479', '', 'rubberchair*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('480', '97', '480', '', 'table_norja_med*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('481', '97', '481', '', 'table_norja_med*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('482', '97', '482', '', 'table_norja_med*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('483', '97', '483', '', 'table_norja_med*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('484', '97', '484', '', 'table_norja_med*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('485', '97', '485', '', 'table_norja_med*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('486', '97', '486', '', 'table_norja_med*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('487', '97', '487', '', 'table_norja_med*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('488', '97', '488', '', 'couch_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('489', '97', '489', '', 'couch_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('490', '97', '490', '', 'couch_norja*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('491', '97', '491', '', 'couch_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('492', '97', '492', '', 'couch_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('493', '97', '493', '', 'couch_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('494', '97', '494', '', 'couch_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('495', '97', '495', '', 'couch_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('496', '97', '496', '', 'shelves_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('497', '97', '497', '', 'shelves_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('498', '97', '498', '', 'shelves_norja*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('499', '97', '499', '', 'shelves_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('500', '97', '500', '', 'shelves_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('501', '97', '501', '', 'shelves_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('502', '97', '502', '', 'shelves_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('503', '97', '503', '', 'shelves_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('504', '97', '504', '', 'chair_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('505', '97', '505', '', 'chair_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('506', '97', '506', '', 'chair_norja*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('507', '97', '507', '', 'chair_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('508', '97', '508', '', 'chair_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('509', '97', '509', '', 'chair_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('510', '97', '510', '', 'chair_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('511', '97', '511', '', 'chair_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('512', '97', '512', '', 'divider_nor1*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('513', '97', '513', '', 'divider_nor1*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('514', '97', '514', '', 'divider_nor1*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('515', '97', '515', '', 'divider_nor1*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('516', '97', '516', '', 'divider_nor1*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('517', '97', '517', '', 'divider_nor1*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('518', '97', '518', '', 'divider_nor1*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('519', '97', '519', '', 'divider_nor1*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('520', '97', '520', '', 'soft_sofa_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('521', '97', '521', '', 'soft_sofa_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('522', '97', '522', '', 'soft_sofa_norja*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('523', '97', '523', '', 'soft_sofa_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('524', '97', '524', '', 'soft_sofa_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('525', '97', '525', '', 'soft_sofa_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('526', '97', '526', '', 'soft_sofa_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('527', '97', '527', '', 'soft_sofa_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('528', '97', '528', '', 'soft_sofachair_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('529', '97', '529', '', 'soft_sofachair_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('530', '97', '530', '', 'soft_sofachair_norja*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('531', '97', '531', '', 'soft_sofachair_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('532', '97', '532', '', 'soft_sofachair_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('533', '97', '533', '', 'soft_sofachair_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('534', '97', '534', '', 'soft_sofachair_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('535', '97', '535', '', 'soft_sofachair_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('536', '98', '536', '', 'sofachair_silo*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('537', '98', '537', '', 'sofachair_silo*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('538', '98', '538', '', 'sofachair_silo*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('539', '98', '539', '', 'sofachair_silo*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('540', '98', '540', '', 'sofachair_silo*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('541', '98', '541', '', 'sofachair_silo*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('542', '98', '542', '', 'sofachair_silo*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('543', '98', '543', '', 'sofachair_silo*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('544', '98', '544', '', 'table_silo_small*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('545', '98', '545', '', 'table_silo_small*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('546', '98', '546', '', 'table_silo_small*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('547', '98', '547', '', 'table_silo_small*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('548', '98', '548', '', 'table_silo_small*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('549', '98', '549', '', 'table_silo_small*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('550', '98', '550', '', 'table_silo_small*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('551', '98', '551', '', 'table_silo_small*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('552', '98', '552', '', 'divider_silo1*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('553', '98', '553', '', 'divider_silo1*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('554', '98', '554', '', 'divider_silo1*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('555', '98', '555', '', 'divider_silo1*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('556', '98', '556', '', 'divider_silo1*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('557', '98', '557', '', 'divider_silo1*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('558', '98', '558', '', 'divider_silo1*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('559', '98', '559', '', 'divider_silo1*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('560', '98', '560', '', 'divider_silo3*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('561', '98', '561', '', 'divider_silo3*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('562', '98', '562', '', 'divider_silo3*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('563', '98', '563', '', 'divider_silo3*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('564', '98', '564', '', 'divider_silo3*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('565', '98', '565', '', 'divider_silo3*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('566', '98', '566', '', 'divider_silo3*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('567', '98', '567', '', 'divider_silo3*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('568', '98', '568', '', 'table_silo_med*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('569', '98', '569', '', 'table_silo_med*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('570', '98', '570', '', 'table_silo_med*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('571', '98', '571', '', 'table_silo_med*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('572', '98', '572', '', 'table_silo_med*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('573', '98', '573', '', 'table_silo_med*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('574', '98', '574', '', 'table_silo_med*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('575', '98', '575', '', 'table_silo_med*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('576', '98', '576', '', 'sofa_silo*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('577', '98', '577', '', 'sofa_silo*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('578', '98', '578', '', 'sofa_silo*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('579', '98', '579', '', 'sofa_silo*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('580', '98', '580', '', 'sofa_silo*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('581', '98', '581', '', 'sofa_silo*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('582', '98', '582', '', 'sofa_silo*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('583', '98', '583', '', 'sofa_silo*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('584', '13', '584', '', 'sofachair_polyfon*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('585', '13', '585', '', 'sofachair_polyfon*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('586', '13', '586', '', 'sofachair_polyfon*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('587', '13', '587', '', 'sofachair_polyfon*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('588', '13', '588', '', 'sofachair_polyfon*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('589', '13', '589', '', 'sofachair_polyfon*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('590', '13', '590', '', 'sofachair_polyfon*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('591', '13', '591', '', 'sofa_polyfon*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('592', '13', '592', '', 'sofa_polyfon*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('593', '13', '593', '', 'sofa_polyfon*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('594', '13', '594', '', 'sofa_polyfon*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('595', '13', '595', '', 'sofa_polyfon*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('596', '13', '596', '', 'sofa_polyfon*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('597', '13', '597', '', 'sofa_polyfon*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('598', '13', '598', '', 'bed_polyfon*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('599', '13', '599', '', 'bed_polyfon*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('600', '13', '600', '', 'bed_polyfon*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('601', '13', '601', '', 'bed_polyfon*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('602', '13', '602', '', 'bed_polyfon*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('603', '13', '603', '', 'bed_polyfon*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('604', '13', '604', '', 'bed_polyfon*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('605', '13', '605', '', 'bed_polyfon_one*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('606', '13', '606', '', 'bed_polyfon_one*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('607', '13', '607', '', 'bed_polyfon_one*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('608', '13', '608', '', 'bed_polyfon_one*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('609', '13', '609', '', 'bed_polyfon_one*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('610', '13', '610', '', 'bed_polyfon_one*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('611', '13', '611', '', 'bed_polyfon_one*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('612', '13', '612', '', 'bardesk_polyfon*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('613', '13', '613', '', 'bardesk_polyfon*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('614', '13', '614', '', 'bardesk_polyfon*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('615', '13', '615', '', 'bardesk_polyfon*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('616', '13', '616', '', 'bardesk_polyfon*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('617', '13', '617', '', 'bardesk_polyfon*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('618', '13', '618', '', 'bardesk_polyfon*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('619', '13', '619', '', 'bardesk_polyfon*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('620', '13', '620', '', 'bardeskcorner_polyfon*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('621', '13', '621', '', 'bardeskcorner_polyfon*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('622', '13', '622', '', 'bardeskcorner_polyfon*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('623', '13', '623', '', 'bardeskcorner_polyfon*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('624', '13', '624', '', 'bardeskcorner_polyfon*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('625', '13', '625', '', 'bardeskcorner_polyfon*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('626', '13', '626', '', 'bardeskcorner_polyfon*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('627', '13', '627', '', 'bardeskcorner_polyfon*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('628', '13', '628', '', 'divider_poly3*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('629', '13', '629', '', 'divider_poly3*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('630', '13', '630', '', 'divider_poly3*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('631', '13', '631', '', 'divider_poly3*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('632', '13', '632', '', 'divider_poly3*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('633', '13', '633', '', 'divider_poly3*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('634', '13', '634', '', 'divider_poly3*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('635', '13', '635', '', 'divider_poly3*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('636', '98', '636', '', 'chair_silo*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('637', '98', '637', '', 'chair_silo*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('638', '98', '638', '', 'chair_silo*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('639', '98', '639', '', 'chair_silo*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('640', '98', '640', '', 'chair_silo*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('641', '98', '641', '', 'chair_silo*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('642', '98', '642', '', 'chair_silo*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('643', '98', '643', '', 'chair_silo*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('644', '97', '644', '', 'divider_nor3*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('645', '97', '645', '', 'divider_nor3*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('646', '97', '646', '', 'divider_nor3*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('647', '97', '647', '', 'divider_nor3*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('648', '97', '648', '', 'divider_nor3*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('649', '97', '649', '', 'divider_nor3*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('650', '97', '650', '', 'divider_nor3*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('651', '97', '651', '', 'divider_nor3*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('652', '97', '652', '', 'divider_nor2*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('653', '97', '653', '', 'divider_nor2*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('654', '97', '654', '', 'divider_nor2*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('655', '97', '655', '', 'divider_nor2*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('656', '97', '656', '', 'divider_nor2*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('657', '97', '657', '', 'divider_nor2*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('658', '97', '658', '', 'divider_nor2*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('659', '97', '659', '', 'divider_nor2*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('660', '98', '660', '', 'silo_studydesk', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('661', '97', '661', '', 'solarium_norja', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('662', '97', '662', '', 'solarium_norja*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('663', '97', '663', '', 'solarium_norja*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('664', '97', '664', '', 'solarium_norja*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('665', '97', '665', '', 'solarium_norja*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('666', '97', '666', '', 'solarium_norja*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('667', '97', '667', '', 'solarium_norja*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('668', '97', '668', '', 'solarium_norja*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('669', '97', '669', '', 'solarium_norja*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('670', '96', '670', '', 'sandrug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('671', '96', '671', '', 'rare_moonrug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('672', '83', '672', '', 'chair_china', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('673', '83', '673', '', 'china_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('674', '96', '674', '', 'sleepingbag*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('675', '96', '675', '', 'sleepingbag*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('676', '96', '676', '', 'sleepingbag*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('677', '96', '677', '', 'sleepingbag*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('678', '98', '678', '', 'safe_silo', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('679', '96', '679', '', 'sleepingbag*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('680', '96', '680', '', 'sleepingbag*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('681', '96', '681', '', 'sleepingbag*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('682', '96', '682', '', 'sleepingbag*10', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('683', '96', '683', '', 'sleepingbag*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('684', '96', '684', '', 'sleepingbag*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('685', '83', '685', '', 'china_shelve', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('686', '96', '686', '', 'traffic_light*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('687', '97', '687', '', 'divider_nor4*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('688', '97', '688', '', 'divider_nor4*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('689', '97', '689', '', 'divider_nor4*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('690', '97', '690', '', 'divider_nor4*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('691', '97', '691', '', 'divider_nor4*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('692', '97', '692', '', 'divider_nor4*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('693', '97', '693', '', 'divider_nor4*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('694', '97', '694', '', 'divider_nor5*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('695', '97', '695', '', 'divider_nor5*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('696', '97', '696', '', 'divider_nor5*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('697', '97', '697', '', 'divider_nor5*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('698', '97', '698', '', 'divider_nor5*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('699', '97', '699', '', 'divider_nor5*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('700', '97', '700', '', 'divider_nor5*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('701', '97', '701', '', 'divider_nor5*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('702', '97', '702', '', 'divider_nor5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('703', '97', '703', '', 'divider_nor4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('704', '83', '704', '', 'wall_china', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('705', '83', '705', '', 'corner_china', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('706', '98', '706', '', 'barchair_silo*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('707', '98', '707', '', 'barchair_silo*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('708', '98', '708', '', 'barchair_silo*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('709', '98', '709', '', 'barchair_silo*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('710', '98', '710', '', 'barchair_silo*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('711', '98', '711', '', 'barchair_silo*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('712', '98', '712', '', 'barchair_silo*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('713', '98', '713', '', 'barchair_silo*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('714', '98', '714', '', 'safe_silo*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('715', '98', '715', '', 'safe_silo*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('716', '98', '716', '', 'safe_silo*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('717', '98', '717', '', 'safe_silo*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('718', '98', '718', '', 'safe_silo*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('719', '98', '719', '', 'safe_silo*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('720', '98', '720', '', 'safe_silo*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('721', '98', '721', '', 'safe_silo*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('722', '72', '722', '', 'glass_shelf', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('723', '72', '723', '', 'glass_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('724', '72', '724', '', 'glass_stool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('725', '72', '725', '', 'glass_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('726', '72', '726', '', 'glass_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('727', '72', '727', '', 'glass_table*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('728', '72', '728', '', 'glass_table*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('729', '72', '729', '', 'glass_table*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('730', '72', '730', '', 'glass_table*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('731', '72', '731', '', 'glass_table*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('732', '72', '732', '', 'glass_table*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('733', '72', '733', '', 'glass_table*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('734', '72', '734', '', 'glass_table*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('735', '72', '735', '', 'glass_chair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('736', '72', '736', '', 'glass_chair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('737', '72', '737', '', 'glass_chair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('738', '72', '738', '', 'glass_chair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('739', '72', '739', '', 'glass_chair*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('740', '72', '740', '', 'glass_chair*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('741', '72', '741', '', 'glass_chair*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('742', '72', '742', '', 'glass_chair*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('743', '72', '743', '', 'glass_sofa*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('744', '72', '744', '', 'glass_sofa*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('745', '72', '745', '', 'glass_sofa*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('746', '72', '746', '', 'glass_sofa*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('747', '72', '747', '', 'glass_sofa*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('748', '72', '748', '', 'glass_sofa*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('749', '72', '749', '', 'glass_sofa*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('750', '72', '750', '', 'glass_sofa*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('751', '72', '751', '', 'glass_stool*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('752', '72', '752', '', 'glass_stool*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('753', '72', '753', '', 'glass_stool*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('754', '72', '754', '', 'glass_stool*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('755', '72', '755', '', 'glass_stool*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('756', '72', '756', '', 'glass_stool*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('757', '72', '757', '', 'glass_stool*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('758', '72', '758', '', 'glass_stool*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('759', '30', '759', '10', 'CF_10_coin_gold', '0', '100', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('760', '30', '760', '1', 'CF_1_coin_bronze', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('761', '108', '761', '20', 'CF_20_moneybag', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('762', '108', '762', '50', 'CF_50_goldbar', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('763', '30', '763', '5', 'CF_5_coin_silver', '0', '50', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('764', '7', '764', '', 'hc_crpt', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('765', '7', '765', '', 'hc_tv', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('766', '73', '766', '', 'gothgate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('767', '73', '767', '', 'gothiccandelabra', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('768', '73', '768', '', 'gothrailing', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('769', '73', '769', '', 'goth_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('770', '7', '770', '', 'hc_bkshlf', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('771', '7', '771', '', 'hc_btlr', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('772', '7', '772', '', 'hc_crtn', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('773', '7', '773', '', 'hc_djset', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('774', '7', '774', '', 'hc_frplc', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('775', '7', '775', '', 'hc_lmpst', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('776', '7', '776', '', 'hc_machine', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('777', '7', '777', '', 'hc_rllr', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('778', '7', '778', '', 'hc_rntgn', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('779', '7', '779', '', 'hc_trll', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('780', '73', '780', '', 'gothic_chair*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('781', '73', '781', '', 'gothic_sofa*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('782', '73', '782', '', 'gothic_stool*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('783', '73', '783', '', 'gothic_chair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('784', '73', '784', '', 'gothic_sofa*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('785', '73', '785', '', 'gothic_stool*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('786', '73', '786', '', 'gothic_chair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('787', '73', '787', '', 'gothic_sofa*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('788', '73', '788', '', 'gothic_stool*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('789', '73', '789', '', 'gothic_chair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('790', '73', '790', '', 'gothic_sofa*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('791', '73', '791', '', 'gothic_stool*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('792', '73', '792', '', 'gothic_chair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('793', '73', '793', '', 'gothic_sofa*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('794', '73', '794', '', 'gothic_stool*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('795', '73', '795', '', 'gothic_chair*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('796', '73', '796', '', 'gothic_sofa*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('797', '73', '797', '', 'gothic_stool*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('798', '68', '798', '', 'wcandle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('799', '61', '799', '', 'val_cauldron', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('800', '68', '800', '', 'tree2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('801', '108', '801', '', 'sound_machine', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('802', '74', '802', '', 'romantique_pianochair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('803', '74', '803', '', 'romantique_pianochair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('804', '74', '804', '', 'romantique_pianochair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('805', '74', '805', '', 'romantique_pianochair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('806', '74', '806', '', 'romantique_pianochair*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('807', '74', '807', '', 'romantique_divan*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('808', '74', '808', '', 'romantique_divan*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('809', '74', '809', '', 'romantique_divan*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('810', '74', '810', '', 'romantique_divan*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('811', '74', '811', '', 'romantique_divan*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('812', '74', '812', '', 'romantique_chair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('813', '74', '813', '', 'romantique_chair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('814', '74', '814', '', 'romantique_chair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('815', '74', '815', '', 'romantique_chair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('816', '74', '816', '', 'romantique_chair*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('817', '68', '817', '', 'rcandle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('818', '96', '818', '', 'rare_parasol', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('819', '61', '819', '', 'plant_valentinerose*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('820', '61', '820', '', 'plant_valentinerose*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('821', '61', '821', '', 'plant_valentinerose*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('822', '61', '822', '', 'plant_valentinerose*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('823', '61', '823', '', 'plant_valentinerose*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('824', '15', '824', '', 'plant_mazegate', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('825', '15', '825', '', 'plant_maze', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('826', '15', '826', '', 'plant_bulrush', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('827', '108', '827', '', 'petfood4', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('828', '61', '828', '', 'carpet_valentine', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('829', '73', '829', '', 'gothic_carpet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('830', '73', '830', '', 'gothic_carpet2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('831', '73', '831', '', 'gothic_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('832', '73', '832', '', 'gothic_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('833', '73', '833', '', 'gothic_stool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('839', '93', '839', '', 'theatre_seat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('840', '74', '840', '', 'romantique_tray2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('841', '74', '841', '', 'romantique_tray1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('842', '74', '842', '', 'romantique_smalltabl*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('843', '74', '843', '', 'romantique_smalltabl*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('844', '74', '844', '', 'romantique_smalltabl*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('845', '74', '845', '', 'romantique_smalltabl*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('846', '74', '846', '', 'romantique_smalltabl*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('847', '74', '847', '', 'romantique_mirrortabl', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('848', '74', '848', '', 'romantique_divider*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('849', '74', '849', '', 'romantique_divider*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('850', '74', '850', '', 'romantique_divider*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('851', '74', '851', '', 'romantique_divider*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('852', '84', '852', '', 'jp_tatami2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('853', '84', '853', '', 'jp_tatami', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('854', '93', '854', '', 'habbowood_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('855', '84', '855', '', 'jp_bamboo', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('856', '84', '856', '', 'jp_irori', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('857', '84', '857', '', 'jp_pillow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('858', '108', '858', '', 'sound_set_1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('859', '108', '859', '', 'sound_set_2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('860', '108', '860', '', 'sound_set_3', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('861', '108', '861', '', 'sound_set_4', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('862', '108', '862', '', 'sound_set_5', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('863', '108', '863', '', 'sound_set_6', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('864', '108', '864', '', 'sound_set_7', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('865', '108', '865', '', 'sound_set_8', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('866', '108', '866', '', 'sound_set_9', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('867', '108', '867', '', 'sound_machine*1', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('868', '108', '868', '', 'sound_set_23', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('869', '94', '869', '', 'rclr_garden', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('870', '94', '870', '', 'rclr_sofa', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('871', '99', '871', '', 'pura_mdl1*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('872', '99', '872', '', 'pura_mdl1*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('873', '99', '873', '', 'pura_mdl1*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('874', '99', '874', '', 'pura_mdl1*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('875', '99', '875', '', 'pura_mdl1*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('876', '99', '876', '', 'pura_mdl1*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('877', '99', '877', '', 'pura_mdl1*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('878', '99', '878', '', 'pura_mdl1*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('879', '99', '879', '', 'pura_mdl1*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('880', '108', '880', '', 'sound_set_19', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('881', '108', '881', '', 'sound_set_25', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('882', '84', '882', '', 'jp_lantern', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('883', '99', '883', '', 'pura_mdl4*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('884', '99', '884', '', 'pura_mdl4*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('885', '99', '885', '', 'pura_mdl4*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('886', '99', '886', '', 'pura_mdl4*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('887', '99', '887', '', 'pura_mdl4*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('888', '99', '888', '', 'pura_mdl4*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('889', '99', '889', '', 'pura_mdl4*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('890', '99', '890', '', 'pura_mdl4*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('891', '99', '891', '', 'pura_mdl4*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('892', '108', '892', '', 'sound_set_10', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('893', '108', '893', '', 'sound_set_14', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('894', '99', '894', '', 'pura_mdl2*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('895', '99', '895', '', 'pura_mdl2*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('896', '99', '896', '', 'pura_mdl2*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('897', '99', '897', '', 'pura_mdl2*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('898', '99', '898', '', 'pura_mdl2*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('899', '99', '899', '', 'pura_mdl2*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('900', '99', '900', '', 'pura_mdl2*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('901', '99', '901', '', 'pura_mdl2*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('902', '99', '902', '', 'pura_mdl2*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('903', '108', '903', '', 'sound_set_24', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('904', '108', '904', '', 'sound_set_12', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('905', '108', '905', '', 'sound_set_21', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('906', '108', '906', '', 'sound_set_15', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('907', '108', '907', '', 'sound_set_28', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('908', '108', '908', '', 'sound_set_18', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('909', '99', '909', '', 'bed_budget_one*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('910', '99', '910', '', 'bed_budget_one*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('911', '99', '911', '', 'bed_budget_one*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('912', '99', '912', '', 'bed_budget_one*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('913', '99', '913', '', 'bed_budget_one*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('914', '99', '914', '', 'bed_budget_one*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('915', '99', '915', '', 'bed_budget_one*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('916', '99', '916', '', 'bed_budget_one*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('917', '99', '917', '', 'bed_budget_one*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('918', '94', '918', '', 'rare_icecream_campaign', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('919', '108', '919', '', 'sound_set_26', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('920', '99', '920', '', 'pura_mdl5*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('921', '99', '921', '', 'pura_mdl5*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('922', '99', '922', '', 'pura_mdl5*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('923', '99', '923', '', 'pura_mdl5*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('924', '99', '924', '', 'pura_mdl5*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('925', '99', '925', '', 'pura_mdl5*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('926', '99', '926', '', 'pura_mdl5*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('927', '99', '927', '', 'pura_mdl5*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('928', '99', '928', '', 'pura_mdl5*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('929', '93', '929', '', 'rope_divider', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('930', '93', '930', '', 'spotlight', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('931', '74', '931', '', 'romantique_clock', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('932', '108', '932', '', 'sound_set_22', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('933', '84', '933', '', 'jp_drawer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('934', '108', '934', '', 'sound_set_13', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('935', '108', '935', '', 'sound_set_20', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('936', '99', '936', '', 'chair_basic*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('937', '99', '937', '', 'chair_basic*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('938', '99', '938', '', 'chair_basic*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('939', '99', '939', '', 'chair_basic*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('940', '99', '940', '', 'chair_basic*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('941', '99', '941', '', 'chair_basic*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('942', '99', '942', '', 'chair_basic*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('943', '99', '943', '', 'chair_basic*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('944', '99', '944', '', 'chair_basic*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('945', '99', '945', '', 'pura_mdl3*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('946', '99', '946', '', 'pura_mdl3*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('947', '99', '947', '', 'pura_mdl3*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('948', '99', '948', '', 'pura_mdl3*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('949', '99', '949', '', 'pura_mdl3*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('950', '99', '950', '', 'pura_mdl3*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('951', '99', '951', '', 'pura_mdl3*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('952', '99', '952', '', 'pura_mdl3*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('953', '99', '953', '', 'pura_mdl3*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('954', '108', '954', '', 'sound_machine*2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('955', '108', '955', '', 'sound_machine*3', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('956', '108', '956', '', 'sound_machine*4', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('957', '108', '957', '', 'sound_machine*5', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('958', '108', '958', '', 'sound_machine*6', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('959', '108', '959', '', 'sound_machine*7', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('960', '108', '960', '', 'sound_set_27', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('961', '108', '961', '', 'sound_set_17', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('962', '74', '962', '', 'rom_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('963', '99', '963', '', 'bed_budget*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('964', '99', '964', '', 'bed_budget*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('965', '99', '965', '', 'bed_budget*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('966', '99', '966', '', 'bed_budget*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('967', '99', '967', '', 'bed_budget*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('968', '99', '968', '', 'bed_budget*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('969', '99', '969', '', 'bed_budget*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('970', '99', '970', '', 'bed_budget*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('971', '99', '971', '', 'bed_budget*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('972', '108', '972', '', 'sound_set_16', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('973', '94', '973', '', 'rclr_chair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('974', '108', '974', '', 'sound_set_11', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('975', '108', '975', '', 'sound_set_33', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('976', '108', '976', '', 'sound_set_37', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('977', '93', '977', '', 'tile_marble', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('978', '11', '978', '', 'exe_rug', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('979', '93', '979', '', 'tile_stella', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('980', '108', '980', '', 'sound_set_32', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('981', '108', '981', '', 'sound_set_34', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('982', '10', '982', '', 'summer_chair*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('983', '10', '983', '', 'summer_chair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('984', '10', '984', '', 'summer_chair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('985', '10', '985', '', 'summer_chair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('986', '10', '986', '', 'summer_chair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('987', '10', '987', '', 'summer_chair*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('988', '10', '988', '', 'summer_chair*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('989', '10', '989', '', 'summer_chair*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('990', '10', '990', '', 'summer_chair*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('991', '108', '991', '', 'sound_set_29', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('992', '11', '992', '', 'exe_s_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('993', '93', '993', '', 'tile_brown', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('994', '108', '994', '', 'sound_set_36', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('995', '94', '995', '', 'rare_mnstr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('996', '108', '996', '', 'sound_set_30', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('997', '101', '997', '', 'a0 prizetrophy7_b', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('998', '10', '998', '', 'summer_grill*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('999', '10', '999', '', 'summer_grill*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1000', '10', '1000', '', 'summer_grill*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1001', '10', '1001', '', 'summer_grill*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1002', '10', '1002', '', 'summer_pool*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1003', '10', '1003', '', 'summer_pool*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1004', '10', '1004', '', 'summer_pool*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1005', '10', '1005', '', 'summer_pool*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1006', '108', '1006', '', 'sound_set_35', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1007', '108', '1007', '', 'sound_set_31', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1008', '19', '1008', '', 'one_way_door*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1009', '19', '1009', '', 'one_way_door*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1010', '19', '1010', '', 'one_way_door*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1011', '19', '1011', '', 'one_way_door*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1012', '19', '1012', '', 'one_way_door*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1013', '19', '1013', '', 'one_way_door*6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1014', '19', '1014', '', 'one_way_door*7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1015', '19', '1015', '', 'one_way_door*8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1016', '19', '1016', '', 'one_way_door*9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1017', '108', '1017', '', 'sound_machine_pro', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1018', '108', '1018', '', 'song_disk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1019', '108', '1019', '', 'jukebox*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1020', '23', '1020', '', 'carpet_soft_tut', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1021', '108', '1021', '', 'sound_set_44', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1022', '65', '1022', '', 'habboween_crypt', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1023', '108', '1023', '', 'sound_set_41', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1024', '71', '1024', '', 'grunge_sign', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1025', '108', '1025', '', 'sound_set_43', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1026', '108', '1026', '', 'sound_set_40', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1027', '108', '1027', '', 'sound_set_38', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1028', '71', '1028', '', 'grunge_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1029', '71', '1029', '', 'grunge_mattress', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1030', '71', '1030', '', 'grunge_shelf', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1031', '65', '1031', '', 'hal_grave', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1032', '71', '1032', '', 'grunge_radiator', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1033', '108', '1033', '', 'sound_set_39', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1034', '71', '1034', '', 'grunge_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1035', '108', '1035', '', 'sound_set_42', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1036', '65', '1036', '', 'hal_cauldron', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1037', '65', '1037', '', 'habboween_grass', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1038', '108', '1038', '', 'sound_set_47', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1039', '108', '1039', '', 'sound_set_45', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1040', '108', '1040', '', 'sound_set_48', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1041', '108', '1041', '', 'sound_set_46', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1042', '108', '1042', '', 'sound_set_51', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1043', '108', '1043', '', 'sound_set_50', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1044', '108', '1044', '', 'sound_set_52', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1045', '108', '1045', '', 'sound_set_49', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1046', '68', '1046', '', 'plant_maze_snow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1047', '114', '1047', '', 'xmas_cstl_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1048', '68', '1048', '', 'christmas_reindeer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1049', '68', '1049', '', 'tree6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1050', '11', '1050', '', 'exe_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1051', '68', '1051', '', 'plant_mazegate_snow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1052', '114', '1052', '', 'xmas_icelamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1053', '98', '1053', '', 'safe_silo_pb', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1054', '11', '1054', '', 'exe_bardesk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1055', '11', '1055', '', 'exe_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1056', '11', '1056', '', 'exe_drinks', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1057', '114', '1057', '', 'xmas_cstl_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1058', '11', '1058', '', 'exe_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1059', '68', '1059', '', 'christmas_sleigh', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1060', '108', '1060', '', 'sound_set_54', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1061', '11', '1061', '', 'exe_chair2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1062', '114', '1062', '', 'xmas_cstl_twr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1063', '108', '1063', '', 'sound_set_53', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1064', '114', '1064', '', 'tree7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1065', '68', '1065', '', 'christmas_poop', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1066', '11', '1066', '', 'exe_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1067', '108', '1067', '', 'sound_set_58', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1068', '34', '1068', '', 'noob_stool*1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1069', '34', '1069', '', 'noob_stool*2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1070', '34', '1070', '', 'noob_stool*3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1071', '34', '1071', '', 'noob_stool*4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1072', '34', '1072', '', 'noob_stool*5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1073', '34', '1073', '', 'noob_stool*6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1074', '34', '1074', '', 'noob_lamp*1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1075', '34', '1075', '', 'noob_lamp*2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1076', '34', '1076', '', 'noob_lamp*3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1077', '34', '1077', '', 'noob_lamp*4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1078', '34', '1078', '', 'noob_lamp*5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1079', '34', '1079', '', 'noob_lamp*6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1080', '108', '1080', '', 'sound_set_56', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1081', '108', '1081', '', 'sound_set_59', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1082', '108', '1082', '', 'sound_set_55', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1083', '11', '1083', '', 'exe_globe', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1084', '108', '1084', '', 'sound_set_57', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1085', '11', '1085', '', 'exe_plant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1086', '34', '1086', '', 'noob_chair*1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1087', '34', '1087', '', 'noob_chair*2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1088', '34', '1088', '', 'noob_chair*3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1089', '34', '1089', '', 'noob_chair*4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1090', '34', '1090', '', 'noob_chair*5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1091', '34', '1091', '', 'noob_chair*6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1092', '34', '1092', '', 'noob_rug*1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1093', '34', '1093', '', 'noob_rug*2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1094', '34', '1094', '', 'noob_rug*3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1095', '34', '1095', '', 'noob_rug*4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1096', '34', '1096', '', 'noob_rug*5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1097', '34', '1097', '', 'noob_rug*6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1098', '34', '1098', '', 'noob_table*1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1099', '34', '1099', '', 'noob_table*2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1100', '34', '1100', '', 'noob_table*3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1101', '34', '1101', '', 'noob_table*4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1102', '34', '1102', '', 'noob_table*5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1103', '34', '1103', '', 'noob_table*6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1104', '9', '1104', '', 'teleport_door', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1105', '61', '1105', '', 'fortune', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1106', '108', '1106', '', 'sound_set_60', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1107', '61', '1107', '', 'val_randomizer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1108', '61', '1108', '', 'val_choco', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1109', '108', '1109', '', 'sound_set_61', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1110', '61', '1110', '', 'val_teddy*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1111', '61', '1111', '', 'val_teddy*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1112', '61', '1112', '', 'val_teddy*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1113', '61', '1113', '', 'val_teddy*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1114', '61', '1114', '', 'val_teddy*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1115', '61', '1115', '', 'val_teddy*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1116', '94', '1116', '', 'sand_cstl_twr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1117', '71', '1117', '', 'grunge_barrel', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1118', '71', '1118', '', 'grunge_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1119', '71', '1119', '', 'grunge_candle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1120', '94', '1120', '', 'sw_chest', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1121', '107', '1121', '', 'sand_cstl_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1122', '94', '1122', '', 'sw_raven', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1123', '94', '1123', '', 'sand_cstl_gate', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1124', '94', '1124', '', 'sw_table', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1125', '85', '1125', '', 'arabian_tetbl', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1126', '84', '1126', '', 'jp_tray1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1127', '85', '1127', '', 'arabian_teamk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1128', '84', '1128', '', 'jp_tray5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1130', '85', '1130', '', 'arabian_rug', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1131', '84', '1131', '', 'jp_tray6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1132', '85', '1132', '', 'arabian_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1133', '85', '1133', '', 'arabian_pllw', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1134', '85', '1134', '', 'arabian_tray3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1135', '84', '1135', '', 'jp_tray2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1136', '84', '1136', '', 'jp_tray4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1137', '84', '1137', '', 'jp_tray3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1138', '94', '1138', '', 'md_rug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1139', '85', '1139', '', 'arabian_tray4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1141', '85', '1141', '', 'arabian_divdr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1142', '85', '1142', '', 'arabian_bigtb', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1143', '85', '1143', '', 'arabian_snake', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1144', '94', '1144', '', 'rclr_lamp', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1145', '85', '1145', '', 'arabian_tray1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1146', '85', '1146', '', 'arabian_tray2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1147', '94', '1147', '', 'nouvelle_trax', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1148', '94', '1148', '', 'calippo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1149', '108', '1149', '', 'sound_set_64', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1150', '108', '1150', '', 'jukebox_ptv*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1151', '108', '1151', '', 'sound_set_63', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1152', '108', '1152', '', 'sound_set_62', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1153', '108', '1153', '', 'traxgold', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1154', '108', '1154', '', 'traxbronze', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1155', '108', '1155', '', 'traxsilver', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1156', '94', '1156', '', 'bench_puffet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1157', '108', '1157', '', 'footylamp_campaign', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1158', '84', '1158', '', 'jp_katana2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1159', '84', '1159', '', 'jp_katana3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1160', '84', '1160', '', 'jp_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1161', '84', '1161', '', 'jp_rare', '15', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1162', '84', '1162', '', 'jp_katana1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1163', '108', '1163', '', 'sound_set_66', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1164', '86', '1164', '', 'tiki_tray3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1165', '94', '1165', '', 'tampax_rug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1166', '86', '1166', '', 'tiki_tray1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1167', '86', '1167', '', 'tiki_toucan', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1168', '86', '1168', '', 'tiki_waterfall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1169', '108', '1169', '', 'noob_lamp_tradeable*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1170', '108', '1170', '', 'noob_lamp_tradeable*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1171', '108', '1171', '', 'noob_lamp_tradeable*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1172', '108', '1172', '', 'noob_lamp_tradeable*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1173', '108', '1173', '', 'noob_lamp_tradeable*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1174', '108', '1174', '', 'noob_lamp_tradeable*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1175', '30', '1175', '500', 'CFC_500_goldbar', '0', '5000', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1176', '86', '1176', '', 'tiki_tray4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1177', '108', '1177', '', 'sound_set_65', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1178', '108', '1178', '', 'sound_set_70', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1179', '86', '1179', '', 'tiki_tray2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1180', '86', '1180', '', 'tiki_parasol', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1181', '30', '1181', '200', 'CFC_200_moneybag', '0', '2000', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1182', '108', '1182', '', 'sound_set_67', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1183', '30', '1183', '50', 'CFC_50_coin_silver', '0', '500', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1184', '86', '1184', '', 'tiki_torch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1185', '84', '1185', '', 'jp_teamaker', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1186', '108', '1186', '', 'noob_chair_tradeable*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1187', '108', '1187', '', 'noob_chair_tradeable*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1188', '108', '1188', '', 'noob_chair_tradeable*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1189', '108', '1189', '', 'noob_chair_tradeable*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1190', '108', '1190', '', 'noob_chair_tradeable*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1191', '108', '1191', '', 'noob_chair_tradeable*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1192', '86', '1192', '', 'tiki_junglerug', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1193', '86', '1193', '', 'tiki_statue', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1194', '34', '1194', '', 'noob_plant', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1195', '86', '1195', '', 'tiki_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1196', '86', '1196', '', 'tiki_bflies', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1197', '108', '1197', '', 'noob_rug_tradeable*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1198', '108', '1198', '', 'noob_rug_tradeable*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1199', '108', '1199', '', 'noob_rug_tradeable*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1200', '108', '1200', '', 'noob_rug_tradeable*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1201', '108', '1201', '', 'noob_rug_tradeable*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1202', '108', '1202', '', 'noob_rug_tradeable*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1203', '86', '1203', '', 'tiki_tray0', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1204', '108', '1204', '', 'sound_set_68', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1205', '86', '1205', '', 'tiki_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1206', '86', '1206', '', 'tiki_bardesk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1207', '30', '1207', '100', 'CFC_100_coin_gold', '0', '1000', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1208', '108', '1208', '10', 'CFC_10_coin_bronze', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1209', '86', '1209', '', 'tiki_sand', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1210', '108', '1210', '', 'sound_set_69', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1211', '70', '1211', '', 'diner_tray_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1212', '94', '1212', '', 'svnr_de', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1213', '70', '1213', '', 'diner_tray_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1214', '70', '1214', '', 'diner_rug', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1215', '70', '1215', '', 'diner_sofa_2*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1216', '70', '1216', '', 'diner_sofa_2*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1217', '70', '1217', '', 'diner_sofa_2*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1218', '70', '1218', '', 'diner_sofa_2*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1219', '70', '1219', '', 'diner_sofa_2*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1220', '70', '1220', '', 'diner_sofa_2*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1221', '70', '1221', '', 'diner_sofa_2*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1222', '70', '1222', '', 'diner_sofa_2*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1223', '70', '1223', '', 'diner_sofa_2*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1224', '94', '1224', '', 'svnr_it', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1225', '70', '1225', '', 'diner_shaker', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1226', '70', '1226', '', 'diner_tray_5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1227', '70', '1227', '', 'diner_cashreg*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1228', '70', '1228', '', 'diner_cashreg*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1229', '70', '1229', '', 'diner_cashreg*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1230', '70', '1230', '', 'diner_cashreg*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1231', '70', '1231', '', 'diner_cashreg*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1232', '70', '1232', '', 'diner_cashreg*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1233', '70', '1233', '', 'diner_cashreg*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1234', '70', '1234', '', 'diner_cashreg*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1235', '70', '1235', '', 'diner_cashreg*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1236', '94', '1236', '', 'svnr_nl', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1237', '70', '1237', '', 'diner_tray_6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1238', '70', '1238', '', 'diner_gumvendor*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1239', '70', '1239', '', 'diner_gumvendor*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1240', '70', '1240', '', 'diner_gumvendor*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1241', '70', '1241', '', 'diner_gumvendor*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1242', '70', '1242', '', 'diner_gumvendor*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1243', '70', '1243', '', 'diner_gumvendor*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1244', '70', '1244', '', 'diner_gumvendor*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1245', '70', '1245', '', 'diner_gumvendor*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1246', '70', '1246', '', 'diner_gumvendor*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1247', '94', '1247', '', 'svnr_aus', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1248', '70', '1248', '', 'diner_tray_0', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1249', '94', '1249', '', 'svnr_uk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1250', '70', '1250', '', 'diner_tray_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1251', '70', '1251', '', 'diner_tray_7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1252', '70', '1252', '', 'diner_tray_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1253', '70', '1253', '', 'diner_bardesk_gate*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1254', '70', '1254', '', 'diner_bardesk_gate*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1255', '70', '1255', '', 'diner_bardesk_gate*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1256', '70', '1256', '', 'diner_bardesk_gate*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1257', '70', '1257', '', 'diner_bardesk_gate*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1258', '70', '1258', '', 'diner_bardesk_gate*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1259', '70', '1259', '', 'diner_bardesk_gate*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1260', '70', '1260', '', 'diner_bardesk_gate*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1261', '70', '1261', '', 'diner_bardesk_gate*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1262', '70', '1262', '', 'diner_bardesk*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1263', '70', '1263', '', 'diner_bardesk*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1264', '70', '1264', '', 'diner_bardesk*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1265', '70', '1265', '', 'diner_bardesk*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1266', '70', '1266', '', 'diner_bardesk*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1267', '70', '1267', '', 'diner_bardesk*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1268', '70', '1268', '', 'diner_bardesk*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1269', '70', '1269', '', 'diner_bardesk*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1270', '70', '1270', '', 'diner_bardesk*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1271', '94', '1271', '', 'ads_dave_cns', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1272', '70', '1272', '', 'diner_chair*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1273', '70', '1273', '', 'diner_chair*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1274', '70', '1274', '', 'diner_chair*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1275', '70', '1275', '', 'diner_chair*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1276', '70', '1276', '', 'diner_chair*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1277', '70', '1277', '', 'diner_chair*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1278', '70', '1278', '', 'diner_chair*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1279', '70', '1279', '', 'diner_chair*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1280', '70', '1280', '', 'diner_chair*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1281', '70', '1281', '', 'diner_bardesk_corner*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1282', '70', '1282', '', 'diner_bardesk_corner*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1283', '70', '1283', '', 'diner_bardesk_corner*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1284', '70', '1284', '', 'diner_bardesk_corner*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1285', '70', '1285', '', 'diner_bardesk_corner*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1286', '70', '1286', '', 'diner_bardesk_corner*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1287', '70', '1287', '', 'diner_bardesk_corner*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1288', '70', '1288', '', 'diner_bardesk_corner*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1289', '70', '1289', '', 'diner_bardesk_corner*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1290', '70', '1290', '', 'diner_table_2*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1291', '70', '1291', '', 'diner_table_2*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1292', '70', '1292', '', 'diner_table_2*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1293', '70', '1293', '', 'diner_table_2*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1294', '70', '1294', '', 'diner_table_2*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1295', '70', '1295', '', 'diner_table_2*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1296', '70', '1296', '', 'diner_table_2*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1297', '70', '1297', '', 'diner_table_2*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1298', '70', '1298', '', 'diner_table_2*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1299', '70', '1299', '', 'diner_sofa_1*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1300', '70', '1300', '', 'diner_sofa_1*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1301', '70', '1301', '', 'diner_sofa_1*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1302', '70', '1302', '', 'diner_sofa_1*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1303', '70', '1303', '', 'diner_sofa_1*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1304', '70', '1304', '', 'diner_sofa_1*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1305', '70', '1305', '', 'diner_sofa_1*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1306', '70', '1306', '', 'diner_sofa_1*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1307', '70', '1307', '', 'diner_sofa_1*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1308', '70', '1308', '', 'diner_table_1*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1309', '70', '1309', '', 'diner_table_1*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1310', '70', '1310', '', 'diner_table_1*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1311', '70', '1311', '', 'diner_table_1*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1312', '70', '1312', '', 'diner_table_1*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1313', '70', '1313', '', 'diner_table_1*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1314', '70', '1314', '', 'diner_table_1*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1315', '70', '1315', '', 'diner_table_1*8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1316', '70', '1316', '', 'diner_table_1*9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1317', '87', '1317', '', 'greek_seat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1318', '94', '1318', '', 'easy_bowl2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1319', '87', '1319', '', 'greek_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1320', '87', '1320', '', 'greek_pillars', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1321', '87', '1321', '', 'greek_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1322', '94', '1322', '', 'easy_carpet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1326', '87', '1326', '', 'greek_block', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1327', '94', '1327', '', 'netari_carpet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1328', '7', '1328', '', 'hcc_shelf', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1329', '94', '1329', '', 'det_divider', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1330', '7', '1330', '', 'hcc_chair', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1331', '7', '1331', '', 'hcc_stool', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1332', '7', '1332', '', 'hcc_sofa', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1333', '94', '1333', '', 'det_body', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1334', '7', '1334', '', 'hcc_table', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1335', '7', '1335', '', 'hcc_minibar', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1336', '7', '1336', '', 'hcc_sofachair', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1337', '7', '1337', '', 'hcc_crnr', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1338', '7', '1338', '', 'hcc_dvdr', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1339', '23', '1339', '', 'sob_carpet', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1340', '94', '1340', '', 'igor_seat', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1341', '94', '1341', '', 'ads_711*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1342', '94', '1342', '', 'ads_711*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1343', '94', '1343', '', 'ads_711*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1344', '94', '1344', '', 'ads_711*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1345', '94', '1345', '', 'ads_igorswitch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1346', '94', '1346', '', 'ads_igorraygun', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1347', '94', '1347', '', 'ads_igorbrain', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1348', '66', '1348', '', 'hween08_bed2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1349', '66', '1349', '', 'hween08_defibs', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1350', '66', '1350', '', 'hween08_defibs2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1351', '66', '1351', '', 'hween08_sink2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1352', '66', '1352', '', 'hween08_trll', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1353', '66', '1353', '', 'hween08_curtain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1354', '66', '1354', '', 'hween08_bbag', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1355', '66', '1355', '', 'hween08_sink', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1356', '66', '1356', '', 'hween08_bed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1357', '66', '1357', '', 'hween08_manhole', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1358', '66', '1358', '', 'hween08_bath2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1359', '66', '1359', '', 'hween08_bath', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1360', '66', '1360', '', 'hween08_curtain2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1361', '75', '1361', '', 'party_block2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1362', '75', '1362', '', 'party_tube_bubble', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1363', '75', '1363', '', 'party_seat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1364', '75', '1364', '', 'party_mic', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1365', '75', '1365', '', 'party_djtable', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1366', '75', '1366', '', 'party_tray', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1367', '75', '1367', '', 'party_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1368', '75', '1368', '', 'party_barcorn', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1369', '75', '1369', '', 'party_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1370', '75', '1370', '', 'party_block', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1371', '75', '1371', '', 'party_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1372', '75', '1372', '', 'party_beamer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1373', '75', '1373', '', 'party_bardesk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1374', '75', '1374', '', 'party_discol', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1375', '75', '1375', '', 'party_ball', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1376', '75', '1376', '', 'party_ravel', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1377', '75', '1377', '', 'party_tube_lava', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1378', '114', '1378', '', 'xmas08_icetree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1379', '114', '1379', '', 'xmas08_lantern', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1380', '114', '1380', '', 'penguin_robot', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1381', '114', '1381', '', 'xmas08_dvdr2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1382', '114', '1382', '', 'penguin_elf', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1383', '114', '1383', '', 'xmas08_trph1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1384', '114', '1384', '', 'penguin_skater', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1385', '68', '1385', '', 'campfire', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1386', '114', '1386', '', 'penguin_bunny', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1387', '114', '1387', '', 'penguin_ninja', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1388', '114', '1388', '', 'penguin_basic', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1389', '114', '1389', '', 'xmas08_telep', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1390', '114', '1390', '', 'penguin_boxer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1391', '114', '1391', '', 'xmas08_hole', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1392', '114', '1392', '', 'penguin_ski', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1393', '114', '1393', '', 'xmas_snow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1394', '114', '1394', '', 'penguin_infected', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1395', '114', '1395', '', 'penguin_swim', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1396', '114', '1396', '', 'xmas08_geysir', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1397', '114', '1397', '', 'xmas08_hottub', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1398', '114', '1398', '', 'penguin_cowboy', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1399', '114', '1399', '', 'penguin_icehockey', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1400', '114', '1400', '', 'penguin_clown', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1401', '114', '1401', '', 'penguin_wrestler', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1402', '94', '1402', '', 'svnr_fi', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1403', '114', '1403', '', 'xmas08_dvdr1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1404', '114', '1404', '', 'penguin_glow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1405', '114', '1405', '', 'penguin_sumo', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1406', '114', '1406', '', 'penguin_musketeer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1407', '114', '1407', '', 'penguin_ballet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1408', '114', '1408', '', 'penguin_magician', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1409', '114', '1409', '', 'penguin_super', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1410', '114', '1410', '', 'penguin_pirate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1411', '108', '1411', '', 'sound_set_71', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1412', '114', '1412', '', 'xmas08_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1413', '114', '1413', '', 'xmas08_icerug', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1414', '114', '1414', '', 'penguin_hunchback', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1415', '114', '1415', '', 'penguin_punk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1416', '114', '1416', '', 'xmas08_snowpl', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1417', '114', '1417', '', 'xmas08_cubetree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1418', '114', '1418', '', 'penguin_pilot', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1419', '114', '1419', '', 'penguin_suit', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1420', '114', '1420', '', 'xmas08_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1421', '114', '1421', '', 'penguin_rock', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1422', '35', '1422', '', 'fx_explosion', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1423', '35', '1423', '', 'fx_bubble', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1424', '35', '1424', '', 'fx_flare', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1425', '94', '1425', '', 'ads_cltele', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1426', '68', '1426', '', 'xmas08_trph2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1427', '89', '1427', '', 'lostc_merdragon', '15', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1428', '94', '1428', '', 'ads_cldesk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1429', '94', '1429', '', 'ads_ob_pillow', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1430', '94', '1430', '', 'ads_clfloor', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1431', '107', '1431', '', 'ads_mall_tele', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1432', '94', '1432', '', 'ads_cllava2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1433', '88', '1433', '', 'bolly_lotus_pool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1434', '108', '1434', '', 'kinkysofa', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1435', '83', '1435', '', 'china_moongt', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1436', '83', '1436', '', 'china_ox', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1437', '88', '1437', '', 'bolly_petals', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1438', '88', '1438', '', 'bolly_tile2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1439', '88', '1439', '', 'bolly_tile1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1440', '88', '1440', '', 'bolly_fountain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1441', '88', '1441', '', 'bolly_pillow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1442', '88', '1442', '', 'bolly_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1443', '88', '1443', '', 'bolly_drapec', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1444', '88', '1444', '', 'bolly_phant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1445', '88', '1445', '', 'bolly_desk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1446', '88', '1446', '', 'bolly_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1447', '88', '1447', '', 'bolly_monkey_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1448', '88', '1448', '', 'bolly_swing', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1449', '88', '1449', '', 'bolly_drapea', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1450', '108', '1450', '', 'bolly_palm', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1451', '88', '1451', '', 'bolly_drapeb', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1452', '88', '1452', '', 'bolly_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1453', '88', '1453', '', 'bolly_tree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1454', '88', '1454', '', 'bolly_vase', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1455', '94', '1455', '', 'planet_of_love', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1456', '94', '1456', '', 'ads_idol_floor1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1457', '94', '1457', '', 'ads_igor_flask', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1458', '94', '1458', '', 'ads_idol_floor2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1459', '94', '1459', '', 'ads_idol_drape', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1460', '94', '1460', '', 'ads_igor_dsk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1461', '94', '1461', '', 'ads_idol_desk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1462', '94', '1462', '', 'ads_idol_ch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1463', '89', '1463', '', 'lostc_octopus', '15', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1464', '107', '1464', '', 'ads_idol_tele', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1465', '94', '1465', '', 'ads_idol_mic', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1466', '94', '1466', '', 'ads_idol_trax', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1467', '94', '1467', '', 'ads_idol_pchair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1468', '94', '1468', '', 'ads_idol_audChr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1469', '94', '1469', '', 'ads_idol_piano', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1470', '94', '1470', '', 'ads_idol_jukebox*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1471', '89', '1471', '', 'lc_glass_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1472', '89', '1472', '', 'lc_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1473', '89', '1473', '', 'lc_crab1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1474', '89', '1474', '', 'lc_stool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1475', '89', '1475', '', 'lc_medusa1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1476', '89', '1476', '', 'lc_tubes_straight', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1477', '94', '1477', '', 'ads_711shelf', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1478', '89', '1478', '', 'lc_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1479', '89', '1479', '', 'lc_crab2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1480', '89', '1480', '', 'lc_tile2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1481', '89', '1481', '', 'lc_desk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1482', '89', '1482', '', 'lostc_teleport', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1483', '89', '1483', '', 'lc_tubes_corners', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1484', '89', '1484', '', 'lc_medusa2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1485', '89', '1485', '', 'lc_anemone', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1486', '89', '1486', '', 'lc_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1487', '89', '1487', '', 'lc_tile1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1488', '89', '1488', '', 'lc_coral_divider_low', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1489', '89', '1489', '', 'lc_coral_divider_hi', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1490', '94', '1490', '', 'ads_idol_clRack', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1491', '94', '1491', '', 'ads_idol_hotspot', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1492', '94', '1492', '', 'ads_idol_voting_ch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1493', '108', '1493', '', 'eco_light2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1494', '108', '1494', '', 'eco_cactus1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1495', '108', '1495', '', 'eco_chair1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1496', '108', '1496', '', 'eco_cactus3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1497', '108', '1497', '', 'eco_table3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1498', '37', '1498', '', 'bump_tottero', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1499', '108', '1499', '', 'eco_sofa3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1500', '108', '1500', '', 'eco_table2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1501', '37', '1501', '', 'bump_signs', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1502', '108', '1502', '', 'eco_lamp3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1503', '108', '1503', '', 'eco_lamp2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1504', '108', '1504', '', 'eco_tree1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1505', '108', '1505', '', 'eco_chair3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1506', '108', '1506', '', 'ecotron_box', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1507', '108', '1507', '', 'eco_sofa1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1508', '108', '1508', '', 'eco_lamp1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1509', '108', '1509', '', 'eco_light1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1510', '108', '1510', '', 'eco_table1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1511', '108', '1511', '', 'eco_sofa2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1512', '37', '1512', '', 'bump_tires', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1513', '108', '1513', '', 'eco_fruits2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1514', '37', '1514', '', 'bump_lights', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1515', '108', '1515', '', 'eco_fruits3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1516', '108', '1516', '', 'eco_cactus2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1517', '108', '1517', '', 'eco_chair2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1518', '108', '1518', '', 'eco_fruits1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1519', '108', '1519', '', 'eco_light3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1520', '108', '1520', '', 'eco_tree2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1521', '37', '1521', '', 'bump_road', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1522', '94', '1522', '', 'ads_frankb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1523', '94', '1523', '', 'ads_grefusa_cactus', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1524', '86', '1524', '', 'totem_leg', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1525', '11', '1525', '', 'exe_artlamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1526', '15', '1526', '', 'env_bushes', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1527', '94', '1527', '', 'ads_idol_newsDsk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1528', '15', '1528', '', 'env_tree1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1529', '15', '1529', '', 'env_tree4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1530', '11', '1530', '', 'exe_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1531', '94', '1531', '', 'ads_idol_cork', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1532', '11', '1532', '', 'exe_cubelight', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1533', '11', '1533', '', 'exe_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1534', '15', '1534', '', 'env_tree2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1535', '94', '1535', '', 'ads_idol_ichair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1536', '15', '1536', '', 'env_tree3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1537', '94', '1537', '', 'ads_idol_tube', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1538', '94', '1538', '', 'ads_cl_jukeb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1539', '15', '1539', '', 'env_bushes_gate', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1540', '15', '1540', '', 'env_grass', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1541', '112', '1541', '', 'tray_glasstower', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1542', '94', '1542', '', 'ads_malaco_gu', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1543', '94', '1543', '', 'ads_reebok_block2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1544', '112', '1544', '', 'tray_cake', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1545', '112', '1545', '', 'tray_champagne', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1546', '94', '1546', '', 'ads_malaco_rug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1547', '112', '1547', '', 'ads_idol_tblCloth', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1548', '94', '1548', '', 'ads_cl_sofa', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1549', '112', '1549', '', 'ads_idol_lamp', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1550', '94', '1550', '', 'ads_clcake', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1551', '94', '1551', '', 'ads_idol_carpet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1552', '77', '1552', '', 'country_fnc2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1553', '108', '1553', '', 'eco_mush1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1554', '77', '1554', '', 'country_rbw', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1555', '108', '1555', '', 'sound_set_72', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1556', '77', '1556', '', 'country_soil', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1557', '77', '1557', '', 'country_log', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1558', '77', '1558', '', 'country_trctr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1559', '77', '1559', '', 'country_stage', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1560', '77', '1560', '', 'country_well', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1561', '77', '1561', '', 'country_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1562', '94', '1562', '', 'ads_goldtabl', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1563', '77', '1563', '', 'country_fnc3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1564', '77', '1564', '', 'country_rain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1565', '77', '1565', '', 'country_fnc1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1566', '108', '1566', '', 'eco_mush2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1567', '94', '1567', '', 'ads_calip_cola*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1568', '94', '1568', '', 'ads_calip_cola*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1569', '94', '1569', '', 'ads_calip_cola*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1570', '94', '1570', '', 'ads_calip_cola*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1571', '77', '1571', '', 'country_scarecrow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1572', '94', '1572', '', 'env_telep', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1573', '77', '1573', '', 'country_grass', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1574', '77', '1574', '', 'country_wheat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1575', '77', '1575', '', 'country_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1576', '77', '1576', '', 'country_ditch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1577', '77', '1577', '', 'country_patio', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1578', '86', '1578', '', 'totem_head', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1579', '94', '1579', '', 'ads_calip_chair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1580', '94', '1580', '', 'ads_idol_trophy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1581', '90', '1581', '', 'LT_pillar2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1582', '90', '1582', '', 'LT_throne', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1583', '90', '1583', '', 'lt_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1584', '94', '1584', '', 'laptopdesk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1585', '90', '1585', '', 'lt_bughill', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1586', '90', '1586', '', 'lt_stage2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1587', '90', '1587', '', 'lt_lava', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1588', '90', '1588', '', 'lt_stone2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1589', '90', '1589', '', 'lt_spider', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1590', '94', '1590', '', 'audChr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1591', '90', '1591', '', 'lt_lavac', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1592', '94', '1592', '', 'saturn', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1593', '94', '1593', '', 'ads_calip_pool', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1594', '90', '1594', '', 'lt_stage1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1595', '94', '1595', '', 'clrack', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1596', '90', '1596', '', 'lt_statue', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1597', '94', '1597', '', 'noticeboard', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1598', '90', '1598', '', 'LT_pillar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1599', '90', '1599', '', 'lt_patch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1600', '90', '1600', '', 'LT_skull', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1601', '94', '1601', '', 'ads_calip_tele', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1602', '94', '1602', '', 'ads_calip_parasol', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1603', '90', '1603', '', 'lt_stone1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1604', '94', '1604', '', 'ads_calip_lava', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1605', '94', '1605', '', 'ads_calip_fan', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1606', '94', '1606', '', 'transparent_floor', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1607', '86', '1607', '', 'totem_planet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1608', '94', '1608', '', 'voting_ch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1609', '94', '1609', '', 'ads_mall_coffeem', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1610', '76', '1610', '', 'sf_roof', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1611', '76', '1611', '', 'SF_crate_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1612', '76', '1612', '', 'SF_crate_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1613', '76', '1613', '', 'sf_stick', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1614', '76', '1614', '', 'SF_chair_blue', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1615', '76', '1615', '', 'SF_panel3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1616', '76', '1616', '', 'sf_roller', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1617', '76', '1617', '', 'SF_alien', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1618', '76', '1618', '', 'SF_floor_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1619', '76', '1619', '', 'SF_reactor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1620', '76', '1620', '', 'sf_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1621', '76', '1621', '', 'sf_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1622', '76', '1622', '', 'SF_chair_green', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1623', '94', '1623', '', 'ads_mall_kiosk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1624', '76', '1624', '', 'SF_panel1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1625', '76', '1625', '', 'SF_panel2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1626', '76', '1626', '', 'sf_pod', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1627', '76', '1627', '', 'SF_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1628', '76', '1628', '', 'sf_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1629', '76', '1629', '', 'SF_floor_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1630', '76', '1630', '', 'SF_chair_red', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1631', '76', '1631', '', 'SF_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1632', '101', '1632', '', 'a0 prizetrophy_cool', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1633', '94', '1633', '', 'ads_elisa_gnome', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1634', '10', '1634', '', 'summer_raft2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1635', '10', '1635', '', 'summer_raft1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1636', '101', '1636', '', 'prizetrophy_hot', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1637', '94', '1637', '', 'ads_oc_soda', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1638', '10', '1638', '', 'summer_icebox', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1639', '96', '1639', '', 'marsrug', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1640', '78', '1640', '', 'rela_stone', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1641', '78', '1641', '', 'rela_candles1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1642', '78', '1642', '', 'rela_candle3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1643', '78', '1643', '', 'rela_candles3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1644', '94', '1644', '', 'pix_asteroid', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1645', '78', '1645', '', 'rela_candle1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1646', '78', '1646', '', 'rela_orchid', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1647', '78', '1647', '', 'rela_stick', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1648', '94', '1648', '', 'ads_711*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1649', '94', '1649', '', 'ads_711*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1650', '94', '1650', '', 'ads_711*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1651', '78', '1651', '', 'rela_candle2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1652', '78', '1652', '', 'rela_candles2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1653', '78', '1653', '', 'rela_plant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1654', '78', '1654', '', 'rela_hchair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1655', '78', '1655', '', 'rela_rock', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1656', '18', '1656', '', 'ktchn_fridge', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1657', '18', '1657', '', 'ktchn_inspctr', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1658', '94', '1658', '', 'ads_1800tele', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1659', '18', '1659', '', 'ktchn_pots', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1660', '18', '1660', '', 'ktchn_countr_2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1661', '18', '1661', '', 'ktchn_gate', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1662', '18', '1662', '', 'ktchn_bBlock', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1663', '18', '1663', '', 'ktchn_stove', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1664', '18', '1664', '', 'ktchn_cornr', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1665', '18', '1665', '', 'ktchn_light', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1666', '18', '1666', '', 'ktchn_dvdr', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1667', '18', '1667', '', 'ktchn_desk', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1668', '18', '1668', '', 'ktchn_countr_1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1669', '18', '1669', '', 'ktchn_sink', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1670', '18', '1670', '', 'ktchn_plates', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1671', '18', '1671', '', 'ktchn_trash', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1672', '79', '1672', '', 'urban_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1673', '79', '1673', '', 'urban_bin', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1674', '79', '1674', '', 'urban_fence', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1675', '79', '1675', '', 'urban_carsofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1676', '79', '1676', '', 'urban_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1677', '79', '1677', '', 'urban_blocker', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1678', '79', '1678', '', 'urban_bsktbll', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1679', '79', '1679', '', 'urban_wpost', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1680', '76', '1680', '', 'sf_mbar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1681', '79', '1681', '', 'urban_sidewalk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1682', '79', '1682', '', 'urban_fence_corner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1683', '94', '1683', '', 'ads_idol_l_carpet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1684', '94', '1684', '', 'ads_gsArcade_1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1685', '94', '1685', '', 'ads_gsArcade_2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1686', '94', '1686', '', 'ads_mtvtrophy_gold', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1687', '94', '1687', '', 'ads_spang_sleep', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1688', '94', '1688', '', 'ads_mtvtrophy_silver', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1689', '65', '1689', '', 'hween09_organ', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1690', '94', '1690', '', 'ads_idol_chmpgn', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1691', '79', '1691', '', 'urban_bench_plain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1692', '65', '1692', '', 'hween09_hatch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1693', '65', '1693', '', 'hween09_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1694', '65', '1694', '', 'hween09_jar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1695', '65', '1695', '', 'hween09_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1696', '94', '1696', '', 'byesw_hotel', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1697', '65', '1697', '', 'hween09_ghost', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1698', '94', '1698', '', 'byesw_hand', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1699', '65', '1699', '', 'hween09_tv', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1700', '65', '1700', '', 'hween09_mirror', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1701', '65', '1701', '', 'hween09_chandelier', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1702', '65', '1702', '', 'hween09_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1703', '94', '1703', '', 'ads_twi_toolbx', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1704', '94', '1704', '', 'ads_twi_table', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1705', '94', '1705', '', 'ads_twi_tower', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1706', '94', '1706', '', 'ads_twi_piano', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1707', '94', '1707', '', 'ads_twi_chair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1708', '94', '1708', '', 'ads_twi_fountn', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1709', '94', '1709', '', 'ads_twi_dvdr2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1710', '94', '1710', '', 'ads_twi_dvdr1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1711', '94', '1711', '', 'ads_twi_roses', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1712', '11', '1712', '', 'exe_elevator', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1713', '94', '1713', '', 'ads_mall_elevator', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1714', '18', '1714', '', 'ktchn_hlthNut', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1715', '94', '1715', '', 'ads_twi_mist', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1716', '108', '1716', '', 'nest_plow_bro', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1717', '108', '1717', '', 'nest_snug_grn', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1718', '94', '1718', '', 'ads_twi_trophy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1719', '85', '1719', '', 'arabian_tile', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1720', '68', '1720', '', 'xm09_lrgBauble', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1721', '68', '1721', '', 'xm09_candyCane', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1722', '108', '1722', '', 'nest_snug_blu', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1723', '108', '1723', '', 'nest_plow_blu', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1724', '108', '1724', '', 'nest_snug_red', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1725', '108', '1725', '', 'nest_plow_reg', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1726', '108', '1726', '', 'nest_snug_yel', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1727', '108', '1727', '', 'nest_plow_red', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1728', '108', '1728', '', 'petfood7', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1729', '108', '1729', '', 'petfood9', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1730', '108', '1730', '', 'petfood6', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1731', '108', '1731', '', 'petfood5', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1732', '108', '1732', '', 'petfood8', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1733', '108', '1733', '', 'petfood10', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1734', '69', '1734', '', 'party_lantern', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1735', '114', '1735', '', 'xm09_man_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1736', '114', '1736', '', 'xm09_man_c', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1737', '114', '1737', '', 'xm09_man_a', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1738', '108', '1738', '', 'nest_dirt', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1739', '108', '1739', '', 'nest_snug_prp', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1740', '108', '1740', '', 'nest_basket', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1741', '108', '1741', '', 'nest_nest', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1742', '68', '1742', '', 'xm09_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1743', '108', '1743', '', 'nest_nails', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1744', '68', '1744', '', 'xm09_cocoa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1745', '108', '1745', '', 'nest_snug_bla', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1746', '108', '1746', '', 'nest_ice', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1747', '68', '1747', '', 'xm09_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1748', '108', '1748', '', 'nest_plow_skl', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1749', '94', '1749', '', 'ads_cl_moodi', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1750', '101', '1750', '', 'prizetrophy_nrj', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1751', '83', '1751', '', 'china_tiger', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1752', '94', '1752', '', 'org_chrblk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1753', '83', '1753', '', 'china_tigrSeat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1754', '94', '1754', '', 'org_tblblk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1755', '94', '1755', '', 'org_lamppnk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1756', '94', '1756', '', 'org_chairblk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1757', '94', '1757', '', 'org_chrpnk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1758', '1', '1758', '', 'xm09_trophy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1759', '94', '1759', '', 'org_tblpnk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1760', '94', '1760', '', 'org_lampblk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1761', '94', '1761', '', 'org_chairpnk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1762', '83', '1762', '', 'china_plmTree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1763', '94', '1763', '', 'org_table', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1764', '61', '1764', '', 'val09_floor2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1765', '108', '1765', '', 'petfood11', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1766', '108', '1766', '', 'petfood13', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1767', '62', '1767', '', 'bling_chair_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1768', '62', '1768', '', 'bling_chair_c', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1769', '62', '1769', '', 'bling_toilet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1770', '61', '1770', '', 'val09_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1771', '62', '1771', '', 'bling_bed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1772', '94', '1772', '', 'ads_droetker_paula', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1773', '62', '1773', '', 'bling_fridge', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1774', '94', '1774', '', 'ads_chups', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1775', '62', '1775', '', 'bling_chair_a', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1776', '62', '1776', '', 'bling_pool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1777', '108', '1777', '', 'petfood12', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1778', '62', '1778', '', 'bling_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1779', '108', '1779', '', 'present_wrap*1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1780', '108', '1780', '', 'present_wrap*10', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1781', '108', '1781', '', 'present_wrap*2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1782', '108', '1782', '', 'present_wrap*3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1783', '108', '1783', '', 'present_wrap*4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1784', '108', '1784', '', 'present_wrap*5', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1785', '108', '1785', '', 'present_wrap*6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1786', '108', '1786', '', 'present_wrap*7', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1787', '108', '1787', '', 'present_wrap*8', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1788', '108', '1788', '', 'present_wrap*9', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1789', '61', '1789', '', 'val_basket', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1790', '61', '1790', '', 'teddy_pink', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1791', '61', '1791', '', 'teddy_pendergrass', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1792', '61', '1792', '', 'teddy_bear', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1793', '61', '1793', '', 'val_hSeat*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1794', '61', '1794', '', 'val_hSeat*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1795', '61', '1795', '', 'val_hSeat*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1796', '61', '1796', '', 'val_hSeat*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1797', '61', '1797', '', 'val_hSeat*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1798', '61', '1798', '', 'val_hSeat*6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1799', '61', '1799', '', 'val_hSeat*7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1800', '61', '1800', '', 'teddy_basic', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1801', '108', '1801', '', 'bling_fridge_restricted', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1802', '94', '1802', '', 'ads_percyrock', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1803', '62', '1803', '', 'bling_shwr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1804', '61', '1804', '', 'val_table1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1805', '94', '1805', '', 'rare_trex', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1806', '94', '1806', '', 'rare_ironmaiden', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1807', '94', '1807', '', 'crystal_patch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1808', '64', '1808', '', 'beanstalk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1809', '94', '1809', '', 'rare_mmmth', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1810', '94', '1810', '', 'rare_vdoll', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1811', '64', '1811', '', 'garden_mursu', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1812', '64', '1812', '', 'garden_jyrki', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1813', '64', '1813', '', 'garden_seed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1814', '64', '1814', '', 'garden_lupin3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1815', '64', '1815', '', 'garden_mursu3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1816', '64', '1816', '', 'garden_flo2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1817', '101', '1817', '', 'prizetrophy_thumb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1818', '64', '1818', '', 'garden_lupin5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1819', '64', '1819', '', 'garden_mursu2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1820', '64', '1820', '', 'garden_orchtree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1821', '64', '1821', '', 'garden_mursu4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1822', '64', '1822', '', 'garden_flolamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1823', '64', '1823', '', 'garden_lupin2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1824', '64', '1824', '', 'garden_staringbush', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1825', '64', '1825', '', 'garden_flo1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1826', '64', '1826', '', 'garden_lupin4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1827', '64', '1827', '', 'garden_flytrap', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1828', '64', '1828', '', 'garden_lupin1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1829', '64', '1829', '', 'garden_jungle', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1830', '94', '1830', '', 'ads_grefusa_yum', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1831', '64', '1831', '', 'garden_volcano', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1832', '64', '1832', '', 'garden_leaves', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1833', '64', '1833', '', 'garden_flo3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1834', '80', '1834', '', 'runway_bigchr_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1835', '7', '1835', '', 'hc2_vase', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1836', '80', '1836', '', 'runway_chair_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1837', '7', '1837', '', 'hc2_cart', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1838', '7', '1838', '', 'hc3_divider', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1839', '80', '1839', '', 'runway_head', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1840', '80', '1840', '', 'runway_block_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1841', '7', '1841', '', 'hc2_sofatbl', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1842', '80', '1842', '', 'runway_bigchr_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1843', '7', '1843', '', 'hc2_armchair', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1844', '80', '1844', '', 'runway_manqn_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1845', '7', '1845', '', 'hc3_shelf', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1846', '7', '1846', '', 'hc2_barchair', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1847', '7', '1847', '', 'hc2_carpet', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1848', '7', '1848', '', 'hc3_sofa', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1849', '80', '1849', '', 'runway_stool', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1850', '80', '1850', '', 'runway_block_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1851', '80', '1851', '', 'runway_table_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1852', '7', '1852', '', 'hc3_bard', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1853', '7', '1853', '', 'hc2_biglamp', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1854', '7', '1854', '', 'hc3_hugelamp', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1855', '7', '1855', '', 'hc3_stool', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1856', '7', '1856', '', 'hc2_divider', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1857', '7', '1857', '', 'hc2_coffee', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1858', '80', '1858', '', 'runway_chair_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1859', '7', '1859', '', 'hc2_sofa', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1860', '94', '1860', '', 'ads_cheetos', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1861', '80', '1861', '', 'runway_bigchr_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1862', '94', '1862', '', 'merger_chest', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1863', '80', '1863', '', 'runway_dvdr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1864', '80', '1864', '', 'runway_display', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1865', '7', '1865', '', 'hc2_frplc', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1866', '7', '1866', '', 'hc2_dvn', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('1867', '80', '1867', '', 'runway_table_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1868', '7', '1868', '', 'hc3_dc', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1869', '80', '1869', '', 'runway_bigchr_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1870', '80', '1870', '', 'runway_bigchr_5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1871', '80', '1871', '', 'runway_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1872', '7', '1872', '', 'hc3_light', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1873', '7', '1873', '', 'hc3_table', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1874', '80', '1874', '', 'runway_manqn_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1875', '94', '1875', '', 'cmp_fish_s', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1876', '94', '1876', '', 'cmp_fish_bk', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1877', '7', '1877', '', 'hc3_stereo', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1878', '19', '1878', '', 'cmp_nobox_2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1879', '94', '1879', '', 'cmp_fish_b', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1880', '19', '1880', '', 'cmp_nobox_3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1881', '94', '1881', '', 'cmp_fish_gr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1882', '94', '1882', '', 'cmp_fish_g', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1883', '19', '1883', '', 'cmp_nobox', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1884', '94', '1884', '', 'cmp_fish_r', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1885', '94', '1885', '', 'cmp_sub', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1886', '7', '1886', '', 'hc3_vase', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('1887', '75', '1887', '', 'party_crate2_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1888', '75', '1888', '', 'party_crate1_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1889', '94', '1889', '', 'wed_plant', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1890', '94', '1890', '', 'wed_arch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1891', '75', '1891', '', 'party_djset', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1892', '75', '1892', '', 'party_crate1_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1893', '94', '1893', '', 'ads_chocapic', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1894', '75', '1894', '', 'party_crate1_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1895', '94', '1895', '', 'wed_icesculp', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1896', '75', '1896', '', 'party_crate1_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1897', '75', '1897', '', 'party_crate2_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1898', '75', '1898', '', 'party_crate2_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1899', '75', '1899', '', 'party_crate2_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1900', '94', '1900', '', 'wed_carsofa', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1901', '48', '1901', '', 'fball_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1902', '48', '1902', '', 'fball_fnc3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1903', '48', '1903', '', 'fball_score_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1904', '48', '1904', '', 'fball_ball3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1905', '48', '1905', '', 'fball_ptch5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1906', '48', '1906', '', 'fball_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1907', '48', '1907', '', 'fball_audbench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1908', '48', '1908', '', 'fball_fnc1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1909', '48', '1909', '', 'fball_ptch8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1910', '48', '1910', '', 'fball_crnr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1911', '48', '1911', '', 'fball_ptch4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1912', '48', '1912', '', 'fball_trophy', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1913', '48', '1913', '', 'fball_score_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1914', '48', '1914', '', 'fball_cote', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1915', '48', '1915', '', 'fball_ball', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1916', '48', '1916', '', 'fball_ptch7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1917', '48', '1917', '', 'fball_ball2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1918', '48', '1918', '', 'fball_ptch2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1919', '48', '1919', '', 'fball_score_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1920', '48', '1920', '', 'fball_ptch3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1921', '48', '1921', '', 'fball_goal_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1922', '48', '1922', '', 'fball_goal_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1923', '48', '1923', '', 'fball_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1924', '48', '1924', '', 'fball_ptch6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1925', '48', '1925', '', 'fball_ball5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1926', '48', '1926', '', 'fball_goal_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1927', '48', '1927', '', 'fball_ptch0', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1928', '48', '1928', '', 'fball_ball4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1929', '48', '1929', '', 'fball_score_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1930', '48', '1930', '', 'fball_goal_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1931', '48', '1931', '', 'fball_ptch1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1932', '48', '1932', '', 'fball_counter', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1933', '94', '1933', '', 'prison_gate', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1934', '10', '1934', '', 'bw_boat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1935', '94', '1935', '', 'prison_crnr', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1936', '10', '1936', '', 'bw_lgchair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1937', '10', '1937', '', 'bw_water_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1938', '94', '1938', '', 'prison_tower', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1939', '94', '1939', '', 'prison_dvdr2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1940', '10', '1940', '', 'bw_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1941', '94', '1941', '', 'prison_dvdr1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1942', '94', '1942', '', 'ads_capri_chair', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1943', '94', '1943', '', 'ads_capri_lava', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1944', '94', '1944', '', 'prison_stone', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1945', '10', '1945', '', 'bw_fin', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1946', '10', '1946', '', 'bw_ccnuts', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1947', '10', '1947', '', 'bw_shower', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1948', '10', '1948', '', 'bw_water_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1949', '10', '1949', '', 'bw_croc', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1950', '10', '1950', '', 'bw_sboard', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1951', '10', '1951', '', 'bw_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1952', '10', '1952', '', 'bw_table', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1953', '94', '1953', '', 'ads_capri_tree', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1954', '10', '1954', '', 'bw_bball', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1955', '10', '1955', '', 'bw_mttrss', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1956', '10', '1956', '', 'bw_van', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1957', '10', '1957', '', 'bw_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1958', '10', '1958', '', 'bw_fnc_crnr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1959', '10', '1959', '', 'bw_fnc', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1960', '94', '1960', '', 'ads_capri_arcade', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1961', '94', '1961', '', 'ads_pepsi0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1962', '10', '1962', '', 'bw_boat_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1963', '10', '1963', '', 'bw_pool_a3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1964', '10', '1964', '', 'bw_fnc_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1965', '10', '1965', '', 'bw_mttrss_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1966', '10', '1966', '', 'bw_mttrss_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1967', '10', '1967', '', 'bw_pool_b1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1968', '10', '1968', '', 'bw_sofa_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1969', '10', '1969', '', 'bw_sboard_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1970', '10', '1970', '', 'bw_fnc_crnr_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1971', '10', '1971', '', 'bw_pool_a2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1972', '10', '1972', '', 'bw_pool_b2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1973', '10', '1973', '', 'bw_table_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1974', '10', '1974', '', 'bw_chair_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1975', '10', '1975', '', 'bw_boat_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1976', '10', '1976', '', 'bw_fnc_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1977', '10', '1977', '', 'bw_van_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1978', '10', '1978', '', 'bw_sboard_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1979', '10', '1979', '', 'bw_chair_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1980', '10', '1980', '', 'bw_pool_b3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1981', '10', '1981', '', 'bw_van_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1982', '10', '1982', '', 'bw_sofa_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1983', '10', '1983', '', 'bw_fnc_crnr_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1984', '10', '1984', '', 'bw_pool_a1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1985', '10', '1985', '', 'bw_table_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1986', '94', '1986', '', 'african_fence', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1987', '18', '1987', '', 'ktchn10_pot', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1988', '18', '1988', '', 'ktchn10_stove', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1989', '94', '1989', '', 'easel_0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1990', '108', '1990', '', 'petfood15', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1991', '94', '1991', '', 'african_tree1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1992', '94', '1992', '', 'ads_cheetos_hotdog', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1993', '81', '1993', '', 'hosptl_cab1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1994', '108', '1994', '', 'nest_lion2', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('1995', '81', '1995', '', 'hosptl_curtain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1996', '18', '1996', '', 'ktchn10_block', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1997', '81', '1997', '', 'hosptl_bed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1998', '81', '1998', '', 'hosptl_bbag', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('1999', '18', '1999', '', 'ktchn10_tea', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2000', '108', '2000', '', 'ads_cheetos_bath', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2001', '94', '2001', '', 'easel_1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2002', '86', '2002', '', 'tiki_gate', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2003', '94', '2003', '', 'easel_3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2004', '108', '2004', '', 'nest_rhino', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2005', '94', '2005', '', 'ads_oc_soda_cherry', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2006', '108', '2006', '', 'petfood14', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2007', '94', '2007', '', 'easel_4', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2008', '108', '2008', '', 'nest_lion', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2009', '94', '2009', '', 'african_patch', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2010', '94', '2010', '', 'easel_2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2011', '81', '2011', '', 'hosptl_skele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2012', '94', '2012', '', 'african_tree2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2013', '81', '2013', '', 'hosptl_defibs', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2014', '94', '2014', '', 'african_stage', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2015', '81', '2015', '', 'hosptl_cab2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2016', '94', '2016', '', 'african_bones', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2017', '81', '2017', '', 'hosptl_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2018', '81', '2018', '', 'hosptl_seat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2019', '18', '2019', '', 'ktchn10_sink', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2020', '94', '2020', '', 'ads_disney_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2021', '47', '2021', '', 'bb_crnr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2022', '47', '2022', '', 'bb_score_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2023', '47', '2023', '', 'bb_robo', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2024', '47', '2024', '', 'bb_dragon', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2025', '47', '2025', '', 'bb_ducklight', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2026', '47', '2026', '', 'bb_caterhead', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2027', '47', '2027', '', 'bb_cargobox', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2028', '47', '2028', '', 'bb_gate_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2029', '47', '2029', '', 'bb_crchair3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2030', '47', '2030', '', 'bb_score_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2031', '47', '2031', '', 'bb_crchair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2032', '47', '2032', '', 'bb_crchair2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2033', '47', '2033', '', 'bb_score_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2034', '47', '2034', '', 'bb_knj1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2035', '47', '2035', '', 'bb_gate_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2036', '47', '2036', '', 'bb_tddhnd', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2037', '47', '2037', '', 'bb_lightdiv', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2038', '47', '2038', '', 'bb_tddhead', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2039', '47', '2039', '', 'bb_pyramid', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2040', '47', '2040', '', 'bb_patch1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2041', '47', '2041', '', 'bb_fnc3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2042', '47', '2042', '', 'bb_gate_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2043', '67', '2043', '', 'hween10_zombie', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2044', '47', '2044', '', 'bb_apparatus', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2045', '47', '2045', '', 'bb_caterbody', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2046', '47', '2046', '', 'bb_knj2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2047', '47', '2047', '', 'bb_fnc1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2048', '47', '2048', '', 'bb_puck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2049', '47', '2049', '', 'bb_rnd_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2050', '47', '2050', '', 'bb_gate_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2051', '47', '2051', '', 'bb_score_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2052', '47', '2052', '', 'bb_counter', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2053', '67', '2053', '', 'hween10_tarot', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2054', '67', '2054', '', 'hween10_voodoo1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2055', '67', '2055', '', 'hween10_tree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2056', '67', '2056', '', 'hween10_swamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2057', '67', '2057', '', 'hween10_pond', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2058', '67', '2058', '', 'hween10_jar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2059', '67', '2059', '', 'hween10_fog', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2060', '67', '2060', '', 'hween10_voodoo2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2061', '67', '2061', '', 'hween10_skullpost', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2062', '67', '2062', '', 'hween10_voodoo3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2063', '67', '2063', '', 'hween10_logs', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2064', '67', '2064', '', 'hween10_ffly', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2065', '67', '2065', '', 'hween10_chicken', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2066', '67', '2066', '', 'hween10_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2067', '67', '2067', '', 'hween10_throne', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2068', '67', '2068', '', 'hween10_portch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2069', '67', '2069', '', 'hween10_bat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2070', '41', '2070', '', 'wf_act_move_rotate', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2071', '43', '2071', '', 'wf_wire2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2072', '42', '2072', '', 'wf_cnd_time_more_than', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2073', '43', '2073', '', 'wf_colortile', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2074', '43', '2074', '', 'wf_floor_switch2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2075', '40', '2075', '', 'wf_trg_state_changed', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2076', '43', '2076', '', 'wf_xtra_random', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2077', '43', '2077', '', 'wf_xtra_unseen', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2078', '40', '2078', '', 'wf_trg_periodically', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2079', '43', '2079', '', 'wf_pyramid', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2080', '40', '2080', '', 'wf_trg_score_achieved', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2081', '41', '2081', '', 'wf_act_teleport_to', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2082', '40', '2082', '', 'wf_trg_says_something', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2083', '43', '2083', '', 'wf_colorwheel', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2084', '43', '2084', '', 'wf_wire4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2085', '40', '2085', '', 'wf_trg_walks_off_furni', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2086', '40', '2086', '', 'wf_trg_at_given_time', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2087', '40', '2087', '', 'wf_trg_game_ends', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2088', '41', '2088', '', 'wf_act_show_message', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2089', '42', '2089', '', 'wf_cnd_time_less_than', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2090', '40', '2090', '', 'wf_trg_enter_room', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2091', '94', '2091', '', 'ads_hh_safe', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2092', '41', '2092', '', 'wf_act_toggle_state', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2093', '43', '2093', '', 'wf_firegate', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2094', '43', '2094', '', 'wf_ringplate', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2095', '43', '2095', '', 'wf_pressureplate', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2096', '43', '2096', '', 'wf_glowball', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2097', '47', '2097', '', 'bb_lightstrip', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2098', '41', '2098', '', 'wf_act_reset_timers', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2099', '42', '2099', '', 'wf_cnd_furnis_hv_avtrs', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2100', '43', '2100', '', 'wf_arrowplate', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2101', '42', '2101', '', 'wf_cnd_trggrer_on_frn', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2102', '42', '2102', '', 'wf_cnd_match_snapshot', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2103', '43', '2103', '', 'wf_wire1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2104', '41', '2104', '', 'wf_act_give_score', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2105', '43', '2105', '', 'wf_wire3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2106', '43', '2106', '', 'wf_glassdoor', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2107', '41', '2107', '', 'wf_act_match_to_sshot', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2108', '43', '2108', '', 'wf_floor_switch1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2109', '40', '2109', '', 'wf_trg_game_starts', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2110', '40', '2110', '', 'wf_trg_walks_on_furni', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2111', '11', '2111', '', 'exe_copier', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2112', '11', '2112', '', 'exe_wrkdesk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2113', '11', '2113', '', 'exe_glassdvdr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2114', '11', '2114', '', 'exe_seccam', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2115', '114', '2115', '', 'qt_penguin_icehockey', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2116', '94', '2116', '', 'duck_vip', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2117', '108', '2117', '', 'duck_hc', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2118', '114', '2118', '', 'qt_penguin_ballet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2119', '103', '2119', '', 'es_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2120', '44', '2120', '', 'es_icestar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2121', '103', '2121', '', 'es_fnc_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2122', '114', '2122', '', 'qt_xm10_monkey_lamp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2123', '103', '2123', '', 'es_sidewalk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2124', '103', '2124', '', 'es_statue', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2125', '114', '2125', '', 'qt_xm10_iceclubsofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2126', '114', '2126', '', 'qt_xm10_xmduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2127', '114', '2127', '', 'qt_xm10_palm_tree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2128', '103', '2128', '', 'es_fnc_crnr', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2129', '114', '2129', '', 'qt_xm10_trex', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2130', '68', '2130', '', 'es_epictree', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2131', '114', '2131', '', 'qt_xm10_elephant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2132', '103', '2132', '', 'es_wpost', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2133', '114', '2133', '', 'qt_xm10_gnome', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2134', '114', '2134', '', 'qt_xm10_iceduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2135', '114', '2135', '', 'qt_xm10_icetiger', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2136', '103', '2136', '', 'es_fnc_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2137', '114', '2137', '', 'qt_xm10_iceplasto', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2138', '33', '2138', '', 'es_icestar_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2139', '114', '2139', '', 'qt_xm10_icelupin', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2140', '101', '2140', '', 'prizetrophy_nrj_2011', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2141', '114', '2141', '', 'qt_xm10_iceteddy', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2142', '103', '2142', '', 'es_lmppst', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2143', '33', '2143', '', 'es_skating_ice', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2144', '114', '2144', '', 'qt_xm10_icepillar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2145', '103', '2145', '', 'es_roaster', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2146', '44', '2146', '', 'es_puck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2147', '68', '2147', '', 'es_santa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2148', '33', '2148', '', 'es_tagging', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2149', '114', '2149', '', 'qt_xm10_nest', '3', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2150', '114', '2150', '', 'qt_xm10_icesilotable', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2151', '108', '2151', '', 'petfood16', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2152', '33', '2152', '', 'es_icestar_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2153', '114', '2153', '', 'qt_xm10_icedragon', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2154', '114', '2154', '', 'qt_xm10_stone', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2155', '114', '2155', '', 'qt_xm10_ice_fish', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2156', '33', '2156', '', 'es_icestar_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2157', '114', '2157', '', 'qt_xm10_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2158', '108', '2158', '', 'xmas10_surprise', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2159', '68', '2159', '', 'xmas10_fireplace', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2160', '33', '2160', '', 'es_geysir', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2161', '108', '2161', '', 'xmas10_present', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2162', '114', '2162', '', 'qt_xm10_iceelephant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2163', '33', '2163', '', 'es_score_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2164', '33', '2164', '', 'es_tile', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2165', '33', '2165', '', 'es_box', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2166', '33', '2166', '', 'es_exit', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2167', '33', '2167', '', 'es_gate_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2168', '33', '2168', '', 'es_gate_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2169', '33', '2169', '', 'es_gate_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2170', '33', '2170', '', 'es_gate_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2171', '33', '2171', '', 'es_counter', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2172', '33', '2172', '', 'es_score_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2173', '33', '2173', '', 'es_score_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2174', '33', '2174', '', 'es_score_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2175', '69', '2175', '', 'year2011_waver_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2176', '101', '2176', '', 'prizetrophy_2011_w', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2177', '101', '2177', '', 'prizetrophy_2011_r', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2178', '101', '2178', '', 'prizetrophy_2011_y', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2179', '69', '2179', '', 'fireworks_01', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2180', '101', '2180', '', 'prizetrophy_2011_b', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2181', '69', '2181', '', 'fireworks_03', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2182', '101', '2182', '', 'prizetrophy_2011_p', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2183', '69', '2183', '', 'fireworks_02', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2184', '69', '2184', '', 'year2011_waver_r', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2185', '101', '2185', '', 'prizetrophy_2011_g', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2186', '69', '2186', '', 'fireworks_05', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2187', '69', '2187', '', 'year2011_waver_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2188', '69', '2188', '', 'year2011_waver_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2189', '69', '2189', '', 'fireworks_07', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2190', '69', '2190', '', 'fireworks_06', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2191', '69', '2191', '', 'fireworks_04', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2192', '62', '2192', '', 'bling11_statue2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2193', '62', '2193', '', 'bling11_slot', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2194', '62', '2194', '', 'bling11_towels', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2195', '62', '2195', '', 'bling11_rug1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2196', '62', '2196', '', 'bling11_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2197', '62', '2197', '', 'bling11_sofa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2198', '62', '2198', '', 'bling11_statue1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2199', '45', '2199', '', 'val11_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2200', '62', '2200', '', 'bling11_dvd', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2201', '62', '2201', '', 'bling11_floor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2202', '62', '2202', '', 'bling11_plant', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2203', '83', '2203', '', 'china_rabbit', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2204', '62', '2204', '', 'bling11_rug2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2205', '62', '2205', '', 'bling11_dvn', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2206', '62', '2206', '', 'bling11_seat2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2207', '62', '2207', '', 'bling11_seat1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2208', '62', '2208', '', 'bling11_block', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2209', '62', '2209', '', 'bling11_pillar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2210', '61', '2210', '', 'qt_val11_holoduck', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2211', '61', '2211', '', 'val11_playa', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2212', '61', '2212', '', 'qt_val11_discoball', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2213', '45', '2213', '', 'val11_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2214', '61', '2214', '', 'qt_val11_nest', '3', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2215', '108', '2215', '', 'nest_terrarium', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2216', '61', '2216', '', 'qt_val11_duckformer', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2217', '61', '2217', '', 'qt_val11_jellychair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2218', '61', '2218', '', 'qt_val11_jellyheart', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2219', '45', '2219', '', 'val11_rail', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2220', '61', '2220', '', 'qt_val11_holoheart', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2221', '94', '2221', '', 'ads_leaf_teleport', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2222', '94', '2222', '', 'ads_sunnyvend', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2223', '108', '2223', '', 'petfood18', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2224', '108', '2224', '', 'petfood17', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2225', '93', '2225', '', 'limo_w_mid', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2226', '93', '2226', '', 'limo_w_mid2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2227', '108', '2227', '', 'petfood19', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2228', '93', '2228', '', 'limo_w_back', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2229', '93', '2229', '', 'limo_w_front', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2230', '73', '2230', '', 'gothic_bed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2231', '73', '2231', '', 'gothic_candles', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2232', '73', '2232', '', 'gothic_desk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2233', '94', '2233', '', 'ads_grefu_trophy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2234', '73', '2234', '', 'gothic_bowl', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2235', '108', '2235', '', 'nest_frog', '10', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2236', '108', '2236', '', 'pond', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2237', '108', '2237', '', 'val11_present', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2238', '101', '2238', '', 'prizetrophy_cine', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2239', '93', '2239', '', 'cine_vipsign', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2240', '93', '2240', '', 'limo_b_mid3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2241', '93', '2241', '', 'limo_b_mid2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2242', '93', '2242', '', 'limo_b_front', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2243', '93', '2243', '', 'limo_b_mid', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2244', '93', '2244', '', 'cine_star', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2245', '93', '2245', '', 'limo_b_back', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2246', '93', '2246', '', 'cine_curtain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2247', '93', '2247', '', 'cine_screen', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2248', '93', '2248', '', 'theatre_seat_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2249', '93', '2249', '', 'cine_tile', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2250', '93', '2250', '', 'cine_bench_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2251', '93', '2251', '', 'theatre_seat_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2252', '93', '2252', '', 'cine_roof', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2253', '93', '2253', '', 'cine_popcorn', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2254', '93', '2254', '', 'cine_bench', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2255', '93', '2255', '', 'cine_bench_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2256', '93', '2256', '', 'cine_ticket_booth', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2257', '93', '2257', '', 'cine_projector', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2258', '43', '2258', '', 'wf_box', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2259', '43', '2259', '', 'wf_maze', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2260', '94', '2260', '', 'ads_rangocactus', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2261', '93', '2261', '', 'cine_glass', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2262', '42', '2262', '', 'wf_cnd_has_furni_on', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2263', '19', '2263', 'FFFF33', 'post.it', '0', '5', '1', '30', '0');
INSERT INTO `catalog_items` VALUES ('2264', '108', '2264', 'FFFF33', 'post.it.vd', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2265', '108', '2265', '', 'photo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2266', '108', '2266', '', 'Chess', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2267', '108', '2267', '', 'TicTacToe', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2268', '108', '2268', '', 'BattleShip', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2269', '108', '2269', '', 'Poker', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2270', '108', '2270', '', 'wallpaper', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2271', '108', '2271', '', 'floor', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2272', '108', '2272', '', 'poster', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2273', '73', '2273', '', 'gothicfountain', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2274', '7', '2274', '', 'hc_wall_lamp', '3', '0', '1', '1', '1');
INSERT INTO `catalog_items` VALUES ('2275', '73', '2275', '', 'industrialfan', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2276', '73', '2276', '', 'torch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2277', '61', '2277', '', 'val_heart', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2278', '74', '2278', '', 'wallmirror', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2279', '84', '2279', '', 'jp_ninjastars', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2280', '93', '2280', '', 'habw_mirror', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2281', '19', '2281', '', 'habbowheel', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2282', '22', '2282', '', 'guitar_skull', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2283', '22', '2283', '', 'guitar_v', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2284', '22', '2284', '', 'hrella_poster_2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2285', '22', '2285', '', 'hrella_poster_1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2286', '68', '2286', '', 'xmas_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2287', '22', '2287', '', 'hrella_poster_3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2288', '107', '2288', '', 'sw_swords', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2289', '107', '2289', '', 'sw_stone', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2290', '107', '2290', '', 'sw_hole', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2291', '85', '2291', '', 'arabian_swords', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2292', '84', '2292', '', 'jp_sheet3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2293', '85', '2293', '', 'arabian_wndw', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2294', '107', '2294', '', 'md_logo_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2295', '84', '2295', '', 'jp_sheet1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2296', '107', '2296', '', 'md_can', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2297', '84', '2297', '', 'jp_sheet2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2298', '19', '2298', '1,1,1,#000000,255', 'roomdimmer', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2299', '86', '2299', '', 'tiki_surfboard', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2300', '107', '2300', '', 'tampax_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2301', '86', '2301', '', 'tiki_wallplnt', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2302', '8', '2302', '', 'window_single_default', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2303', '8', '2303', '', 'window_double_default', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2304', '34', '2304', '', 'noob_window_double', '5', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2305', '8', '2305', '', 'window_chinese_wide', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2306', '8', '2306', '', 'window_golden', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2307', '8', '2307', '', 'window_square', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2308', '8', '2308', '', 'window_romantic_narrow', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2309', '8', '2309', '', 'window_chinese_narrow', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2310', '8', '2310', '', 'window_70s_wide', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2311', '8', '2311', '', 'window_70s_narrow', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2312', '8', '2312', '', 'window_romantic_wide', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2313', '8', '2313', '', 'window_basic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2314', '107', '2314', '', 'ads_sunnyd', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2315', '71', '2315', '', 'window_grunge', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2316', '8', '2316', '', 'window_triple', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2317', '70', '2317', '', 'window_diner2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2318', '107', '2318', '', 'ads_dave_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2319', '70', '2319', '', 'diner_walltable', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2320', '70', '2320', '', 'window_diner', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2321', '107', '2321', '', 'ads_nokia_logo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2322', '107', '2322', '', 'easy_poster', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2323', '8', '2323', '', 'window_hole', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2324', '107', '2324', '', 'ads_nokia_phone', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2325', '8', '2325', '', 'window_skyscraper', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2326', '108', '2326', '', 'landscape', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2327', '107', '2327', '', 'det_bhole', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2328', '107', '2328', '', 'netari_poster', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2329', '107', '2329', '', 'ads_campguitar', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2330', '66', '2330', '', 'hween08_rad', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2331', '66', '2331', '', 'hw_08_xray', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2332', '66', '2332', '', 'hween08_wndwb', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2333', '66', '2333', '', 'hween08_wndw', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2334', '66', '2334', '', 'hween08_bio', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2335', '66', '2335', '', 'hw08_xray', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2336', '73', '2336', '', 'gothicfountain2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2337', '75', '2337', '', 'party_led', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2338', '107', '2338', '', 'ads_cmusic', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2339', '75', '2339', '', 'party_wc_girl', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2340', '75', '2340', '', 'party_neon1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2341', '75', '2341', '', 'party_wc_boy', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2342', '75', '2342', '', 'party_shelf', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2343', '75', '2343', '', 'party_neon4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2344', '75', '2344', '', 'party_neon2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2345', '75', '2345', '', 'party_neon5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2346', '75', '2346', '', 'party_neon3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2347', '114', '2347', '', 'xmas08_icewall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2348', '114', '2348', '', 'xmas08_wallpaper', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2349', '107', '2349', '', 'ads_clwall2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2350', '107', '2350', '', 'ads_clwall3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2351', '108', '2351', '', 'xmas_icewall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2352', '107', '2352', '', 'ads_ob_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2353', '107', '2353', '', 'ads_clwall1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2354', '107', '2354', '', 'ads_mall_window', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2355', '83', '2355', '', 'china_pstr1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2356', '83', '2356', '', 'china_pstr2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2357', '83', '2357', '', 'china_light', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2358', '88', '2358', '', 'bolly_wdw_wd', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2359', '107', '2359', '', 'ads_idol_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2360', '107', '2360', '', 'ads_igorevilb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2361', '107', '2361', '', 'ads_igor_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2362', '107', '2362', '', 'ads_mall_winpet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2363', '107', '2363', '', 'ads_mall_winfur', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2364', '107', '2364', '', 'ads_idol_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2365', '89', '2365', '', 'lc_window1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2366', '89', '2366', '', 'lc_wall1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2367', '89', '2367', '', 'lc_window2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2368', '89', '2368', '', 'lc_wall2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2369', '107', '2369', '', 'ads_mall_wincin', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2370', '107', '2370', '', 'ads_idol_mirror', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2371', '107', '2371', '', 'ads_mall_winbea', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2372', '107', '2372', '', 'ads_mall_winmus', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2373', '108', '2373', '', 'eco_curtains2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2374', '107', '2374', '', 'ads_mall_winchi', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2375', '108', '2375', '', 'eco_curtains3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2376', '108', '2376', '', 'eco_curtains1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2377', '107', '2377', '', 'ads_mall_winspo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2378', '11', '2378', '', 'exe_wfall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2379', '107', '2379', '', 'ads_idol_logo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2380', '107', '2380', '', 'ads_mall_winice', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2381', '11', '2381', '', 'exe_map', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2382', '107', '2382', '', 'ads_puffet_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2383', '107', '2383', '', 'ads_reebok_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2384', '107', '2384', '', 'ads_malaco_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2385', '77', '2385', '', 'country_forestwall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2386', '107', '2386', '', 'ads_lin_wh_c', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2387', '77', '2387', '', 'country_lantern', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2388', '77', '2388', '', 'country_fp', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2389', '77', '2389', '', 'country_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2390', '22', '2390', '', 'flag_norway', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2391', '70', '2391', '', 'diner_poster', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2392', '90', '2392', '', 'lt_jngl_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2393', '107', '2393', '', 'ads_mirror', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2394', '90', '2394', '', 'lt_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2395', '61', '2395', '', 'post_it_vd', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2396', '108', '2396', '', 'post_it', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2397', '107', '2397', '', 'ads_veet', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2398', '76', '2398', '', 'sf_wall3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2399', '76', '2399', '', 'sf_window', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2400', '107', '2400', '', 'ads_mall_wintra', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2401', '107', '2401', '', 'ads_wwe_poster', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2402', '76', '2402', '', 'sf_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2403', '76', '2403', '', 'sf_wall2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2404', '22', '2404', '', 'flag_belgium', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2405', '107', '2405', '', 'ads_mall_wingar', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2406', '22', '2406', '', 'flag_portugal', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2407', '78', '2407', '', 'rela_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2408', '18', '2408', '', 'ktchn_knives', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2409', '18', '2409', '', 'ktchn_oven', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2410', '18', '2410', '', 'ktchn_wall', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2411', '107', '2411', '', 'ads_mall_winclo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2412', '19', '2412', '1,1,1,#000000,255', 'dimmer_swtch', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2413', '19', '2413', '1,1,1,#000000,255', 'dimmer_buttn', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2414', '19', '2414', '1,1,1,#000000,255', 'dimmer_fuse2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2415', '19', '2415', '1,1,1,#000000,255', 'dimmer_fuse6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2416', '107', '2416', '', 'ads_mtv_bigtv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2417', '107', '2417', '', 'ads_mtv_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2418', '107', '2418', '', 'ads_idol_l_logo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2419', '79', '2419', '', 'urban_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2420', '107', '2420', '', 'ads_idol_l_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2421', '22', '2421', '', 'flag_peru', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2422', '65', '2422', '', 'hween09_crnr1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2423', '22', '2423', '', 'flag_tunisia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2424', '22', '2424', '', 'flag_singapore', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2425', '22', '2425', '', 'flag_mexico', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2426', '22', '2426', '', 'flag_philippines', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2427', '22', '2427', '', 'flag_malaysia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2428', '22', '2428', '', 'flag_greece', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2429', '22', '2429', '', 'flag_venezl', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2430', '22', '2430', '', 'flag_turkey', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2431', '22', '2431', '', 'flag_chile', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2432', '65', '2432', '', 'hween09_wall1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2433', '22', '2433', '', 'flag_columbia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2434', '65', '2434', '', 'hween09_stonewall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2435', '22', '2435', '', 'flag_newzealand', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2436', '22', '2436', '', 'flag_argentina', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2437', '22', '2437', '', 'flag_panama', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2438', '65', '2438', '', 'hween09_paint', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2439', '22', '2439', '', 'flag_morocco', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2440', '22', '2440', '', 'flag_dominicanrepublic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2441', '65', '2441', '', 'hween09_curt', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2442', '107', '2442', '', 'byesw_loadscreen', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2443', '22', '2443', '', 'flag_ecuador', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2444', '65', '2444', '', 'hween09_treewall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2445', '22', '2445', '', 'flag_algeria', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2446', '65', '2446', '', 'hween09_win', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2447', '107', '2447', '', 'ads_twi_paint', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2448', '107', '2448', '', 'ads_twi_dreamc', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2449', '107', '2449', '', 'ads_twi_bwall1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2450', '107', '2450', '', 'ads_twi_crest', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2451', '107', '2451', '', 'ads_twi_bwall2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2452', '107', '2452', '', 'ads_twi_windw', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2453', '68', '2453', '', 'xm09_bauble_24', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2454', '68', '2454', '', 'xm09_bauble_27', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2455', '68', '2455', '', 'xm09_stocking', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2456', '68', '2456', '', 'xm09_bauble_17', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2457', '68', '2457', '', 'xm09_bauble_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2458', '68', '2458', '', 'xm09_bauble_19', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2459', '68', '2459', '', 'xm09_bauble_6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2460', '68', '2460', '', 'xm09_bauble_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2461', '68', '2461', '', 'xm09_bauble_25', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2462', '85', '2462', '', 'arabian_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2463', '68', '2463', '', 'xm09_bauble_5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2464', '68', '2464', '', 'xm09_bauble_11', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2465', '68', '2465', '', 'xm09_bauble_14', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2466', '68', '2466', '', 'xm09_bauble_7', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2467', '68', '2467', '', 'xm09_bauble_23', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2468', '68', '2468', '', 'xm09_bauble_10', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2469', '68', '2469', '', 'xm09_bauble_9', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2470', '68', '2470', '', 'xm09_bauble_8', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2471', '68', '2471', '', 'xm09_bauble_20', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2472', '68', '2472', '', 'xm09_bauble_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2473', '68', '2473', '', 'xm09_bauble_18', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2474', '68', '2474', '', 'xm09_bauble_13', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2475', '68', '2475', '', 'xm09_bauble_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2476', '68', '2476', '', 'xm09_bauble_15', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2477', '68', '2477', '', 'xm09_bauble_22', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2478', '68', '2478', '', 'xm09_bauble_16', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2479', '68', '2479', '', 'xm09_bauble_12', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2480', '68', '2480', '', 'xm09_bauble_21', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2481', '68', '2481', '', 'xm09_bauble_26', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2482', '114', '2482', '', 'xm09_firwall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2483', '114', '2483', '', 'xm09_forestwall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2484', '75', '2484', '', 'party_lights', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2485', '68', '2485', '', 'xm09_lodgewall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2486', '68', '2486', '', 'xm09_frplc', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2487', '69', '2487', '', 'year2010', '3', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2488', '83', '2488', '', 'china_pstr3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2489', '107', '2489', '', 'ads_tv_jaapuisto', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2490', '61', '2490', '', 'val09_wall2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2491', '61', '2491', '', 'val09_wdrobe_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2492', '61', '2492', '', 'val09_wall1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2493', '62', '2493', '', 'bling_sink', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2494', '61', '2494', '', 'val09_wdrobe_b', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2495', '62', '2495', '', 'bling_cabinet', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2496', '94', '2496', '', 'ads_percyw', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2497', '107', '2497', '', 'ads_boost_surfb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2498', '107', '2498', '', 'ads_tlc_wheel', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2499', '64', '2499', '', 'garden_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2500', '107', '2500', '', 'ads_tv_yle', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2501', '80', '2501', '', 'runway_shelf', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2502', '107', '2502', '', 'ads_latrobe_flag', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2503', '7', '2503', '', 'hc3_walldeco', '3', '0', '1', '1', '2');
INSERT INTO `catalog_items` VALUES ('2504', '107', '2504', '', 'ads_nokia_x6', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2505', '80', '2505', '', 'runway_fabric', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2506', '107', '2506', '', 'ads_target_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2507', '107', '2507', '', 'ads_super_pop', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2508', '107', '2508', '', 'ads_tv_chocapic_02', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2509', '107', '2509', '', 'ads_tv_chocapic_01', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2510', '10', '2510', '', 'bw_jaws', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2511', '107', '2511', '', 'ads_grefusa_surfb', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2512', '18', '2512', '', 'ktchn10_cabnt', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2513', '81', '2513', '', 'hosptl_xray', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2514', '67', '2514', '', 'hween10_fogwall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2515', '47', '2515', '', 'bb_painimies1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2516', '47', '2516', '', 'bb_painimies2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2517', '107', '2517', '', 'ads_mtv_bigtv2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2518', '107', '2518', '', 'ads_mtv_tv2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2519', '67', '2519', '', 'hween10_card_3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2520', '67', '2520', '', 'hween10_card_1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2521', '67', '2521', '', 'hween10_card_4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2522', '67', '2522', '', 'hween10_card_6', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2523', '67', '2523', '', 'hween10_wallskull', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2524', '67', '2524', '', 'hween10_card_2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2525', '67', '2525', '', 'hween10_card_5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2526', '107', '2526', '', 'ads_nokiax3_wall2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2527', '107', '2527', '', 'ads_nokiax3_wall3', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2528', '107', '2528', '', 'ads_nokiax3_wall1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2529', '107', '2529', '', 'ads_nokiax3_phn', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2530', '11', '2530', '', 'exe_sensor', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2531', '108', '2531', '', 'qt_calendar2', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2532', '107', '2532', '', 'ads_r7logo', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2533', '108', '2533', '', 'qt_calendar0', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2534', '108', '2534', '', 'qt_calendar1', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2535', '114', '2535', '', 'qt_xm10_bauble2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2536', '103', '2536', '', 'es_build1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2537', '103', '2537', '', 'es_build4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2538', '103', '2538', '', 'es_build2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2539', '114', '2539', '', 'qt_xm10_bauble1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2540', '103', '2540', '', 'es_build3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2541', '107', '2541', '', 'es_window', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2542', '114', '2542', '', 'qt_xm10_bauble3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2543', '114', '2543', '', 'qt_xm10_icestar', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2544', '103', '2544', '', 'es_big1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2545', '103', '2545', '', 'es_big3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2546', '103', '2546', '', 'es_big2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2547', '69', '2547', '', 'year2011', '3', '0', '0', '1', '0');
INSERT INTO `catalog_items` VALUES ('2548', '62', '2548', '', 'bling11_wall1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2549', '62', '2549', '', 'bling11_wall4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2550', '62', '2550', '', 'bling11_wall2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2551', '62', '2551', '', 'bling11_wall3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2552', '61', '2552', '', 'qt_val11_heartlights', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2553', '62', '2553', '', 'bling11_big1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2554', '73', '2554', '', 'gothic_st_glass', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2555', '107', '2555', '', 'ads_bigtv_missmix', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2556', '93', '2556', '', 'cine_light2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('2557', '93', '2557', '', 'cine_light1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3858', '102', '2559', '', 'cubie_lamp_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3859', '102', '2560', '', 'cubie_chair_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3860', '102', '2561', '', 'cubie_rug_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3861', '102', '2562', '', 'cubie_bigtable_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3862', '102', '2563', '', 'cubie_beanbag_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3863', '102', '2564', '', 'cubie_lamp_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3864', '102', '2565', '', 'cubie_sofaseat_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3865', '102', '2566', '', 'cubie_shelf_0_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3866', '102', '2567', '', 'cubie_shelf_4_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3867', '102', '2568', '', 'cubie_shelf_2_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3868', '102', '2569', '', 'cubie_bed_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3869', '102', '2570', '', 'cubie_stool_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3870', '102', '2571', '', 'cubie_rug_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3871', '102', '2572', '', 'cubie_bed_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3872', '102', '2573', '', 'cubie_shelf_3_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3873', '102', '2574', '', 'cubie_shelf_3_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3874', '102', '2575', '', 'cubie_shelf_1_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3875', '102', '2576', '', 'cubie_shelf_1_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3876', '102', '2577', '', 'cubie_bigtable_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3877', '102', '2578', '', 'cubie_beanbag_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3878', '102', '2579', '', 'cubie_stool_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3879', '102', '2580', '', 'cubie_chair_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3880', '102', '2581', '', 'cubie_table', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3881', '102', '2582', '', 'cubie_sofaseat_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3882', '102', '2583', '', 'cubie_shelf_4_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3883', '102', '2584', '', 'cubie_shelf_2_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3884', '102', '2585', '', 'cubie_shelf_0_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3885', '108', '2598', '', 'newbie_present', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3886', '104', '2599', '', 'tv_flat', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3887', '104', '2600', '', 'waasa_table2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3888', '104', '2601', '', 'computer_flatscreen', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3889', '104', '2602', '', 'waasa_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3890', '104', '2603', '', 'waasa_ship2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3891', '104', '2604', '', 'waasa_ship1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3892', '104', '2605', '', 'waasa_bunk_bed', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3893', '104', '2606', '', 'computer_laptop', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3894', '104', '2607', '', 'computer_old', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3895', '104', '2608', '', 'waasa_table1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3896', '104', '2609', '', 'waasa_desk', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3897', '108', '2612', '', 'newbie_nest', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3898', '104', '2613', '', 'waasa_rug5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3899', '104', '2614', '', 'waasa_rug1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3900', '104', '2615', '', 'waasa_rug3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3901', '104', '2616', '', 'waasa_aquarium', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3902', '104', '2617', '', 'waasa_rug4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3903', '104', '2618', '', 'waasa_chair_wood', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3904', '104', '2619', '', 'waasa_rug2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3905', '108', '2620', '', 'jukebox_big', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3906', '108', '2621', '', 'milkbowl', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3907', '108', '2622', '', 'petfood21', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3908', '63', '2623', '', 'easter11_basket', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3909', '63', '2624', '', 'easter11_grasspatch', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3910', '94', '2625', '', 'ads_wowpball', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3911', '108', '2626', '', 'pet_food_corn', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3912', '108', '2627', '', 'pet_toy_trampoline', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3913', '108', '2628', '', 'nest_chick', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3914', '63', '2629', '', 'easter11_tag', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3915', '63', '2630', '', 'easter11_tuip_g', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3916', '63', '2631', '', 'easter11_tuip_y', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3917', '63', '2632', '', 'easter11_mushroom4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3918', '63', '2633', '', 'easter11_mushroom1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3919', '105', '2634', '', 'kuurna_sofa', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3920', '63', '2635', '', 'easter11_mushroom3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3921', '63', '2636', '', 'easter11_mushroom2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3922', '105', '2637', '', 'kuurna_lamp', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3923', '105', '2638', '', 'kuurna_chair', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3924', '105', '2639', '', 'kuurna_mat', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3925', '105', '2640', '', 'kuurna_table1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3926', '105', '2641', '', 'kuurna_table', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3927', '94', '2642', '', 'ads_suun', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3928', '105', '2643', '', 'kuurna_chair1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3929', '63', '2644', '', 'easter11_tuip_p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3930', '106', '2655', '', 'anna_divider*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3931', '106', '2656', '', 'anna_divider*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3932', '106', '2657', '', 'anna_divider*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3933', '106', '2658', '', 'anna_divider*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3934', '106', '2659', '', 'anna_divider*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3935', '106', '2660', '', 'anna_div_gate*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3936', '106', '2661', '', 'anna_div_gate*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3937', '106', '2662', '', 'anna_div_gate*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3938', '106', '2663', '', 'anna_div_gate*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3939', '106', '2664', '', 'anna_div_gate*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3940', '106', '2665', '', 'anna_chair*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3941', '106', '2666', '', 'anna_chair*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3942', '106', '2667', '', 'anna_chair*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3943', '106', '2668', '', 'anna_chair*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3944', '106', '2669', '', 'anna_chair*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3945', '106', '2670', '', 'anna_stool*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3946', '106', '2671', '', 'anna_stool*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3947', '106', '2672', '', 'anna_stool*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3948', '106', '2673', '', 'anna_stool*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3949', '106', '2674', '', 'anna_stool*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3950', '106', '2675', '', 'anna_table*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3951', '106', '2676', '', 'anna_table*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3952', '106', '2677', '', 'anna_table*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3953', '106', '2678', '', 'anna_table*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3954', '106', '2679', '', 'anna_table*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3955', '106', '2680', '', 'anna_rug*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3956', '106', '2681', '', 'anna_rug*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3957', '106', '2682', '', 'anna_rug*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3958', '106', '2683', '', 'anna_rug*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3959', '106', '2684', '', 'anna_rug*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3960', '106', '2685', '', 'anna_sofa*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3961', '106', '2686', '', 'anna_sofa*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3962', '106', '2687', '', 'anna_sofa*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3963', '106', '2688', '', 'anna_sofa*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3964', '106', '2689', '', 'anna_sofa*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3965', '106', '2690', '', 'anna_pill*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3966', '106', '2691', '', 'anna_pill*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3967', '106', '2692', '', 'anna_pill*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3968', '106', '2693', '', 'anna_pill*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3969', '106', '2694', '', 'anna_pill*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3970', '106', '2695', '', 'anna_lamp*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3971', '106', '2696', '', 'anna_lamp*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3972', '106', '2697', '', 'anna_lamp*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3973', '106', '2698', '', 'anna_lamp*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3974', '106', '2699', '', 'anna_lamp*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3975', '106', '2700', '', 'anna_div_crnr*1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3976', '106', '2701', '', 'anna_div_crnr*2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3977', '106', '2702', '', 'anna_div_crnr*3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3978', '106', '2703', '', 'anna_div_crnr*4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('3979', '106', '2704', '', 'anna_div_crnr*5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4384', '102', '2586', '', 'cubie_decal_3_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4385', '102', '2587', '', 'cubie_decklight_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4386', '102', '2588', '', 'cubie_decal_1_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4387', '102', '2589', '', 'cubie_decal_2_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4388', '102', '2590', '', 'cubie_decal_3_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4389', '102', '2591', '', 'cubie_wallshelf_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4390', '102', '2592', '', 'cubie_decal_1_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4391', '102', '2593', '', 'cubie_decal_3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4392', '102', '2594', '', 'cubie_wallshelf_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4393', '102', '2595', '', 'cubie_decal_2_p', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4394', '102', '2596', '', 'cubie_decklight_b', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4395', '102', '2597', '', 'cubie_decal_0', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4396', '104', '2610', '', 'waasa_wall_shelf2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4397', '104', '2611', '', 'waasa_wall_shelf1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4398', '63', '2645', '', 'easter11_wall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4399', '107', '2646', '', 'ads_suunvuorow', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4400', '107', '2647', '', 'ads_volkswagen_poster', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4401', '74', '2650', '', 'grand_piano*3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4402', '74', '2651', '', 'grand_piano*5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4403', '74', '2652', '', 'grand_piano*2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4404', '74', '2653', '', 'grand_piano*4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4405', '74', '2654', '', 'grand_piano*1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4406', '77', '2705', '', 'picnic_blanket_yel', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4407', '77', '2706', '', 'picnic_pillow_yel', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4408', '77', '2707', '', 'picnic_food1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4409', '19', '2708', '', 'note_tag', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4410', '77', '2709', '', 'picnic_wfall', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4411', '77', '2710', '', 'picnic_blanket_blu', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4412', '77', '2711', '', 'picnic_food3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4413', '77', '2712', '', 'picnic_blanket', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4414', '77', '2713', '', 'picnic_pillow_blu', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4415', '77', '2714', '', 'picnic_food2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4416', '77', '2715', '', 'picnic_tele', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4417', '77', '2716', '', 'picnic_basket', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4418', '77', '2717', '', 'picnic_pillow', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4419', '77', '2718', '', 'picnic_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4420', '77', '2719', '', 'picnic_3brds', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4421', '107', '2720', '', 'picture_car', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4422', '108', '2721', '', 'petfood23', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4688', '60', '2270', '101', 'wallpaper_single_101', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4689', '60', '2270', '102', 'wallpaper_single_102', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4690', '60', '2270', '103', 'wallpaper_single_103', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4691', '60', '2270', '104', 'wallpaper_single_104', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4692', '60', '2270', '105', 'wallpaper_single_105', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4693', '60', '2270', '106', 'wallpaper_single_106', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4694', '60', '2270', '107', 'wallpaper_single_107', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4695', '60', '2270', '108', 'wallpaper_single_108', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4696', '60', '2270', '109', 'wallpaper_single_109', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4697', '60', '2270', '110', 'wallpaper_single_110', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4698', '60', '2270', '111', 'wallpaper_single_111', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4699', '60', '2270', '112', 'wallpaper_single_112', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4700', '60', '2270', '113', 'wallpaper_single_113', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4701', '60', '2270', '114', 'wallpaper_single_114', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4702', '60', '2270', '115', 'wallpaper_single_115', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4703', '60', '2270', '201', 'wallpaper_single_201', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4704', '60', '2270', '202', 'wallpaper_single_202', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4705', '60', '2270', '203', 'wallpaper_single_203', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4706', '60', '2270', '204', 'wallpaper_single_204', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4707', '60', '2270', '205', 'wallpaper_single_205', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4708', '60', '2270', '206', 'wallpaper_single_206', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4709', '60', '2270', '207', 'wallpaper_single_207', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4710', '60', '2270', '208', 'wallpaper_single_208', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4711', '60', '2270', '209', 'wallpaper_single_209', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4712', '60', '2270', '210', 'wallpaper_single_210', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4713', '60', '2270', '211', 'wallpaper_single_211', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4714', '60', '2270', '212', 'wallpaper_single_212', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4715', '60', '2270', '213', 'wallpaper_single_213', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4716', '60', '2270', '214', 'wallpaper_single_214', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4717', '60', '2270', '215', 'wallpaper_single_215', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4718', '60', '2270', '216', 'wallpaper_single_216', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4719', '60', '2270', '217', 'wallpaper_single_217', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4720', '60', '2270', '218', 'wallpaper_single_218', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4721', '60', '2270', '301', 'wallpaper_single_301', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4722', '60', '2270', '302', 'wallpaper_single_302', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4723', '60', '2270', '303', 'wallpaper_single_303', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4724', '60', '2270', '304', 'wallpaper_single_304', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4725', '60', '2270', '305', 'wallpaper_single_305', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4726', '60', '2270', '306', 'wallpaper_single_306', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4727', '60', '2270', '307', 'wallpaper_single_307', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4728', '60', '2270', '401', 'wallpaper_single_401', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4729', '60', '2270', '402', 'wallpaper_single_402', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4730', '60', '2270', '403', 'wallpaper_single_403', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4731', '60', '2270', '404', 'wallpaper_single_404', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4732', '60', '2270', '405', 'wallpaper_single_405', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4733', '60', '2270', '406', 'wallpaper_single_406', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4734', '60', '2270', '407', 'wallpaper_single_407', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4735', '60', '2270', '408', 'wallpaper_single_408', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4736', '60', '2270', '501', 'wallpaper_single_501', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4737', '60', '2270', '502', 'wallpaper_single_502', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4738', '60', '2270', '503', 'wallpaper_single_503', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4739', '60', '2270', '504', 'wallpaper_single_504', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4740', '60', '2270', '505', 'wallpaper_single_505', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4741', '60', '2270', '506', 'wallpaper_single_506', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4742', '60', '2270', '507', 'wallpaper_single_507', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4743', '60', '2270', '508', 'wallpaper_single_508', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4744', '60', '2270', '601', 'wallpaper_single_601', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4745', '60', '2270', '602', 'wallpaper_single_602', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4746', '60', '2270', '603', 'wallpaper_single_603', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4747', '60', '2270', '604', 'wallpaper_single_604', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4748', '60', '2270', '605', 'wallpaper_single_605', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4749', '60', '2270', '606', 'wallpaper_single_606', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4750', '60', '2270', '607', 'wallpaper_single_607', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4751', '60', '2270', '608', 'wallpaper_single_608', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4752', '60', '2270', '609', 'wallpaper_single_609', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4753', '60', '2270', '610', 'wallpaper_single_610', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4754', '60', '2270', '701', 'wallpaper_single_701', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4755', '60', '2270', '702', 'wallpaper_single_702', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4756', '60', '2270', '703', 'wallpaper_single_703', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4757', '60', '2270', '704', 'wallpaper_single_704', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4758', '60', '2270', '705', 'wallpaper_single_705', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4759', '60', '2270', '706', 'wallpaper_single_706', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4760', '60', '2270', '707', 'wallpaper_single_707', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4761', '60', '2270', '708', 'wallpaper_single_708', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4762', '60', '2270', '709', 'wallpaper_single_709', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4763', '60', '2270', '710', 'wallpaper_single_710', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4764', '60', '2270', '801', 'wallpaper_single_801', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4765', '60', '2270', '802', 'wallpaper_single_802', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4766', '60', '2270', '803', 'wallpaper_single_803', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4767', '60', '2270', '804', 'wallpaper_single_804', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4768', '60', '2270', '805', 'wallpaper_single_805', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4769', '60', '2270', '806', 'wallpaper_single_806', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4770', '60', '2270', '807', 'wallpaper_single_807', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4771', '60', '2270', '808', 'wallpaper_single_808', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4772', '60', '2270', '809', 'wallpaper_single_809', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4773', '60', '2270', '810', 'wallpaper_single_810', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4774', '60', '2270', '901', 'wallpaper_single_901', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4775', '60', '2270', '902', 'wallpaper_single_902', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4776', '60', '2270', '903', 'wallpaper_single_903', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4777', '60', '2270', '904', 'wallpaper_single_904', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4778', '60', '2270', '905', 'wallpaper_single_905', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4779', '60', '2270', '906', 'wallpaper_single_906', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4780', '60', '2270', '907', 'wallpaper_single_907', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4781', '60', '2270', '908', 'wallpaper_single_908', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4782', '60', '2270', '1001', 'wallpaper_single_1001', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4783', '60', '2270', '1002', 'wallpaper_single_1002', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4784', '60', '2270', '1003', 'wallpaper_single_1003', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4785', '60', '2270', '1004', 'wallpaper_single_1004', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4786', '60', '2270', '1005', 'wallpaper_single_1005', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4787', '60', '2270', '1006', 'wallpaper_single_1006', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4788', '60', '2270', '1007', 'wallpaper_single_1007', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4789', '60', '2270', '1101', 'wallpaper_single_1101', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4790', '60', '2270', '1201', 'wallpaper_single_1201', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4791', '60', '2270', '1301', 'wallpaper_single_1301', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4792', '60', '2270', '1401', 'wallpaper_single_1401', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4793', '60', '2270', '1501', 'wallpaper_single_1501', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4794', '60', '2270', '1601', 'wallpaper_single_1601', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4795', '60', '2270', '1701', 'wallpaper_single_1701', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4796', '60', '2270', '1801', 'wallpaper_single_1801', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4797', '60', '2270', '1901', 'wallpaper_single_1901', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4798', '60', '2270', '1902', 'wallpaper_single_1902', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4799', '60', '2270', '2001', 'wallpaper_single_2001', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4800', '60', '2270', '2002', 'wallpaper_single_2002', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4801', '60', '2270', '2003', 'wallpaper_single_2003', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4802', '60', '2270', '2101', 'wallpaper_single_2101', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4803', '60', '2270', '2102', 'wallpaper_single_2102', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4804', '60', '2270', '2103', 'wallpaper_single_2103', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4805', '60', '2270', '2201', 'wallpaper_single_2201', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4806', '60', '2270', '2202', 'wallpaper_single_2202', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4807', '60', '2270', '2203', 'wallpaper_single_2203', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4808', '60', '2270', '2204', 'wallpaper_single_2204', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4809', '60', '2270', '2205', 'wallpaper_single_2205', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4810', '60', '2270', '2206', 'wallpaper_single_2206', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4811', '60', '2270', '2301', 'wallpaper_single_2301', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4812', '60', '2270', '2302', 'wallpaper_single_2302', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4813', '60', '2270', '2303', 'wallpaper_single_2303', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4814', '60', '2270', '2304', 'wallpaper_single_2304', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4815', '60', '2270', '2401', 'wallpaper_single_2401', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4816', '60', '2270', '2402', 'wallpaper_single_2402', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4817', '60', '2270', '2403', 'wallpaper_single_2403', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4818', '60', '2270', '2501', 'wallpaper_single_2501', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4819', '60', '2270', '2502', 'wallpaper_single_2502', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4820', '60', '2270', '2503', 'wallpaper_single_2503', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4821', '60', '2270', '2504', 'wallpaper_single_2504', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4822', '60', '2270', '2601', 'wallpaper_single_2601', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4823', '60', '2270', '2602', 'wallpaper_single_2602', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4824', '60', '2270', '2603', 'wallpaper_single_2603', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4825', '60', '2270', '2604', 'wallpaper_single_2604', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4826', '60', '2270', '2701', 'wallpaper_single_2701', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4827', '60', '2270', '2702', 'wallpaper_single_2702', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4828', '60', '2270', '2703', 'wallpaper_single_2703', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4829', '60', '2270', '2704', 'wallpaper_single_2704', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4830', '60', '2270', '2801', 'wallpaper_single_2801', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4831', '60', '2270', '2802', 'wallpaper_single_2802', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4832', '60', '2270', '2803', 'wallpaper_single_2803', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4833', '60', '2270', '2804', 'wallpaper_single_2804', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4834', '60', '2270', '2901', 'wallpaper_single_2901', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4835', '60', '2270', '2902', 'wallpaper_single_2902', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4836', '60', '2270', '2903', 'wallpaper_single_2903', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4837', '60', '2270', '2904', 'wallpaper_single_2904', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4838', '60', '2270', '3001', 'wallpaper_single_3001', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4839', '60', '2270', '3002', 'wallpaper_single_3002', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4840', '60', '2270', '3003', 'wallpaper_single_3003', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4841', '60', '2270', '3004', 'wallpaper_single_3004', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4842', '60', '2270', '3101', 'wallpaper_single_3101', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4843', '60', '2270', '3102', 'wallpaper_single_3102', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4844', '60', '2270', '3103', 'wallpaper_single_3103', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4845', '60', '2270', '3104', 'wallpaper_single_3104', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4846', '60', '2270', '3105', 'wallpaper_single_3105', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4847', '60', '2270', '3106', 'wallpaper_single_3106', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4848', '60', '2271', '101', 'floor_single_101', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4849', '60', '2271', '102', 'floor_single_102', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4850', '60', '2271', '103', 'floor_single_103', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4851', '60', '2271', '104', 'floor_single_104', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4852', '60', '2271', '105', 'floor_single_105', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4853', '60', '2271', '106', 'floor_single_106', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4854', '60', '2271', '107', 'floor_single_107', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4855', '60', '2271', '108', 'floor_single_108', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4856', '60', '2271', '109', 'floor_single_109', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4857', '60', '2271', '110', 'floor_single_110', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4858', '60', '2271', '111', 'floor_single_111', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4859', '60', '2271', '201', 'floor_single_201', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4860', '60', '2271', '202', 'floor_single_202', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4861', '60', '2271', '203', 'floor_single_203', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4862', '60', '2271', '204', 'floor_single_204', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4863', '60', '2271', '205', 'floor_single_205', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4864', '60', '2271', '206', 'floor_single_206', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4865', '60', '2271', '207', 'floor_single_207', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4866', '60', '2271', '208', 'floor_single_208', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4867', '60', '2271', '209', 'floor_single_209', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4868', '60', '2271', '210', 'floor_single_210', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4869', '60', '2271', '211', 'floor_single_211', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4870', '60', '2271', '212', 'floor_single_212', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4871', '60', '2271', '301', 'floor_single_301', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4872', '60', '2271', '302', 'floor_single_302', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4873', '60', '2271', '303', 'floor_single_303', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4874', '60', '2271', '304', 'floor_single_304', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4875', '60', '2271', '305', 'floor_single_305', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4876', '60', '2271', '306', 'floor_single_306', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4877', '60', '2271', '307', 'floor_single_307', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4878', '60', '2271', '401', 'floor_single_401', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4879', '60', '2271', '402', 'floor_single_402', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4880', '60', '2271', '403', 'floor_single_403', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4881', '60', '2271', '404', 'floor_single_404', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4882', '60', '2271', '405', 'floor_single_405', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4883', '60', '2271', '406', 'floor_single_406', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4884', '60', '2271', '407', 'floor_single_407', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4885', '60', '2271', '408', 'floor_single_408', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4886', '60', '2271', '409', 'floor_single_409', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4887', '60', '2271', '410', 'floor_single_410', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4888', '60', '2271', '501', 'floor_single_501', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4889', '60', '2271', '502', 'floor_single_502', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4890', '60', '2271', '503', 'floor_single_503', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4891', '60', '2271', '504', 'floor_single_504', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4892', '60', '2271', '505', 'floor_single_505', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4893', '60', '2271', '506', 'floor_single_506', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4894', '60', '2271', '507', 'floor_single_507', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4895', '60', '2271', '601', 'floor_single_601', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4896', '60', '2271', '602', 'floor_single_602', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4897', '60', '2271', '603', 'floor_single_603', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4898', '60', '2271', '604', 'floor_single_604', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4899', '60', '2271', '605', 'floor_single_605', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4900', '60', '2271', '606', 'floor_single_606', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4901', '60', '2271', '607', 'floor_single_607', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4902', '60', '2271', '608', 'floor_single_608', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4903', '60', '2271', '609', 'floor_single_609', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4904', '60', '2271', '610', 'floor_single_610', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4905', '60', '2326', '1.1', 'landscape_single_1.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4906', '60', '2326', '2.1', 'landscape_single_2.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4907', '60', '2326', '3.1', 'landscape_single_3.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4908', '60', '2326', '4.1', 'landscape_single_4.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4909', '60', '2326', '5.1', 'landscape_single_5.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4910', '60', '2326', '6.1', 'landscape_single_6.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4911', '60', '2326', '7.1', 'landscape_single_7.1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4912', '60', '2326', '1.2', 'landscape_single_1.2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4913', '60', '2326', '1.3', 'landscape_single_1.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4914', '60', '2326', '2.3', 'landscape_single_2.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4915', '60', '2326', '3.3', 'landscape_single_3.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4916', '60', '2326', '4.3', 'landscape_single_4.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4917', '60', '2326', '5.3', 'landscape_single_5.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4918', '60', '2326', '6.3', 'landscape_single_6.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4919', '60', '2326', '7.3', 'landscape_single_7.3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4920', '60', '2326', '1.4', 'landscape_single_1.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4921', '60', '2326', '2.4', 'landscape_single_2.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4922', '60', '2326', '3.4', 'landscape_single_3.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4923', '60', '2326', '4.4', 'landscape_single_4.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4924', '60', '2326', '5.4', 'landscape_single_5.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4925', '60', '2326', '6.4', 'landscape_single_6.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4926', '60', '2326', '7.4', 'landscape_single_7.4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4927', '60', '2326', '1.5', 'landscape_single_1.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4928', '60', '2326', '2.5', 'landscape_single_2.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4929', '60', '2326', '3.5', 'landscape_single_3.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4930', '60', '2326', '4.5', 'landscape_single_4.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4931', '60', '2326', '5.5', 'landscape_single_5.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4932', '60', '2326', '6.5', 'landscape_single_6.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4933', '60', '2326', '7.5', 'landscape_single_7.5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4934', '60', '2326', '1.6', 'landscape_single_1.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4935', '60', '2326', '2.6', 'landscape_single_2.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4936', '60', '2326', '3.6', 'landscape_single_3.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4937', '60', '2326', '4.6', 'landscape_single_4.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4938', '60', '2326', '5.6', 'landscape_single_5.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4939', '60', '2326', '6.6', 'landscape_single_6.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4940', '60', '2326', '7.6', 'landscape_single_7.6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4941', '60', '2326', '1.7', 'landscape_single_1.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4942', '60', '2326', '2.7', 'landscape_single_2.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4943', '60', '2326', '3.7', 'landscape_single_3.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4944', '60', '2326', '4.7', 'landscape_single_4.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4945', '60', '2326', '5.7', 'landscape_single_5.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4946', '60', '2326', '6.7', 'landscape_single_6.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4947', '60', '2326', '7.7', 'landscape_single_7.7', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4948', '60', '2326', '1.8', 'landscape_single_1.8', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4949', '60', '2326', '1.9', 'landscape_single_1.9', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4950', '60', '2326', '1.10', 'landscape_single_1.10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4951', '60', '2326', '1.11', 'landscape_single_1.11', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4952', '60', '2326', '7.12', 'landscape_single_7.12', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4953', '22', '2272', '1005', 'poster 1005', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4954', '22', '2272', '40', 'poster 40', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4955', '22', '2272', '2006', 'poster 2006', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4956', '22', '2272', '31', 'poster 31', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4957', '22', '2272', '34', 'poster 34', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4958', '22', '2272', '38', 'poster 38', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4959', '22', '2272', '39', 'poster 39', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4960', '22', '2272', '2007', 'poster 2007', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4961', '22', '2272', '1', 'poster 1', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4962', '96', '2272', '2002', 'poster 2002', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4963', '22', '2272', '1002', 'poster 1002', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4964', '22', '2272', '1003', 'poster 1003', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4965', '22', '2272', '2000', 'poster 2000', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4966', '22', '2272', '10', 'poster 10', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4967', '22', '2272', '12', 'poster 12', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4968', '22', '2272', '13', 'poster 13', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4969', '22', '2272', '15', 'poster 15', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4970', '22', '2272', '14', 'poster 14', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4971', '22', '2272', '17', 'poster 17', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4972', '22', '2272', '18', 'poster 18', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4973', '22', '2272', '3', 'poster 3', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4974', '22', '2272', '33', 'poster 33', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4975', '22', '2272', '5', 'poster 5', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4976', '22', '2272', '4', 'poster 4', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4977', '22', '2272', '32', 'poster 32', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4978', '22', '2272', '55', 'poster 55', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4979', '22', '2272', '11', 'poster 11', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4980', '22', '2272', '16', 'poster 16', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4981', '22', '2272', '19', 'poster 19', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4982', '22', '2272', '2', 'poster 2', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4983', '22', '2272', '2001', 'poster 2001', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4984', '22', '2272', '6', 'poster 6', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4988', '22', '2445', '', 'flag_algeria', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4989', '22', '2436', '', 'flag_argentina', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4990', '22', '2272', '513', 'poster 513', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4991', '22', '2404', '', 'flag_belgium', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4992', '22', '2272', '521', 'poster 521', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4993', '22', '2272', '505', 'poster 505', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4994', '22', '2431', '', 'flag_chile', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4995', '22', '2433', '', 'flag_columbia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4996', '22', '2440', '', 'flag_dominicanrepublic', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4997', '22', '2272', '511', 'poster 511', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4998', '22', '2272', '514', 'poster 514', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('4999', '22', '2443', '', 'flag_ecuador', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5000', '22', '2272', '516', 'poster 516', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5001', '22', '2272', '506', 'poster 506', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5002', '22', '2272', '507', 'poster 507', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5003', '22', '2272', '504', 'poster 504', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5004', '22', '2428', '', 'flag_greece', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5005', '22', '2272', '523', 'poster 523', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5006', '22', '2272', '512', 'poster 512', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5007', '22', '2272', '510', 'poster 510', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5008', '22', '2272', '509', 'poster 509', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5009', '22', '2272', '522', 'poster 522', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5010', '22', '2427', '', 'flag_malaysia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5011', '22', '2425', '', 'flag_mexico', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5012', '22', '2439', '', 'flag_morocco', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5013', '22', '2435', '', 'flag_newzealand', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5014', '22', '2390', '', 'flag_norway', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5015', '22', '2437', '', 'flag_panama', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5016', '22', '2421', '', 'flag_peru', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5017', '22', '2426', '', 'flag_philippines', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5018', '22', '2406', '', 'flag_portugal', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5019', '22', '2272', '517', 'poster 517', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5020', '22', '2424', '', 'flag_singapore', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5021', '22', '2272', '508', 'poster 508', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5022', '22', '2272', '515', 'poster 515', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5023', '22', '2272', '503', 'poster 503', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5024', '22', '2423', '', 'flag_tunisia', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5025', '22', '2430', '', 'flag_turkey', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5026', '22', '2272', '500', 'poster 500', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5027', '22', '2272', '502', 'poster 502', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5028', '22', '2429', '', 'flag_venezl', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5029', '22', '2272', '518', 'poster 518', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5030', '22', '2272', '501', 'poster 501', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5031', '22', '2272', '520', 'poster 520', '0', '5', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5032', '107', '2722', '', 'ads_background', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5033', '94', '2723', '', 'ads_kelloggs_statue', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5034', '94', '2724', '', 'race_trophy', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5035', '94', '2725', '', 'ads_kfp2statue', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5036', '108', '2726', '', 'petfood22', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5037', '107', '2727', '', 'ads_kfp2_tv', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5038', '107', '2728', '', 'ads_kfp2_wall', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5040', '108', '2730', '', 'nest_dragon', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5041', '108', '2731', '', 'ashtree', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5042', '108', '2732', '', 'grail_water', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5043', '108', '2733', '', 'grail_nectar', '10', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5112', '113', '2740', '', 'dng_treasure', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5113', '113', '2737', '', 'dng_treasure2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5114', '113', '2735', '', 'dng_ground', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5115', '113', '2738', '', 'dng_floor', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5118', '113', '2734', '', 'dng_cube', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5119', '113', '2736', '', 'dng_pillar', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5120', '113', '2729', '', 'dng_wall', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5121', '113', '2742', '', 'dng_block', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5122', '113', '2739', '', 'dng_stairs', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5123', '113', '2741', '', 'deal_dragonthrone', '15', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('5124', '8', '2325', '', 'window_skyscraper', '0', '40', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('5125', '37', '1521', '', 'bump_road', '0', '40', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50002', '18', '2410', '', 'ktchn_wall', '0', '40', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50003', '114', '1413', '', 'xmas08_icerug', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50004', '63', '2624', '', 'easter11_grasspatch', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50005', '63', '2645', '', 'easter11_wall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50006', '113', '2734', '', 'dng_cube', '75', '0', '1', '20', '0');
INSERT INTO `catalog_items` VALUES ('50007', '113', '2738', '', 'dng_floor', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50008', '113', '2735', '', 'dng_ground', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50009', '61', '1770', '', 'val09_floor', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50010', '61', '1764', '', 'val09_floor2', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50011', '65', '1037', '', 'habboween_grass', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50012', '10', '1937', '', 'bw_water_1', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50013', '10', '1948', '', 'bw_water_2', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50014', '73', '829', '', 'gothic_carpet', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50015', '67', '2063', '', 'hween10_logs', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50016', '103', '2123', '', 'es_sidewalk', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50017', '79', '2419', '', 'urban_wall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50018', '77', '2389', '', 'country_wall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50019', '77', '2385', '', 'country_forestwall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50020', '85', '2462', '', 'arabian_wall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50021', '86', '1209', '', 'tiki_sand', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50022', '86', '1192', '', 'tiki_junglerug', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50023', '62', '2201', '', 'bling11_floor', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50024', '75', '1369', '', 'party_floor', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50025', '11', '978', '', 'exe_eug', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50026', '93', '977', '', 'tile_marble', '50', '0', '1', '20', '0');
INSERT INTO `catalog_items` VALUES ('50027', '93', '993', '', 'tile_brown', '50', '0', '1', '20', '0');
INSERT INTO `catalog_items` VALUES ('50028', '93', '979', '', 'tile_stella', '50', '0', '1', '20', '0');
INSERT INTO `catalog_items` VALUES ('50029', '78', '2407', '', 'rela_wall', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50030', '70', '1214', '', 'diner_rug', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50031', '96', '250', '', 'rare_daffodil_rug', '200', '0', '1', '25', '0');
INSERT INTO `catalog_items` VALUES ('50032', '45', '2199', '', 'val11_floor', '15', '0', '1', '6', '0');
INSERT INTO `catalog_items` VALUES ('50033', '11', '1054', '', 'exe_bardesk', '25', '0', '1', '10', '0');
INSERT INTO `catalog_items` VALUES ('50055', '36', '2813', '', 'avatar_effect70', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50056', '36', '2808', '', 'avatar_effect65', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50057', '36', '2787', '', 'avatar_effect44', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50058', '36', '2807', '', 'avatar_effect64', '1', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50059', '36', '2752', '', 'avatar_effect9', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50060', '36', '2759', '', 'avatar_effect16', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50061', '36', '2749', '', 'avatar_effect6', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50062', '36', '2757', '', 'avatar_effect14', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50063', '36', '2758', '', 'avatar_effect15', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50064', '36', '2745', '', 'avatar_effect2', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50065', '36', '2760', '', 'avatar_effect17', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50066', '36', '2761', '', 'avatar_effect18', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50067', '36', '2746', '', 'avatar_effect3', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50068', '36', '2744', '', 'avatar_effect1', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50069', '36', '2747', '', 'avatar_effect4', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50070', '36', '2748', '', 'avatar_effect5', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50071', '36', '2750', '', 'avatar_effect7', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50072', '36', '2751', '', 'avatar_effect8', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50073', '36', '2753', '', 'avatar_effect10', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50074', '36', '2755', '', 'avatar_effect12', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50075', '36', '2756', '', 'avatar_effect13', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50091', '20', '304', '', 'a0 prizetrophy5_g', '0', '12', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50092', '20', '311', '', 'a0 prizetrophy5_s', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50093', '20', '298', '', 'a0 prizetrophy5_b', '0', '8', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50094', '20', '302', '', 'a0 prizetrophy3_g', '0', '12', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50095', '20', '309', '', 'a0 prizetrophy3_s', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50096', '20', '296', '', 'a0 prizetrophy3_b', '0', '8', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50097', '20', '301', '', 'a0 prizetrophy2_g', '0', '12', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50098', '20', '308', '', 'a0 prizetrophy2_s', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50099', '20', '295', '', 'a0 prizetrophy2_b', '0', '8', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50100', '20', '303', '', 'a0 prizetrophy4_g', '0', '12', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50101', '20', '310', '', 'a0 prizetrophy4_s', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50102', '20', '297', '', 'a0 prizetrophy4_b', '0', '8', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50103', '20', '305', '', 'a0 prizetrophy6_g', '0', '12', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50104', '20', '312', '', 'a0 prizetrophy6_s', '0', '10', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50105', '20', '299', '', 'a0 prizetrophy6_b', '0', '8', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50106', '115', '2883', '', 'a0 pet12', '20', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50107', '94', '2886', '', 'mm_lemon_drink', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50108', '10', '2887', '', 'qt_sum11_shell1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50109', '10', '2888', '', 'qt_sum11_ictrolley', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50110', '10', '2889', '', 'qt_sum11_petfood', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50111', '10', '2890', '', 'qt_sum11_shell4', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50112', '10', '2891', '', 'qt_sum11_shell3', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50113', '10', '2892', '', 'qt_sum11_platfrm', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50114', '10', '2893', '', 'qt_sum11_shell2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50115', '10', '2894', '', 'qt_sum11_shell5', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50116', '10', '2895', '', 'qt_sum11_chair', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50117', '94', '2896', '', 'ads_cchups_screen', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50118', '94', '2897', '', 'mm_tub', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50119', '100', '290', '', 'a1 newplch16', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50120', '100', '284', '', 'a1 newplch2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50121', '100', '83', '', 'A1 E3P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50122', '100', '24', '', 'A1 EHP', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50123', '100', '98', '', 'A1 E7P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50124', '100', '93', '', 'A1 E6P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50125', '100', '52', '', 'A1 E1P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50126', '100', '73', '', 'A1 E8P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50127', '100', '88', '', 'A1 E2P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50128', '100', '59', '', 'A1 E4P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50129', '100', '66', '', 'A1 E5P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50130', '100', '103', '', 'A1 E9P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50131', '100', '291', '', 'a1 newpltb4lg16', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50132', '100', '277', '', 'a1 newpl4lg2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50133', '100', '79', '', 'A1 A3P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50134', '100', '94', '', 'A1 A7P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50135', '100', '89', '', 'A1 A6P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50136', '100', '276', '', 'a1 newa8p', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50137', '100', '55', '', 'A1 A4P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50138', '100', '99', '', 'A1 A9P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50139', '100', '3', '', 'A1 AHP', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50140', '100', '84', '', 'A1 A2P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50141', '100', '62', '', 'A1 A5P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50142', '100', '48', '', 'A1 A1P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50143', '100', '282', '', 'a1 newplsq1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50144', '100', '283', '', 'a1 newplsq2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50145', '100', '82', '', 'A1 B3P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50146', '100', '97', '', 'A1 B7P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50147', '100', '92', '', 'A1 B6P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50148', '100', '51', '', 'A1 B1P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50149', '100', '72', '', 'A1 B8P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50150', '100', '87', '', 'A1 B2P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50151', '100', '58', '', 'A1 B4P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50152', '100', '102', '', 'A1 B9P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50153', '100', '65', '', 'A1 B5P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50154', '100', '25', '', 'A1 BHP', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50155', '100', '101', '', 'A1 C9P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50156', '100', '86', '', 'A1 C2P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50157', '100', '71', '', 'A1 C8P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50158', '100', '50', '', 'A1 C1P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50159', '100', '57', '', 'A1 C4P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50160', '100', '64', '', 'A1 C5P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50161', '100', '10', '', 'A1 CHP', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50162', '100', '91', '', 'A1 C6P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50163', '100', '96', '', 'A1 C7P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50164', '100', '81', '', 'A1 C3P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50165', '100', '281', '', 'a1 newplrnd2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50166', '100', '280', '', 'a1 newplrnd1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50167', '100', '80', '', 'A1 D3P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50168', '100', '95', '', 'A1 D7P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50169', '100', '100', '', 'A1 D9P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50170', '100', '63', '', 'A1 D5P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50171', '100', '56', '', 'A1 D4P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50172', '100', '11', '', 'A1 DHP', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50173', '100', '85', '', 'A1 D2P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50174', '100', '70', '', 'A1 D8P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50175', '100', '49', '', 'A1 D1P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50176', '100', '90', '', 'A1 D6P', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50177', '100', '278', '', 'a1 newplbsq1', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50178', '100', '279', '', 'a1 newplbsq2', '3', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50179', '100', '23', '', 'A2 PL1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50180', '100', '105', '', 'A2 PL2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50181', '100', '285', '', 'a1 newplty1', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50182', '100', '110', '', 'A2 PL5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50183', '100', '287', '', 'a1 newplty3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50184', '100', '288', '', 'a1 newplty4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50185', '100', '289', '', 'a1 newplty5', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50186', '100', '286', '', 'a1 newplty2', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50187', '100', '108', '', 'A2 PL3', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50188', '100', '109', '', 'A2 PL4', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50189', '100', '130', '', 'A2 PL6', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50190', '100', '134', '', 'A2 PL7', '5', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50230', '117', '1018', '2', 'SONG bossanova', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50232', '117', '1018', '1', 'SONG TeemuP2', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50233', '117', '1018', '3', 'Frank\'s Generic Hotel Sounds', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50234', '117', '1018', '4', 'SONG pianissimo', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50235', '117', '1018', '5', 'SONG park_adventure', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50236', '117', '1018', '6', 'SONG new_song', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50237', '117', '1018', '7', 'SONG miamimiamor', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50238', '117', '1018', '8', 'SONG limbertake', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50239', '117', '1018', '9', 'SONG klubhaus', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50240', '117', '1018', '10', 'SONG disco_extreme', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50241', '117', '1018', '11', 'SONG TeemuP1', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50242', '117', '1018', '12', 'SONG Haadolocknloll', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50243', '117', '1018', '13', 'SONG Weirdodo', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50244', '117', '1018', '14', 'SONG double_peks', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50245', '117', '1018', '15', 'SONG Trax_1', '1', '0', '1', '1', '0');
INSERT INTO `catalog_items` VALUES ('50246', '117', '1018', '16', 'SONG WhoDaresStacks', '1', '0', '1', '1', '0');

-- ----------------------------
-- Table structure for `catalog_subscriptions`
-- ----------------------------
DROP TABLE IF EXISTS `catalog_subscriptions`;
CREATE TABLE `catalog_subscriptions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT 'HABBO_CLUB_BASIC_1_MONTH',
  `type` enum('vip','upgrade','basic') NOT NULL DEFAULT 'basic',
  `cost_credits` int(10) NOT NULL DEFAULT '20',
  `length_days` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of catalog_subscriptions
-- ----------------------------
INSERT INTO `catalog_subscriptions` VALUES ('1', 'HABBO_CLUB_VIP_1_MONTH', 'vip', '25', '31');
INSERT INTO `catalog_subscriptions` VALUES ('2', 'HABBO_CLUB_VIP_3_MONTHS', 'vip', '60', '93');
INSERT INTO `catalog_subscriptions` VALUES ('3', 'HABBO_CLUB_BASIC_1_MONTH', 'basic', '15', '31');
INSERT INTO `catalog_subscriptions` VALUES ('4', 'HABBO_CLUB_BASIC_3_MONTHS', 'basic', '45', '93');
INSERT INTO `catalog_subscriptions` VALUES ('5', 'HABBO_CLUB_UPGRADE_1', 'upgrade', '10', '0');
INSERT INTO `catalog_subscriptions` VALUES ('6', 'HABBO_CLUB_UPGRADE_3', 'upgrade', '50', '62');

-- ----------------------------
-- Table structure for `characters`
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `account_uid` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(15) NOT NULL DEFAULT '',
  `real_name` varchar(64) NOT NULL DEFAULT '',
  `motto` varchar(255) NOT NULL DEFAULT 'uberHotel Newbie',
  `figure` varchar(255) NOT NULL DEFAULT 'hr-165-34.sh-290-92.ch-215-84.hd-180-1.lg-280-64',
  `gender` enum('M','F') NOT NULL DEFAULT 'M',
  `credits_balance` int(10) NOT NULL DEFAULT '100',
  `activity_points_balance` int(10) NOT NULL DEFAULT '2000',
  `activity_points_last_update` double NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '0',
  `privacy_accept_friends` enum('0','1') NOT NULL DEFAULT '1',
  `home_room` int(10) unsigned NOT NULL DEFAULT '0',
  `auth_ticket` varchar(64) NOT NULL DEFAULT '',
  `last_ip` varchar(64) NOT NULL DEFAULT '',
  `config_volume` int(11) NOT NULL DEFAULT '100',
  `timestamp_lastvisit` double(11,0) NOT NULL DEFAULT '0',
  `timestamp_created` double NOT NULL DEFAULT '0',
  `moderation_tickets` int(11) NOT NULL DEFAULT '0',
  `moderation_tickets_abusive` int(11) NOT NULL DEFAULT '0',
  `moderation_tickets_cooldown` double NOT NULL DEFAULT '0',
  `moderation_bans` int(11) NOT NULL DEFAULT '0',
  `moderation_cautions` int(11) NOT NULL DEFAULT '0',
  `moderation_muted_until_timestamp` double NOT NULL,
  `respect_points` int(11) NOT NULL DEFAULT '0',
  `respect_credit_humans` int(11) NOT NULL DEFAULT '3',
  `respect_credit_pets` int(11) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of characters
-- ----------------------------
INSERT INTO `characters` VALUES ('1', '1', 'Admin', 'Jane Doe', 'Administrator', 'hr-3194-40-31.cc-3039-100.sh-290-62.hd-3092-1.lg-270-110.fa-1206-62.ha-3129-100', 'M', '100', '2000', '0', '0', '1', '0', '', '', '100', '0', '0', '0', '0', '0', '0', '0', '0', '0', '3', '3');

-- ----------------------------
-- Table structure for `drink_sets`
-- ----------------------------
DROP TABLE IF EXISTS `drink_sets`;
CREATE TABLE `drink_sets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `drinks` varchar(255) COLLATE latin1_german1_ci NOT NULL,
  `internal_comment` text COLLATE latin1_german1_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_german1_ci;

-- ----------------------------
-- Records of drink_sets
-- ----------------------------
INSERT INTO `drink_sets` VALUES ('1', '4', 'icecream machines');
INSERT INTO `drink_sets` VALUES ('2', '43,7,6,2,5', 'minbars');
INSERT INTO `drink_sets` VALUES ('3', '1', 'teamakers');
INSERT INTO `drink_sets` VALUES ('4', '43,7,6,2,5,3,4,34', 'fridges');
INSERT INTO `drink_sets` VALUES ('5', '8,13,4,10,11,12,17,53', 'coffee machines');
INSERT INTO `drink_sets` VALUES ('6', '24', 'bubble juice machines');
INSERT INTO `drink_sets` VALUES ('7', '7', 'water dispensers');

-- ----------------------------
-- Table structure for `favorites`
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorites
-- ----------------------------

-- ----------------------------
-- Table structure for `flat_categories`
-- ----------------------------
DROP TABLE IF EXISTS `flat_categories`;
CREATE TABLE `flat_categories` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) NOT NULL DEFAULT '',
  `order_num` int(11) NOT NULL DEFAULT '0',
  `visible` enum('0','1') NOT NULL DEFAULT '1',
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  `allow_trading` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of flat_categories
-- ----------------------------
INSERT INTO `flat_categories` VALUES ('1', 'Party, Chat and Chill ', '1', '1', '1', '0');
INSERT INTO `flat_categories` VALUES ('2', 'Food and Drink', '2', '1', '1', '0');
INSERT INTO `flat_categories` VALUES ('4', 'Creativity and Other', '7', '1', '1', '0');
INSERT INTO `flat_categories` VALUES ('7', 'Shops and Services', '3', '1', '1', '0');
INSERT INTO `flat_categories` VALUES ('8', 'Gaming and Mazes', '4', '1', '1', '0');
INSERT INTO `flat_categories` VALUES ('9', 'Trading, Shopping, Selling', '5', '1', '1', '1');
INSERT INTO `flat_categories` VALUES ('10', 'Groups and Role-Playing', '6', '1', '1', '0');

-- ----------------------------
-- Table structure for `help_categories`
-- ----------------------------
DROP TABLE IF EXISTS `help_categories`;
CREATE TABLE `help_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `visible` enum('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of help_categories
-- ----------------------------
INSERT INTO `help_categories` VALUES ('1', 'General', '1');
INSERT INTO `help_categories` VALUES ('2', 'Credits and pixels', '1');
INSERT INTO `help_categories` VALUES ('3', 'Furniture and catalogue', '1');
INSERT INTO `help_categories` VALUES ('4', 'Rooms and users', '1');
INSERT INTO `help_categories` VALUES ('5', 'Bugs and missing features', '1');
INSERT INTO `help_categories` VALUES ('6', 'Other', '1');

-- ----------------------------
-- Table structure for `help_topics`
-- ----------------------------
DROP TABLE IF EXISTS `help_topics`;
CREATE TABLE `help_topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` int(10) unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `body` text NOT NULL,
  `priority` enum('1','2','0') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of help_topics
-- ----------------------------
INSERT INTO `help_topics` VALUES ('1', '1', 'Welcome to Snowlight!', 'Welcome to the uberHotel! uberHotel is the test platform for the new Snowlight server. Snowlight is fast, robust and packed with features - designed to meet your every need. Snowlight is still under development and will be available in several different packages from July 2011.\r\n\r\nFor more information, visit the official website at <a href=\"http://www.meth0d.org/snowlight\">http://www.meth0d.org/snowlight</a>.\r\n\r\nThis is a test/development platform, and is in no way a representation of the final product.', '2');
INSERT INTO `help_topics` VALUES ('2', '5', 'snowlight.uservoice.com', 'If you have found any bugs, missing features, or have other ideas or feedback, please submit them on our uservoice forum:\r\n\r\nhttp://snowlight.uservoice.com\r\n\r\nThank you!', '2');
INSERT INTO `help_topics` VALUES ('3', '4', 'Reporting a user', 'If another user is misbehaving, breaking rules, or behaving inappropiately, it is possible to report the user to the moderators. There are two possible ways to do so:\r\n\r\n1. Select the user, and press \'Report\'. The report window will appear.\r\n2. Click the yellow question mark (while in a room), and click \'Report user to the moderators\'. Select the offending user. The report window will appear.', '1');
INSERT INTO `help_topics` VALUES ('4', '1', 'The Habbo Way (Rules)', 'What is the Habbo Way?\r\nThe Habbo Way is like a code of conduct, a guide to how Habbos should act in the Hotel. Habbos who break the Habbo Way are not welcome in the Hotel and may be banned. The Habbo Way is a simple set of rules for all players to follow in the Habbo.\r\n\r\nThe Habbo Way\r\n1. Do not bully, harass or abuse other players; avoid violent or aggressive behaviour.\r\n2. Do not steal or scam passwords, credits or furniture from other players. \r\n3. Keep your password and personal details secret and never try to gain this information from other players.\r\n4. You may not give away, sell or trade your Habbo account or seek to sell virtual items from Habbo for cash.\r\n5. Do not take part in sexual activities, make sexual proposals or respond to them.\r\n6. Do not use any scripts or third party software to enter, disrupt or modify Habbo.\r\n7. Treat other players as you would wish to be treated! And remember that a crime in a virtual world is as serious as in the real world.\r\n\r\nYou may also wish to review our Terms of Use.\r\n\r\nWhy is there a Habbo Way?\r\nHabbo Hotel is a place where people come to relax, hang out and make new friends in a safe, non-threatening environment. The Habbo Way helps to maintain this safe, non-threatening environment.\r\n\r\nWhat should I do if I see someone break the Habbo Way?\r\nIf you see someone break the Habbo Way and you are uncomfortable with it, you should use the Ignore feature. This prevents their chat from showing up on your screen. Use Ignore for name-calling, mild swearing, or anything else that just doesn\'t suit your taste. If the chat is truly offensive, hateful or racist, or if you feel threatened by it, send a \'call for help\' and report them to an on duty Moderator, then leave the room or place the Habbo on Ignore.\r\n\r\nWhat will happen if I break the Habbo Way?\r\nIf you break the Habbo Way you may be alerted, kicked from the room or banned from Habbo Hotel.\r\n\r\nWhy do my words come up as \'*****\'?\r\nAll areas of Habbo Hotel have a word filter which takes out offensive words. This covers swearing and racist or sexist language, plus email addresses and phone numbers.  Offensive words are replaced with \'*****\'. The filters also work on Habbo names, missions, Stickies and all types of messages sent through the Console.\r\n\r\nWhat happens if I avoid the word filter?\r\nIf you avoid the word filter you may be banned from Habbo Hotel.', '2');
INSERT INTO `help_topics` VALUES ('5', '2', 'How do I aquire credits?', 'You can acquire credits by buying exchange furniture from the catalog using pixels. You get pixels automatically for playing.\r\n\r\nCredits are considered the \"premium\" currency.', '1');
INSERT INTO `help_topics` VALUES ('6', '2', 'How do I aquire pixels?', 'You will receive pixels automatically every 15 minutes while being logged in to the hotel.', '1');

-- ----------------------------
-- Table structure for `ignores`
-- ----------------------------
DROP TABLE IF EXISTS `ignores`;
CREATE TABLE `ignores` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `ignore_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ignores
-- ----------------------------

-- ----------------------------
-- Table structure for `interstitials`
-- ----------------------------
DROP TABLE IF EXISTS `interstitials`;
CREATE TABLE `interstitials` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `views` int(11) NOT NULL,
  `enabled` enum('1','0') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of interstitials
-- ----------------------------
INSERT INTO `interstitials` VALUES ('2', 'http://www.uberhotel.org', 'http://cdn.uber.meth0d.org/interstitials/1.png', '2', '0');
INSERT INTO `interstitials` VALUES ('3', 'http://www.uberhotel.org', 'http://cdn.uber.meth0d.org/interstitials/2.png', '0', '0');
INSERT INTO `interstitials` VALUES ('4', 'http://www.uberhotel.org', 'http://cdn.uber.meth0d.org/interstitials/3.png', '1', '0');
INSERT INTO `interstitials` VALUES ('5', 'http://www.uberhotel.org', 'http://cdn.uber.meth0d.org/interstitials/4.png', '3', '0');

-- ----------------------------
-- Table structure for `items`
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `definition_id` int(10) unsigned NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_pos` varchar(16) NOT NULL DEFAULT '0|0|0',
  `room_wall_pos` varchar(64) NOT NULL DEFAULT '',
  `room_rot` int(11) NOT NULL DEFAULT '0',
  `flags` text NOT NULL,
  `flags_display` text NOT NULL,
  `untradable` enum('0','1') NOT NULL DEFAULT '0',
  `expire_timestamp` double NOT NULL DEFAULT '0',
  `soundmanager_id` int(10) unsigned NOT NULL DEFAULT '0',
  `soundmanager_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of items
-- ----------------------------

-- ----------------------------
-- Table structure for `item_definitions`
-- ----------------------------
DROP TABLE IF EXISTS `item_definitions`;
CREATE TABLE `item_definitions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sprite_id` int(10) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'new_item',
  `type` varchar(32) NOT NULL DEFAULT 's',
  `behavior` varchar(32) NOT NULL DEFAULT 'switch',
  `behavior_data` int(11) NOT NULL DEFAULT '2',
  `stacking_behavior` enum('ignore','terminator','initiator','disable','normal') NOT NULL DEFAULT 'normal',
  `size_x` int(11) NOT NULL DEFAULT '1',
  `size_y` int(11) NOT NULL DEFAULT '1',
  `height` float NOT NULL DEFAULT '1',
  `allow_recycling` enum('0','1') NOT NULL DEFAULT '1',
  `allow_trading` enum('0','1') NOT NULL DEFAULT '1',
  `allow_selling` enum('0','1') NOT NULL DEFAULT '1',
  `allow_gifting` enum('0','1') NOT NULL DEFAULT '1',
  `allow_inventory_stacking` enum('0','1') NOT NULL DEFAULT '1',
  `walkable` enum('1','2','0') NOT NULL DEFAULT '0',
  `room_limit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2898 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of item_definitions
-- ----------------------------
INSERT INTO `item_definitions` VALUES ('1', '13', 'shelves_norja', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2', '14', 'shelves_polyfon', 's', 'static', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('3', '22', 'table_plasto_4leg', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('4', '4309', 'xm09_infotv', 'i', 'switch', '2', 'normal', '0', '0', '1', '0', '0', '0', '0', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('5', '15', 'shelves_silo', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('6', '17', 'table_polyfon_small', 's', 'static', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('7', '18', 'chair_polyfon', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('8', '20', 'table_norja_med', 's', 'switch', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('9', '21', 'table_silo_med', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('10', '23', 'table_plasto_round', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('11', '24', 'table_plasto_bigsquare', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('12', '25', 'stand_polyfon_z', 's', 'static', '2', 'normal', '1', '1', '0.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('13', '26', 'chair_silo', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('14', '28', 'sofa_silo', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('15', '29', 'couch_norja', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('16', '30', 'chair_norja', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('17', '31', 'table_polyfon_med', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('18', '32', 'doormat_love', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('19', '33', 'doormat_plain', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('20', '34', 'sofachair_polyfon', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('21', '35', 'sofa_polyfon', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('22', '36', 'sofachair_silo', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('23', '38', 'chair_plasty', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('24', '39', 'chair_plasto', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('25', '40', 'table_plasto_square', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('26', '41', 'bed_polyfon', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('27', '42', 'bed_polyfon_one', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('28', '43', 'bed_trad_one', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('29', '44', 'bed_trad', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('30', '45', 'bed_silo_one', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('31', '46', 'bed_silo_two', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('32', '47', 'table_silo_small', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('33', '48', 'bed_armas_two', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('34', '49', 'bed_budget_one', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('35', '50', 'bed_budget', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('36', '51', 'shelves_armas', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('37', '52', 'bench_armas', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('38', '53', 'table_armas', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('39', '54', 'small_table_armas', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('40', '55', 'small_chair_armas', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('41', '56', 'fireplace_armas', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('42', '57', 'lamp_armas', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('43', '58', 'bed_armas_one', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('44', '59', 'carpet_standard', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('45', '60', 'carpet_armas', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('46', '61', 'carpet_polar', 's', 'static', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('47', '62', 'fireplace_polyfon', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('48', '63', 'table_plasto_4leg*1', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('49', '64', 'table_plasto_bigsquare*1', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('50', '65', 'table_plasto_round*1', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('51', '66', 'table_plasto_square*1', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('52', '67', 'chair_plasto*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('53', '68', 'carpet_standard*1', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('54', '69', 'doormat_plain*1', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('55', '70', 'table_plasto_4leg*2', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('56', '71', 'table_plasto_bigsquare*2', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('57', '72', 'table_plasto_round*2', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('58', '73', 'table_plasto_square*2', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('59', '74', 'chair_plasto*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('60', '75', 'doormat_plain*2', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('61', '76', 'carpet_standard*2', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('62', '77', 'table_plasto_4leg*3', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('63', '78', 'table_plasto_bigsquare*3', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('64', '79', 'table_plasto_round*3', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('65', '80', 'table_plasto_square*3', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('66', '81', 'chair_plasto*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('67', '82', 'carpet_standard*3', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('68', '83', 'doormat_plain*3', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('69', '84', 'table_plasto_4leg*4', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('70', '85', 'table_plasto_bigsquare*4', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('71', '86', 'table_plasto_round*4', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('72', '87', 'table_plasto_square*4', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('73', '88', 'chair_plasto*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('74', '89', 'carpet_standard*4', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('75', '90', 'doormat_plain*4', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('76', '91', 'doormat_plain*6', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('77', '93', 'doormat_plain*5', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('78', '94', 'carpet_standard*5', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('79', '95', 'table_plasto_4leg*5', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('80', '96', 'table_plasto_bigsquare*5', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('81', '97', 'table_plasto_round*5', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('82', '98', 'table_plasto_square*5', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('83', '99', 'chair_plasto*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('84', '100', 'table_plasto_4leg*6', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('85', '101', 'table_plasto_bigsquare*6', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('86', '102', 'table_plasto_round*6', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('87', '103', 'table_plasto_square*6', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('88', '104', 'chair_plasto*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('89', '105', 'table_plasto_4leg*7', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('90', '106', 'table_plasto_bigsquare*7', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('91', '107', 'table_plasto_round*7', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('92', '108', 'table_plasto_square*7', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('93', '109', 'chair_plasto*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('94', '110', 'table_plasto_4leg*8', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('95', '111', 'table_plasto_bigsquare*8', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('96', '112', 'table_plasto_round*8', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('97', '113', 'table_plasto_square*8', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('98', '114', 'chair_plasto*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('99', '115', 'table_plasto_4leg*9', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('100', '116', 'table_plasto_bigsquare*9', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('101', '117', 'table_plasto_round*9', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('102', '118', 'table_plasto_square*9', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('103', '119', 'chair_plasto*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('104', '120', 'carpet_standard*6', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('105', '121', 'chair_plasty*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('106', '122', 'pizza', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('107', '123', 'drinks', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('108', '124', 'chair_plasty*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('109', '125', 'chair_plasty*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('110', '126', 'chair_plasty*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('111', '127', 'bar_polyfon', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('112', '128', 'plant_cruddy', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('113', '129', 'bottle', 's', 'spinningbottle', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('114', '130', 'bardesk_polyfon', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('115', '131', 'bardeskcorner_polyfon', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('116', '132', 'floortile', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('117', '133', 'bar_armas', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('118', '134', 'bartable_armas', 's', 'static', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('119', '135', 'bar_chair_armas', 's', 'seat', '0', 'terminator', '1', '1', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('120', '136', 'carpet_soft', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('121', '137', 'carpet_soft*1', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('122', '138', 'carpet_soft*2', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('123', '139', 'carpet_soft*3', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('124', '140', 'carpet_soft*4', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('125', '141', 'carpet_soft*5', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('126', '143', 'carpet_soft*6', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('127', '144', 'red_tv', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('128', '145', 'wood_tv', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('129', '146', 'carpet_polar*1', 's', 'static', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('130', '147', 'chair_plasty*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('131', '148', 'carpet_polar*2', 's', 'static', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('132', '149', 'carpet_polar*3', 's', 'static', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('133', '150', 'carpet_polar*4', 's', 'static', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('134', '151', 'chair_plasty*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('135', '152', 'table_polyfon', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('136', '153', 'smooth_table_polyfon', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('137', '154', 'sofachair_polyfon_girl', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('138', '155', 'bed_polyfon_girl_one', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('139', '156', 'bed_polyfon_girl', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('140', '157', 'sofa_polyfon_girl', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('141', '158', 'bed_budgetb_one', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('142', '159', 'bed_budgetb', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('143', '160', 'plant_pineapple', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('144', '161', 'plant_fruittree', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('145', '162', 'plant_small_cactus', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('146', '163', 'plant_bonsai', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('147', '164', 'plant_big_cactus', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('148', '165', 'plant_yukka', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('149', '166', 'carpet_standard*7', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('150', '167', 'carpet_standard*8', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('151', '168', 'carpet_standard*9', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('152', '169', 'carpet_standard*10', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('153', '170', 'carpet_standard*11', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('154', '171', 'plant_sunflower', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('155', '172', 'plant_rose', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('156', '173', 'tv_luxus', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('157', '174', 'bath', 's', 'seat', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('158', '177', 'sink', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('159', '178', 'toilet', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('160', '179', 'duck', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('161', '180', 'tile', 's', 'static', '2', 'normal', '4', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('162', '181', 'toilet_red', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('163', '182', 'toilet_yell', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('164', '183', 'tile_red', 's', 'static', '2', 'normal', '4', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('165', '184', 'tile_yell', 's', 'static', '2', 'normal', '4', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('166', '185', 'prize1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('167', '186', 'prize2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('168', '187', 'present_gen', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('169', '188', 'present_gen1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('170', '189', 'present_gen2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('171', '190', 'present_gen3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('172', '191', 'present_gen4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('173', '192', 'present_gen5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('174', '193', 'present_gen6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('175', '195', 'bar_basic', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('176', '196', 'shelves_basic', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('177', '197', 'soft_sofachair_norja', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('178', '198', 'soft_sofa_norja', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('179', '199', 'lamp_basic', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('180', '200', 'lamp2_armas', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('181', '201', 'fridge', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('182', '202', 'door', 's', 'teleporter', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('183', '204', 'doorB', 's', 'teleporter', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('184', '205', 'doorC', 's', 'teleporter', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('185', '206', 'pumpkin', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('186', '207', 'skullcandle', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('187', '208', 'deadduck', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('188', '209', 'deadduck2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('189', '210', 'deadduck3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('190', '211', 'menorah', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('191', '212', 'pudding', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('192', '213', 'ham', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('193', '214', 'turkey', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('194', '215', 'xmasduck', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('195', '216', 'house', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('196', '217', 'triplecandle', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('197', '218', 'tree3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('198', '219', 'tree4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('199', '220', 'tree5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('200', '223', 'ham2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('201', '224', 'wcandleset', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('202', '225', 'rcandleset', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('203', '226', 'statue', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('204', '227', 'heart', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('205', '228', 'valeduck', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('206', '229', 'heartsofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('207', '230', 'throne', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('208', '231', 'samovar', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('209', '232', 'giftflowers', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('210', '233', 'habbocake', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('211', '234', 'hologram', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('212', '235', 'easterduck', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('213', '236', 'bunny', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('214', '237', 'basket', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('215', '238', 'birdie', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('216', '239', 'edice', 's', 'holodice', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('217', '243', 'prize3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('218', '244', 'divider_poly3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('219', '245', 'divider_arm1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('220', '246', 'divider_arm2', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('221', '247', 'divider_arm3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('222', '248', 'divider_nor1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('223', '249', 'divider_silo1', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('224', '250', 'divider_nor2', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('225', '251', 'divider_silo2', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('226', '252', 'divider_nor3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('227', '253', 'divider_silo3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('228', '254', 'typingmachine', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('229', '260', 'spyro', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('230', '261', 'redhologram', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('231', '263', 'camera', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('232', '264', 'joulutahti', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('233', '265', 'hyacinth1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('234', '266', 'hyacinth2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('235', '267', 'club_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('236', '268', 'chair_plasto*10', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('237', '269', 'chair_plasto*11', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('238', '270', 'bardeskcorner_polyfon*12', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('239', '271', 'bardeskcorner_polyfon*13', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('240', '273', 'chair_plasto*12', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('241', '274', 'chair_plasto*13', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('242', '275', 'chair_plasto*14', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('243', '276', 'table_plasto_4leg*14', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('244', '277', 'mocchamaster', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('245', '278', 'carpet_legocourt', 's', 'switch', '2', 'initiator', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('246', '279', 'bench_lego', 's', 'seat', '5', 'terminator', '4', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('247', '280', 'legotrophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('248', '283', 'valentinescreen', 's', 'static', '5', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('249', '284', 'edicehc', 's', 'dice', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('250', '285', 'rare_daffodil_rug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('251', '286', 'rare_beehive_bulb', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('252', '287', 'hcsohva', 's', 'seat', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('253', '288', 'hcamme', 's', 'seat', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('254', '289', 'rare_parasol*0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('255', '290', 'rare_elephant_statue', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('256', '291', 'rare_fountain', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('257', '292', 'rare_stand', 's', 'seat', '5', 'terminator', '1', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('258', '293', 'rare_globe', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('259', '294', 'rare_hammock', 's', 'bed', '5', 'normal', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('260', '295', 'rare_elephant_statue*1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('261', '296', 'rare_elephant_statue*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('262', '297', 'rare_fountain*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('263', '298', 'rare_fountain*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('264', '299', 'rare_fountain*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('265', '300', 'rare_beehive_bulb*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('266', '301', 'rare_beehive_bulb*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('267', '302', 'rare_xmas_screen', 's', 'seat', '2', 'normal', '2', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('268', '303', 'rare_parasol*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('269', '304', 'rare_parasol*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('270', '305', 'rare_parasol*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('271', '420', 'soft_jaggara_norja', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('272', '428', 'house2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('273', '449', 'djesko_turntable', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('274', '456', 'md_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('275', '457', 'md_limukaappi', 's', 'dispenser', '4', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('276', '1484', 'table_plasto_4leg*10', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('277', '1486', 'table_plasto_4leg*15', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('278', '1487', 'table_plasto_bigsquare*14', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('279', '1488', 'table_plasto_bigsquare*15', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('280', '1489', 'table_plasto_round*14', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('281', '1490', 'table_plasto_round*15', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('282', '1491', 'table_plasto_square*14', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('283', '1492', 'table_plasto_square*15', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('284', '1495', 'chair_plasto*15', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('285', '1496', 'chair_plasty*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('286', '1497', 'chair_plasty*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('287', '1498', 'chair_plasty*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('288', '1499', 'chair_plasty*10', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('289', '1500', 'chair_plasty*11', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('290', '1501', 'chair_plasto*16', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('291', '1502', 'table_plasto_4leg*16', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('292', '1503', 'hockey_score', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('293', '1504', 'hockey_light', 's', 'alert', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('294', '1505', 'doorD', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('295', '1506', 'prizetrophy2*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('296', '1507', 'prizetrophy3*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('297', '1508', 'prizetrophy4*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('298', '1509', 'prizetrophy5*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('299', '1510', 'prizetrophy6*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('300', '1512', 'prizetrophy*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('301', '1513', 'prizetrophy2*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('302', '1514', 'prizetrophy3*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('303', '1515', 'prizetrophy4*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('304', '1516', 'prizetrophy5*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('305', '1517', 'prizetrophy6*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('306', '1518', 'prizetrophy7*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('307', '1519', 'prizetrophy*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('308', '1520', 'prizetrophy2*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('309', '1521', 'prizetrophy3*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('310', '1522', 'prizetrophy4*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('311', '1523', 'prizetrophy5*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('312', '1524', 'prizetrophy6*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('313', '1525', 'prizetrophy7*2', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('314', '1526', 'prizetrophy*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('315', '1527', 'hc_chr', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('316', '1528', 'hc_tbl', 's', 'switch', '2', 'normal', '1', '3', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('317', '1529', 'hc_lmp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('318', '1530', 'hc_dsk', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('319', '1531', 'nest', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('320', '1532', 'petfood1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('321', '1533', 'petfood2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('322', '1534', 'petfood3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('323', '1535', 'waterbowl*4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('324', '1536', 'waterbowl*5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('325', '1537', 'waterbowl*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('326', '1538', 'waterbowl*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('327', '1539', 'waterbowl*3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('328', '1540', 'toy1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('329', '1541', 'toy1*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('330', '1542', 'toy1*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('331', '1543', 'toy1*3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('332', '1544', 'toy1*4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('333', '1545', 'goodie1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('334', '1546', 'goodie1*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('335', '1547', 'goodie1*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('336', '1548', 'goodie2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('337', '1549', 'scifiport*0', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('338', '1550', 'scifiport*9', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('339', '1551', 'scifiport*8', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('340', '1552', 'scifiport*7', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('341', '1553', 'scifiport*6', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('342', '1554', 'scifiport*5', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('343', '1555', 'scifiport*4', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('344', '1556', 'scifiport*3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('345', '1557', 'scifiport*2', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('346', '1558', 'scifiport*1', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('347', '1559', 'scifirocket*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('348', '1560', 'scifirocket*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('349', '1561', 'scifirocket*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('350', '1562', 'scifirocket*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('351', '1563', 'scifirocket*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('352', '1564', 'scifirocket*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('353', '1565', 'scifirocket*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('354', '1566', 'scifirocket*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('355', '1567', 'scifirocket*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('356', '1568', 'scifirocket*0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('357', '1569', 'scifidoor*10', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('358', '1570', 'scifidoor*9', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('359', '1571', 'scifidoor*8', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('360', '1572', 'scifidoor*7', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('361', '1573', 'scifidoor*6', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('362', '1574', 'scifidoor*5', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('363', '1575', 'scifidoor*4', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('364', '1576', 'scifidoor*3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('365', '1577', 'scifidoor*2', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('366', '1578', 'scifidoor*1', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('367', '1579', 'pillow*5', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('368', '1580', 'pillow*8', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('369', '1581', 'pillow*0', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('370', '1582', 'pillow*1', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('371', '1583', 'pillow*2', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('372', '1584', 'pillow*7', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('373', '1585', 'pillow*9', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('374', '1586', 'pillow*4', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('375', '1587', 'pillow*6', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('376', '1588', 'pillow*3', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('377', '1589', 'marquee*1', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('378', '1590', 'marquee*2', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('379', '1591', 'marquee*7', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('380', '1592', 'marquee*10', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('381', '1593', 'marquee*8', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('382', '1594', 'marquee*9', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('383', '1595', 'marquee*5', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('384', '1596', 'marquee*4', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('385', '1597', 'marquee*6', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('386', '1598', 'marquee*3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('387', '1599', 'wooden_screen*1', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('388', '1600', 'wooden_screen*2', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('389', '1601', 'wooden_screen*7', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('390', '1602', 'wooden_screen*0', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('391', '1603', 'wooden_screen*8', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('392', '1604', 'wooden_screen*5', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('393', '1605', 'wooden_screen*9', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('394', '1606', 'wooden_screen*4', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('395', '1607', 'wooden_screen*6', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('396', '1608', 'wooden_screen*3', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('397', '1609', 'pillar*6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('398', '1610', 'pillar*1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('399', '1611', 'pillar*9', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('400', '1612', 'pillar*0', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('401', '1613', 'pillar*8', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('402', '1614', 'pillar*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('403', '1615', 'pillar*5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('404', '1616', 'pillar*4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('405', '1617', 'pillar*7', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('406', '1618', 'pillar*3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('407', '1619', 'rare_dragonlamp*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('408', '1620', 'rare_dragonlamp*0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('409', '1621', 'rare_dragonlamp*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('410', '1622', 'rare_dragonlamp*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('411', '1623', 'rare_dragonlamp*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('412', '1624', 'rare_dragonlamp*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('413', '1625', 'rare_dragonlamp*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('414', '1626', 'rare_dragonlamp*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('415', '1627', 'rare_dragonlamp*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('416', '1628', 'rare_dragonlamp*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('417', '1629', 'rare_icecream*1', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('418', '1630', 'rare_icecream*7', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('419', '1631', 'rare_icecream*8', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('420', '1632', 'rare_icecream*2', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('421', '1633', 'rare_icecream*6', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('422', '1634', 'rare_icecream*9', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('423', '1635', 'rare_icecream*3', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('424', '1636', 'rare_icecream*0', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('425', '1637', 'rare_icecream*4', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('426', '1638', 'rare_icecream*5', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('427', '1639', 'rare_fan*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('428', '1640', 'rare_fan*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('429', '1641', 'rare_fan*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('430', '1642', 'rare_fan*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('431', '1643', 'rare_fan*0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('432', '1644', 'rare_fan*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('433', '1645', 'rare_fan*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('434', '1646', 'rare_fan*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('435', '1647', 'rare_fan*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('436', '1648', 'rare_fan*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('437', '1649', 'queue_tile1*3', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('438', '1650', 'queue_tile1*6', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('439', '1651', 'queue_tile1*4', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('440', '1652', 'queue_tile1*9', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('441', '1653', 'queue_tile1*8', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('442', '1654', 'queue_tile1*5', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('443', '1655', 'queue_tile1*7', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('444', '1656', 'queue_tile1*2', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('445', '1657', 'queue_tile1*1', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('446', '1658', 'queue_tile1*0', 's', 'roller', '2', 'initiator', '1', '1', '0.45', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('447', '1659', 'ticket', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('448', '1738', 'rare_snowrug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('449', '1741', 'cn_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('450', '1742', 'cn_sofa', 's', 'seat', '0', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('451', '1745', 'sporttrack1*1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('452', '1747', 'sporttrack1*3', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('453', '1748', 'sporttrack1*2', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('454', '1750', 'sporttrack2*1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('455', '1751', 'sporttrack2*2', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('456', '1752', 'sporttrack2*3', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('457', '1754', 'sporttrack3*1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('458', '1755', 'sporttrack3*2', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('459', '1756', 'sporttrack3*3', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('460', '1757', 'footylamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('461', '1758', 'tree1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('462', '1759', 'barchair_silo', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('463', '1760', 'divider_nor4*4', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('464', '1761', 'traffic_light*1', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('465', '1762', 'traffic_light*2', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('466', '1763', 'traffic_light*3', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('467', '1764', 'traffic_light*4', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('468', '1765', 'traffic_light*6', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('469', '1766', 'rubberchair*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('470', '1767', 'rubberchair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('471', '1768', 'rubberchair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('472', '1769', 'rubberchair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('473', '1770', 'rubberchair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('474', '1771', 'rubberchair*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('475', '1772', 'barrier*1', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('476', '1773', 'barrier*2', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('477', '1774', 'barrier*3', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('478', '1775', 'rubberchair*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('479', '1776', 'rubberchair*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('480', '1777', 'table_norja_med*2', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('481', '1778', 'table_norja_med*3', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('482', '1779', 'table_norja_med*4', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('483', '1780', 'table_norja_med*5', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('484', '1781', 'table_norja_med*6', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('485', '1782', 'table_norja_med*7', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('486', '1783', 'table_norja_med*8', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('487', '1784', 'table_norja_med*9', 's', 'static', '2', 'normal', '2', '2', '1.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('488', '1785', 'couch_norja*2', 's', 'seat', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('489', '1786', 'couch_norja*3', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('490', '1787', 'couch_norja*4', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('491', '1788', 'couch_norja*5', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('492', '1789', 'couch_norja*6', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('493', '1790', 'couch_norja*7', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('494', '1791', 'couch_norja*8', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('495', '1792', 'couch_norja*9', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('496', '1793', 'shelves_norja*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('497', '1794', 'shelves_norja*3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('498', '1795', 'shelves_norja*4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('499', '1796', 'shelves_norja*5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('500', '1797', 'shelves_norja*6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('501', '1798', 'shelves_norja*7', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('502', '1799', 'shelves_norja*8', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('503', '1800', 'shelves_norja*9', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('504', '1801', 'chair_norja*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('505', '1802', 'chair_norja*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('506', '1803', 'chair_norja*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('507', '1804', 'chair_norja*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('508', '1805', 'chair_norja*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('509', '1806', 'chair_norja*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('510', '1807', 'chair_norja*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('511', '1808', 'chair_norja*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('512', '1809', 'divider_nor1*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('513', '1810', 'divider_nor1*3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('514', '1811', 'divider_nor1*4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('515', '1812', 'divider_nor1*5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('516', '1813', 'divider_nor1*6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('517', '1814', 'divider_nor1*7', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('518', '1815', 'divider_nor1*8', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('519', '1816', 'divider_nor1*9', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('520', '1817', 'soft_sofa_norja*2', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('521', '1818', 'soft_sofa_norja*3', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('522', '1819', 'soft_sofa_norja*4', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('523', '1820', 'soft_sofa_norja*5', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('524', '1821', 'soft_sofa_norja*6', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('525', '1822', 'soft_sofa_norja*7', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('526', '1823', 'soft_sofa_norja*8', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('527', '1824', 'soft_sofa_norja*9', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('528', '1825', 'soft_sofachair_norja*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('529', '1826', 'soft_sofachair_norja*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('530', '1827', 'soft_sofachair_norja*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('531', '1828', 'soft_sofachair_norja*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('532', '1829', 'soft_sofachair_norja*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('533', '1830', 'soft_sofachair_norja*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('534', '1831', 'soft_sofachair_norja*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('535', '1832', 'soft_sofachair_norja*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('536', '1833', 'sofachair_silo*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('537', '1834', 'sofachair_silo*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('538', '1835', 'sofachair_silo*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('539', '1836', 'sofachair_silo*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('540', '1837', 'sofachair_silo*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('541', '1838', 'sofachair_silo*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('542', '1839', 'sofachair_silo*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('543', '1840', 'sofachair_silo*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('544', '1841', 'table_silo_small*2', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('545', '1842', 'table_silo_small*3', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('546', '1843', 'table_silo_small*4', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('547', '1844', 'table_silo_small*5', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('548', '1845', 'table_silo_small*6', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('549', '1846', 'table_silo_small*7', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('550', '1847', 'table_silo_small*8', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('551', '1848', 'table_silo_small*9', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('552', '1849', 'divider_silo1*2', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('553', '1850', 'divider_silo1*3', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('554', '1851', 'divider_silo1*4', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('555', '1852', 'divider_silo1*5', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('556', '1853', 'divider_silo1*6', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('557', '1854', 'divider_silo1*7', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('558', '1855', 'divider_silo1*8', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('559', '1856', 'divider_silo1*9', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('560', '1857', 'divider_silo3*2', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('561', '1858', 'divider_silo3*3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('562', '1859', 'divider_silo3*4', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('563', '1860', 'divider_silo3*5', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('564', '1861', 'divider_silo3*6', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('565', '1862', 'divider_silo3*7', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('566', '1863', 'divider_silo3*8', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('567', '1864', 'divider_silo3*9', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('568', '1865', 'table_silo_med*2', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('569', '1866', 'table_silo_med*3', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('570', '1867', 'table_silo_med*4', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('571', '1868', 'table_silo_med*5', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('572', '1869', 'table_silo_med*6', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('573', '1870', 'table_silo_med*7', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('574', '1871', 'table_silo_med*8', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('575', '1872', 'table_silo_med*9', 's', 'static', '0', 'normal', '2', '2', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('576', '1873', 'sofa_silo*2', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('577', '1874', 'sofa_silo*3', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('578', '1875', 'sofa_silo*4', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('579', '1876', 'sofa_silo*5', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('580', '1877', 'sofa_silo*6', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('581', '1878', 'sofa_silo*7', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('582', '1879', 'sofa_silo*8', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('583', '1880', 'sofa_silo*9', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('584', '1881', 'sofachair_polyfon*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('585', '1882', 'sofachair_polyfon*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('586', '1883', 'sofachair_polyfon*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('587', '1884', 'sofachair_polyfon*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('588', '1885', 'sofachair_polyfon*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('589', '1886', 'sofachair_polyfon*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('590', '1887', 'sofachair_polyfon*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('591', '1888', 'sofa_polyfon*2', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('592', '1889', 'sofa_polyfon*3', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('593', '1890', 'sofa_polyfon*4', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('594', '1891', 'sofa_polyfon*6', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('595', '1892', 'sofa_polyfon*7', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('596', '1893', 'sofa_polyfon*8', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('597', '1894', 'sofa_polyfon*9', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('598', '1895', 'bed_polyfon*2', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('599', '1896', 'bed_polyfon*3', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('600', '1897', 'bed_polyfon*4', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('601', '1898', 'bed_polyfon*6', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('602', '1899', 'bed_polyfon*7', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('603', '1900', 'bed_polyfon*8', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('604', '1901', 'bed_polyfon*9', 's', 'bed', '0', 'terminator', '2', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('605', '1902', 'bed_polyfon_one*2', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('606', '1903', 'bed_polyfon_one*3', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('607', '1904', 'bed_polyfon_one*4', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('608', '1905', 'bed_polyfon_one*6', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('609', '1906', 'bed_polyfon_one*7', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('610', '1907', 'bed_polyfon_one*8', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('611', '1908', 'bed_polyfon_one*9', 's', 'bed', '0', 'terminator', '1', '3', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('612', '1909', 'bardesk_polyfon*2', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('613', '1910', 'bardesk_polyfon*3', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('614', '1911', 'bardesk_polyfon*4', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('615', '1912', 'bardesk_polyfon*5', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('616', '1913', 'bardesk_polyfon*6', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('617', '1914', 'bardesk_polyfon*7', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('618', '1915', 'bardesk_polyfon*8', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('619', '1916', 'bardesk_polyfon*9', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('620', '1917', 'bardeskcorner_polyfon*2', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('621', '1918', 'bardeskcorner_polyfon*3', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('622', '1919', 'bardeskcorner_polyfon*4', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('623', '1920', 'bardeskcorner_polyfon*5', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('624', '1921', 'bardeskcorner_polyfon*6', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('625', '1922', 'bardeskcorner_polyfon*7', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('626', '1923', 'bardeskcorner_polyfon*8', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('627', '1924', 'bardeskcorner_polyfon*9', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('628', '1925', 'divider_poly3*2', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('629', '1926', 'divider_poly3*3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('630', '1927', 'divider_poly3*4', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('631', '1928', 'divider_poly3*5', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('632', '1929', 'divider_poly3*6', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('633', '1930', 'divider_poly3*7', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('634', '1931', 'divider_poly3*8', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('635', '1932', 'divider_poly3*9', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('636', '1933', 'chair_silo*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('637', '1934', 'chair_silo*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('638', '1935', 'chair_silo*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('639', '1936', 'chair_silo*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('640', '1937', 'chair_silo*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('641', '1938', 'chair_silo*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('642', '1939', 'chair_silo*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('643', '1940', 'chair_silo*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('644', '1941', 'divider_nor3*2', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('645', '1942', 'divider_nor3*3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('646', '1943', 'divider_nor3*4', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('647', '1944', 'divider_nor3*5', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('648', '1945', 'divider_nor3*6', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('649', '1946', 'divider_nor3*7', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('650', '1947', 'divider_nor3*8', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('651', '1948', 'divider_nor3*9', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('652', '1949', 'divider_nor2*2', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('653', '1950', 'divider_nor2*3', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('654', '1951', 'divider_nor2*4', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('655', '1952', 'divider_nor2*5', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('656', '1953', 'divider_nor2*6', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('657', '1954', 'divider_nor2*7', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('658', '1955', 'divider_nor2*8', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('659', '1956', 'divider_nor2*9', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('660', '1957', 'silo_studydesk', 's', 'static', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('661', '1958', 'solarium_norja', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('662', '1959', 'solarium_norja*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('663', '1960', 'solarium_norja*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('664', '1961', 'solarium_norja*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('665', '1962', 'solarium_norja*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('666', '1963', 'solarium_norja*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('667', '1964', 'solarium_norja*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('668', '1965', 'solarium_norja*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('669', '1966', 'solarium_norja*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('670', '1967', 'sandrug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('671', '1968', 'rare_moonrug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('672', '1969', 'chair_china', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('673', '1970', 'china_table', 's', 'switch', '2', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('674', '1971', 'sleepingbag*1', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('675', '1972', 'sleepingbag*2', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('676', '1973', 'sleepingbag*3', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('677', '1974', 'sleepingbag*4', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('678', '1975', 'safe_silo', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('679', '1976', 'sleepingbag*7', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('680', '1977', 'sleepingbag*9', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('681', '1978', 'sleepingbag*5', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('682', '1979', 'sleepingbag*10', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('683', '1980', 'sleepingbag*6', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('684', '1981', 'sleepingbag*8', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('685', '1982', 'china_shelve', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('686', '1983', 'traffic_light*5', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('687', '1984', 'divider_nor4*2', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('688', '1985', 'divider_nor4*3', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('689', '1986', 'divider_nor4*5', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('690', '1987', 'divider_nor4*6', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('691', '1988', 'divider_nor4*7', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('692', '1989', 'divider_nor4*8', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('693', '1990', 'divider_nor4*9', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('694', '1991', 'divider_nor5*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('695', '1992', 'divider_nor5*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('696', '1993', 'divider_nor5*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('697', '1994', 'divider_nor5*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('698', '1995', 'divider_nor5*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('699', '1996', 'divider_nor5*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('700', '1997', 'divider_nor5*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('701', '1998', 'divider_nor5*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('702', '1999', 'divider_nor5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('703', '2000', 'divider_nor4', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('704', '2001', 'wall_china', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('705', '2002', 'corner_china', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('706', '2003', 'barchair_silo*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('707', '2004', 'barchair_silo*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('708', '2005', 'barchair_silo*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('709', '2006', 'barchair_silo*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('710', '2007', 'barchair_silo*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('711', '2008', 'barchair_silo*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('712', '2009', 'barchair_silo*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('713', '2010', 'barchair_silo*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('714', '2011', 'safe_silo*2', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('715', '2012', 'safe_silo*3', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('716', '2013', 'safe_silo*4', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('717', '2014', 'safe_silo*5', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('718', '2015', 'safe_silo*6', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('719', '2016', 'safe_silo*7', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('720', '2017', 'safe_silo*8', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('721', '2018', 'safe_silo*9', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('722', '2019', 'glass_shelf', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('723', '2020', 'glass_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('724', '2021', 'glass_stool', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('725', '2022', 'glass_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('726', '2023', 'glass_table', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('727', '2024', 'glass_table*2', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('728', '2025', 'glass_table*3', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('729', '2026', 'glass_table*4', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('730', '2027', 'glass_table*5', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('731', '2028', 'glass_table*6', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('732', '2029', 'glass_table*7', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('733', '2030', 'glass_table*8', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('734', '2031', 'glass_table*9', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('735', '2032', 'glass_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('736', '2033', 'glass_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('737', '2034', 'glass_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('738', '2035', 'glass_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('739', '2036', 'glass_chair*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('740', '2037', 'glass_chair*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('741', '2038', 'glass_chair*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('742', '2039', 'glass_chair*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('743', '2040', 'glass_sofa*2', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('744', '2041', 'glass_sofa*3', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('745', '2042', 'glass_sofa*4', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('746', '2043', 'glass_sofa*5', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('747', '2044', 'glass_sofa*6', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('748', '2045', 'glass_sofa*7', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('749', '2046', 'glass_sofa*8', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('750', '2047', 'glass_sofa*9', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('751', '2048', 'glass_stool*2', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('752', '2050', 'glass_stool*4', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('753', '2051', 'glass_stool*5', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('754', '2052', 'glass_stool*6', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('755', '2053', 'glass_stool*7', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('756', '2054', 'glass_stool*8', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('757', '2056', 'glass_stool*3', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('758', '2057', 'glass_stool*9', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('759', '2063', 'CF_10_coin_gold', 's', 'exchange', '10', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('760', '2064', 'CF_1_coin_bronze', 's', 'exchange', '1', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('761', '2065', 'CF_20_moneybag', 's', 'exchange', '20', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('762', '2066', 'CF_50_goldbar', 's', 'exchange', '50', 'normal', '1', '1', '0.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('763', '2067', 'CF_5_coin_silver', 's', 'exchange', '5', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('764', '2068', 'hc_crpt', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('765', '2069', 'hc_tv', 's', 'seat', '2', 'terminator', '2', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('766', '2070', 'gothgate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('767', '2071', 'gothiccandelabra', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('768', '2072', 'gothrailing', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('769', '2073', 'goth_table', 's', 'static', '2', 'terminator', '1', '5', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('770', '2074', 'hc_bkshlf', 's', 'static', '2', 'terminator', '1', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('771', '2075', 'hc_btlr', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('772', '2076', 'hc_crtn', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('773', '2077', 'hc_djset', 's', 'static', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('774', '2078', 'hc_frplc', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('775', '2079', 'hc_lmpst', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('776', '2080', 'hc_machine', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('777', '2081', 'hc_rllr', 's', 'roller', '2', 'initiator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('778', '2082', 'hc_rntgn', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('779', '2083', 'hc_trll', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('780', '2084', 'gothic_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('781', '2085', 'gothic_sofa*1', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('782', '2086', 'gothic_stool*1', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('783', '2087', 'gothic_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('784', '2088', 'gothic_sofa*2', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('785', '2089', 'gothic_stool*2', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('786', '2090', 'gothic_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('787', '2091', 'gothic_sofa*3', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('788', '2092', 'gothic_stool*3', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('789', '2093', 'gothic_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('790', '2094', 'gothic_sofa*4', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('791', '2095', 'gothic_stool*4', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('792', '2096', 'gothic_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('793', '2097', 'gothic_sofa*5', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('794', '2098', 'gothic_stool*5', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('795', '2099', 'gothic_chair*6', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('796', '2100', 'gothic_sofa*6', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('797', '2101', 'gothic_stool*6', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('798', '2102', 'wcandle', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('799', '2103', 'val_cauldron', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('800', '2104', 'tree2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('801', '2105', 'sound_machine', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('802', '2106', 'romantique_pianochair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('803', '2107', 'romantique_pianochair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('804', '2108', 'romantique_pianochair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('805', '2109', 'romantique_pianochair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('806', '2110', 'romantique_pianochair*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('807', '2111', 'romantique_divan*3', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('808', '2112', 'romantique_divan*5', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('809', '2113', 'romantique_divan*2', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('810', '2114', 'romantique_divan*4', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('811', '2115', 'romantique_divan*1', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('812', '2116', 'romantique_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('813', '2117', 'romantique_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('814', '2118', 'romantique_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('815', '2119', 'romantique_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('816', '2120', 'romantique_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('817', '2121', 'rcandle', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('818', '2122', 'rare_parasol', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('819', '2123', 'plant_valentinerose*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('820', '2124', 'plant_valentinerose*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('821', '2125', 'plant_valentinerose*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('822', '2126', 'plant_valentinerose*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('823', '2127', 'plant_valentinerose*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('824', '2128', 'plant_mazegate', 's', 'gate', '0', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('825', '2129', 'plant_maze', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('826', '2130', 'plant_bulrush', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('827', '2131', 'petfood4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('828', '2132', 'carpet_valentine', 's', 'switch', '2', 'normal', '2', '7', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('829', '2133', 'gothic_carpet', 's', 'switch', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('830', '2134', 'gothic_carpet2', 's', 'switch', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('831', '2135', 'gothic_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('832', '2136', 'gothic_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('833', '2137', 'gothic_stool', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('839', '2143', 'theatre_seat', 's', 'seat', '7', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('840', '2144', 'romantique_tray2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('841', '2145', 'romantique_tray1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('842', '2146', 'romantique_smalltabl*3', 's', 'static', '2', 'normal', '1', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('843', '2147', 'romantique_smalltabl*5', 's', 'static', '2', 'normal', '1', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('844', '2148', 'romantique_smalltabl*2', 's', 'static', '2', 'normal', '1', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('845', '2149', 'romantique_smalltabl*4', 's', 'static', '2', 'normal', '1', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('846', '2150', 'romantique_smalltabl*1', 's', 'static', '2', 'normal', '1', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('847', '2151', 'romantique_mirrortabl', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('848', '2152', 'romantique_divider*3', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('849', '2153', 'romantique_divider*2', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('850', '2154', 'romantique_divider*4', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('851', '2155', 'romantique_divider*1', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('852', '2156', 'jp_tatami2', 's', 'static', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('853', '2157', 'jp_tatami', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('854', '2158', 'habbowood_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('855', '2159', 'jp_bamboo', 's', 'static', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('856', '2160', 'jp_irori', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('857', '2161', 'jp_pillow', 's', 'seat', '5', 'terminator', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('858', '2162', 'sound_set_1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('859', '2163', 'sound_set_2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('860', '2164', 'sound_set_3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('861', '2165', 'sound_set_4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('862', '2166', 'sound_set_5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('863', '2167', 'sound_set_6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('864', '2168', 'sound_set_7', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('865', '2169', 'sound_set_8', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('866', '2170', 'sound_set_9', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('867', '2171', 'sound_machine*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('868', '2457', 'sound_set_23', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('869', '2458', 'rclr_garden', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('870', '2459', 'rclr_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('871', '2460', 'pura_mdl1*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('872', '2461', 'pura_mdl1*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('873', '2462', 'pura_mdl1*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('874', '2463', 'pura_mdl1*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('875', '2464', 'pura_mdl1*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('876', '2465', 'pura_mdl1*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('877', '2466', 'pura_mdl1*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('878', '2467', 'pura_mdl1*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('879', '2468', 'pura_mdl1*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('880', '2469', 'sound_set_19', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('881', '2470', 'sound_set_25', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('882', '2471', 'jp_lantern', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('883', '2472', 'pura_mdl4*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('884', '2473', 'pura_mdl4*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('885', '2474', 'pura_mdl4*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('886', '2475', 'pura_mdl4*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('887', '2476', 'pura_mdl4*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('888', '2477', 'pura_mdl4*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('889', '2478', 'pura_mdl4*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('890', '2479', 'pura_mdl4*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('891', '2480', 'pura_mdl4*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('892', '2481', 'sound_set_10', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('893', '2482', 'sound_set_14', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('894', '2483', 'pura_mdl2*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('895', '2484', 'pura_mdl2*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('896', '2485', 'pura_mdl2*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('897', '2486', 'pura_mdl2*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('898', '2487', 'pura_mdl2*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('899', '2488', 'pura_mdl2*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('900', '2489', 'pura_mdl2*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('901', '2490', 'pura_mdl2*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('902', '2491', 'pura_mdl2*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('903', '2492', 'sound_set_24', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('904', '2493', 'sound_set_12', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('905', '2494', 'sound_set_21', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('906', '2495', 'sound_set_15', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('907', '2496', 'sound_set_28', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('908', '2497', 'sound_set_18', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('909', '2498', 'bed_budget_one*1', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('910', '2499', 'bed_budget_one*2', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('911', '2500', 'bed_budget_one*3', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('912', '2501', 'bed_budget_one*4', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('913', '2502', 'bed_budget_one*5', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('914', '2503', 'bed_budget_one*6', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('915', '2504', 'bed_budget_one*7', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('916', '2505', 'bed_budget_one*8', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('917', '2506', 'bed_budget_one*9', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('918', '2507', 'rare_icecream_campaign', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('919', '2508', 'sound_set_26', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('920', '2509', 'pura_mdl5*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('921', '2510', 'pura_mdl5*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('922', '2511', 'pura_mdl5*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('923', '2512', 'pura_mdl5*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('924', '2513', 'pura_mdl5*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('925', '2514', 'pura_mdl5*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('926', '2515', 'pura_mdl5*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('927', '2516', 'pura_mdl5*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('928', '2517', 'pura_mdl5*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('929', '2518', 'rope_divider', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('930', '2519', 'spotlight', 's', 'switch', '6', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('931', '2520', 'romantique_clock', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('932', '2521', 'sound_set_22', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('933', '2522', 'jp_drawer', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('934', '2523', 'sound_set_13', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('935', '2524', 'sound_set_20', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('936', '2525', 'chair_basic*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('937', '2526', 'chair_basic*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('938', '2527', 'chair_basic*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('939', '2528', 'chair_basic*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('940', '2529', 'chair_basic*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('941', '2530', 'chair_basic*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('942', '2531', 'chair_basic*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('943', '2532', 'chair_basic*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('944', '2533', 'chair_basic*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('945', '2534', 'pura_mdl3*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('946', '2535', 'pura_mdl3*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('947', '2536', 'pura_mdl3*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('948', '2537', 'pura_mdl3*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('949', '2538', 'pura_mdl3*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('950', '2539', 'pura_mdl3*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('951', '2540', 'pura_mdl3*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('952', '2541', 'pura_mdl3*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('953', '2542', 'pura_mdl3*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('954', '2543', 'sound_machine*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('955', '2544', 'sound_machine*3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('956', '2545', 'sound_machine*4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('957', '2546', 'sound_machine*5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('958', '2547', 'sound_machine*6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('959', '2548', 'sound_machine*7', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('960', '2549', 'sound_set_27', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('961', '2550', 'sound_set_17', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('962', '2551', 'rom_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('963', '2552', 'bed_budget*1', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('964', '2553', 'bed_budget*2', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('965', '2554', 'bed_budget*3', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('966', '2555', 'bed_budget*4', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('967', '2556', 'bed_budget*5', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('968', '2557', 'bed_budget*6', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('969', '2558', 'bed_budget*7', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('970', '2559', 'bed_budget*8', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('971', '2560', 'bed_budget*9', 's', 'bed', '0', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('972', '2561', 'sound_set_16', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('973', '2562', 'rclr_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('974', '2563', 'sound_set_11', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('975', '2564', 'sound_set_33', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('976', '2565', 'sound_set_37', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('977', '2566', 'tile_marble', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('978', '2567', 'exe_rug', 's', 'static', '0', 'normal', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('979', '2568', 'tile_stella', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('980', '2569', 'sound_set_32', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('981', '2570', 'sound_set_34', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('982', '2571', 'summer_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('983', '2572', 'summer_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('984', '2573', 'summer_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('985', '2574', 'summer_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('986', '2575', 'summer_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('987', '2576', 'summer_chair*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('988', '2577', 'summer_chair*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('989', '2578', 'summer_chair*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('990', '2579', 'summer_chair*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('991', '2580', 'sound_set_29', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('992', '2581', 'exe_s_table', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('993', '2582', 'tile_brown', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('994', '2583', 'sound_set_36', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('995', '2584', 'rare_mnstr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('996', '2585', 'sound_set_30', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('997', '2586', 'prizetrophy7*3', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('998', '2587', 'summer_grill*1', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('999', '2588', 'summer_grill*2', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1000', '2589', 'summer_grill*3', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1001', '2590', 'summer_grill*4', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1002', '2591', 'summer_pool*1', 's', 'static', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1003', '2592', 'summer_pool*2', 's', 'static', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1004', '2593', 'summer_pool*3', 's', 'static', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1005', '2594', 'summer_pool*4', 's', 'static', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1006', '2595', 'sound_set_35', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1007', '2596', 'sound_set_31', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1008', '2597', 'one_way_door*1', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1009', '2598', 'one_way_door*2', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1010', '2599', 'one_way_door*3', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1011', '2600', 'one_way_door*4', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1012', '2601', 'one_way_door*5', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1013', '2602', 'one_way_door*6', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1014', '2603', 'one_way_door*7', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1015', '2604', 'one_way_door*8', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1016', '2605', 'one_way_door*9', 's', 'onewaygate', '0', 'terminator', '1', '1', '0', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1017', '2606', 'sound_machine_pro', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1018', '2607', 'song_disk', 's', 'musicdisk', '2', 'normal', '1', '1', '0.1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `item_definitions` VALUES ('1019', '2608', 'jukebox*1', 's', 'traxplayer', '10', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1');
INSERT INTO `item_definitions` VALUES ('1020', '2609', 'carpet_soft_tut', 's', 'switch', '2', 'normal', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1021', '2610', 'sound_set_44', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1022', '2611', 'habboween_crypt', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1023', '2612', 'sound_set_41', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1024', '2613', 'grunge_sign', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1025', '2614', 'sound_set_43', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1026', '2615', 'sound_set_40', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1027', '2616', 'sound_set_38', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1028', '2617', 'grunge_chair', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1029', '2618', 'grunge_mattress', 's', 'seat', '5', 'terminator', '3', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1030', '2619', 'grunge_shelf', 's', 'static', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1031', '2620', 'hal_grave', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1032', '2621', 'grunge_radiator', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1033', '2622', 'sound_set_39', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1034', '2623', 'grunge_table', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1035', '2624', 'sound_set_42', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1036', '2625', 'hal_cauldron', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1037', '2626', 'habboween_grass', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1038', '2627', 'sound_set_47', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1039', '2628', 'sound_set_45', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1040', '2629', 'sound_set_48', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1041', '2630', 'sound_set_46', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1042', '2631', 'sound_set_51', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1043', '2632', 'sound_set_50', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1044', '2633', 'sound_set_52', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1045', '2634', 'sound_set_49', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1046', '2635', 'plant_maze_snow', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1047', '2636', 'xmas_cstl_gate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1048', '2637', 'christmas_reindeer', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1049', '2638', 'tree6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1050', '2639', 'exe_sofa', 's', 'seat', '0', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1051', '2640', 'plant_mazegate_snow', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1052', '2641', 'xmas_icelamp', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1053', '2642', 'safe_silo_pb', 's', 'dispenser', '4', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1054', '2643', 'exe_bardesk', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1055', '2644', 'exe_table', 's', 'switch', '2', 'terminator', '3', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1056', '2645', 'exe_drinks', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1057', '2646', 'xmas_cstl_wall', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1058', '2647', 'exe_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1059', '2648', 'christmas_sleigh', 's', 'seat', '5', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1060', '2649', 'sound_set_54', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1061', '2650', 'exe_chair2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1062', '2651', 'xmas_cstl_twr', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1063', '2652', 'sound_set_53', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1064', '2653', 'tree7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1065', '2654', 'christmas_poop', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1066', '2655', 'exe_corner', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1067', '2656', 'sound_set_58', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1068', '2657', 'noob_stool*1', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1069', '2658', 'noob_stool*2', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1070', '2659', 'noob_stool*3', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1071', '2660', 'noob_stool*4', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1072', '2661', 'noob_stool*5', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1073', '2662', 'noob_stool*6', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1074', '2663', 'noob_lamp*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1075', '2664', 'noob_lamp*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1076', '2665', 'noob_lamp*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1077', '2666', 'noob_lamp*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1078', '2667', 'noob_lamp*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1079', '2668', 'noob_lamp*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1080', '2669', 'sound_set_56', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1081', '2670', 'sound_set_59', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1082', '2671', 'sound_set_55', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1083', '2672', 'exe_globe', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1084', '2673', 'sound_set_57', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1085', '2674', 'exe_plant', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1086', '2675', 'noob_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1087', '2676', 'noob_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1088', '2677', 'noob_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1089', '2678', 'noob_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1090', '2679', 'noob_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1091', '2680', 'noob_chair*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1092', '2681', 'noob_rug*1', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1093', '2682', 'noob_rug*2', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1094', '2683', 'noob_rug*3', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1095', '2684', 'noob_rug*4', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1096', '2685', 'noob_rug*5', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1097', '2686', 'noob_rug*6', 's', 'static', '0', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1098', '2687', 'noob_table*1', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1099', '2688', 'noob_table*2', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1100', '2689', 'noob_table*3', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1101', '2690', 'noob_table*4', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1102', '2691', 'noob_table*5', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1103', '2692', 'noob_table*6', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1104', '2693', 'teleport_door', 's', 'teleporter', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1105', '2694', 'fortune', 's', 'holodice', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1106', '2695', 'sound_set_60', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1107', '2696', 'val_randomizer', 's', 'loveshuffler', '5', 'terminator', '4', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1108', '2697', 'val_choco', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1109', '2698', 'sound_set_61', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1110', '2699', 'val_teddy*1', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1111', '2700', 'val_teddy*2', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1112', '2701', 'val_teddy*3', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1113', '2702', 'val_teddy*4', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1114', '2703', 'val_teddy*5', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1115', '2704', 'val_teddy*6', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1116', '2705', 'sand_cstl_twr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1117', '2706', 'grunge_barrel', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1118', '2707', 'grunge_bench', 's', 'static', '5', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1119', '2708', 'grunge_candle', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1120', '2709', 'sw_chest', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1121', '2710', 'sand_cstl_wall', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1122', '2711', 'sw_raven', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1123', '2712', 'sand_cstl_gate', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1124', '2713', 'sw_table', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1125', '2714', 'arabian_tetbl', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1126', '2715', 'jp_tray1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1127', '2716', 'arabian_teamk', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1128', '2717', 'jp_tray5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1129', '2718', 'prizetrophy9*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1130', '2719', 'arabian_rug', 's', 'static', '0', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1131', '2720', 'jp_tray6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1132', '2721', 'arabian_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1133', '2722', 'arabian_pllw', 's', 'seat', '5', 'normal', '1', '1', '0.7', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1134', '2723', 'arabian_tray3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1135', '2724', 'jp_tray2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1136', '2725', 'jp_tray4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1137', '2726', 'jp_tray3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1138', '2727', 'md_rug', 's', 'static', '0', 'terminator', '4', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1139', '2728', 'arabian_tray4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1140', '2729', 'prizetrophy8*1', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1141', '2730', 'arabian_divdr', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1142', '2731', 'arabian_bigtb', 's', 'static', '2', 'normal', '3', '2', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1143', '2732', 'arabian_snake', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1144', '2733', 'rclr_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1145', '2734', 'arabian_tray1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1146', '2735', 'arabian_tray2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1147', '2736', 'nouvelle_trax', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1');
INSERT INTO `item_definitions` VALUES ('1148', '2737', 'calippo', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1149', '2738', 'sound_set_64', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1150', '2739', 'jukebox_ptv*1', 's', 'traxplayer', '10', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1');
INSERT INTO `item_definitions` VALUES ('1151', '2740', 'sound_set_63', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1152', '2741', 'sound_set_62', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1153', '2742', 'traxgold', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1154', '2743', 'traxbronze', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1155', '2744', 'traxsilver', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1156', '2745', 'bench_puffet', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1157', '2746', 'footylamp_campaign', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1158', '2747', 'jp_katana2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1159', '2748', 'jp_katana3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1160', '2749', 'jp_table', 's', 'switch', '4', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1161', '2750', 'jp_rare', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1162', '2751', 'jp_katana1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1163', '2752', 'sound_set_66', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1164', '2753', 'tiki_tray3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1165', '2754', 'tampax_rug', 's', 'static', '0', 'terminator', '3', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1166', '2755', 'tiki_tray1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1167', '2756', 'tiki_toucan', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1168', '2757', 'tiki_waterfall', 's', 'static', '2', 'terminator', '3', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1169', '2758', 'noob_lamp_tradeable*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1170', '2759', 'noob_lamp_tradeable*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1171', '2760', 'noob_lamp_tradeable*3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1172', '2761', 'noob_lamp_tradeable*4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1173', '2762', 'noob_lamp_tradeable*5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1174', '2763', 'noob_lamp_tradeable*6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1175', '2764', 'CFC_500_goldbar', 's', 'exchange', '500', 'normal', '1', '1', '0.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1176', '2765', 'tiki_tray4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1177', '2766', 'sound_set_65', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1178', '2767', 'sound_set_70', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1179', '2768', 'tiki_tray2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1180', '2769', 'tiki_parasol', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1181', '2770', 'CFC_200_moneybag', 's', 'exchange', '200', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1182', '2771', 'sound_set_67', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1183', '2772', 'CFC_50_coin_silver', 's', 'exchange', '50', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1184', '2773', 'tiki_torch', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1185', '2774', 'jp_teamaker', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1186', '2775', 'noob_chair_tradeable*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1187', '2776', 'noob_chair_tradeable*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1188', '2777', 'noob_chair_tradeable*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1189', '2778', 'noob_chair_tradeable*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1190', '2779', 'noob_chair_tradeable*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1191', '2780', 'noob_chair_tradeable*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1192', '2781', 'tiki_junglerug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1193', '2782', 'tiki_statue', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1194', '2783', 'noob_plant', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1195', '2784', 'tiki_bench', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1196', '2785', 'tiki_bflies', 's', 'switch', '3', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1197', '2786', 'noob_rug_tradeable*1', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1198', '2787', 'noob_rug_tradeable*2', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1199', '2788', 'noob_rug_tradeable*3', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1200', '2789', 'noob_rug_tradeable*4', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1201', '2790', 'noob_rug_tradeable*5', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1202', '2791', 'noob_rug_tradeable*6', 's', 'static', '0', 'normal', '2', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1203', '2792', 'tiki_tray0', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1204', '2793', 'sound_set_68', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1205', '2794', 'tiki_corner', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1206', '2795', 'tiki_bardesk', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1207', '2796', 'CFC_100_coin_gold', 's', 'exchange', '100', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1208', '2797', 'CFC_10_coin_bronze', 's', 'exchange', '10', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1209', '2798', 'tiki_sand', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1210', '2799', 'sound_set_69', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1211', '2800', 'diner_tray_4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1212', '2801', 'svnr_de', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1213', '2802', 'diner_tray_2', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1214', '2803', 'diner_rug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1215', '2804', 'diner_sofa_2*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1216', '2805', 'diner_sofa_2*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1217', '2806', 'diner_sofa_2*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1218', '2807', 'diner_sofa_2*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1219', '2808', 'diner_sofa_2*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1220', '2809', 'diner_sofa_2*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1221', '2810', 'diner_sofa_2*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1222', '2811', 'diner_sofa_2*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1223', '2812', 'diner_sofa_2*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1224', '2813', 'svnr_it', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1225', '2814', 'diner_shaker', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1226', '2815', 'diner_tray_5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1227', '2816', 'diner_cashreg*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1228', '2817', 'diner_cashreg*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1229', '2818', 'diner_cashreg*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1230', '2819', 'diner_cashreg*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1231', '2820', 'diner_cashreg*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1232', '2821', 'diner_cashreg*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1233', '2822', 'diner_cashreg*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1234', '2823', 'diner_cashreg*8', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1235', '2824', 'diner_cashreg*9', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1236', '2825', 'svnr_nl', 's', 'seat', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1237', '2826', 'diner_tray_6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1238', '2827', 'diner_gumvendor*1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1239', '2828', 'diner_gumvendor*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1240', '2829', 'diner_gumvendor*3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1241', '2830', 'diner_gumvendor*4', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1242', '2831', 'diner_gumvendor*5', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1243', '2832', 'diner_gumvendor*6', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1244', '2833', 'diner_gumvendor*7', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1245', '2834', 'diner_gumvendor*8', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1246', '2835', 'diner_gumvendor*9', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1247', '2836', 'svnr_aus', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1248', '2837', 'diner_tray_0', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1249', '2838', 'svnr_uk', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1250', '2839', 'diner_tray_1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1251', '2840', 'diner_tray_7', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1252', '2841', 'diner_tray_3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1253', '2842', 'diner_bardesk_gate*1', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1254', '2843', 'diner_bardesk_gate*2', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1255', '2844', 'diner_bardesk_gate*3', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1256', '2845', 'diner_bardesk_gate*4', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1257', '2846', 'diner_bardesk_gate*5', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1258', '2847', 'diner_bardesk_gate*6', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1259', '2848', 'diner_bardesk_gate*7', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1260', '2849', 'diner_bardesk_gate*8', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1261', '2850', 'diner_bardesk_gate*9', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1262', '2851', 'diner_bardesk*1', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1263', '2852', 'diner_bardesk*2', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1264', '2853', 'diner_bardesk*3', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1265', '2854', 'diner_bardesk*4', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1266', '2855', 'diner_bardesk*5', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1267', '2856', 'diner_bardesk*6', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1268', '2857', 'diner_bardesk*7', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1269', '2858', 'diner_bardesk*8', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1270', '2859', 'diner_bardesk*9', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1271', '2860', 'ads_dave_cns', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1272', '2861', 'diner_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1273', '2862', 'diner_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1274', '2863', 'diner_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1275', '2864', 'diner_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1276', '2865', 'diner_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1277', '2866', 'diner_chair*6', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1278', '2867', 'diner_chair*7', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1279', '2868', 'diner_chair*8', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1280', '2869', 'diner_chair*9', 's', 'seat', '0', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1281', '2870', 'diner_bardesk_corner*1', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1282', '2871', 'diner_bardesk_corner*2', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1283', '2872', 'diner_bardesk_corner*3', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1284', '2873', 'diner_bardesk_corner*4', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1285', '2874', 'diner_bardesk_corner*5', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1286', '2875', 'diner_bardesk_corner*6', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1287', '2876', 'diner_bardesk_corner*7', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1288', '2877', 'diner_bardesk_corner*8', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1289', '2878', 'diner_bardesk_corner*9', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1290', '2879', 'diner_table_2*1', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1291', '2880', 'diner_table_2*2', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1292', '2881', 'diner_table_2*3', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1293', '2882', 'diner_table_2*4', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1294', '2883', 'diner_table_2*5', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1295', '2884', 'diner_table_2*6', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1296', '2885', 'diner_table_2*7', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1297', '2886', 'diner_table_2*8', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1298', '2887', 'diner_table_2*9', 's', 'static', '2', 'normal', '3', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1299', '2888', 'diner_sofa_1*1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1300', '2889', 'diner_sofa_1*2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1301', '2890', 'diner_sofa_1*3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1302', '2891', 'diner_sofa_1*4', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1303', '2892', 'diner_sofa_1*5', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1304', '2893', 'diner_sofa_1*6', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1305', '2894', 'diner_sofa_1*7', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1306', '2895', 'diner_sofa_1*8', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1307', '2896', 'diner_sofa_1*9', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1308', '2897', 'diner_table_1*1', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1309', '2898', 'diner_table_1*2', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1310', '2899', 'diner_table_1*3', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1311', '2900', 'diner_table_1*4', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1312', '2901', 'diner_table_1*5', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1313', '2902', 'diner_table_1*6', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1314', '2903', 'diner_table_1*7', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1315', '2904', 'diner_table_1*8', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1316', '2905', 'diner_table_1*9', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1317', '2906', 'greek_seat', 's', 'seat', '5', 'terminator', '1', '1', '0.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1318', '2907', 'easy_bowl2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1319', '2908', 'greek_gate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1320', '2909', 'greek_pillars', 's', 'switch', '2', 'normal', '2', '1', '2.7', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1321', '2910', 'greek_corner', 's', 'switch', '2', 'normal', '1', '1', '2.7', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1322', '2911', 'easy_carpet', 's', 'switch', '2', 'terminator', '4', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1323', '2912', 'greektrophy*1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1324', '2913', 'greektrophy*2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1325', '2914', 'greektrophy*3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1326', '2915', 'greek_block', 's', 'switch', '2', 'normal', '2', '1', '0.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1327', '2916', 'netari_carpet', 's', 'switch', '2', 'terminator', '3', '5', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1328', '2917', 'hcc_shelf', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1329', '2918', 'det_divider', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1330', '2919', 'hcc_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1331', '2920', 'hcc_stool', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1332', '2921', 'hcc_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1333', '2922', 'det_body', 's', 'switch', '2', 'initiator', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1334', '2923', 'hcc_table', 's', 'static', '2', 'normal', '1', '2', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1335', '2924', 'hcc_minibar', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1336', '2925', 'hcc_sofachair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1337', '2926', 'hcc_crnr', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1338', '2927', 'hcc_dvdr', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1339', '2928', 'sob_carpet', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1340', '2929', 'igor_seat', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1341', '2930', 'ads_711*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1342', '2931', 'ads_711*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1343', '2932', 'ads_711*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1344', '2933', 'ads_711*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1345', '2934', 'ads_igorswitch', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1346', '2935', 'ads_igorraygun', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1347', '2936', 'ads_igorbrain', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1348', '2937', 'hween08_bed2', 's', 'bed', '0', 'terminator', '1', '3', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1349', '2938', 'hween08_defibs', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1350', '2939', 'hween08_defibs2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1351', '2940', 'hween08_sink2', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1352', '2941', 'hween08_trll', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1353', '2942', 'hween08_curtain', 's', 'static', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1354', '2943', 'hween08_bbag', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1355', '2944', 'hween08_sink', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1356', '2945', 'hween08_bed', 's', 'bed', '0', 'terminator', '1', '3', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1357', '2946', 'hween08_manhole', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1358', '2947', 'hween08_bath2', 's', 'seat', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1359', '2948', 'hween08_bath', 's', 'seat', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1360', '2949', 'hween08_curtain2', 's', 'static', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1361', '2950', 'party_block2', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1362', '2951', 'party_tube_bubble', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1363', '2952', 'party_seat', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1364', '2953', 'party_mic', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1365', '2954', 'party_djtable', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1366', '2955', 'party_tray', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1367', '2956', 'party_table', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1368', '2957', 'party_barcorn', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1369', '2958', 'party_floor', 's', 'switch', '11', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1370', '2959', 'party_block', 's', 'switch', '2', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1371', '2960', 'party_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1372', '2961', 'party_beamer', 's', 'switch', '7', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1373', '2962', 'party_bardesk', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1374', '2963', 'party_discol', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1375', '2964', 'party_ball', 's', 'switch', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1376', '2965', 'party_ravel', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1377', '2966', 'party_tube_lava', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1378', '2967', 'xmas08_icetree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1379', '2968', 'xmas08_lantern', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1380', '2969', 'penguin_robot', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1381', '2970', 'xmas08_dvdr2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1382', '2971', 'penguin_elf', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1383', '2972', 'xmas08_trph1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1384', '2973', 'penguin_skater', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1385', '2974', 'campfire', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1386', '2975', 'penguin_bunny', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1387', '2976', 'penguin_ninja', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1388', '2977', 'penguin_basic', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1389', '2978', 'xmas08_telep', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1390', '2979', 'penguin_boxer', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1391', '2980', 'xmas08_hole', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1392', '2981', 'penguin_ski', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1393', '2982', 'xmas_snow', 's', 'static', '0', 'ignore', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1394', '2983', 'penguin_infected', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1395', '2984', 'penguin_swim', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1396', '2985', 'xmas08_geysir', 's', 'static', '0', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1397', '2986', 'xmas08_hottub', 's', 'seat', '5', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1398', '2987', 'penguin_cowboy', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1399', '2988', 'penguin_icehockey', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1400', '2989', 'penguin_clown', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1401', '2990', 'penguin_wrestler', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1402', '2991', 'svnr_fi', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1403', '2992', 'xmas08_dvdr1', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1404', '2993', 'penguin_glow', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1405', '2994', 'penguin_sumo', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1406', '2995', 'penguin_musketeer', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1407', '2996', 'penguin_ballet', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1408', '2997', 'penguin_magician', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1409', '2998', 'penguin_super', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1410', '2999', 'penguin_pirate', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1411', '3000', 'sound_set_71', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1412', '3001', 'xmas08_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1413', '3002', 'xmas08_icerug', 's', 'static', '0', 'ignore', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1414', '3003', 'penguin_hunchback', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1415', '3004', 'penguin_punk', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1416', '3005', 'xmas08_snowpl', 's', 'seat', '5', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1417', '3006', 'xmas08_cubetree', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1418', '3007', 'penguin_pilot', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1419', '3008', 'penguin_suit', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1420', '3009', 'xmas08_table', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1421', '3010', 'penguin_rock', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1422', '3011', 'fx_explosion', 's', 'rental', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1423', '3012', 'fx_bubble', 's', 'rental', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1424', '3013', 'fx_flare', 's', 'rental', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1425', '3014', 'ads_cltele', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1426', '3015', 'xmas08_trph2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1427', '3016', 'lostc_merdragon', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1428', '3017', 'ads_cldesk', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1429', '3018', 'ads_ob_pillow', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1430', '3019', 'ads_clfloor', 's', 'switch', '2', 'terminator', '3', '5', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1431', '3020', 'ads_mall_tele', 's', 'teleporter', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1432', '3021', 'ads_cllava2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1433', '3022', 'bolly_lotus_pool', 's', 'switch', '3', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1434', '3023', 'kinkysofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1435', '3024', 'china_moongt', 's', 'switch', '2', 'terminator', '1', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1436', '3025', 'china_ox', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1437', '3026', 'bolly_petals', 's', 'switch', '3', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1438', '3027', 'bolly_tile2', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1439', '3028', 'bolly_tile1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1440', '3029', 'bolly_fountain', 's', 'switch', '3', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1441', '3030', 'bolly_pillow', 's', 'seat', '5', 'terminator', '1', '1', '0.7', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1442', '3031', 'bolly_corner', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1443', '3032', 'bolly_drapec', 's', 'gate', '2', 'terminator', '3', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1444', '3033', 'bolly_phant', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1445', '3034', 'bolly_desk', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1446', '3035', 'bolly_table', 's', 'static', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1447', '3036', 'bolly_monkey_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1448', '3037', 'bolly_swing', 's', 'seat', '5', 'normal', '2', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1449', '3038', 'bolly_drapea', 's', 'gate', '2', 'terminator', '3', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1450', '3039', 'bolly_palm', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1451', '3040', 'bolly_drapeb', 's', 'gate', '2', 'terminator', '3', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1452', '3041', 'bolly_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1453', '3042', 'bolly_tree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1454', '3043', 'bolly_vase', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1455', '3044', 'planet_of_love', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1456', '3045', 'ads_idol_floor1', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1457', '3046', 'ads_igor_flask', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1458', '3047', 'ads_idol_floor2', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1459', '3048', 'ads_idol_drape', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1460', '3049', 'ads_igor_dsk', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1461', '3050', 'ads_idol_desk', 's', 'switch', '2', 'terminator', '1', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1462', '3051', 'ads_idol_ch', 's', 'seat', '2', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1463', '3052', 'lostc_octopus', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1464', '3053', 'ads_idol_tele', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1465', '3054', 'ads_idol_mic', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1466', '3055', 'ads_idol_trax', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1467', '3056', 'ads_idol_pchair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1468', '3057', 'ads_idol_audChr', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1469', '3058', 'ads_idol_piano', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1470', '3059', 'ads_idol_jukebox*1', 's', 'traxplayer', '10', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '1');
INSERT INTO `item_definitions` VALUES ('1471', '3060', 'lc_glass_floor', 's', 'switch', '2', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1472', '3061', 'lc_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1473', '3062', 'lc_crab1', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1474', '3063', 'lc_stool', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1475', '3064', 'lc_medusa1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1476', '3065', 'lc_tubes_straight', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1477', '3066', 'ads_711shelf', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1478', '3067', 'lc_table', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1479', '3068', 'lc_crab2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1480', '3069', 'lc_tile2', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1481', '3070', 'lc_desk', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1482', '3071', 'lostc_teleport', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1483', '3072', 'lc_tubes_corners', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1484', '3073', 'lc_medusa2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1485', '3074', 'lc_anemone', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1486', '3075', 'lc_corner', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1487', '3076', 'lc_tile1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1488', '3077', 'lc_coral_divider_low', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1489', '3078', 'lc_coral_divider_hi', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1490', '3079', 'ads_idol_clRack', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1491', '3080', 'ads_idol_hotspot', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1492', '3081', 'ads_idol_voting_ch', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1493', '3082', 'eco_light2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1494', '3083', 'eco_cactus1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1495', '3084', 'eco_chair1', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1496', '3085', 'eco_cactus3', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1497', '3086', 'eco_table3', 's', 'switch', '2', 'normal', '2', '2', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1498', '3087', 'bump_tottero', 's', 'static', '10', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1499', '3088', 'eco_sofa3', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1500', '3089', 'eco_table2', 's', 'switch', '2', 'normal', '2', '2', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1501', '3090', 'bump_signs', 's', 'switch', '7', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1502', '3091', 'eco_lamp3', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1503', '3092', 'eco_lamp2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1504', '3093', 'eco_tree1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1505', '3094', 'eco_chair3', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1506', '3095', 'ecotron_box', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1507', '3096', 'eco_sofa1', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1508', '3097', 'eco_lamp1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1509', '3098', 'eco_light1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1510', '3099', 'eco_table1', 's', 'switch', '2', 'normal', '2', '2', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1511', '3100', 'eco_sofa2', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1512', '3101', 'bump_tires', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1513', '3102', 'eco_fruits2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1514', '3103', 'bump_lights', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1515', '3104', 'eco_fruits3', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1516', '3105', 'eco_cactus2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1517', '3106', 'eco_chair2', 's', 'seat', '0', 'terminator', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1518', '3107', 'eco_fruits1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1519', '3108', 'eco_light3', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1520', '3109', 'eco_tree2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1521', '3110', 'bump_road', 's', 'switch', '5', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1522', '3111', 'ads_frankb', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1523', '3112', 'ads_grefusa_cactus', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1524', '3113', 'totem_leg', 's', 'switch', '12', 'normal', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1525', '3114', 'exe_artlamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1526', '3115', 'env_bushes', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1527', '3116', 'ads_idol_newsDsk', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1528', '3117', 'env_tree1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1529', '3118', 'env_tree4', 's', 'switch', '4', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1530', '3119', 'exe_gate', 's', 'gate', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1531', '3120', 'ads_idol_cork', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1532', '3121', 'exe_cubelight', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1533', '3122', 'exe_light', 's', 'switch', '4', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1534', '3123', 'env_tree2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1535', '3124', 'ads_idol_ichair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1536', '3125', 'env_tree3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1537', '3126', 'ads_idol_tube', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1538', '3127', 'ads_cl_jukeb', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1539', '3128', 'env_bushes_gate', 's', 'gate', '0', 'terminator', '1', '2', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1540', '3129', 'env_grass', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1541', '3130', 'tray_glasstower', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1542', '3131', 'ads_malaco_gu', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1543', '3132', 'ads_reebok_block2', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1544', '3133', 'tray_cake', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1545', '3134', 'tray_champagne', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1546', '3135', 'ads_malaco_rug', 's', 'static', '0', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1547', '3136', 'ads_idol_tblCloth', 's', 'static', '0', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1548', '3137', 'ads_cl_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1549', '3138', 'ads_idol_lamp', 's', 'switch', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1550', '3139', 'ads_clcake', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1551', '3140', 'ads_idol_carpet', 's', 'switch', '2', 'terminator', '2', '7', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1552', '3141', 'country_fnc2', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1553', '3142', 'eco_mush1', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1554', '3143', 'country_rbw', 's', 'static', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1555', '3144', 'sound_set_72', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1556', '3145', 'country_soil', 's', 'switch', '6', 'terminator', '2', '2', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1557', '3146', 'country_log', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1558', '3147', 'country_trctr', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1559', '3148', 'country_stage', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1560', '3149', 'country_well', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1561', '3150', 'country_gate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1562', '3151', 'ads_goldtabl', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1563', '3152', 'country_fnc3', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1564', '3153', 'country_rain', 's', 'switch', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1565', '3154', 'country_fnc1', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1566', '3155', 'eco_mush2', 's', 'switch', '2', 'normal', '1', '1', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1567', '3156', 'ads_calip_cola*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1568', '3157', 'ads_calip_cola*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1569', '3158', 'ads_calip_cola*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1570', '3159', 'ads_calip_cola*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1571', '3160', 'country_scarecrow', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1572', '3161', 'env_telep', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1573', '3162', 'country_grass', 's', 'switch', '3', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1574', '3163', 'country_wheat', 's', 'static', '10', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1575', '3164', 'country_corner', 's', 'static', '2', 'disable', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1576', '3165', 'country_ditch', 's', 'gate', '2', 'disable', '1', '2', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1577', '3166', 'country_patio', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1578', '3167', 'totem_head', 's', 'switch', '15', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1579', '3168', 'ads_calip_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1580', '3169', 'ads_idol_trophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1581', '3170', 'LT_pillar2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1582', '3171', 'LT_throne', 's', 'seat', '5', 'terminator', '1', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1583', '3172', 'lt_gate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1584', '3173', 'laptopdesk', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1585', '3174', 'lt_bughill', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1586', '3175', 'lt_stage2', 's', 'switch', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1587', '3176', 'lt_lava', 's', 'gate', '2', 'disable', '1', '2', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1588', '3177', 'lt_stone2', 's', 'switch', '3', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1589', '3178', 'lt_spider', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1590', '3179', 'audChr', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1591', '3180', 'lt_lavac', 's', 'static', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1592', '3181', 'saturn', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1593', '3182', 'ads_calip_pool', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1594', '3183', 'lt_stage1', 's', 'switch', '2', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1595', '3184', 'clrack', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1596', '3185', 'lt_statue', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1597', '3186', 'noticeboard', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1598', '3187', 'LT_pillar', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1599', '3188', 'lt_patch', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1600', '3189', 'LT_skull', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1601', '3190', 'ads_calip_tele', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1602', '3195', 'ads_calip_parasol', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1603', '3196', 'lt_stone1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1604', '3197', 'ads_calip_lava', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1605', '3198', 'ads_calip_fan', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1606', '3199', 'transparent_floor', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1607', '3200', 'totem_planet', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1608', '3201', 'voting_ch', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1609', '3202', 'ads_mall_coffeem', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1610', '3203', 'sf_roof', 's', 'switch', '2', 'ignore', '2', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1611', '3204', 'SF_crate_2', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1612', '3205', 'SF_crate_1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1613', '3206', 'sf_stick', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1614', '3207', 'SF_chair_blue', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1615', '3208', 'SF_panel3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1616', '3209', 'sf_roller', 's', 'roller', '2', 'initiator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1617', '3210', 'SF_alien', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1618', '3211', 'SF_floor_2', 's', 'switch', '2', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1619', '3212', 'SF_reactor', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1620', '3213', 'sf_floor', 's', 'switch', '2', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1621', '3214', 'sf_tele', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1622', '3215', 'SF_chair_green', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1623', '3216', 'ads_mall_kiosk', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1624', '3217', 'SF_panel1', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1625', '3218', 'SF_panel2', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1626', '3219', 'sf_pod', 's', 'bed', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1627', '3220', 'SF_table', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1628', '3221', 'sf_gate', 's', 'gate', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1629', '3222', 'SF_floor_1', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1630', '3223', 'SF_chair_red', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1631', '3224', 'SF_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1632', '3225', 'prizetrophy_cool', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1633', '3226', 'ads_elisa_gnome', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1634', '3227', 'summer_raft2', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1635', '3228', 'summer_raft1', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1636', '3229', 'prizetrophy_hot', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1637', '3230', 'ads_oc_soda', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1638', '3231', 'summer_icebox', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1639', '3232', 'marsrug', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1640', '3233', 'rela_stone', 's', 'static', '2', 'normal', '1', '1', '0.2', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1641', '3234', 'rela_candles1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1642', '3235', 'rela_candle3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1643', '3236', 'rela_candles3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1644', '3237', 'pix_asteroid', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1645', '3238', 'rela_candle1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1646', '3239', 'rela_orchid', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1647', '3240', 'rela_stick', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1648', '3241', 'ads_711*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1649', '3242', 'ads_711*6', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1650', '3243', 'ads_711*7', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1651', '3244', 'rela_candle2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1652', '3245', 'rela_candles2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1653', '3246', 'rela_plant', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1654', '3247', 'rela_hchair', 's', 'seat', '0', 'terminator', '1', '1', '1.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1655', '3248', 'rela_rock', 's', 'seat', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1656', '3249', 'ktchn_fridge', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1657', '3250', 'ktchn_inspctr', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1658', '3251', 'ads_1800tele', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1659', '3252', 'ktchn_pots', 's', 'static', '2', 'ignore', '2', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1660', '3253', 'ktchn_countr_2', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1661', '3254', 'ktchn_gate', 's', 'gate', '0', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1662', '3255', 'ktchn_bBlock', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1663', '3256', 'ktchn_stove', 's', 'switch', '4', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1664', '3257', 'ktchn_cornr', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1665', '3258', 'ktchn_light', 's', 'switch', '2', 'ignore', '2', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1666', '3259', 'ktchn_dvdr', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1667', '3260', 'ktchn_desk', 's', 'static', '2', 'normal', '2', '1', '0.9', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1668', '3261', 'ktchn_countr_1', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1669', '3262', 'ktchn_sink', 's', 'switch', '4', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1670', '3263', 'ktchn_plates', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1671', '3264', 'ktchn_trash', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1672', '3265', 'urban_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1673', '3266', 'urban_bin', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1674', '3267', 'urban_fence', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1675', '3268', 'urban_carsofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1676', '3269', 'urban_bench', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1677', '3270', 'urban_blocker', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1678', '3271', 'urban_bsktbll', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1679', '3272', 'urban_wpost', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1680', '3273', 'sf_mbar', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1681', '3274', 'urban_sidewalk', 's', 'switch', '4', 'normal', '2', '2', '0.2', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1682', '3275', 'urban_fence_corner', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1683', '3276', 'ads_idol_l_carpet', 's', 'switch', '2', 'terminator', '2', '7', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1684', '3277', 'ads_gsArcade_1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1685', '3278', 'ads_gsArcade_2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1686', '3279', 'ads_mtvtrophy_gold', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1687', '3280', 'ads_spang_sleep', 's', 'bed', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1688', '3281', 'ads_mtvtrophy_silver', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1689', '3282', 'hween09_organ', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1690', '3283', 'ads_idol_chmpgn', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1691', '3284', 'urban_bench_plain', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1692', '3285', 'hween09_hatch', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1693', '3286', 'hween09_table', 's', 'switch', '2', 'terminator', '1', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1694', '3287', 'hween09_jar', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1695', '3288', 'hween09_floor', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1696', '3289', 'byesw_hotel', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1697', '3290', 'hween09_ghost', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1698', '3291', 'byesw_hand', 's', 'seat', '2', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1699', '3292', 'hween09_tv', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1700', '3293', 'hween09_mirror', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1701', '3294', 'hween09_chandelier', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1702', '3295', 'hween09_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1703', '3296', 'ads_twi_toolbx', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1704', '3297', 'ads_twi_table', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1705', '3298', 'ads_twi_tower', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1706', '3299', 'ads_twi_piano', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1707', '3300', 'ads_twi_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1708', '3301', 'ads_twi_fountn', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1709', '3302', 'ads_twi_dvdr2', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1710', '3303', 'ads_twi_dvdr1', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1711', '3304', 'ads_twi_roses', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1712', '3305', 'exe_elevator', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1713', '3306', 'ads_mall_elevator', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1714', '3307', 'ktchn_hlthNut', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1715', '3308', 'ads_twi_mist', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1716', '3309', 'nest_plow_bro', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1717', '3310', 'nest_snug_grn', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1718', '3311', 'ads_twi_trophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1719', '3312', 'arabian_tile', 's', 'static', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1720', '3313', 'xm09_lrgBauble', 's', 'switch', '2', 'ignore', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1721', '3314', 'xm09_candyCane', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1722', '3315', 'nest_snug_blu', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1723', '3316', 'nest_plow_blu', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1724', '3317', 'nest_snug_red', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1725', '3318', 'nest_plow_reg', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1726', '3319', 'nest_snug_yel', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1727', '3320', 'nest_plow_red', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1728', '3321', 'petfood7', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1729', '3322', 'petfood9', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1730', '3323', 'petfood6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1731', '3324', 'petfood5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1732', '3325', 'petfood8', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1733', '3326', 'petfood10', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1734', '3327', 'party_lantern', 's', 'switch', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1735', '3328', 'xm09_man_b', 's', 'switch', '2', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1736', '3329', 'xm09_man_c', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1737', '3330', 'xm09_man_a', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1738', '3331', 'nest_dirt', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1739', '3332', 'nest_snug_prp', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1740', '3333', 'nest_basket', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1741', '3334', 'nest_nest', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1742', '3335', 'xm09_table', 's', 'switch', '2', 'terminator', '2', '6', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1743', '3336', 'nest_nails', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1744', '3337', 'xm09_cocoa', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1745', '3338', 'nest_snug_bla', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1746', '3339', 'nest_ice', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1747', '3340', 'xm09_bench', 's', 'seat', '5', 'terminator', '6', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1748', '3341', 'nest_plow_skl', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1749', '3342', 'ads_cl_moodi', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1750', '3343', 'prizetrophy_nrj', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1751', '3344', 'china_tiger', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1752', '3345', 'org_chrblk', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1753', '3346', 'china_tigrSeat', 's', 'seat', '5', 'terminator', '1', '2', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1754', '3347', 'org_tblblk', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1755', '3348', 'org_lamppnk', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1756', '3349', 'org_chairblk', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1757', '3350', 'org_chrpnk', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1758', '3351', 'xm09_trophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1759', '3352', 'org_tblpnk', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1760', '3353', 'org_lampblk', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1761', '3354', 'org_chairpnk', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1762', '3355', 'china_plmTree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1763', '3356', 'org_table', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1764', '3357', 'val09_floor2', 's', 'switch', '6', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1765', '3358', 'petfood11', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1766', '3359', 'petfood13', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1767', '3360', 'bling_chair_b', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1768', '3361', 'bling_chair_c', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1769', '3362', 'bling_toilet', 's', 'seat', '5', 'normal', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1770', '3363', 'val09_floor', 's', 'switch', '6', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1771', '3364', 'bling_bed', 's', 'bed', '2', 'terminator', '2', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1772', '3365', 'ads_droetker_paula', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1773', '3366', 'bling_fridge', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1774', '3367', 'ads_chups', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1775', '3368', 'bling_chair_a', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1776', '3369', 'bling_pool', 's', 'seat', '5', 'terminator', '3', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1777', '3370', 'petfood12', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1778', '3371', 'bling_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1779', '3372', 'present_wrap*1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1780', '3373', 'present_wrap*10', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1781', '3374', 'present_wrap*2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1782', '3375', 'present_wrap*3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1783', '3376', 'present_wrap*4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1784', '3377', 'present_wrap*5', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1785', '3378', 'present_wrap*6', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1786', '3379', 'present_wrap*7', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1787', '3380', 'present_wrap*8', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1788', '3381', 'present_wrap*9', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1789', '3382', 'val_basket', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1790', '3383', 'teddy_pink', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1791', '3384', 'teddy_pendergrass', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1792', '3385', 'teddy_bear', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1793', '3386', 'val_hSeat*1', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1794', '3387', 'val_hSeat*2', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1795', '3388', 'val_hSeat*3', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1796', '3389', 'val_hSeat*4', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1797', '3390', 'val_hSeat*5', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1798', '3391', 'val_hSeat*6', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1799', '3392', 'val_hSeat*7', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1800', '3393', 'teddy_basic', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1801', '3394', 'bling_fridge_restricted', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1802', '3395', 'ads_percyrock', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1803', '3396', 'bling_shwr', 's', 'autoswitch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1804', '3397', 'val_table1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1805', '3398', 'rare_trex', 's', 'switch', '2', 'terminator', '3', '7', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1806', '3399', 'rare_ironmaiden', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1807', '3400', 'crystal_patch', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1808', '3401', 'beanstalk', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1809', '3402', 'rare_mmmth', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1810', '3403', 'rare_vdoll', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1811', '3404', 'garden_mursu', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1812', '3405', 'garden_jyrki', 's', 'switch', '8', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1813', '3406', 'garden_seed', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1814', '3407', 'garden_lupin3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1815', '3408', 'garden_mursu3', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1816', '3409', 'garden_flo2', 's', 'static', '2', 'normal', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1817', '3410', 'prizetrophy_thumb', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1818', '3411', 'garden_lupin5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1819', '3412', 'garden_mursu2', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1820', '3413', 'garden_orchtree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1821', '3414', 'garden_mursu4', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1822', '3415', 'garden_flolamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1823', '3416', 'garden_lupin2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1824', '3417', 'garden_staringbush', 's', 'switch', '3', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1825', '3418', 'garden_flo1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1826', '3419', 'garden_lupin4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1827', '3420', 'garden_flytrap', 's', 'teleporter', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1828', '3421', 'garden_lupin1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1829', '3422', 'garden_jungle', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1830', '3423', 'ads_grefusa_yum', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1831', '3424', 'garden_volcano', 's', 'switch', '3', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1832', '3425', 'garden_leaves', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1833', '3426', 'garden_flo3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1834', '3427', 'runway_bigchr_2', 's', 'seat', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1835', '3428', 'hc2_vase', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1836', '3429', 'runway_chair_2', 's', 'seat', '0', 'terminator', '1', '1', '1.4', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1837', '3430', 'hc2_cart', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1838', '3431', 'hc3_divider', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1839', '3432', 'runway_head', 's', 'switch', '7', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1840', '3433', 'runway_block_1', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1841', '3434', 'hc2_sofatbl', 's', 'seat', '0', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1842', '3435', 'runway_bigchr_4', 's', 'static', '2', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1843', '3436', 'hc2_armchair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1844', '3437', 'runway_manqn_1', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1845', '3438', 'hc3_shelf', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1846', '3439', 'hc2_barchair', 's', 'seat', '0', 'terminator', '1', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1847', '3440', 'hc2_carpet', 's', 'static', '2', 'normal', '3', '5', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1848', '3441', 'hc3_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1849', '3442', 'runway_stool', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1850', '3443', 'runway_block_2', 's', 'static', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('1851', '3444', 'runway_table_2', 's', 'static', '10', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1852', '3445', 'hc3_bard', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1853', '3446', 'hc2_biglamp', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1854', '3447', 'hc3_hugelamp', 's', 'switch', '2', 'ignore', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1855', '3448', 'hc3_stool', 's', 'seat', '5', 'terminator', '1', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1856', '3449', 'hc2_divider', 's', 'static', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1857', '3450', 'hc2_coffee', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1858', '3451', 'runway_chair_1', 's', 'seat', '0', 'terminator', '1', '1', '1.4', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1859', '3452', 'hc2_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1860', '3453', 'ads_cheetos', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1861', '3454', 'runway_bigchr_3', 's', 'seat', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1862', '3455', 'merger_chest', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1863', '3456', 'runway_dvdr', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1864', '3457', 'runway_display', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1865', '3458', 'hc2_frplc', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1866', '3459', 'hc2_duvan', 's', 'bed', '2', 'terminator', '1', '3', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1867', '3460', 'runway_table_1', 's', 'switch', '3', 'terminator', '3', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1868', '3461', 'hc3_dc', 's', 'bed', '2', 'terminator', '1', '3', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1869', '3462', 'runway_bigchr_1', 's', 'seat', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1870', '3463', 'runway_bigchr_5', 's', 'seat', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1871', '3464', 'runway_bench', 's', 'seat', '5', 'terminator', '2', '1', '1.4', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1872', '3465', 'hc3_light', 's', 'switch', '2', 'ignore', '2', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1873', '3466', 'hc3_table', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1874', '3467', 'runway_manqn_2', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1875', '3468', 'cmp_fish_s', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1876', '3469', 'cmp_fish_bk', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1877', '3470', 'hc3_stereo', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1878', '3471', 'cmp_nobox_2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1879', '3472', 'cmp_fish_b', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1880', '3473', 'cmp_nobox_3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1881', '3474', 'cmp_fish_gr', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1882', '3475', 'cmp_fish_g', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1883', '3476', 'cmp_nobox', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1884', '3477', 'cmp_fish_r', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1885', '3478', 'cmp_sub', 's', 'switch', '2', 'terminator', '7', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1886', '3479', 'hc3_vase', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1887', '3480', 'party_crate2_1', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1888', '3481', 'party_crate1_3', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1889', '3482', 'wed_plant', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1890', '3483', 'wed_arch', 's', 'switch', '2', 'terminator', '1', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1891', '3484', 'party_djset', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1892', '3485', 'party_crate1_4', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1893', '3486', 'ads_chocapic', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1894', '3487', 'party_crate1_1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1895', '3488', 'wed_icesculp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1896', '3489', 'party_crate1_2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1897', '3490', 'party_crate2_2', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1898', '3491', 'party_crate2_3', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1899', '3492', 'party_crate2_4', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1900', '3493', 'wed_carsofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1901', '3494', 'fball_bench', 's', 'seat', '5', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1902', '3495', 'fball_fnc3', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1903', '3496', 'fball_score_b', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1904', '3497', 'fball_ball3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1905', '3498', 'fball_ptch5', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1906', '3499', 'fball_light', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1907', '3500', 'fball_audbench', 's', 'seat', '5', 'terminator', '4', '1', '1.4', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1908', '3501', 'fball_fnc1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1909', '3502', 'fball_ptch8', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1910', '3503', 'fball_crnr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1911', '3504', 'fball_ptch4', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1912', '3505', 'fball_trophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1913', '3506', 'fball_score_y', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1914', '3507', 'fball_cote', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1915', '3508', 'fball_ball', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1916', '3509', 'fball_ptch7', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1917', '3510', 'fball_ball2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1918', '3511', 'fball_ptch2', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1919', '3512', 'fball_score_g', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1920', '3513', 'fball_ptch3', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1921', '3514', 'fball_goal_r', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1922', '3515', 'fball_goal_b', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1923', '3516', 'fball_gate', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1924', '3517', 'fball_ptch6', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1925', '3518', 'fball_ball5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1926', '3519', 'fball_goal_g', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1927', '3520', 'fball_ptch0', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1928', '3521', 'fball_ball4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1929', '3522', 'fball_score_r', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1930', '3523', 'fball_goal_y', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1931', '3524', 'fball_ptch1', 's', 'switch', '2', 'terminator', '3', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1932', '3525', 'fball_counter', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1933', '3526', 'prison_gate', 's', 'gate', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1934', '3527', 'bw_boat', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1935', '3528', 'prison_crnr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1936', '3529', 'bw_lgchair', 's', 'seat', '2', 'terminator', '1', '1', '2.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1937', '3530', 'bw_water_1', 's', 'effectgenerator', '30', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1938', '3531', 'prison_tower', 's', 'seat', '2', 'terminator', '1', '1', '3', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1939', '3532', 'prison_dvdr2', 's', 'switch', '4', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1940', '3533', 'bw_sofa', 's', 'seat', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1941', '3534', 'prison_dvdr1', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1942', '3535', 'ads_capri_chair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1943', '3536', 'ads_capri_lava', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1944', '3537', 'prison_stone', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1945', '3538', 'bw_fin', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1946', '3539', 'bw_ccnuts', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1947', '3540', 'bw_shower', 's', 'autoswitch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1948', '3541', 'bw_water_2', 's', 'effectgenerator', '28', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('1949', '3542', 'bw_croc', 's', 'switch', '2', 'normal', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1950', '3543', 'bw_sboard', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1951', '3544', 'bw_chair', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1952', '3545', 'bw_table', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1953', '3546', 'ads_capri_tree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1954', '3547', 'bw_bball', 's', 'football', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1955', '3548', 'bw_mttrss', 's', 'bed', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1956', '3549', 'bw_van', 's', 'seat', '5', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1957', '3550', 'bw_tele', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1958', '3551', 'bw_fnc_crnr', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1959', '3552', 'bw_fnc', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1960', '3553', 'ads_capri_arcade', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1961', '3554', 'ads_pepsi0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1962', '3555', 'bw_boat_p', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1963', '3556', 'bw_pool_a3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1964', '3557', 'bw_fnc_g', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1965', '3558', 'bw_mttrss_g', 's', 'bed', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1966', '3559', 'bw_mttrss_p', 's', 'bed', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1967', '3560', 'bw_pool_b1', 's', 'static', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1968', '3561', 'bw_sofa_p', 's', 'seat', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1969', '3562', 'bw_sboard_g', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1970', '3563', 'bw_fnc_crnr_g', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1971', '3564', 'bw_pool_a2', 's', 'static', '2', 'normal', '2', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1972', '3565', 'bw_pool_b2', 's', 'static', '2', 'normal', '2', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1973', '3566', 'bw_table_g', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1974', '3567', 'bw_chair_p', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1975', '3568', 'bw_boat_g', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1976', '3569', 'bw_fnc_p', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1977', '3570', 'bw_van_p', 's', 'seat', '5', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1978', '3571', 'bw_sboard_p', 's', 'switch', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1979', '3572', 'bw_chair_g', 's', 'seat', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1980', '3573', 'bw_pool_b3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1981', '3574', 'bw_van_g', 's', 'seat', '5', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1982', '3575', 'bw_sofa_g', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1983', '3576', 'bw_fnc_crnr_p', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1984', '3577', 'bw_pool_a1', 's', 'static', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1985', '3578', 'bw_table_p', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1986', '3579', 'african_fence', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1987', '3580', 'ktchn10_pot', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1988', '3581', 'ktchn10_stove', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1989', '3582', 'easel_0', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1990', '3583', 'petfood15', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1991', '3584', 'african_tree1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1992', '3585', 'ads_cheetos_hotdog', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1993', '3586', 'hosptl_cab1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1994', '3587', 'nest_lion2', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1995', '3588', 'hosptl_curtain', 's', 'static', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1996', '3589', 'ktchn10_block', 's', 'switch', '3', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1997', '3590', 'hosptl_bed', 's', 'bed', '0', 'terminator', '1', '3', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1998', '3591', 'hosptl_bbag', 's', 'bed', '5', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('1999', '3592', 'ktchn10_tea', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2000', '3593', 'ads_cheetos_bath', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2001', '3594', 'easel_1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2002', '3595', 'tiki_gate', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2003', '3596', 'easel_3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2004', '3597', 'nest_rhino', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2005', '3598', 'ads_oc_soda_cherry', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2006', '3599', 'petfood14', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2007', '3600', 'easel_4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2008', '3601', 'nest_lion', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2009', '3602', 'african_patch', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2010', '3603', 'easel_2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2011', '3604', 'hosptl_skele', 's', 'static', '10', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2012', '3605', 'african_tree2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2013', '3606', 'hosptl_defibs', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2014', '3607', 'african_stage', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2015', '3608', 'hosptl_cab2', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2016', '3609', 'african_bones', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2017', '3610', 'hosptl_light', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2018', '3611', 'hosptl_seat', 's', 'seat', '5', 'terminator', '2', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2019', '3612', 'ktchn10_sink', 's', 'switch', '3', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2020', '3613', 'ads_disney_tv', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2021', '3614', 'bb_crnr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2022', '3615', 'bb_score_b', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2023', '3616', 'bb_robo', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2024', '3617', 'bb_dragon', 's', 'switch', '2', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2025', '3618', 'bb_ducklight', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2026', '3619', 'bb_caterhead', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2027', '3620', 'bb_cargobox', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2028', '3621', 'bb_gate_g', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2029', '3622', 'bb_crchair3', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2030', '3623', 'bb_score_g', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2031', '3624', 'bb_crchair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2032', '3625', 'bb_crchair2', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2033', '3626', 'bb_score_y', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2034', '3627', 'bb_knj1', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2035', '3628', 'bb_gate_r', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2036', '3629', 'bb_tddhnd', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2037', '3630', 'bb_lightdiv', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2038', '3631', 'bb_tddhead', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2039', '3632', 'bb_pyramid', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2040', '3633', 'bb_patch1', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2041', '3634', 'bb_fnc3', 's', 'switch', '2', 'terminator', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2042', '3635', 'bb_gate_y', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2043', '3636', 'hween10_zombie', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2044', '3637', 'bb_apparatus', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2045', '3638', 'bb_caterbody', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2046', '3639', 'bb_knj2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2047', '3640', 'bb_fnc1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2048', '3641', 'bb_puck', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2049', '3642', 'bb_rnd_tele', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2050', '3643', 'bb_gate_b', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2051', '3644', 'bb_score_r', 's', 'scoreboard', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2052', '3645', 'bb_counter', 's', 'switch', '2', 'terminator', '1', '4', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2053', '3646', 'hween10_tarot', 's', 'switch', '7', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2054', '3647', 'hween10_voodoo1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2055', '3648', 'hween10_tree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2056', '3649', 'hween10_swamp', 's', 'switch', '3', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2057', '3650', 'hween10_pond', 's', 'effectgenerator', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2058', '3651', 'hween10_jar', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2059', '3652', 'hween10_fog', 's', 'switch', '2', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2060', '3653', 'hween10_voodoo2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2061', '3654', 'hween10_skullpost', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2062', '3655', 'hween10_voodoo3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2063', '3656', 'hween10_logs', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2064', '3657', 'hween10_ffly', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2065', '3658', 'hween10_chicken', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2066', '3659', 'hween10_tele', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2067', '3660', 'hween10_throne', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2068', '3661', 'hween10_portch', 's', 'static', '2', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2069', '3662', 'hween10_bat', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2070', '3663', 'wf_act_move_rotate', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2071', '3664', 'wf_wire2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2072', '3665', 'wf_cnd_time_more_than', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2073', '3666', 'wf_colortile', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2074', '3667', 'wf_floor_switch2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2075', '3668', 'wf_trg_state_changed', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2076', '3669', 'wf_xtra_random', 's', 'switch', '2', 'normal', '1', '1', '0.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2077', '3670', 'wf_xtra_unseen', 's', 'switch', '2', 'normal', '1', '1', '0.5', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2078', '3671', 'wf_trg_periodically', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2079', '3672', 'wf_pyramid', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2080', '3673', 'wf_trg_score_achieved', 's', 'scoreboard', '0', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2081', '3674', 'wf_act_teleport_to', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2082', '3675', 'wf_trg_says_something', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2083', '3676', 'wf_colorwheel', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2084', '3677', 'wf_wire4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2085', '3678', 'wf_trg_walks_off_furni', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2086', '3679', 'wf_trg_at_given_time', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2087', '3680', 'wf_trg_game_ends', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2088', '3681', 'wf_act_show_message', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2089', '3682', 'wf_cnd_time_less_than', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2090', '3683', 'wf_trg_enter_room', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2091', '3684', 'ads_hh_safe', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2092', '3685', 'wf_act_toggle_state', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2093', '3686', 'wf_firegate', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2094', '3687', 'wf_ringplate', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2095', '3688', 'wf_pressureplate', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2096', '3689', 'wf_glowball', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2097', '3690', 'bb_lightstrip', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2098', '3691', 'wf_act_reset_timers', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2099', '3692', 'wf_cnd_furnis_hv_avtrs', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2100', '3693', 'wf_arrowplate', 's', 'switch', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2101', '3694', 'wf_cnd_trggrer_on_frn', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2102', '3695', 'wf_cnd_match_snapshot', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2103', '3696', 'wf_wire1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2104', '3697', 'wf_act_give_score', 's', 'scoreboard', '0', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2105', '3698', 'wf_wire3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2106', '3699', 'wf_glassdoor', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2107', '3700', 'wf_act_match_to_sshot', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2108', '3701', 'wf_floor_switch1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2109', '3702', 'wf_trg_game_starts', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2110', '3703', 'wf_trg_walks_on_furni', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2111', '3704', 'exe_copier', 's', 'seat', '2', 'terminator', '1', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2112', '3705', 'exe_wrkdesk', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2113', '3706', 'exe_glassdvdr', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2114', '3707', 'exe_seccam', 's', 'switch', '3', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2115', '3708', 'qt_penguin_icehockey', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2116', '3709', 'duck_vip', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2117', '3710', 'duck_hc', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2118', '3711', 'qt_penguin_ballet', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2119', '3712', 'es_bench', 's', 'seat', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2120', '3713', 'es_icestar', 's', 'static', '2', 'ignore', '1', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2121', '3714', 'es_fnc_2', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2122', '3715', 'qt_xm10_monkey_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2123', '3716', 'es_sidewalk', 's', 'switch', '4', 'normal', '2', '2', '0.2', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2124', '3717', 'es_statue', 's', 'switch', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2125', '3718', 'qt_xm10_iceclubsofa', 's', 'seat', '0', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2126', '3719', 'qt_xm10_xmduck', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2127', '3720', 'qt_xm10_palm_tree', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2128', '3721', 'es_fnc_crnr', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2129', '3722', 'qt_xm10_trex', 's', 'switch', '2', 'normal', '3', '7', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2130', '3723', 'es_epictree', 's', 'switch', '3', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2131', '3724', 'qt_xm10_elephant', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2132', '3725', 'es_wpost', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2133', '3726', 'qt_xm10_gnome', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2134', '3727', 'qt_xm10_iceduck', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2135', '3728', 'qt_xm10_icetiger', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2136', '3729', 'es_fnc_1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2137', '3730', 'qt_xm10_iceplasto', 's', 'seat', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2138', '3731', 'es_icestar_g', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2139', '3732', 'qt_xm10_icelupin', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2140', '3733', 'prizetrophy_nrj_2011', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2141', '3734', 'qt_xm10_iceteddy', 's', 'seat', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2142', '3735', 'es_lmppst', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2143', '3736', 'es_skating_ice', 's', 'switch', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2144', '3737', 'qt_xm10_icepillar', 's', 'switch', '2', 'normal', '1', '1', '3.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2145', '3738', 'es_roaster', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2146', '3739', 'es_puck', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2147', '3740', 'es_santa', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2148', '3741', 'es_tagging', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2149', '3742', 'qt_xm10_nest', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2150', '3743', 'qt_xm10_icesilotable', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2151', '3744', 'petfood16', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2152', '3745', 'es_icestar_r', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2153', '3746', 'qt_xm10_icedragon', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2154', '3747', 'qt_xm10_stone', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2155', '3748', 'qt_xm10_ice_fish', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2156', '3749', 'es_icestar_y', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2157', '3750', 'qt_xm10_bench', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2158', '3751', 'xmas10_surprise', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2159', '3752', 'xmas10_fireplace', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2160', '3753', 'es_geysir', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2161', '3754', 'xmas10_present', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2162', '3755', 'qt_xm10_iceelephant', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2163', '3756', 'es_score_b', 's', 'scoreboard', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2164', '3757', 'es_tile', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2165', '3758', 'es_box', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2166', '3759', 'es_exit', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2167', '3760', 'es_gate_r', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2168', '3761', 'es_gate_g', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2169', '3762', 'es_gate_b', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2170', '3763', 'es_gate_y', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2171', '3764', 'es_counter', 's', 'switch', '2', 'normal', '1', '3', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2172', '3765', 'es_score_r', 's', 'scoreboard', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2173', '3766', 'es_score_g', 's', 'scoreboard', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2174', '3767', 'es_score_y', 's', 'scoreboard', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2175', '3768', 'year2011_waver_y', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2176', '3769', 'prizetrophy_2011_w', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2177', '3770', 'prizetrophy_2011_r', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2178', '3771', 'prizetrophy_2011_y', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2179', '3772', 'fireworks_01', 's', 'fireworks', '6', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2180', '3773', 'prizetrophy_2011_b', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2181', '3774', 'fireworks_03', 's', 'fireworks', '11', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2182', '3775', 'prizetrophy_2011_p', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2183', '3776', 'fireworks_02', 's', 'fireworks', '16', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2184', '3777', 'year2011_waver_r', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2185', '3778', 'prizetrophy_2011_g', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2186', '3779', 'fireworks_05', 's', 'fireworks', '9', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2187', '3780', 'year2011_waver_g', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2188', '3781', 'year2011_waver_b', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2189', '3782', 'fireworks_07', 's', 'fireworks', '20', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2190', '3783', 'fireworks_06', 's', 'fireworks', '9', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2191', '3784', 'fireworks_04', 's', 'fireworks', '9', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2192', '3785', 'bling11_statue2', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2193', '3786', 'bling11_slot', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2194', '3787', 'bling11_towels', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2195', '3788', 'bling11_rug1', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2196', '3789', 'bling11_tele', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2197', '3790', 'bling11_sofa', 's', 'seat', '0', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2198', '3791', 'bling11_statue1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2199', '3792', 'val11_floor', 's', 'effectgenerator', '55', 'initiator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2200', '3793', 'bling11_dvd', 's', 'switch', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2201', '3794', 'bling11_floor', 's', 'switch', '9', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2202', '3795', 'bling11_plant', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2203', '3796', 'china_rabbit', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2204', '3797', 'bling11_rug2', 's', 'static', '0', 'normal', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2205', '3798', 'bling11_dvn', 's', 'bed', '5', 'normal', '1', '3', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2206', '3799', 'bling11_seat2', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2207', '3800', 'bling11_seat1', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2208', '3801', 'bling11_block', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2209', '3802', 'bling11_pillar', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2210', '3803', 'qt_val11_holoduck', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2211', '3804', 'val11_playa', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2212', '3805', 'qt_val11_discoball', 's', 'switch', '2', 'ignore', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2213', '3806', 'val11_chair', 's', 'seat', '4', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2214', '3807', 'qt_val11_nest', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2215', '3808', 'nest_terrarium', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2216', '3809', 'qt_val11_duckformer', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2217', '3810', 'qt_val11_jellychair', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2218', '3811', 'qt_val11_jellyheart', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2219', '3812', 'val11_rail', 's', 'static', '2', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2220', '3813', 'qt_val11_holoheart', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2221', '3814', 'ads_leaf_teleport', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2222', '3815', 'ads_sunnyvend', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2223', '3816', 'petfood18', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2224', '3817', 'petfood17', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2225', '3819', 'limo_w_mid', 's', 'seat', '5', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2226', '3820', 'limo_w_mid2', 's', 'static', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2227', '3821', 'petfood19', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2228', '3822', 'limo_w_back', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2229', '3823', 'limo_w_front', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2230', '3824', 'gothic_bed', 's', 'bed', '2', 'terminator', '2', '3', '2.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2231', '3825', 'gothic_candles', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2232', '3826', 'gothic_desk', 's', 'switch', '2', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2233', '3827', 'ads_grefu_trophy', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2234', '3828', 'gothic_bowl', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2235', '3830', 'nest_frog', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2236', '3831', 'pond', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2237', '3832', 'val11_present', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2238', '3833', 'prizetrophy_cine', 's', 'prizetrophy', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2239', '3834', 'cine_vipsign', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2240', '3835', 'limo_b_mid3', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2241', '3836', 'limo_b_mid2', 's', 'static', '2', 'terminator', '2', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2242', '3837', 'limo_b_front', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2243', '3838', 'limo_b_mid', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2244', '3839', 'cine_star', 's', 'static', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2245', '3840', 'limo_b_back', 's', 'seat', '5', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2246', '3841', 'cine_curtain', 's', 'gate', '2', 'terminator', '8', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2247', '3842', 'cine_screen', 's', 'switch', '7', 'terminator', '6', '1', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2248', '3843', 'theatre_seat_g', 's', 'seat', '5', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2249', '3844', 'cine_tile', 's', 'autoswitch', '2', 'normal', '1', '1', '0.1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2250', '3845', 'cine_bench_b', 's', 'seat', '5', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2251', '3846', 'theatre_seat_b', 's', 'seat', '7', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2252', '3847', 'cine_roof', 's', 'switch', '2', 'ignore', '3', '3', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2253', '3848', 'cine_popcorn', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2254', '3849', 'cine_bench', 's', 'seat', '5', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2255', '3850', 'cine_bench_g', 's', 'seat', '5', 'terminator', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2256', '3851', 'cine_ticket_booth', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2257', '3852', 'cine_projector', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2258', '3853', 'wf_box', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2259', '3854', 'wf_maze', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2260', '3855', 'ads_rangocactus', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2261', '3856', 'cine_glass', 's', 'switch', '2', 'normal', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2262', '3857', 'wf_cnd_has_furni_on', 's', 'switch', '2', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2263', '1', 'post.it', 'i', 'stickynote', '0', 'normal', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2264', '2', 'post.it.vd', 'i', 'stickynote', '0', 'normal', '0', '0', '0', '0', '0', '0', '0', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2265', '3', 'photo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2266', '1001', 'Chess', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2267', '1011', 'TicTacToe', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2268', '1021', 'BattleShip', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2269', '2010', 'Poker', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2270', '3001', 'wallpaper', 'i', 'wallpaper', '5', 'normal', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `item_definitions` VALUES ('2271', '3002', 'floor', 'i', 'floor', '5', 'normal', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `item_definitions` VALUES ('2272', '4001', 'poster', 'i', 'static', '0', 'normal', '0', '0', '1', '0', '1', '1', '0', '0', '0', '0');
INSERT INTO `item_definitions` VALUES ('2273', '4002', 'gothicfountain', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2274', '4003', 'hc_wall_lamp', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2275', '4004', 'industrialfan', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2276', '4005', 'torch', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2277', '4006', 'val_heart', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2278', '4007', 'wallmirror', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2279', '4008', 'jp_ninjastars', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2280', '4009', 'habw_mirror', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2281', '4010', 'habbowheel', 'i', 'habbowheel', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2282', '4011', 'guitar_skull', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2283', '4012', 'guitar_v', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2284', '4013', 'hrella_poster_2', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2285', '4014', 'hrella_poster_1', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2286', '4015', 'xmas_light', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2287', '4016', 'hrella_poster_3', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2288', '4017', 'sw_swords', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2289', '4018', 'sw_stone', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2290', '4019', 'sw_hole', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2291', '4020', 'arabian_swords', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2292', '4021', 'jp_sheet3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2293', '4022', 'arabian_wndw', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2294', '4023', 'md_logo_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2295', '4024', 'jp_sheet1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2296', '4025', 'md_can', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2297', '4026', 'jp_sheet2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2298', '4027', 'roomdimmer', 'i', 'moodlight', '0', 'normal', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2299', '4028', 'tiki_surfboard', 'i', 'switch', '9', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2300', '4029', 'tampax_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2301', '4030', 'tiki_wallplnt', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2302', '4031', 'window_single_default', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2303', '4032', 'window_double_default', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2304', '4033', 'noob_window_double', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2305', '4034', 'window_chinese_wide', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2306', '4035', 'window_golden', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2307', '4036', 'window_square', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2308', '4037', 'window_romantic_narrow', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2309', '4038', 'window_chinese_narrow', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2310', '4039', 'window_70s_wide', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2311', '4040', 'window_70s_narrow', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2312', '4041', 'window_romantic_wide', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2313', '4042', 'window_basic', 'i', 'static', '0', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2314', '4043', 'ads_sunnyd', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2315', '4044', 'window_grunge', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2316', '4045', 'window_triple', 'i', 'static', '0', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2317', '4046', 'window_diner2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2318', '4047', 'ads_dave_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2319', '4048', 'diner_walltable', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2320', '4049', 'window_diner', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2321', '4050', 'ads_nokia_logo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2322', '4051', 'easy_poster', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2323', '4052', 'window_hole', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2324', '4053', 'ads_nokia_phone', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2325', '4054', 'window_skyscraper', 'i', 'static', '0', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2326', '4055', 'landscape', 'i', 'landscape', '5', 'normal', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `item_definitions` VALUES ('2327', '4056', 'det_bhole', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2328', '4057', 'netari_poster', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2329', '4058', 'ads_campguitar', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2330', '4059', 'hween08_rad', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2331', '4060', 'hw_08_xray', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2332', '4061', 'hween08_wndwb', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2333', '4062', 'hween08_wndw', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2334', '4063', 'hween08_bio', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2335', '4064', 'hw08_xray', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2336', '4065', 'gothicfountain2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2337', '4066', 'party_led', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2338', '4067', 'ads_cmusic', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2339', '4068', 'party_wc_girl', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2340', '4069', 'party_neon1', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2341', '4070', 'party_wc_boy', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2342', '4071', 'party_shelf', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2343', '4072', 'party_neon4', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2344', '4073', 'party_neon2', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2345', '4074', 'party_neon5', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2346', '4075', 'party_neon3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2347', '4076', 'xmas08_icewall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2348', '4077', 'xmas08_wallpaper', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2349', '4078', 'ads_clwall2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2350', '4079', 'ads_clwall3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2351', '4080', 'xmas_icewall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2352', '4081', 'ads_ob_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2353', '4082', 'ads_clwall1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2354', '4083', 'ads_mall_window', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2355', '4084', 'china_pstr1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2356', '4085', 'china_pstr2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2357', '4086', 'china_light', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2358', '4087', 'bolly_wdw_wd', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2359', '4088', 'ads_idol_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2360', '4089', 'ads_igorevilb', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2361', '4090', 'ads_igor_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2362', '4091', 'ads_mall_winpet', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2363', '4092', 'ads_mall_winfur', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2364', '4093', 'ads_idol_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2365', '4094', 'lc_window1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2366', '4095', 'lc_wall1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2367', '4096', 'lc_window2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2368', '4097', 'lc_wall2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2369', '4098', 'ads_mall_wincin', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2370', '4099', 'ads_idol_mirror', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2371', '4100', 'ads_mall_winbea', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2372', '4101', 'ads_mall_winmus', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2373', '4102', 'eco_curtains2', 'i', 'switch', '2', 'normal', '0', '0', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2374', '4103', 'ads_mall_winchi', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2375', '4104', 'eco_curtains3', 'i', 'switch', '2', 'normal', '0', '0', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2376', '4105', 'eco_curtains1', 'i', 'switch', '2', 'normal', '0', '0', '1', '0', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2377', '4106', 'ads_mall_winspo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2378', '4107', 'exe_wfall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2379', '4108', 'ads_idol_logo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2380', '4109', 'ads_mall_winice', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2381', '4110', 'exe_map', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2382', '4111', 'ads_puffet_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2383', '4112', 'ads_reebok_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2384', '4113', 'ads_malaco_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2385', '4114', 'country_forestwall', 'i', 'static', '10', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2386', '4115', 'ads_lin_wh_c', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2387', '4116', 'country_lantern', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2388', '4117', 'country_fp', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2389', '4118', 'country_wall', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2390', '4119', 'flag_norway', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2391', '4120', 'diner_poster', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2392', '4121', 'lt_jngl_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2393', '4122', 'ads_mirror', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2394', '4123', 'lt_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2395', '4220', 'post_it_vd', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2396', '4221', 'post_it', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2397', '4222', 'ads_veet', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2398', '4223', 'sf_wall3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2399', '4224', 'sf_window', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2400', '4225', 'ads_mall_wintra', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2401', '4226', 'ads_wwe_poster', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2402', '4227', 'sf_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2403', '4228', 'sf_wall2', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2404', '4229', 'flag_belgium', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2405', '4230', 'ads_mall_wingar', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2406', '4231', 'flag_portugal', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2407', '4232', 'rela_wall', 'i', 'switch', '6', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2408', '4233', 'ktchn_knives', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2409', '4234', 'ktchn_oven', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2410', '4235', 'ktchn_wall', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2411', '4236', 'ads_mall_winclo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2412', '4237', 'dimmer_swtch', 'i', 'moodlight', '0', 'normal', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2413', '4238', 'dimmer_buttn', 'i', 'moodlight', '0', 'normal', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2414', '4239', 'dimmer_fuse2', 'i', 'moodlight', '0', 'normal', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2415', '4240', 'dimmer_fuse6', 'i', 'moodlight', '0', 'normal', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2416', '4241', 'ads_mtv_bigtv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2417', '4242', 'ads_mtv_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2418', '4243', 'ads_idol_l_logo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2419', '4244', 'urban_wall', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2420', '4245', 'ads_idol_l_tv', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2421', '4246', 'flag_peru', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2422', '4247', 'hween09_crnr1', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2423', '4248', 'flag_tunisia', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2424', '4249', 'flag_singapore', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2425', '4250', 'flag_mexico', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2426', '4251', 'flag_philippines', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2427', '4252', 'flag_malaysia', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2428', '4253', 'flag_greece', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2429', '4254', 'flag_venezl', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2430', '4255', 'flag_turkey', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2431', '4256', 'flag_chile', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2432', '4257', 'hween09_wall1', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2433', '4258', 'flag_columbia', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2434', '4259', 'hween09_stonewall', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2435', '4260', 'flag_newzealand', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2436', '4261', 'flag_argentina', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2437', '4262', 'flag_panama', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2438', '4263', 'hween09_paint', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2439', '4264', 'flag_morocco', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2440', '4265', 'flag_dominicanrepublic', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2441', '4266', 'hween09_curt', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2442', '4267', 'byesw_loadscreen', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2443', '4268', 'flag_ecuador', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2444', '4269', 'hween09_treewall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2445', '4270', 'flag_algeria', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2446', '4271', 'hween09_win', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2447', '4272', 'ads_twi_paint', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2448', '4273', 'ads_twi_dreamc', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2449', '4274', 'ads_twi_bwall1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2450', '4275', 'ads_twi_crest', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2451', '4276', 'ads_twi_bwall2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2452', '4277', 'ads_twi_windw', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2453', '4278', 'xm09_bauble_24', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2454', '4279', 'xm09_bauble_27', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2455', '4280', 'xm09_stocking', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2456', '4281', 'xm09_bauble_17', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2457', '4282', 'xm09_bauble_4', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2458', '4283', 'xm09_bauble_19', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2459', '4284', 'xm09_bauble_6', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2460', '4285', 'xm09_bauble_3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2461', '4286', 'xm09_bauble_25', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2462', '4287', 'arabian_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2463', '4288', 'xm09_bauble_5', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2464', '4289', 'xm09_bauble_11', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2465', '4290', 'xm09_bauble_14', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2466', '4291', 'xm09_bauble_7', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2467', '4292', 'xm09_bauble_23', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2468', '4293', 'xm09_bauble_10', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2469', '4294', 'xm09_bauble_9', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2470', '4295', 'xm09_bauble_8', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2471', '4296', 'xm09_bauble_20', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2472', '4297', 'xm09_bauble_2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2473', '4298', 'xm09_bauble_18', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2474', '4299', 'xm09_bauble_13', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2475', '4300', 'xm09_bauble_1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2476', '4301', 'xm09_bauble_15', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2477', '4302', 'xm09_bauble_22', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2478', '4303', 'xm09_bauble_16', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2479', '4304', 'xm09_bauble_12', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2480', '4305', 'xm09_bauble_21', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2481', '4306', 'xm09_bauble_26', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2482', '4307', 'xm09_firwall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2483', '4308', 'xm09_forestwall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2484', '4310', 'party_lights', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2485', '4311', 'xm09_lodgewall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2486', '4312', 'xm09_frplc', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2487', '4313', 'year2010', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2488', '4314', 'china_pstr3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2489', '4315', 'ads_tv_jaapuisto', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2490', '4316', 'val09_wall2', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2491', '4317', 'val09_wdrobe_g', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2492', '4318', 'val09_wall1', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2493', '4319', 'bling_sink', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2494', '4320', 'val09_wdrobe_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2495', '4321', 'bling_cabinet', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2496', '4322', 'ads_percyw', 'i', 'switch', '2', 'terminator', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2497', '4323', 'ads_boost_surfb', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2498', '4324', 'ads_tlc_wheel', 'i', 'habbowheel', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2499', '4325', 'garden_wall', 'i', 'switch', '3', 'terminator', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2500', '4326', 'ads_tv_yle', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2501', '4327', 'runway_shelf', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2502', '4328', 'ads_latrobe_flag', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2503', '4329', 'hc3_walldeco', 'i', 'switch', '10', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2504', '4330', 'ads_nokia_x6', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2505', '4331', 'runway_fabric', 'i', 'switch', '4', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2506', '4332', 'ads_target_wall', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2507', '4333', 'ads_super_pop', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2508', '4334', 'ads_tv_chocapic_02', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2509', '4335', 'ads_tv_chocapic_01', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2510', '4336', 'bw_jaws', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2511', '4337', 'ads_grefusa_surfb', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2512', '4338', 'ktchn10_cabnt', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2513', '4339', 'hosptl_xray', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2514', '4340', 'hween10_fogwall', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2515', '4341', 'bb_painimies1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2516', '4342', 'bb_painimies2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2517', '4343', 'ads_mtv_bigtv2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2518', '4344', 'ads_mtv_tv2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2519', '4345', 'hween10_card_3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2520', '4346', 'hween10_card_1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2521', '4347', 'hween10_card_4', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2522', '4348', 'hween10_card_6', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2523', '4349', 'hween10_wallskull', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2524', '4350', 'hween10_card_2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2525', '4351', 'hween10_card_5', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2526', '4352', 'ads_nokiax3_wall2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2527', '4353', 'ads_nokiax3_wall3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2528', '4354', 'ads_nokiax3_wall1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2529', '4355', 'ads_nokiax3_phn', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2530', '4356', 'exe_sensor', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2531', '4357', 'qt_calendar2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2532', '4358', 'ads_r7logo', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2533', '4359', 'qt_calendar0', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2534', '4360', 'qt_calendar1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2535', '4361', 'qt_xm10_bauble2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2536', '4362', 'es_build1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2537', '4363', 'es_build4', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2538', '4364', 'es_build2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2539', '4365', 'qt_xm10_bauble1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2540', '4366', 'es_build3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2541', '4367', 'es_window', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2542', '4368', 'qt_xm10_bauble3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2543', '4369', 'qt_xm10_icestar', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2544', '4370', 'es_big1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2545', '4371', 'es_big3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2546', '4372', 'es_big2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2547', '4373', 'year2011', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2548', '4374', 'bling11_wall1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2549', '4375', 'bling11_wall4', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2550', '4376', 'bling11_wall2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2551', '4377', 'bling11_wall3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2552', '4378', 'qt_val11_heartlights', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2553', '4379', 'bling11_big1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2554', '4380', 'gothic_st_glass', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2555', '4381', 'ads_bigtv_missmix', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2556', '4382', 'cine_light2', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2557', '4383', 'cine_light1', 'i', 'switch', '3', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2559', '3858', 'cubie_lamp_b', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2560', '3859', 'cubie_chair_b', 's', 'seat', '0', 'terminator', '1', '1', '1.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2561', '3860', 'cubie_rug_b', 's', 'switch', '3', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2562', '3861', 'cubie_bigtable_b', 's', 'switch', '2', 'normal', '2', '2', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2563', '3862', 'cubie_beanbag_p', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2564', '3863', 'cubie_lamp_p', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2565', '3864', 'cubie_sofaseat_p', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2566', '3865', 'cubie_shelf_0_b', 's', 'switch', '3', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2567', '3866', 'cubie_shelf_4_p', 's', 'switch', '3', 'normal', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2568', '3867', 'cubie_shelf_2_p', 's', 'switch', '11', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2569', '3868', 'cubie_bed_p', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2570', '3869', 'cubie_stool_b', 's', 'seat', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2571', '3870', 'cubie_rug_p', 's', 'static', '3', 'normal', '2', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2572', '3871', 'cubie_bed_b', 's', 'bed', '0', 'terminator', '1', '3', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2573', '3872', 'cubie_shelf_3_b', 's', 'switch', '8', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2574', '3873', 'cubie_shelf_3_p', 's', 'switch', '8', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2575', '3874', 'cubie_shelf_1_p', 's', 'switch', '14', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2576', '3875', 'cubie_shelf_1_b', 's', 'switch', '14', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2577', '3876', 'cubie_bigtable_p', 's', 'switch', '2', 'normal', '2', '2', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2578', '3877', 'cubie_beanbag_b', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2579', '3878', 'cubie_stool_p', 's', 'seat', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2580', '3879', 'cubie_chair_p', 's', 'seat', '0', 'terminator', '1', '1', '1.3', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2581', '3880', 'cubie_table', 's', 'switch', '0', 'normal', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2582', '3881', 'cubie_sofaseat_b', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2583', '3882', 'cubie_shelf_4_b', 's', 'switch', '3', 'normal', '3', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2584', '3883', 'cubie_shelf_2_b', 's', 'switch', '11', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2585', '3884', 'cubie_shelf_0_p', 's', 'switch', '3', 'normal', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2586', '4384', 'cubie_decal_3_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2587', '4385', 'cubie_decklight_p', 'i', 'switch', '2', 'terminator', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2588', '4386', 'cubie_decal_1_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2589', '4387', 'cubie_decal_2_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2590', '4388', 'cubie_decal_3_p', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2591', '4389', 'cubie_wallshelf_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2592', '4390', 'cubie_decal_1_p', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2593', '4391', 'cubie_decal_3', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2594', '4392', 'cubie_wallshelf_p', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2595', '4393', 'cubie_decal_2_p', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2596', '4394', 'cubie_decklight_b', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2597', '4395', 'cubie_decal_0', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2598', '3885', 'newbie_present', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2599', '3886', 'tv_flat', 's', 'switch', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2600', '3887', 'waasa_table2', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2601', '3888', 'computer_flatscreen', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2602', '3889', 'waasa_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2603', '3890', 'waasa_ship2', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2604', '3891', 'waasa_ship1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2605', '3892', 'waasa_bunk_bed', 's', 'static', '0', 'terminator', '3', '1', '2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2606', '3893', 'computer_laptop', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2607', '3894', 'computer_old', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2608', '3895', 'waasa_table1', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2609', '3896', 'waasa_desk', 's', 'static', '2', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2610', '4396', 'waasa_wall_shelf2', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2611', '4397', 'waasa_wall_shelf1', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2612', '3897', 'newbie_nest', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2613', '3898', 'waasa_rug5', 's', 'static', '0', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2614', '3899', 'waasa_rug1', 's', 'static', '0', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2615', '3900', 'waasa_rug3', 's', 'static', '0', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2616', '3901', 'waasa_aquarium', 's', 'static', '2', 'terminator', '2', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2617', '3902', 'waasa_rug4', 's', 'static', '0', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2618', '3903', 'waasa_chair_wood', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2619', '3904', 'waasa_rug2', 's', 'static', '0', 'normal', '2', '4', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2620', '3905', 'jukebox_big', 's', 'traxplayer', '20', 'normal', '2', '1', '1', '1', '1', '1', '1', '1', '0', '1');
INSERT INTO `item_definitions` VALUES ('2621', '3906', 'milkbowl', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2622', '3907', 'petfood21', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2623', '3908', 'easter11_basket', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2624', '3909', 'easter11_grasspatch', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2625', '3910', 'ads_wowpball', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2626', '3911', 'pet_food_corn', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2627', '3912', 'pet_toy_trampoline', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2628', '3913', 'nest_chick', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2629', '3914', 'easter11_tag', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2630', '3915', 'easter11_tuip_g', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2631', '3916', 'easter11_tuip_y', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2632', '3917', 'easter11_mushroom4', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2633', '3918', 'easter11_mushroom1', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2634', '3919', 'kuurna_sofa', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2635', '3920', 'easter11_mushroom3', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2636', '3921', 'easter11_mushroom2', 's', 'switch', '3', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2637', '3922', 'kuurna_lamp', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2638', '3923', 'kuurna_chair', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2639', '3924', 'kuurna_mat', 's', 'static', '2', 'normal', '3', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2640', '3925', 'kuurna_table1', 's', 'static', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2641', '3926', 'kuurna_table', 's', 'static', '2', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2642', '3927', 'ads_suun', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2643', '3928', 'kuurna_chair1', 's', 'seat', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2644', '3929', 'easter11_tuip_p', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2645', '4398', 'easter11_wall', 'i', 'static', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2646', '4399', 'ads_suunvuorow', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2647', '4400', 'ads_volkswagen_poster', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2650', '2138', 'grand_piano*3', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2651', '2139', 'grand_piano*5', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2652', '2140', 'grand_piano*2', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2653', '2141', 'grand_piano*4', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2654', '2142', 'grand_piano*1', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2655', '3930', 'anna_divider*1', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2656', '3931', 'anna_divider*2', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2657', '3932', 'anna_divider*3', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2658', '3933', 'anna_divider*4', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2659', '3934', 'anna_divider*5', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2660', '3935', 'anna_div_gate*1', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2661', '3936', 'anna_div_gate*2', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2662', '3937', 'anna_div_gate*3', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2663', '3938', 'anna_div_gate*4', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2664', '3939', 'anna_div_gate*5', 's', 'gate', '0', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2665', '3940', 'anna_chair*1', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2666', '3941', 'anna_chair*2', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2667', '3942', 'anna_chair*3', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2668', '3943', 'anna_chair*4', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2669', '3944', 'anna_chair*5', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2670', '3945', 'anna_stool*1', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2671', '3946', 'anna_stool*2', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2672', '3947', 'anna_stool*3', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2673', '3948', 'anna_stool*4', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2674', '3949', 'anna_stool*5', 's', 'seat', '0', 'terminator', '1', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2675', '3950', 'anna_table*1', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2676', '3951', 'anna_table*2', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2677', '3952', 'anna_table*3', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2678', '3953', 'anna_table*4', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2679', '3954', 'anna_table*5', 's', 'static', '0', 'normal', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2680', '3955', 'anna_rug*1', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2681', '3956', 'anna_rug*2', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2682', '3957', 'anna_rug*3', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2683', '3958', 'anna_rug*4', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2684', '3959', 'anna_rug*5', 's', 'static', '0', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2685', '3960', 'anna_sofa*1', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2686', '3961', 'anna_sofa*2', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2687', '3962', 'anna_sofa*3', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2688', '3963', 'anna_sofa*4', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2689', '3964', 'anna_sofa*5', 's', 'seat', '0', 'terminator', '2', '1', '1.2', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2690', '3965', 'anna_pill*1', 's', 'static', '0', 'normal', '1', '1', '0.4', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2691', '3966', 'anna_pill*2', 's', 'static', '0', 'normal', '1', '1', '0.4', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2692', '3967', 'anna_pill*3', 's', 'static', '0', 'normal', '1', '1', '0.4', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2693', '3968', 'anna_pill*4', 's', 'static', '0', 'normal', '1', '1', '0.4', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2694', '3969', 'anna_pill*5', 's', 'static', '0', 'normal', '1', '1', '0.4', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2695', '3970', 'anna_lamp*1', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2696', '3971', 'anna_lamp*2', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2697', '3972', 'anna_lamp*3', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2698', '3973', 'anna_lamp*4', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2699', '3974', 'anna_lamp*5', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2700', '3975', 'anna_div_crnr*1', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2701', '3976', 'anna_div_crnr*2', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2702', '3977', 'anna_div_crnr*3', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2703', '3978', 'anna_div_crnr*4', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2704', '3979', 'anna_div_crnr*5', 's', 'static', '0', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2705', '3980', 'picnic_blanket_yel', 's', 'static', '2', 'normal', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2706', '3981', 'picnic_pillow_yel', 's', 'seat', '2', 'terminator', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2707', '3982', 'picnic_food1', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2708', '3983', 'note_tag', 's', 'stickypole', '0', 'terminator', '1', '1', '1', '0', '0', '0', '0', '0', '0', '1');
INSERT INTO `item_definitions` VALUES ('2709', '3984', 'picnic_wfall', 's', 'switch', '2', 'terminator', '2', '2', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2710', '3985', 'picnic_blanket_blu', 's', 'switch', '2', 'normal', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2711', '3986', 'picnic_food3', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2712', '3987', 'picnic_blanket', 's', 'switch', '2', 'normal', '3', '3', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2713', '3988', 'picnic_pillow_blu', 's', 'seat', '2', 'terminator', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2714', '3989', 'picnic_food2', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2715', '3990', 'picnic_tele', 's', 'teleporter', '2', 'terminator', '1', '1', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2716', '3991', 'picnic_basket', 's', 'static', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2717', '3992', 'picnic_pillow', 's', 'switch', '2', 'terminator', '1', '1', '0.6', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2718', '3993', 'picnic_chair', 's', 'static', '0', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2719', '3994', 'picnic_3brds', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2720', '4401', 'picture_car', 'i', 'switch', '2', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2721', '3995', 'petfood23', 's', 'switch', '2', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2722', '3996', 'ads_background', 's', 'static', '0', 'ignore', '1', '1', '0', '0', '0', '0', '0', '0', '2', '0');
INSERT INTO `item_definitions` VALUES ('2723', '3997', 'ads_kelloggs_statue', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2724', '3998', 'race_trophy', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2725', '3999', 'ads_kfp2statue', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2726', '4000', 'petfood22', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2727', '4402', 'ads_kfp2_tv', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2728', '4403', 'ads_kfp2_wall', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2729', '4404', 'dng_wall', 'i', 'switch', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2730', '4001', 'nest_dragon', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2731', '4002', 'ashtree', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2732', '4003', 'grail_water', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2733', '4004', 'grail_nectar', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2734', '4005', 'dng_cube', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2735', '4006', 'dng_ground', 's', 'static', '5', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2736', '4007', 'dng_pillar', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2737', '4008', 'dng_treasure2', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2738', '4009', 'dng_floor', 's', 'static', '5', 'normal', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2739', '4010', 'dng_stairs', 's', 'switch', '5', 'terminator', '1', '1', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('2740', '4011', 'dng_treasure', 's', 'switch', '4', 'terminator', '2', '2', '0', '1', '1', '1', '1', '1', '1', '0');
INSERT INTO `item_definitions` VALUES ('2741', '4012', 'dng_throne', 's', 'seat', '0', 'terminator', '1', '1', '1.8', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2742', '4013', 'dng_block', 's', 'switch', '5', 'normal', '1', '1', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('2744', '1', 'avatar_effect1', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2745', '2', 'avatar_effect2', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2746', '3', 'avatar_effect3', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2747', '4', 'avatar_effect4', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2748', '5', 'avatar_effect5', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2749', '6', 'avatar_effect6', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2750', '7', 'avatar_effect7', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2751', '8', 'avatar_effect8', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2752', '9', 'avatar_effect9', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2753', '10', 'avatar_effect10', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2754', '11', 'avatar_effect11', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2755', '12', 'avatar_effect12', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2756', '13', 'avatar_effect13', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2757', '14', 'avatar_effect14', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2758', '15', 'avatar_effect15', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2759', '16', 'avatar_effect16', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2760', '17', 'avatar_effect17', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2761', '18', 'avatar_effect18', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2762', '19', 'avatar_effect19', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2763', '20', 'avatar_effect20', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2764', '21', 'avatar_effect21', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2765', '22', 'avatar_effect22', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2766', '23', 'avatar_effect23', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2767', '24', 'avatar_effect24', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2768', '25', 'avatar_effect25', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2769', '26', 'avatar_effect26', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2770', '27', 'avatar_effect27', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2771', '28', 'avatar_effect28', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2772', '29', 'avatar_effect29', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2773', '30', 'avatar_effect30', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2774', '31', 'avatar_effect31', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2775', '32', 'avatar_effect32', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2776', '33', 'avatar_effect33', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2777', '34', 'avatar_effect34', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2778', '35', 'avatar_effect35', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2779', '36', 'avatar_effect36', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2780', '37', 'avatar_effect37', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2781', '38', 'avatar_effect38', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2782', '39', 'avatar_effect39', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2783', '40', 'avatar_effect40', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2784', '41', 'avatar_effect41', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2785', '42', 'avatar_effect42', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2786', '43', 'avatar_effect43', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2787', '44', 'avatar_effect44', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2788', '45', 'avatar_effect45', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2789', '46', 'avatar_effect46', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2790', '47', 'avatar_effect47', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2791', '48', 'avatar_effect48', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2792', '49', 'avatar_effect49', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2793', '50', 'avatar_effect50', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2794', '51', 'avatar_effect51', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2795', '52', 'avatar_effect52', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2796', '53', 'avatar_effect53', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2797', '54', 'avatar_effect54', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2798', '55', 'avatar_effect55', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2799', '56', 'avatar_effect56', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2800', '57', 'avatar_effect57', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2801', '58', 'avatar_effect58', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2802', '59', 'avatar_effect59', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2803', '60', 'avatar_effect60', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2804', '61', 'avatar_effect61', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2805', '62', 'avatar_effect62', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2806', '63', 'avatar_effect63', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2807', '64', 'avatar_effect64', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2808', '65', 'avatar_effect65', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2809', '66', 'avatar_effect66', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2810', '67', 'avatar_effect67', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2811', '68', 'avatar_effect68', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2812', '69', 'avatar_effect69', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2813', '70', 'avatar_effect70', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2814', '1', 'avatar_effect1', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2815', '2', 'avatar_effect2', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2816', '3', 'avatar_effect3', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2817', '4', 'avatar_effect4', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2818', '5', 'avatar_effect5', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2819', '6', 'avatar_effect6', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2820', '7', 'avatar_effect7', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2821', '8', 'avatar_effect8', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2822', '9', 'avatar_effect9', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2823', '10', 'avatar_effect10', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2824', '11', 'avatar_effect11', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2825', '12', 'avatar_effect12', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2826', '13', 'avatar_effect13', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2827', '14', 'avatar_effect14', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2828', '15', 'avatar_effect15', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2829', '16', 'avatar_effect16', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2830', '17', 'avatar_effect17', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2831', '18', 'avatar_effect18', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2832', '19', 'avatar_effect19', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2833', '20', 'avatar_effect20', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2834', '21', 'avatar_effect21', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2835', '22', 'avatar_effect22', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2836', '23', 'avatar_effect23', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2837', '24', 'avatar_effect24', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2838', '25', 'avatar_effect25', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2839', '26', 'avatar_effect26', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2840', '27', 'avatar_effect27', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2841', '28', 'avatar_effect28', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2842', '29', 'avatar_effect29', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2843', '30', 'avatar_effect30', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2844', '31', 'avatar_effect31', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2845', '32', 'avatar_effect32', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2846', '33', 'avatar_effect33', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2847', '34', 'avatar_effect34', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2848', '35', 'avatar_effect35', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2849', '36', 'avatar_effect36', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2850', '37', 'avatar_effect37', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2851', '38', 'avatar_effect38', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2852', '39', 'avatar_effect39', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2853', '40', 'avatar_effect40', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2854', '41', 'avatar_effect41', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2855', '42', 'avatar_effect42', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2856', '43', 'avatar_effect43', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2857', '44', 'avatar_effect44', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2858', '45', 'avatar_effect45', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2859', '46', 'avatar_effect46', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2860', '47', 'avatar_effect47', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2861', '48', 'avatar_effect48', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2862', '49', 'avatar_effect49', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2863', '50', 'avatar_effect50', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2864', '51', 'avatar_effect51', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2865', '52', 'avatar_effect52', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2866', '53', 'avatar_effect53', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2867', '54', 'avatar_effect54', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2868', '55', 'avatar_effect55', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2869', '56', 'avatar_effect56', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2870', '57', 'avatar_effect57', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2871', '58', 'avatar_effect58', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2872', '59', 'avatar_effect59', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2873', '60', 'avatar_effect60', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2874', '61', 'avatar_effect61', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2875', '62', 'avatar_effect62', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2876', '63', 'avatar_effect63', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2877', '64', 'avatar_effect64', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2878', '65', 'avatar_effect65', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2879', '66', 'avatar_effect66', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2880', '67', 'avatar_effect67', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2881', '68', 'avatar_effect68', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2882', '69', 'avatar_effect69', 'e', 'switch', '2', 'normal', '0', '0', '0', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2883', '1543', 'pet12', 'p', 'pet', '12', 'normal', '1', '1', '1', '0', '0', '0', '0', '0', '0', '5');
INSERT INTO `item_definitions` VALUES ('2884', '4014', 'petfood_19', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2885', '4015', 'mm_lamp', 's', 'switch', '5', 'normal', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2886', '4016', 'mm_lemon_drink', 's', 'dispenser', '4', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2887', '4017', 'qt_sum11_shell1', 's', 'switch', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2888', '4018', 'qt_sum11_ictrolley', 's', 'switch', '2', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2889', '4019', 'qt_sum11_petfood', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2890', '4020', 'qt_sum11_shell4', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2891', '4021', 'qt_sum11_shell3', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2892', '4022', 'qt_sum11_platfrm', 's', 'switch', '2', 'normal', '2', '2', '0.8', '1', '1', '1', '1', '1', '2', '0');
INSERT INTO `item_definitions` VALUES ('2893', '4023', 'qt_sum11_shell2', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2894', '4024', 'qt_sum11_shell5', 's', 'static', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2895', '4025', 'qt_sum11_chair', 's', 'seat', '5', 'terminator', '1', '1', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2896', '4405', 'ads_cchups_screen', 'i', 'static', '5', 'normal', '0', '0', '1', '1', '1', '1', '1', '1', '0', '0');
INSERT INTO `item_definitions` VALUES ('2897', '4026', 'mm_tub', 's', 'seat', '5', 'terminator', '1', '2', '1', '1', '1', '1', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for `messenger_friendships`
-- ----------------------------
DROP TABLE IF EXISTS `messenger_friendships`;
CREATE TABLE `messenger_friendships` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_1_id` int(11) unsigned NOT NULL,
  `user_2_id` int(11) unsigned NOT NULL,
  `confirmed` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_1_id` (`user_1_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of messenger_friendships
-- ----------------------------

-- ----------------------------
-- Table structure for `moderation_action_log`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_action_log`;
CREATE TABLE `moderation_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `moderator_id` int(10) unsigned NOT NULL,
  `moderator_name` varchar(16) NOT NULL,
  `action_descr` varchar(255) NOT NULL,
  `action_detail` text NOT NULL,
  `timestamp` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for `moderation_chatlogs`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_chatlogs`;
CREATE TABLE `moderation_chatlogs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` double NOT NULL DEFAULT '0',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `message` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_chatlogs
-- ----------------------------

-- ----------------------------
-- Table structure for `moderation_presets`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_presets`;
CREATE TABLE `moderation_presets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('user','room') NOT NULL DEFAULT 'user',
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_presets
-- ----------------------------
INSERT INTO `moderation_presets` VALUES ('1', 'user', 'Thank you for helping to test uberHotel/Snowlight BETA. If you have encountered a bug or would like to leave feedback, visit http://snowlight.uservoice.com');

-- ----------------------------
-- Table structure for `moderation_preset_action_categories`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_preset_action_categories`;
CREATE TABLE `moderation_preset_action_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caption` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_preset_action_categories
-- ----------------------------
INSERT INTO `moderation_preset_action_categories` VALUES ('1', 'Communication');
INSERT INTO `moderation_preset_action_categories` VALUES ('2', 'Rooms');
INSERT INTO `moderation_preset_action_categories` VALUES ('8', 'Account');
INSERT INTO `moderation_preset_action_categories` VALUES ('9', 'Security');
INSERT INTO `moderation_preset_action_categories` VALUES ('10', 'Misc');
INSERT INTO `moderation_preset_action_categories` VALUES ('11', 'General');

-- ----------------------------
-- Table structure for `moderation_preset_action_messages`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_preset_action_messages`;
CREATE TABLE `moderation_preset_action_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL,
  `caption` varchar(32) NOT NULL,
  `message_text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_preset_action_messages
-- ----------------------------
INSERT INTO `moderation_preset_action_messages` VALUES ('1', '2', 'Blocking', 'Blocking parts of/access to a room is against uberHotel rules. ');
INSERT INTO `moderation_preset_action_messages` VALUES ('2', '1', 'Flooding', 'Flooding or spamming is against uberHotel rules. ');
INSERT INTO `moderation_preset_action_messages` VALUES ('3', '1', 'Swearing', 'Excessive or extreme language or swearing is against uberHotel rules. ');
INSERT INTO `moderation_preset_action_messages` VALUES ('4', '1', 'Advertising', 'Excessive or commercial advertising is against uberHotel rules. ');
INSERT INTO `moderation_preset_action_messages` VALUES ('5', '8', 'Unacceptable Name', 'Your username is against uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('6', '8', 'Unacceptable Motto', 'Your motto is against uberHotel rules. ');
INSERT INTO `moderation_preset_action_messages` VALUES ('7', '2', 'Unacceptable Room', 'Your room name and/or description is unacceptable according to uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('8', '8', 'Unacceptable Tags', 'Your tags are unacceptable according to uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('9', '9', 'Scamming', 'Scamming is against uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('10', '9', 'Scripting', 'Scripting is against uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('11', '9', 'Breaching Security', 'Breaching the security of uberHotel is unacceptable.');
INSERT INTO `moderation_preset_action_messages` VALUES ('12', '11', 'Violation', 'You are in violation of uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('13', '10', 'Begging', 'Begging for badges, jobs etc. is against uberHotel rules.');
INSERT INTO `moderation_preset_action_messages` VALUES ('14', '10', 'Impersonating', 'Impersonating other users is unacceptable according to uberHotel rules.');

-- ----------------------------
-- Table structure for `moderation_tickets`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_tickets`;
CREATE TABLE `moderation_tickets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` int(10) unsigned NOT NULL DEFAULT '0',
  `status` enum('5','4','3','2','1','0') NOT NULL DEFAULT '0',
  `reported_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `reportee_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `moderator_user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp` double NOT NULL DEFAULT '0',
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of moderation_tickets
-- ----------------------------

-- ----------------------------
-- Table structure for `navigator_event_search_categories`
-- ----------------------------
DROP TABLE IF EXISTS `navigator_event_search_categories`;
CREATE TABLE `navigator_event_search_categories` (
  `query` varchar(48) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`query`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of navigator_event_search_categories
-- ----------------------------
INSERT INTO `navigator_event_search_categories` VALUES ('Dating', '7');
INSERT INTO `navigator_event_search_categories` VALUES ('Debates & Discussion', '5');
INSERT INTO `navigator_event_search_categories` VALUES ('Earth Hour Gatherings', '4');
INSERT INTO `navigator_event_search_categories` VALUES ('Games', '3');
INSERT INTO `navigator_event_search_categories` VALUES ('Grand Openings', '6');
INSERT INTO `navigator_event_search_categories` VALUES ('Group Events', '9');
INSERT INTO `navigator_event_search_categories` VALUES ('Help Desk', '11');
INSERT INTO `navigator_event_search_categories` VALUES ('Jobs', '8');
INSERT INTO `navigator_event_search_categories` VALUES ('Parties & Music', '1');
INSERT INTO `navigator_event_search_categories` VALUES ('Performance', '10');
INSERT INTO `navigator_event_search_categories` VALUES ('Trading', '2');

-- ----------------------------
-- Table structure for `navigator_frontpage`
-- ----------------------------
DROP TABLE IF EXISTS `navigator_frontpage`;
CREATE TABLE `navigator_frontpage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `is_category` enum('1','0') NOT NULL DEFAULT '0',
  `category_autoexpand` enum('0','1') NOT NULL DEFAULT '0',
  `display_type` enum('details','banner') NOT NULL DEFAULT 'details',
  `name` varchar(64) NOT NULL DEFAULT '',
  `descr` varchar(255) NOT NULL DEFAULT '',
  `image_type` enum('external','internal') NOT NULL DEFAULT 'internal',
  `image_src` varchar(128) NOT NULL DEFAULT '',
  `banner_label` varchar(64) NOT NULL DEFAULT '',
  `order_num` int(11) NOT NULL DEFAULT '0',
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of navigator_frontpage
-- ----------------------------
INSERT INTO `navigator_frontpage` VALUES ('1', '0', '1', '0', '0', 'details', 'Welcome Lounge', 'Get a warm welcome to the hotel and meet new people.', 'internal', '', 'Welcome Lounge', '1', '1');
INSERT INTO `navigator_frontpage` VALUES ('2', '0', '0', '1', '1', 'details', 'Staff Picks', '', 'external', 'officialrooms_hq/staffpickfolder.gif', '', '100', '1');

-- ----------------------------
-- Table structure for `new_items`
-- ----------------------------
DROP TABLE IF EXISTS `new_items`;
CREATE TABLE `new_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tab_id` int(11) NOT NULL DEFAULT '1',
  `item_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of new_items
-- ----------------------------

-- ----------------------------
-- Table structure for `pets`
-- ----------------------------
DROP TABLE IF EXISTS `pets`;
CREATE TABLE `pets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `race` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `room_id` int(11) unsigned NOT NULL DEFAULT '0',
  `room_pos` varchar(16) NOT NULL DEFAULT '0|0|0',
  `timestamp` double NOT NULL DEFAULT '0',
  `experience` int(11) NOT NULL DEFAULT '0',
  `energy` int(11) NOT NULL DEFAULT '120',
  `happiness` int(11) NOT NULL DEFAULT '100',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7756 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pets
-- ----------------------------

-- ----------------------------
-- Table structure for `pet_races`
-- ----------------------------
DROP TABLE IF EXISTS `pet_races`;
CREATE TABLE `pet_races` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pet_type` int(11) NOT NULL DEFAULT '0',
  `data1` int(11) NOT NULL DEFAULT '0',
  `data2` int(11) NOT NULL DEFAULT '0',
  `data3` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pet_type` (`pet_type`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pet_races
-- ----------------------------
INSERT INTO `pet_races` VALUES ('1', '12', '0', '1', '0');
INSERT INTO `pet_races` VALUES ('2', '12', '1', '1', '0');
INSERT INTO `pet_races` VALUES ('3', '12', '2', '1', '0');
INSERT INTO `pet_races` VALUES ('4', '12', '3', '1', '0');
INSERT INTO `pet_races` VALUES ('5', '12', '4', '1', '0');
INSERT INTO `pet_races` VALUES ('6', '12', '5', '1', '0');
INSERT INTO `pet_races` VALUES ('7', '12', '6', '1', '0');
INSERT INTO `pet_races` VALUES ('8', '12', '7', '1', '0');
INSERT INTO `pet_races` VALUES ('9', '12', '8', '1', '0');
INSERT INTO `pet_races` VALUES ('21', '12', '9', '1', '0');

-- ----------------------------
-- Table structure for `pet_tricks`
-- ----------------------------
DROP TABLE IF EXISTS `pet_tricks`;
CREATE TABLE `pet_tricks` (
  `type` int(3) NOT NULL,
  `trick` varchar(32) NOT NULL,
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pet_tricks
-- ----------------------------
INSERT INTO `pet_tricks` VALUES ('11', 'rlx');
INSERT INTO `pet_tricks` VALUES ('11', 'wav');
INSERT INTO `pet_tricks` VALUES ('0', 'jmp');
INSERT INTO `pet_tricks` VALUES ('11', 'eyb');
INSERT INTO `pet_tricks` VALUES ('1', 'snf');
INSERT INTO `pet_tricks` VALUES ('2', 'snf');
INSERT INTO `pet_tricks` VALUES ('11', 'beg');
INSERT INTO `pet_tricks` VALUES ('11', 'dan');
INSERT INTO `pet_tricks` VALUES ('11', 'crk');
INSERT INTO `pet_tricks` VALUES ('0', 'lay');
INSERT INTO `pet_tricks` VALUES ('12', 'flm');
INSERT INTO `pet_tricks` VALUES ('12', 'trn');
INSERT INTO `pet_tricks` VALUES ('12', 'pla');
INSERT INTO `pet_tricks` VALUES ('12', 'rng');

-- ----------------------------
-- Table structure for `quests`
-- ----------------------------
DROP TABLE IF EXISTS `quests`;
CREATE TABLE `quests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(32) NOT NULL DEFAULT '',
  `series_number` int(11) NOT NULL DEFAULT '0',
  `goal_type` int(10) NOT NULL DEFAULT '0',
  `goal_data` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `reward` int(11) NOT NULL DEFAULT '10',
  `data_bit` varchar(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of quests
-- ----------------------------
INSERT INTO `quests` VALUES ('1', 'room_builder', '1', '0', '3', 'MOVEITEM', '10', '_2');
INSERT INTO `quests` VALUES ('2', 'social', '1', '8', '1', 'ENTEROTHERSROOM', '10', '_2');
INSERT INTO `quests` VALUES ('3', 'identity', '1', '14', '1', 'CHANGEFIGURE', '10', '_2');
INSERT INTO `quests` VALUES ('4', 'explore', '1', '17', '1936', 'FINDLIFEGUARDTOWER', '10', '_2');
INSERT INTO `quests` VALUES ('5', 'room_builder', '2', '1', '3', 'ROTATEITEM', '10', '');
INSERT INTO `quests` VALUES ('6', 'room_builder', '3', '2', '1', 'PLACEITEM', '10', '');
INSERT INTO `quests` VALUES ('7', 'room_builder', '4', '3', '1', 'PICKUPITEM', '10', '');
INSERT INTO `quests` VALUES ('8', 'room_builder', '5', '4', '2', 'SWITCHSTATE', '10', '');
INSERT INTO `quests` VALUES ('9', 'room_builder', '6', '5', '1', 'STACKITEM', '10', '');
INSERT INTO `quests` VALUES ('10', 'room_builder', '7', '6', '1', 'PLACEFLOOR', '10', '');
INSERT INTO `quests` VALUES ('11', 'room_builder', '8', '7', '1', 'PLACEWALLPAPER', '10', '_1');
INSERT INTO `quests` VALUES ('12', 'identity', '2', '15', '1', 'CHANGEMOTTO', '10', '');
INSERT INTO `quests` VALUES ('13', 'identity', '3', '16', '1', 'WEARBADGE', '10', '');
INSERT INTO `quests` VALUES ('14', 'social', '2', '9', '1', 'CHATWITHSOMEONE', '10', '');
INSERT INTO `quests` VALUES ('15', 'social', '3', '10', '1', 'REQUESTFRIEND', '10', '');
INSERT INTO `quests` VALUES ('16', 'social', '4', '11', '1', 'GIVERESPECT', '10', '');
INSERT INTO `quests` VALUES ('17', 'social', '5', '12', '1', 'DANCE', '10', '');
INSERT INTO `quests` VALUES ('18', 'social', '6', '13', '1', 'WAVE', '10', '');
INSERT INTO `quests` VALUES ('19', 'explore', '2', '17', '1948', 'SWIM', '10', '');
INSERT INTO `quests` VALUES ('20', 'explore', '3', '17', '1969', 'FINDSURFBOARD', '10', '');
INSERT INTO `quests` VALUES ('21', 'explore', '4', '17', '1956', 'FINDBEETLE', '10', '');
INSERT INTO `quests` VALUES ('22', 'explore', '5', '17', '1369', 'FINDNEONFLOOR', '10', '');
INSERT INTO `quests` VALUES ('23', 'explore', '6', '17', '1375', 'FINDDISCOBALL', '10', '');
INSERT INTO `quests` VALUES ('24', 'explore', '7', '17', '1019', 'FINDJUKEBOX', '10', '');
INSERT INTO `quests` VALUES ('25', 'explore', '8', '17', '2050', 'FINDBBGATE', '10', '');
INSERT INTO `quests` VALUES ('26', 'explore', '9', '17', '2040', 'FINDBBTILE', '10', '');
INSERT INTO `quests` VALUES ('27', 'explore', '10', '17', '2049', 'FINDBBTELEPORT', '10', '');
INSERT INTO `quests` VALUES ('28', 'explore', '11', '17', '2167', 'FINDFREEZEGATE', '10', '');
INSERT INTO `quests` VALUES ('29', 'explore', '12', '17', '2172', 'FINDFREEZESCOREBOARD', '10', '');
INSERT INTO `quests` VALUES ('30', 'explore', '13', '17', '2166', 'FINDFREEZEEXITTILE', '10', '');
INSERT INTO `quests` VALUES ('31', 'explore', '14', '17', '1413', 'ICESKATE', '10', '');
INSERT INTO `quests` VALUES ('32', 'explore', '15', '17', '2148', 'FINDTAGPOLE', '10', '');
INSERT INTO `quests` VALUES ('33', 'explore', '16', '17', '2199', 'ROLLERSKATE', '10', '');

-- ----------------------------
-- Table structure for `recycler_rewards`
-- ----------------------------
DROP TABLE IF EXISTS `recycler_rewards`;
CREATE TABLE `recycler_rewards` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `chance_level` int(11) NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of recycler_rewards
-- ----------------------------
INSERT INTO `recycler_rewards` VALUES ('1', '5', '1553');
INSERT INTO `recycler_rewards` VALUES ('2', '4', '1566');
INSERT INTO `recycler_rewards` VALUES ('3', '3', '1518');
INSERT INTO `recycler_rewards` VALUES ('4', '3', '1513');
INSERT INTO `recycler_rewards` VALUES ('5', '3', '1515');
INSERT INTO `recycler_rewards` VALUES ('6', '2', '1511');
INSERT INTO `recycler_rewards` VALUES ('7', '2', '1499');
INSERT INTO `recycler_rewards` VALUES ('8', '2', '1507');
INSERT INTO `recycler_rewards` VALUES ('9', '2', '1505');
INSERT INTO `recycler_rewards` VALUES ('10', '2', '1517');
INSERT INTO `recycler_rewards` VALUES ('11', '2', '1495');
INSERT INTO `recycler_rewards` VALUES ('12', '2', '2375');
INSERT INTO `recycler_rewards` VALUES ('13', '2', '2373');
INSERT INTO `recycler_rewards` VALUES ('14', '2', '2376');
INSERT INTO `recycler_rewards` VALUES ('15', '2', '1497');
INSERT INTO `recycler_rewards` VALUES ('16', '2', '1500');
INSERT INTO `recycler_rewards` VALUES ('17', '2', '1510');
INSERT INTO `recycler_rewards` VALUES ('18', '2', '1493');
INSERT INTO `recycler_rewards` VALUES ('19', '2', '1509');
INSERT INTO `recycler_rewards` VALUES ('20', '2', '1519');
INSERT INTO `recycler_rewards` VALUES ('21', '1', '1502');
INSERT INTO `recycler_rewards` VALUES ('22', '1', '1503');
INSERT INTO `recycler_rewards` VALUES ('23', '1', '1508');
INSERT INTO `recycler_rewards` VALUES ('24', '1', '1516');
INSERT INTO `recycler_rewards` VALUES ('25', '1', '1494');
INSERT INTO `recycler_rewards` VALUES ('26', '1', '1496');

-- ----------------------------
-- Table structure for `rights`
-- ----------------------------
DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `set_id` int(10) unsigned NOT NULL,
  `right_id` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rights
-- ----------------------------
INSERT INTO `rights` VALUES ('1', '0', 'login');
INSERT INTO `rights` VALUES ('2', '100', 'moderation_tool');
INSERT INTO `rights` VALUES ('3', '100', 'enter_locked_rooms');
INSERT INTO `rights` VALUES ('4', '50', 'enter_full_rooms');
INSERT INTO `rights` VALUES ('5', '10', 'club_regular');
INSERT INTO `rights` VALUES ('6', '20', 'club_vip');
INSERT INTO `rights` VALUES ('7', '100', 'room_rights');
INSERT INTO `rights` VALUES ('8', '200', 'room_rights_owner');
INSERT INTO `rights` VALUES ('9', '200', 'hotel_admin');
INSERT INTO `rights` VALUES ('10', '100', 'moderation_tickets');
INSERT INTO `rights` VALUES ('11', '100', 'cannot_ignore');
INSERT INTO `rights` VALUES ('12', '100', 'mute');
INSERT INTO `rights` VALUES ('13', '0', 'trade');

-- ----------------------------
-- Table structure for `rooms`
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('flat','public') NOT NULL DEFAULT 'flat',
  `owner_id` int(11) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(128) NOT NULL DEFAULT '',
  `pub_internal_name` varchar(64) NOT NULL DEFAULT '',
  `tags` varchar(65) NOT NULL DEFAULT '',
  `access_type` enum('password','doorbell','open') NOT NULL DEFAULT 'open',
  `password` varchar(64) NOT NULL DEFAULT '',
  `category` int(10) NOT NULL DEFAULT '0',
  `current_users` int(11) NOT NULL DEFAULT '0',
  `max_users` int(11) NOT NULL DEFAULT '25',
  `swfs` varchar(64) NOT NULL DEFAULT '',
  `score` int(11) NOT NULL DEFAULT '0',
  `icon` varchar(64) NOT NULL DEFAULT '1|0|1|4,1',
  `model` varchar(64) NOT NULL DEFAULT 'model_a',
  `allow_pets` enum('0','1') NOT NULL DEFAULT '1',
  `allow_pet_eating` enum('0','1') NOT NULL DEFAULT '0',
  `disable_blocking` enum('1','0') NOT NULL DEFAULT '1',
  `hide_walls` enum('0','1') NOT NULL DEFAULT '0',
  `thickness_wall` int(11) NOT NULL DEFAULT '0',
  `thickness_floor` int(11) NOT NULL DEFAULT '0',
  `decorations` varchar(128) NOT NULL DEFAULT 'landscape=0.0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rooms
-- ----------------------------

-- ----------------------------
-- Table structure for `room_models`
-- ----------------------------
DROP TABLE IF EXISTS `room_models`;
CREATE TABLE `room_models` (
  `id` varchar(64) NOT NULL,
  `type` enum('public','flat') NOT NULL DEFAULT 'flat',
  `heightmap` text NOT NULL,
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  `door_x` int(11) NOT NULL,
  `door_y` int(11) NOT NULL,
  `door_z` double NOT NULL,
  `door_dir` int(11) NOT NULL,
  `subscription_requirement` enum('2','1','0') NOT NULL,
  `max_users` int(11) NOT NULL DEFAULT '30',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room_models
-- ----------------------------
INSERT INTO `room_models` VALUES ('cr_kitchen', 'public', 'X0XXXX000XXXX000X0X\r\nX000000000000000000\r\nX000000000000000000\r\nX000000000000000XXX\r\nX00XXXX00XXXX000XXX\r\nX00XXXX00XXXX00XXXX\r\nX00000000000000XXXX\r\nX00000000000000XXXX\r\nX00000000000000XXXX\r\nX00XXXXXXXXXX00XXXX\r\nX00XXXXXXXXXX00XXXX\r\nX00XXXXXXXXXX000XXX\r\n0000000000000000XXX\r\n000000000000000XXXX\r\n000000000000000XXXX\r\n000XXX0000XXX00XXXX\r\n000XXX0000XXX00XXXX\r\n000000000000000XXXX\r\n000000000000000XXXX\r\n000000000000000XXXX\r\nXXXXXXX00XXXXXXXXXX\r\nXXXXXXX00XXXXXXXXXX\r\nXXXXXXX00XXXXXXXXXX', '1', '2', '29', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_a', 'flat', 'xxxxxxxxxxxx\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxx00000000\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '3', '5', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_b', 'flat', 'xxxxxxxxxxxx\r\nxxxxx0000000\r\nxxxxx0000000\r\nxxxxx0000000\r\nxxxxx0000000\r\nx00000000000\r\nx00000000000\r\nx00000000000\r\nx00000000000\r\nx00000000000\r\nx00000000000\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '0', '5', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_c', 'flat', 'xxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '4', '7', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_d', 'flat', 'xxxxxxxxxxxx\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxxxxxxxxxxx', '1', '4', '7', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_e', 'flat', 'xxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxx0000000000\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '1', '5', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_f', 'flat', 'xxxxxxxxxxxx\r\nxxxxxxx0000x\r\nxxxxxxx0000x\r\nxxx00000000x\r\nxxx00000000x\r\nxxx00000000x\r\nxxx00000000x\r\nx0000000000x\r\nx0000000000x\r\nx0000000000x\r\nx0000000000x\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '2', '5', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_g', 'flat', 'xxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxx00000\r\nxxxxxxx00000\r\nxxxxxxx00000\r\nxx1111000000\r\nxx1111000000\r\nxx1111000000\r\nxx1111000000\r\nxx1111000000\r\nxxxxxxx00000\r\nxxxxxxx00000\r\nxxxxxxx00000\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '1', '7', '1', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_h', 'flat', 'xxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxx111111x\r\nxxxxx111111x\r\nxxxxx111111x\r\nxxxxx111111x\r\nxxxxx111111x\r\nxxxxx000000x\r\nxxxxx000000x\r\nxxx00000000x\r\nxxx00000000x\r\nxxx00000000x\r\nxxx00000000x\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx\r\nxxxxxxxxxxxx', '1', '4', '4', '1', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_i', 'flat', 'xxxxxxxxxxxxxxxxx\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nx0000000000000000\r\nxxxxxxxxxxxxxxxxx', '1', '0', '10', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_j', 'flat', 'xxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxx0000000000\r\nxxxxxxxxxxx0000000000\r\nxxxxxxxxxxx0000000000\r\nxxxxxxxxxxx0000000000\r\nxxxxxxxxxxx0000000000\r\nxxxxxxxxxxx0000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx0000000000xxxxxxxxxx\r\nx0000000000xxxxxxxxxx\r\nx0000000000xxxxxxxxxx\r\nx0000000000xxxxxxxxxx\r\nx0000000000xxxxxxxxxx\r\nx0000000000xxxxxxxxxx\r\nxxxxxxxxxxxxxxxxxxxxx', '1', '0', '10', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_k', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxxxxxxxx00000000\r\nxxxxxxxxxxxxxxxxx00000000\r\nxxxxxxxxxxxxxxxxx00000000\r\nxxxxxxxxxxxxxxxxx00000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nx000000000000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '13', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_l', 'flat', 'xxxxxxxxxxxxxxxxxxxxx\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nx00000000xxxx00000000\r\nxxxxxxxxxxxxxxxxxxxxx', '1', '5', '14', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_m', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nx0000000000000000000000000000\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxx00000000xxxxxxxxxx\r\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '15', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_n', 'flat', 'xxxxxxxxxxxxxxxxxxxxx\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx000000xxxxxxxx000000\r\nx000000x000000x000000\r\nx000000x000000x000000\r\nx000000x000000x000000\r\nx000000x000000x000000\r\nx000000x000000x000000\r\nx000000x000000x000000\r\nx000000xxxxxxxx000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nx00000000000000000000\r\nxxxxxxxxxxxxxxxxxxxxx', '1', '0', '16', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('model_o', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx11111111xxxx\r\nxxxxxxxxxxxxx00000000xxxx\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nx111111100000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxx0000000000000000\r\nxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '18', '1', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_p', 'flat', 'xxxxxxxxxxxxxxxxxxx\r\nxxxxxxx222222222222\r\nxxxxxxx222222222222\r\nxxxxxxx222222222222\r\nxxxxxxx222222222222\r\nxxxxxxx222222222222\r\nxxxxxxx222222222222\r\nxxxxxxx22222222xxxx\r\nxxxxxxx11111111xxxx\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx222221111111111111\r\nx2222xx11111111xxxx\r\nx2222xx00000000xxxx\r\nx2222xx000000000000\r\nx2222xx000000000000\r\nx2222xx000000000000\r\nx2222xx000000000000\r\n22222xx000000000000\r\nx2222xx000000000000\r\nxxxxxxxxxxxxxxxxxxx', '1', '0', '23', '2', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_q', 'flat', 'xxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxx22222222\r\nxxxxxxxxxxx22222222\r\nxxxxxxxxxxx22222222\r\nxxxxxxxxxxx22222222\r\nxxxxxxxxxxx22222222\r\nxxxxxxxxxxx22222222\r\nx222222222222222222\r\nx222222222222222222\r\nx222222222222222222\r\nx222222222222222222\r\nx222222222222222222\r\nx222222222222222222\r\nx2222xxxxxxxxxxxxxx\r\nx2222xxxxxxxxxxxxxx\r\nx2222211111xx000000\r\nx222221111110000000\r\nx222221111110000000\r\nx2222211111xx000000\r\nxx22xxx1111xxxxxxxx\r\nxx11xxx1111xxxxxxxx\r\nx1111xx1111xx000000\r\nx1111xx111110000000\r\nx1111xx111110000000\r\nx1111xx1111xx000000\r\nxxxxxxxxxxxxxxxxxxx', '1', '10', '4', '2', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_r', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxx33333333333333\r\nxxxxxxxxxxx33333333333333\r\nxxxxxxxxxxx33333333333333\r\nxxxxxxxxxx333333333333333\r\nxxxxxxxxxxx33333333333333\r\nxxxxxxxxxxx33333333333333\r\nxxxxxxx333333333333333333\r\nxxxxxxx333333333333333333\r\nxxxxxxx333333333333333333\r\nxxxxxxx333333333333333333\r\nxxxxxxx333333333333333333\r\nxxxxxxx333333333333333333\r\nx4444433333xxxxxxxxxxxxxx\r\nx4444433333xxxxxxxxxxxxxx\r\nx44444333333222xx000000xx\r\nx44444333333222xx000000xx\r\nxxx44xxxxxxxx22xx000000xx\r\nxxx33xxxxxxxx11xx000000xx\r\nxxx33322222211110000000xx\r\nxxx33322222211110000000xx\r\nxxxxxxxxxxxxxxxxx000000xx\r\nxxxxxxxxxxxxxxxxx000000xx\r\nxxxxxxxxxxxxxxxxx000000xx\r\nxxxxxxxxxxxxxxxxx000000xx\r\nxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '10', '4', '3', '2', '1', '30');
INSERT INTO `room_models` VALUES ('model_rugtest', 'flat', '00000\r\n00000\r\n00000', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_t', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx\r\nx222222222222222222222222222x\r\nx222222222222222222222222222x\r\n2222222222222222222222222222x\r\nx222222222222222222222222222x\r\nx2222xxxxxx222222xxxxxxx2222x\r\nx2222xxxxxx111111xxxxxxx2222x\r\nx2222xx111111111111111xx2222x\r\nx2222xx111111111111111xx2222x\r\nx2222xx11xxx1111xxxx11xx2222x\r\nx2222xx11xxx0000xxxx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx22222111x00000000xx11xx2222x\r\nx2222xx11xxxxxxxxxxx11xx2222x\r\nx2222xx11xxxxxxxxxxx11xx2222x\r\nx2222xx111111111111111xx2222x\r\nx2222xx111111111111111xx2222x\r\nx2222xxxxxxxxxxxxxxxxxxx2222x\r\nx2222xxxxxxxxxxxxxxxxxxx2222x\r\nx222222222222222222222222222x\r\nx222222222222222222222222222x\r\nx222222222222222222222222222x\r\nx222222222222222222222222222x\r\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_u', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxx\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\n11111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nx1111100000000000000000x\r\nxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '17', '1', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_w', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxxxx\r\nx2222xx1111111111xx11111111\r\nx2222xx1111111111xx11111111\r\n222222111111111111111111111\r\nx22222111111111111111111111\r\nx22222111111111111111111111\r\nx22222111111111111111111111\r\nx2222xx1111111111xx11111111\r\nx2222xx1111111111xx11111111\r\nx2222xx1111111111xxxx1111xx\r\nx2222xx1111111111xxxx0000xx\r\nxxxxxxx1111111111xx00000000\r\nxxxxxxx1111111111xx00000000\r\nx22222111111111111000000000\r\nx22222111111111111000000000\r\nx22222111111111111000000000\r\nx22222111111111111000000000\r\nx2222xx1111111111xx00000000\r\nx2222xx1111111111xx00000000\r\nx2222xxxx1111xxxxxxxxxxxxxx\r\nx2222xxxx0000xxxxxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx\r\nx2222x0000000000xxxxxxxxxxx', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_x', 'flat', 'xxxxxxxxxxxxxxxxxxxx\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nxxx00xxx0000xxx00xxx\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\n0000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000x0000x000000x\r\nx000000xxxxxx000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nx000000000000000000x\r\nxxxxxxxxxxxxxxxxxxxx', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_y', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxx\r\nx00000000xx0000000000xx0000x\r\nx00000000xx0000000000xx0000x\r\n000000000xx0000000000xx0000x\r\nx00000000xx0000000000xx0000x\r\nx00000000xx0000xx0000xx0000x\r\nx00000000xx0000xx0000xx0000x\r\nx00000000xx0000xx0000000000x\r\nx00000000xx0000xx0000000000x\r\nxxxxx0000xx0000xx0000000000x\r\nxxxxx0000xx0000xx0000000000x\r\nxxxxx0000xx0000xxxxxxxxxxxxx\r\nxxxxx0000xx0000xxxxxxxxxxxxx\r\nx00000000xx0000000000000000x\r\nx00000000xx0000000000000000x\r\nx00000000xx0000000000000000x\r\nx00000000xx0000000000000000x\r\nx0000xxxxxxxxxxxxxxxxxx0000x\r\nx0000xxxxxxxxxxxxxxxxxx0000x\r\nx00000000000000000000000000x\r\nx00000000000000000000000000x\r\nx00000000000000000000000000x\r\nx00000000000000000000000000x\r\nxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('model_z', 'flat', 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\r\nxxxxxxxxxxx00000000000000000000\r\nxxxxxxxxxxx00000000000000000000\r\nxxxxxxxxxxx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\n000000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nx00000000xx00000000000000000000\r\nxxxxxxxxxxx00000000000000000000\r\nxxxxxxxxxxx00000000000000000000\r\nxxxxxxxxxxx00000000000000000000\r\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx', '1', '0', '0', '0', '2', '2', '30');
INSERT INTO `room_models` VALUES ('newbie_lobby', 'public', 'xxxxxxxxxxxxxxxx000000\r\nxxxxx0xxxxxxxxxx000000\r\nxxxxx00000000xxx000000\r\nxxxxx000000000xx000000\r\n0000000000000000000000\r\n0000000000000000000000\r\n0000000000000000000000\r\n0000000000000000000000\r\n0000000000000000000000\r\nxxxxx000000000000000xx\r\nxxxxx000000000000000xx\r\nx0000000000000000000xx\r\nx0000000000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxxxx0000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxxxx000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxxx00000000000xxxxx\r\nxxxxx000000000000xxxxx\r\nxxxxx000000000000xxxxx', '1', '2', '11', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('oscar_village', 'flat', 'XX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000XXXXXXXXX\r\nXX000000000XXXXXXXXX\r\nXX000000000XXXXXXXXX\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000X00000000\r\nXX000000000XXXXXXXXX\r\nXX000000000XXXXXXXXX\r\nXX000000000XXXXXXXXX\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXX000000000000000000\r\nXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXX', '1', '2', '29', '0', '2', '0', '30');
INSERT INTO `room_models` VALUES ('park_b', 'public', '0000x0000000\r\n0000xx000000\r\n000000000000\r\n00000000000x\r\n000000000000\r\n00x0000x0000', '1', '11', '2', '0', '4', '0', '30');
INSERT INTO `room_models` VALUES ('rooftop_2', 'public', 'x0000x000\r\nxxxxxx000\r\n000000000\r\n000000000\r\n000000000\r\n000000000\r\n000000000\r\n000000000\r\n000000000\r\n000000000\r\nxxx000xxx\r\nxxx000xxx', '1', '4', '9', '0', '0', '0', '30');
INSERT INTO `room_models` VALUES ('theater', 'public', 'XXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXX111111111XXXXXXX\r\nXXXXXXX11111111100000XX\r\nXXXX00X11111111100000XX\r\nXXXX00x11111111100000XX\r\n4XXX00X11111111100000XX\r\n4440000XXXXXXXXX00000XX\r\n444000000000000000000XX\r\n4XX000000000000000000XX\r\n4XX0000000000000000000X\r\n44400000000000000000000\r\n44400000000000000000000\r\n44X00000000000000000000\r\n44X11111111111111111000\r\n44X11111111111111111000\r\n33X11111111111111111000\r\n22X11111111111111111000\r\n22X11111111111111111000\r\n22X11111111111111111000\r\n22X11111111111111111000\r\n22X11111111111111111000\r\n22211111111111111111000\r\n22211111111111111111000\r\nXXXXXXXXXXXXXXXXXXXX00X\r\nXXXXXXXXXXXXXXXXXXXX00X', '1', '20', '27', '0', '0', '0', '30');
INSERT INTO `room_models` VALUES ('uber_offices', 'flat', 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\nXXXXXXXX0000000000000000XXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\n000000000000000000000000XXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\r\nXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX', '1', '6', '15', '0', '4', '0', '30');

-- ----------------------------
-- Table structure for `room_rights`
-- ----------------------------
DROP TABLE IF EXISTS `room_rights`;
CREATE TABLE `room_rights` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_id` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room_rights
-- ----------------------------

-- ----------------------------
-- Table structure for `room_visits`
-- ----------------------------
DROP TABLE IF EXISTS `room_visits`;
CREATE TABLE `room_visits` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `timestamp_entered` double NOT NULL DEFAULT '0',
  `timestamp_left` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of room_visits
-- ----------------------------

-- ----------------------------
-- Table structure for `server_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `server_statistics`;
CREATE TABLE `server_statistics` (
  `skey` varchar(64) NOT NULL,
  `sval` varchar(64) NOT NULL,
  PRIMARY KEY (`skey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of server_statistics
-- ----------------------------
INSERT INTO `server_statistics` VALUES ('active_connections', '0');

-- ----------------------------
-- Table structure for `songs`
-- ----------------------------
DROP TABLE IF EXISTS `songs`;
CREATE TABLE `songs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `artist` varchar(32) NOT NULL,
  `song_data` text NOT NULL,
  `length` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of songs
-- ----------------------------
INSERT INTO `songs` VALUES ('1', 'The Ballad of Bonnie Blonde', 'Pixel! at the Disco', '1:371,8;374,4;378,4;0,4;378,4;0,4;377,4;378,4;0,6;371,4;0,4;370,3;377,2;0,7:2:353,24;358,4;363,4;353,10;367,4;353,4;367,4;353,8:3:0,4;291,2;365,2;0,2;365,2;377,2;365,2;377,2;365,2;377,2;0,2;359,4;352,4;357,1;0,1;365,2;0,2;292,4;0,3;357,1;292,4;0,3;357,1;292,4;296,4:4:0,2;368,22;354,4;368,26;361,8:', '124');
INSERT INTO `songs` VALUES ('2', 'Push the Call for Help', 'BanzaiBabes', '1:317,6;318,4;319,4;317,4;319,4;0,2:2:0,2;316,4;0,4;316,4;0,4;316,4;0,2:3:0,6;321,4;323,4;322,10:4:0,18;321,2;324,2;0,2:', '48');
INSERT INTO `songs` VALUES ('3', 'Monotone Hotel Sounds', 'Doorman Frank', '1:4,24:2:2,24:3:0,24:4:0,24:', '48');
INSERT INTO `songs` VALUES ('4', 'Haven\'t Friend Request You Yet', 'Micheal Bauble', '1:280,4;281,4;282,4;283,4;284,4;285,4;286,4;287,4;288,4:2:0,36:3:0,36:4:0,36:', '72');
INSERT INTO `songs` VALUES ('5', 'Sounds That Fit Double Rainbows', 'Kallomies', '1:200,12;199,3;201,1;200,28:2:0,2;190,1;0,1;191,1;0,1;192,1;0,1;190,2;191,1;192,1;190,2;0,1;193,2;190,2;191,1;0,1;190,1;192,2;0,1;191,2;178,2;0,1;178,2;0,1;178,2;0,2;177,2;0,1;176,4:3:0,8;176,2;0,1;177,2;0,3;179,2;0,2;177,2;0,2;176,2;0,1;178,6;0,1;178,2;0,2;177,4;176,2:4:0,8;197,16;0,20:', '88');
INSERT INTO `songs` VALUES ('6', 'Gold Coin Digger', 'Kayne Quest', '1:104,10;102,8;104,4;102,8;104,4:2:0,2;181,8;182,8;181,4;182,8;130,2;106,2:3:0,2;105,2;106,2;186,3;187,1;185,1;184,1;185,1;184,1;185,1;184,1;185,1;187,1;186,3;187,1;185,1;184,1;185,1;184,1;185,1;184,1;185,1;184,1;72,1;100,2;0,1:4:0,4;103,6;133,1;101,1;133,1;101,1;133,1;101,1;133,1;101,1;103,4;133,1;101,1;133,1;101,1;133,1;101,1;133,1;101,1;105,2;101,1;0,1:', '68');
INSERT INTO `songs` VALUES ('7', 'Too Lost In Lido', 'BanzaiBabes', '1:317,4;408,7;0,1;410,16;413,4;406,4;410,8;412,4:2:0,2;321,2;443,22;91,2;317,8;443,8;412,2;0,2:3:0,3;320,2;0,7;414,4;445,4;412,2;323,2;412,4;96,2;412,2;414,4;445,7;448,1;317,4:4:0,3;324,2;0,6;448,1;0,6;96,2;322,4;96,2;99,2;322,4;412,2;0,2;322,2;96,2;322,2;0,1;324,2;0,3:', '96');
INSERT INTO `songs` VALUES ('8', 'Pixelrazzi', 'Lady BlaBla', '1:0,3;167,1;163,2;0,2;142,2;163,2;142,2;163,2;142,2;163,2;142,2;0,1;88,1;142,2;163,2;142,2;163,2;142,2;163,2;142,2;163,2:2:89,16;0,2;143,4;119,4;143,4;89,2;119,4;143,4:3:0,3;121,2;0,1;164,2;140,8;141,6;0,1;168,1;141,16:4:0,2;139,2;123,4;143,8;144,2;89,2;144,2;0,1;90,1;144,2;89,2;0,2;89,2;144,2;89,2;0,2;89,2:', '80');
INSERT INTO `songs` VALUES ('9', 'Touch the Skyscraper', 'Kayne Quest', '1:274,4;275,4;276,8;274,4;276,4;274,4:2:0,4;278,4;279,4;273,12;277,3;0,1:3:0,4;429,2;0,4;430,2;429,2;340,2;342,4;429,2;261,2;342,4:4:0,2;340,2;0,3;429,2;0,1;259,2;271,4;254,12:', '56');
INSERT INTO `songs` VALUES ('10', 'About VIP Now', 'BanzaiBabes', '1:152,20;146,1;0,1;152,4;151,4;152,20;153,4:2:0,8;145,12;146,1;0,1;145,4;0,1;151,2;0,1;145,20;0,1;150,2;0,1:3:0,10;150,2;146,1;0,1;150,2;146,1;0,1;150,2;146,1;0,7;151,2;0,2;150,2;146,1;0,1;150,2;146,1;0,1;150,2;0,1;146,1;0,1;146,1;0,1;146,3;0,4:4:0,4;148,2;147,2;148,2;147,2;148,2;147,2;148,2;147,2;148,4;147,2;148,6;147,2;148,2;147,2;148,2;147,2;148,2;147,2;148,2;147,2;0,4:', '108');
INSERT INTO `songs` VALUES ('11', 'The Good Trade', 'Kayne Quest', '1:108,4;135,8;130,2;108,2;135,8;127,28:2:0,3;131,9;104,2;0,2;131,8;108,4;102,4;0,8;92,6;0,6:3:134,4;140,8;0,1;133,1;136,2;140,6;0,10;143,16;108,4:4:0,2;104,2;0,1;133,1;0,3;133,1;134,4;0,1;104,2;133,1;0,3;133,1;0,24;136,2;0,4:', '104');
INSERT INTO `songs` VALUES ('12', 'I Write Bans not Tragedies', 'Pixel! at the Disco', '1:248,4;247,4;252,4;251,8;245,4;250,4;252,4:2:359,4;250,4;359,4;345,8;0,4;359,8:3:0,3;347,1;359,4;352,8;342,4;350,4;342,4;350,4:4:0,3;357,1;334,4;246,4;343,12;334,4;340,2;0,1;347,1:', '64');
INSERT INTO `songs` VALUES ('13', 'Furni Face', 'Lady BlaBla', '1:379,4;45,4;0,1;205,2;42,5;37,4;384,2;41,4;42,5;0,2:2:0,3;199,3;0,1;383,3;519,4;515,8;519,8;39,2;0,1:3:0,2;205,2;382,4;522,2;516,12;518,8;0,3:4:0,4;386,2;0,2;43,1;0,1;207,3;202,1;520,8;44,2;0,2;520,4;207,3:', '66');
INSERT INTO `songs` VALUES ('14', 'Habbowood', 'Micheal Bauble', '1:280,4;265,4;264,4;263,8;0,16:2:262,4;263,8;266,4;267,4;264,12;262,4:3:0,4;268,8;269,4;270,4;268,8;282,4;285,4:4:0,20;74,4;75,3;81,3;0,6:', '72');
INSERT INTO `songs` VALUES ('15', 'Party Trax', 'Aerokid', '1:12,16;3,4;19,8;0,2;29,8;0,16:2:13,4;14,4;10,8;0,4;2,8;0,1;33,1;32,18;16,2;32,2;16,2:3:0,2;15,1;17,1;5,4;7,2;24,1;8,1;4,4;0,2;24,1;6,1;0,4;22,4;0,2;28,4;30,4;31,2;16,2;31,2;16,2;20,1;21,1;20,1;21,1;20,1;21,1;20,1;21,1:4:18,2;0,2;10,4;5,22;35,2;0,20;24,1;17,1:', '100');
INSERT INTO `songs` VALUES ('16', 'Who Dares Stacks', 'Rage Against the Fuse', '1:255,4;310,7;0,9;310,14;0,4:2:0,3;309,1;308,7;309,1;308,7;309,1;308,7;309,1;308,7;309,1;0,2:3:0,4;162,7;0,1;162,7;0,1;162,15;0,3:4:0,6;135,4;135,4;135,4;0,2;135,4;135,4;135,4;135,4;0,2:5:0,14;155,2;0,2;155,2;314,1;315,1;314,1;315,1;314,1;315,1;314,1;0,1;314,1;315,1;314,1;315,1;314,1;315,1;314,1;315,1;0,2:6:0,12;311,1;0,1;311,1;0,1;311,1;0,1;311,1;0,1;311,1;0,5;155,2;311,1;0,1;311,1;0,1;311,1;0,3;311,1;0,1:', '76');

-- ----------------------------
-- Table structure for `static_objects`
-- ----------------------------
DROP TABLE IF EXISTS `static_objects`;
CREATE TABLE `static_objects` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `position` varchar(8) NOT NULL DEFAULT '0|0',
  `height` int(11) NOT NULL DEFAULT '0',
  `rotation` int(11) DEFAULT '0',
  `is_seat` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of static_objects
-- ----------------------------

-- ----------------------------
-- Table structure for `tags`
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `tag` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tags
-- ----------------------------

-- ----------------------------
-- Table structure for `user_achievements`
-- ----------------------------
DROP TABLE IF EXISTS `user_achievements`;
CREATE TABLE `user_achievements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `group_id` varchar(255) NOT NULL DEFAULT '',
  `level` int(11) NOT NULL DEFAULT '0',
  `progress` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_achievements
-- ----------------------------

-- ----------------------------
-- Table structure for `user_quests`
-- ----------------------------
DROP TABLE IF EXISTS `user_quests`;
CREATE TABLE `user_quests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL DEFAULT '0',
  `quest_id` int(10) unsigned NOT NULL DEFAULT '0',
  `progress` int(11) NOT NULL DEFAULT '0',
  `is_current` enum('0','1') NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_quests
-- ----------------------------

-- ----------------------------
-- Table structure for `user_subscriptions`
-- ----------------------------
DROP TABLE IF EXISTS `user_subscriptions`;
CREATE TABLE `user_subscriptions` (
  `user_id` int(10) unsigned NOT NULL,
  `subscription_level` enum('2','1','0') NOT NULL DEFAULT '0',
  `timestamp_created` double(11,0) NOT NULL DEFAULT '0',
  `timestamp_expire` double(11,0) NOT NULL DEFAULT '0',
  `past_time_hc` double NOT NULL DEFAULT '0' COMMENT '0',
  `past_time_vip` double NOT NULL DEFAULT '0' COMMENT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_subscriptions
-- ----------------------------

-- ----------------------------
-- Table structure for `vouchers`
-- ----------------------------
DROP TABLE IF EXISTS `vouchers`;
CREATE TABLE `vouchers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL DEFAULT '',
  `value_credits` int(11) NOT NULL DEFAULT '0',
  `value_pixels` int(11) DEFAULT '0',
  `value_furni` varchar(64) DEFAULT '',
  `uses` int(11) NOT NULL DEFAULT '1',
  `enabled` enum('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vouchers
-- ----------------------------

-- ----------------------------
-- Table structure for `wardrobe`
-- ----------------------------
DROP TABLE IF EXISTS `wardrobe`;
CREATE TABLE `wardrobe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `slot_id` int(11) NOT NULL DEFAULT '0',
  `figure` varchar(255) NOT NULL DEFAULT '',
  `gender` enum('F','M') NOT NULL DEFAULT 'M',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wardrobe
-- ----------------------------




INSERT INTO `badge_definitions` (`id`, `code`, `rights_sets`) VALUES
(34, 'ACH_Spr1', '');

INSERT INTO `achievements` (`id`, `group_name`, `category`, `level`, `reward_pixels`, `reward_points`, `progress_needed`) VALUES
(26, 'ACH_Spr', 'room_builder', 1, 100, 35, 1);