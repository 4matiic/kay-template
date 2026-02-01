-- Listage de la structure de la table bbase. persist2_car
CREATE TABLE IF NOT EXISTS `persist2_car` (
  `owner` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0,
  `idnetworkcar` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage de la structure de la table bbase. persist_car
CREATE TABLE IF NOT EXISTS `persist_car` (
  `owner` varchar(255) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Listage des données de la table bbase.persist_car : ~0 rows (environ)
/*!40000 ALTER TABLE `persist_car` DISABLE KEYS */;
/*!40000 ALTER TABLE `persist_car` ENABLE KEYS */;