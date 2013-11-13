CREATE TABLE `loverInfo` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `gender` int(10) DEFAULT NULL,
  `birthday` datetime DEFAULT NULL,
  `meetTime` datetime DEFAULT NULL,
  `loveTime` datetime DEFAULT NULL,
  `marriageTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8