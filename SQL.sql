CREATE DATABASE IF NOT EXISTS `roleplay` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `roleplay`;

CREATE TABLE IF NOT EXISTS `apartments` (
  `id` int(11) DEFAULT NULL,
  `identifier` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `modifications` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `garage` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `apartment_sessions` (
  `owner` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `players` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `cooldowns` (
  `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `cooldown` bigint(20) DEFAULT NULL,
  `timestamp` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `drug_farms` (
  `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `task` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `tasksLeft` int(11) DEFAULT NULL,
  `delay` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `garages` (
  `identifier` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `jail` (
  `identifier` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `jail_time` int(10) NOT NULL,
  `jail_purchased` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `user_vehicles` (
  `identifier` text COLLATE utf8mb4_bin,
  `plate` text COLLATE utf8mb4_bin,
  `model` text COLLATE utf8mb4_bin,
  `properties` text COLLATE utf8mb4_bin,
  `impounded` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;