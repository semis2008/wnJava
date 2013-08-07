CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `reg_time` datetime DEFAULT NULL,
  `logon_time` datetime DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `user_level` varchar(20) NOT NULL DEFAULT '1' COMMENT '1：注册会员，2：管理员，3：创始人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8