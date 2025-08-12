CREATE TABLE IF NOT EXISTS `dynyx_crafting` (
  `coords` longtext DEFAULT NULL,
  `rot` longtext DEFAULT NULL,
  `bench` varchar(50) DEFAULT NULL,
  `lifetime` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=ARMSCII8_BIN;

CREATE TABLE IF NOT EXISTS `dynyx_crafting_levels` (
  `identifier` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;