CREATE TABLE `timeNode` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `weather` int(10) DEFAULT NULL,
  `dress` varchar(50) DEFAULT NULL,
  `mood` varchar(100) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `photoIds` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8