CREATE TABLE IF NOT EXISTS `recyclers` (
    `recyclerId` VARCHAR(255) NOT NULL,
    `isActive` TINYINT(1) NOT NULL DEFAULT '0',
    `startTime` INT(11) NOT NULL,
    `endTime` INT(11) NOT NULL,
    `coords` varchar(255) NOT NULL,
    `model` varchar(255) NOT NULL,
    PRIMARY KEY (`recyclerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
