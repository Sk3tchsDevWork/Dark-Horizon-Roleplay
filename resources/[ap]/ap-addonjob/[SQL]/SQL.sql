CREATE TABLE IF NOT EXISTS `ap_addonapplications` (
  `applicationID` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `ap_addonjob` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enable` varchar(50) DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `boss_rank` varchar(50) DEFAULT NULL,
  `coords` longtext DEFAULT '[]',
  `ped` varchar(50) DEFAULT NULL,
  `webhook` varchar(200) DEFAULT NULL,
  `management` longtext DEFAULT '[]',
  `appointments` longtext DEFAULT '[]',
  `applications` longtext DEFAULT '[]',
  `template` longtext DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;