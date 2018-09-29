CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) NOT NULL,
  `jail_time` int(10) NOT NULL,
  `jail_purchased` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
)