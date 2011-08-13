/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50510
Source Host           : localhost:3306
Source Database       : snowdb

Target Server Type    : MYSQL
Target Server Version : 50510
File Encoding         : 65001

Date: 2011-08-12 14:26:19
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
-- Table structure for `bots_speech`
-- ----------------------------
DROP TABLE IF EXISTS `bots_speech`;
CREATE TABLE `bots_speech` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bot_id` int(10) unsigned NOT NULL,
  `message` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
-- Table structure for `favorites`
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `room_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

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
-- Table structure for `moderation_preset_action_categories`
-- ----------------------------
DROP TABLE IF EXISTS `moderation_preset_action_categories`;
CREATE TABLE `moderation_preset_action_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caption` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

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
-- Table structure for `navigator_event_search_categories`
-- ----------------------------
DROP TABLE IF EXISTS `navigator_event_search_categories`;
CREATE TABLE `navigator_event_search_categories` (
  `query` varchar(48) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`query`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=7755 DEFAULT CHARSET=utf8;

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
-- Table structure for `pet_tricks`
-- ----------------------------
DROP TABLE IF EXISTS `pet_tricks`;
CREATE TABLE `pet_tricks` (
  `type` int(3) NOT NULL,
  `trick` varchar(32) NOT NULL,
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=608 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;