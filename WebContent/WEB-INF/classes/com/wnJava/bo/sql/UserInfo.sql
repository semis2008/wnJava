CREATE TABLE `user_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `rel_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `gender` int(10) DEFAULT NULL COMMENT '性别：1：男，2：女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `home_province` varchar(20) DEFAULT NULL COMMENT '所在地',
  `hobby` varchar(50) DEFAULT NULL COMMENT '兴趣，用空格隔开',
  `contact` varchar(50) DEFAULT NULL COMMENT '联系方式：phone_123123123123或qq_123123123或msn_123123123',
  `public_info` varchar(50) DEFAULT NULL COMMENT '公开展示信息，为公开字段的字段名和：birthday_hobby_...',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8