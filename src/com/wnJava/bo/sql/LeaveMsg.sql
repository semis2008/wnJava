CREATE TABLE `leavemsg` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `msg` varchar(200) NOT NULL,
  `leave_time` datetime NOT NULL,
  `visited_user_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT '0',
  `user_photo` varchar(50) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8