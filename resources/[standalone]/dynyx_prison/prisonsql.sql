CREATE TABLE IF NOT EXISTS `dynyx_prisoners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sentence` bigint(20) DEFAULT NULL,
  `charges` text NOT NULL,
  `serviceType` varchar(50) DEFAULT NULL,
  `lifer` tinyint(1) DEFAULT 0,
  `timeRemaining` bigint(20) DEFAULT NULL,
  `isVisitable` tinyint(1) DEFAULT 1,
  `hasEscaped` tinyint(1) DEFAULT 0,
  `jailed_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

CREATE TABLE IF NOT EXISTS `dynyx_prisonitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `items` longtext NOT NULL,
  `prison_money` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;
