CREATE TABLE IF NOT EXISTS `ap_appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(100) DEFAULT NULL,
  `name` tinytext DEFAULT NULL,
  `appData` longtext DEFAULT NULL,
  `type` varchar(60) DEFAULT NULL,
  `state` int(11) DEFAULT 0,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ap_dlcsettings` (
  `script` varchar(60) DEFAULT 'SCRIPT',
  `settings` longtext DEFAULT '{}',
  `other` longtext DEFAULT '{}',
  `id_storage` longtext NOT NULL DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `ap_dlcsettings` (`script`, `settings`, `other`, `id_storage`) VALUES
	('ap_voting', '{"voteState":0,"time":0,"currentType":0,"funds":1000,"endDate":"0 days, 0 hours, and 0 minutes."}', '{"Housing":0.2,"Income":0.15,"Vehicle":0.2,"Item":0.2,"Business":0.15}', '[]');

CREATE TABLE IF NOT EXISTS `ap_lawvoting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `fors` int(11) DEFAULT NULL,
  `against` int(11) DEFAULT NULL,
  `date` int(11) DEFAULT NULL,
  `storage` longtext DEFAULT '{}',
  `state` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ap_tax` (
  `business` varchar(60) DEFAULT 'JOB NAME',
  `label` varchar(60) DEFAULT 'JOB LABEL',
  `amount_owed` int(11) DEFAULT 0,
  `total_tax_paid` int(11) DEFAULT 0,
  `pay_timer` int(11) DEFAULT 0,
  `owner` varchar(60) DEFAULT 'COMPANY OWNER',
  `base_tax` int(11) DEFAULT NULL,
  `grants` longtext DEFAULT 'nil'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

CREATE TABLE IF NOT EXISTS `ap_voting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `name` varchar(70) DEFAULT NULL,
  `age` text DEFAULT NULL,
  `shortDescription` mediumtext DEFAULT NULL,
  `whyDoYouWantToBeACandidate` longtext DEFAULT NULL,
  `WhatYoullBringToTheCity` longtext DEFAULT NULL,
  `denied` longtext DEFAULT 'N/A',
  `votes` int(10) DEFAULT NULL,
  `state` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
