DROP TABLE IF EXISTS av_gangs;

CREATE TABLE IF NOT EXISTS `av_gangs` (
  `identifier` varchar(50) DEFAULT NULL,
  `playerName` varchar(50) DEFAULT NULL,
  `isBoss` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `photo` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE av_gangs 
ADD COLUMN rank VARCHAR(50) DEFAULT '',
ADD COLUMN joined VARCHAR(50) DEFAULT '',
ADD COLUMN permissions LONGTEXT DEFAULT '[]';