CREATE TABLE `diary_reply` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `diary_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(50) NOT NULL,
  `reply` varchar(500) NOT NULL,
  `email` varchar(200) NOT NULL,
  `website` varchar(200) DEFAULT NULL,
  `reply_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `parent_name` varchar(50) DEFAULT NULL,
  `parent_id` bigint(20) NOT NULL DEFAULT '0',
  `user_photo` varchar(50) DEFAULT NULL,
  `type` int(10) NOT NULL DEFAULT '0' COMMENT '0:游客；1：会员',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8