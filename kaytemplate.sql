-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 01 fév. 2026 à 16:19
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `kaytemplate`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_bennys', 'Benny\'s Original Motor', 1),
('society_burgershot', 'Burger Shot', 1),
('society_hornys', 'Hornys', 1),
('society_lscustom', 'Los Santos Customs', 1),
('society_mechanic', 'Mechanic', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_samssud', 'SAMS SUD.', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('casiersams', 'Casier SAMS', 0),
('society_bennys', 'Benny\'s Original Motor', 1),
('society_burgershot', 'Burger Shot', 1),
('society_hornys', 'Hornyst', 1),
('society_lscustom', 'Los Santos Customs', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_samssud', 'SAMS SUD.', 1);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `annonces_entreprise`
--

CREATE TABLE `annonces_entreprise` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `annonces_icons`
--

CREATE TABLE `annonces_icons` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url` varchar(255) NOT NULL,
  `job` varchar(50) NOT NULL,
  `identifier` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `owner` varchar(150) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `iban` varchar(50) NOT NULL,
  `pin` varchar(4) NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `owner`, `name`, `iban`, `pin`, `balance`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel', '21221', '2211', 3500);

-- --------------------------------------------------------

--
-- Structure de la table `bank_datas`
--

CREATE TABLE `bank_datas` (
  `id` int(11) NOT NULL,
  `revenus` varchar(200) DEFAULT NULL,
  `depenses` varchar(200) DEFAULT NULL,
  `date` varchar(50) NOT NULL,
  `accountId` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bank_datas`
--

INSERT INTO `bank_datas` (`id`, `revenus`, `depenses`, `date`, `accountId`) VALUES
(1, '4100', '0', '31/01/2026', '0'),
(2, '4500', '1000', '31/01/2026', '1');

-- --------------------------------------------------------

--
-- Structure de la table `bank_transactions`
--

CREATE TABLE `bank_transactions` (
  `id` int(11) NOT NULL,
  `accountId` varchar(50) NOT NULL,
  `reason` varchar(200) DEFAULT NULL,
  `more` varchar(200) DEFAULT NULL,
  `montant` varchar(50) NOT NULL,
  `type` varchar(20) NOT NULL,
  `date` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `bank_transactions`
--

INSERT INTO `bank_transactions` (`id`, `accountId`, `reason`, `more`, `montant`, `type`, `date`) VALUES
(1, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(2, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(3, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(4, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(5, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(6, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(7, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(8, '0', 'Dépot d\'argent', '', '100', 'deposit', '31/01/2026'),
(9, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(10, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(11, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(12, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(13, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(14, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(15, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(16, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(17, '1', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026'),
(18, '1', 'Retrait d\'argent', '', '500', 'withdraw', '31/01/2026'),
(19, '1', 'Retrait d\'argent', '', '500', 'withdraw', '31/01/2026'),
(20, '0', 'Dépot d\'argent', '', '500', 'deposit', '31/01/2026');

-- --------------------------------------------------------

--
-- Structure de la table `blips`
--

CREATE TABLE `blips` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `sprite` int(11) NOT NULL,
  `color` int(11) NOT NULL,
  `scale` float DEFAULT 1,
  `opacity` int(11) DEFAULT 255,
  `creator_identifier` varchar(50) NOT NULL,
  `street_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_public` tinyint(1) DEFAULT 0,
  `hidden` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `blips`
--

INSERT INTO `blips` (`id`, `name`, `x`, `y`, `z`, `sprite`, `color`, `scale`, `opacity`, `creator_identifier`, `street_name`, `created_at`, `is_public`, `hidden`) VALUES
(58, '~b~Etats~w~ | ~w~Gouvernement', -546.76, -607.634, 34.6823, 419, 0, 0.66, 255, 'license:f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'San Andreas Avenue', '2025-05-31 02:24:12', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `blips_groups`
--

CREATE TABLE `blips_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `sprite` int(11) NOT NULL,
  `color` int(11) NOT NULL,
  `scale` float DEFAULT 1,
  `opacity` int(11) DEFAULT 255,
  `creator_identifier` varchar(50) NOT NULL,
  `street_name` varchar(100) DEFAULT NULL,
  `job_name` varchar(50) NOT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `blips_shared`
--

CREATE TABLE `blips_shared` (
  `id` int(11) NOT NULL,
  `blip_id` int(11) NOT NULL,
  `shared_type` enum('player','group') NOT NULL,
  `target_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cardealer_vehicles`
--

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `carnet_sante`
--

CREATE TABLE `carnet_sante` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `blood_type` varchar(3) DEFAULT 'A+',
  `allergies` text DEFAULT NULL,
  `diseases` text DEFAULT NULL,
  `specificities` text DEFAULT NULL,
  `addictions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `carnet_sante`
--

INSERT INTO `carnet_sante` (`id`, `identifier`, `blood_type`, `allergies`, `diseases`, `specificities`, `addictions`) VALUES
(1, '5d9cd1a1bf5f02a5dd6d0a0dda8bbe603e6d56d0', 'A+', '[]', '[]', '[]', '[]'),
(2, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'AB+', '[]', '[]', '[]', '[]'),
(3, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'A+', '[]', '[]', '[]', '[]'),
(4, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'A+', '[]', '[]', '[]', '[]'),
(5, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'A+', '[]', '[]', '[]', '[]'),
(6, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'A+', '[]', '[]', '[]', '[]'),
(7, '295dd2299cd84e2c358d25f1bdf1c93e39d89b99', 'A+', '[]', '[]', '[]', '[]'),
(8, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'A+', '[]', '[]', '[]', '[]'),
(9, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(10, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(11, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'B+', '[]', '[]', '[]', '[]'),
(12, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(13, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(14, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(15, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(16, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(17, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'A+', '[]', '[]', '[]', '[]'),
(18, '541436682f50b38e2f1c7d912fa3c221198fb63c', 'A+', '[]', '[]', '[]', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `casierambulance`
--

CREATE TABLE `casierambulance` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `guest` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `casierambulancecontent`
--

CREATE TABLE `casierambulancecontent` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(25) NOT NULL,
  `name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `chests`
--

CREATE TABLE `chests` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `job` varchar(50) DEFAULT NULL,
  `coords` text NOT NULL,
  `slots` int(11) NOT NULL DEFAULT 50,
  `weight` int(11) NOT NULL DEFAULT 30000,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `contracts`
--

CREATE TABLE `contracts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `signature` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `contracts`
--

INSERT INTO `contracts` (`id`, `title`, `content`, `signature`, `created_at`) VALUES
(1, 'Dev', 'Zeno le goat', 'Zeno', '2025-05-25 20:37:51'),
(2, 'ddd', 'ddd', 'mateo', '2025-06-01 00:10:15');

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('casiersasms', 'Casier SAMS', 0),
('society_bennys', 'Benny\'s Original Motor', 1),
('society_burgershot', 'Burger Shot', 1),
('society_hornys', 'Hornys', 1),
('society_lscustom', 'Los Santos Customs', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_samssud', 'SAMS SUD.', 1);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'society_realestateagent', NULL, '\'{}\''),
(2, 'society_burgershot', NULL, '\'{}\''),
(3, 'society_hornys', NULL, '\'{}\''),
(4, 'society_samssud', NULL, '\'{}\''),
(5, 'casiersasms', 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '{}'),
(6, 'society_bennys', NULL, '\'{}\''),
(7, 'society_lscustom', NULL, '\'{}\''),
(8, 'casiersasms', '541436682f50b38e2f1c7d912fa3c221198fb63c', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `dispatch_adv_records`
--

CREATE TABLE `dispatch_adv_records` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT '',
  `reason` varchar(120) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `palette_index` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dispatch_adv_records_citizen`
--

CREATE TABLE `dispatch_adv_records_citizen` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL DEFAULT '',
  `reason` varchar(120) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `palette_index` int(11) NOT NULL DEFAULT 0,
  `created_at` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dispatch_bracelets`
--

CREATE TABLE `dispatch_bracelets` (
  `id` int(11) NOT NULL,
  `target_identifier` varchar(64) NOT NULL,
  `target_name` varchar(128) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `added_by_identifier` varchar(64) DEFAULT NULL,
  `added_by_name` varchar(128) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `removed` tinyint(1) NOT NULL DEFAULT 0,
  `palette_index` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dispatch_unitnumbers`
--

CREATE TABLE `dispatch_unitnumbers` (
  `id` int(11) NOT NULL,
  `identifier` varchar(64) NOT NULL,
  `unit_number` varchar(32) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dpkeybinds`
--

CREATE TABLE `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `dpkeybinds`
--

INSERT INTO `dpkeybinds` (`id`, `keybind1`, `emote1`, `keybind2`, `emote2`, `keybind3`, `emote3`, `keybind4`, `emote4`, `keybind5`, `emote5`, `keybind6`, `emote6`) VALUES
('license:a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', ''),
('license:a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', ''),
('license:a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'num4', '', 'num5', '', 'num6', '', 'num7', '', 'num8', '', 'num9', '');

-- --------------------------------------------------------

--
-- Structure de la table `duty_states`
--

CREATE TABLE `duty_states` (
  `identifier` varchar(60) NOT NULL,
  `job_name` varchar(50) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `duty_states`
--

INSERT INTO `duty_states` (`identifier`, `job_name`, `state`) VALUES
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'police', 0);

-- --------------------------------------------------------

--
-- Structure de la table `elevators`
--

CREATE TABLE `elevators` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `elevators`
--

INSERT INTO `elevators` (`id`, `name`) VALUES
(17, 'Teste');

-- --------------------------------------------------------

--
-- Structure de la table `elevator_floors`
--

CREATE TABLE `elevator_floors` (
  `id` int(11) NOT NULL,
  `elevator_id` int(11) NOT NULL,
  `floor_name` varchar(255) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `elevator_floors`
--

INSERT INTO `elevator_floors` (`id`, `elevator_id`, `floor_name`, `x`, `y`, `z`) VALUES
(61, 17, 'TOP', 285.555, -1011.5, 86.7462),
(62, 17, 'MID', 281.371, -991.185, 33.0908),
(63, 17, 'DOWN', 285.102, -1005.35, 30.2908);

-- --------------------------------------------------------

--
-- Structure de la table `emote_favorites`
--

CREATE TABLE `emote_favorites` (
  `identifier` varchar(46) NOT NULL,
  `favorites` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `emote_keybind`
--

CREATE TABLE `emote_keybind` (
  `owner` varchar(46) DEFAULT NULL,
  `emote` varchar(255) NOT NULL,
  `bind` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ex_groups`
--

CREATE TABLE `ex_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `ranks` longtext DEFAULT '[]' COMMENT 'JSON array des grades [{id: 1, name: "Grade"}, ...]',
  `group_type` varchar(50) NOT NULL DEFAULT 'Illégal' COMMENT 'Service public, Entreprise privée, Illégal',
  `Benefice` longtext DEFAULT '{}' COMMENT 'JSON object des bénéfices par zone {zoneId: amount}',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ex_groupsplayer`
--

CREATE TABLE `ex_groupsplayer` (
  `id` int(11) NOT NULL,
  `identifier` varchar(64) NOT NULL,
  `group_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ex_groupstashes`
--

CREATE TABLE `ex_groupstashes` (
  `id` int(11) NOT NULL,
  `pos` text NOT NULL COMMENT 'JSON {x, y, z}',
  `weight` int(11) NOT NULL DEFAULT 30000,
  `slots` int(11) NOT NULL DEFAULT 50,
  `group` varchar(100) NOT NULL,
  `owner` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ex_zones`
--

CREATE TABLE `ex_zones` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `radius` double NOT NULL DEFAULT 50,
  `owned` varchar(100) DEFAULT NULL COMMENT 'Nom du groupe propriétaire',
  `last_captured` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_emote_binds`
--

CREATE TABLE `fb_emote_binds` (
  `identifier` varchar(50) NOT NULL,
  `emote_name` varchar(50) NOT NULL,
  `emote_label` varchar(50) NOT NULL,
  `command_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_emote_favorites`
--

CREATE TABLE `fb_emote_favorites` (
  `identifier` varchar(50) NOT NULL,
  `emote_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_emote_states`
--

CREATE TABLE `fb_emote_states` (
  `identifier` varchar(50) NOT NULL,
  `current_walk` varchar(50) DEFAULT NULL,
  `current_expression` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_groups`
--

CREATE TABLE `fb_groups` (
  `id` int(11) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `group_type` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_groupsplayer`
--

CREATE TABLE `fb_groupsplayer` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `group_id` int(11) NOT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_mailbox`
--

CREATE TABLE `fb_mailbox` (
  `id` int(11) NOT NULL,
  `owner` varchar(64) NOT NULL,
  `property_id` int(11) DEFAULT 0,
  `coordsX` double NOT NULL,
  `coordsY` double NOT NULL,
  `coordsZ` double NOT NULL,
  `heading` double NOT NULL DEFAULT 0,
  `spawned` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_multichest`
--

CREATE TABLE `fb_multichest` (
  `id` varchar(100) NOT NULL,
  `content` longtext NOT NULL DEFAULT '[]',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fb_props`
--

CREATE TABLE `fb_props` (
  `id` int(11) NOT NULL,
  `owner` varchar(64) NOT NULL,
  `model` varchar(60) NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `rx` double NOT NULL DEFAULT 0,
  `ry` double NOT NULL DEFAULT 0,
  `rz` double NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fishing`
--

CREATE TABLE `fishing` (
  `UniqueID` int(11) DEFAULT NULL,
  `level` longtext DEFAULT 0,
  `fishList` longtext DEFAULT NULL,
  `permit` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fourrieres_pos`
--

CREATE TABLE `fourrieres_pos` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` longtext NOT NULL,
  `spawn_point` longtext NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `fourrieres_pos`
--

INSERT INTO `fourrieres_pos` (`id`, `name`, `position`, `spawn_point`, `price`) VALUES
(1, 'Fourière', '{\"x\":409.54949951171877,\"y\":-1623.1610107421876,\"z\":29.29193115234375}', '{\"x\":402.2474670410156,\"y\":-1634.3233642578126,\"z\":29.29193305969238,\"w\":188.82716369628907}', 500);

-- --------------------------------------------------------

--
-- Structure de la table `fourriere_vehicles`
--

CREATE TABLE `fourriere_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle_id` int(11) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `fourriere_id` int(11) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `fourriere_vehicles`
--

INSERT INTO `fourriere_vehicles` (`id`, `vehicle_id`, `plate`, `fourriere_id`, `date_added`) VALUES
(1, 7, 'FVMFX555', 1, '2026-01-23 07:00:00'),
(2, 18, 'PWEMR641', 1, '2026-01-23 07:00:01'),
(3, 23, 'JUCU4W3E', 1, '2026-01-23 07:05:00'),
(4, 24, 'CUSTOM', 1, '2026-01-30 19:54:30'),
(5, 25, 'OED72LU1', 1, '2026-01-30 19:54:31');

-- --------------------------------------------------------

--
-- Structure de la table `garages`
--

CREATE TABLE `garages` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `position` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`position`)),
  `heading` float NOT NULL,
  `spawn_points` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`spawn_points`)),
  `store_point` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`store_point`)),
  `type` varchar(20) DEFAULT 'car'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `garages`
--

INSERT INTO `garages` (`id`, `name`, `position`, `heading`, `spawn_points`, `store_point`, `type`) VALUES
(1, 'Garage', '{\"x\":215.7798309326172,\"y\":-809.8912963867188,\"z\":30.73097419738769}', 71.9864, '[{\"x\":228.42404174804688,\"y\":-798.4905395507813,\"z\":30.60294151306152,\"w\":158.67697143554688},{\"x\":233.2726287841797,\"y\":-799.684326171875,\"z\":30.51213264465332,\"w\":166.28530883789063}]', '{\"x\":213.620849609375,\"y\":-795.0208740234375,\"z\":30.8563175201416}', 'car');

-- --------------------------------------------------------

--
-- Structure de la table `ins_bans`
--

CREATE TABLE `ins_bans` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `date` longtext NOT NULL,
  `raison` longtext DEFAULT NULL,
  `auteur` blob DEFAULT NULL,
  `duree` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ins_jail`
--

CREATE TABLE `ins_jail` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `staffName` blob DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL,
  `raison` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ins_players`
--

CREATE TABLE `ins_players` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `name` blob DEFAULT NULL,
  `rank` longtext DEFAULT NULL,
  `report_count` int(11) DEFAULT 0,
  `report_notes` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `ins_players`
--

INSERT INTO `ins_players` (`id`, `identifier`, `name`, `rank`, `report_count`, `report_notes`) VALUES
(14, 'license:3aa062f5ba4f99929980851a973c0857c9252c1c', 0x736f646f, 'owner', 6, 20),
(15, 'license:a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 0x536879726f7a, 'owner', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ins_ranks`
--

CREATE TABLE `ins_ranks` (
  `id` int(11) NOT NULL,
  `label` longtext DEFAULT NULL,
  `rank` longtext DEFAULT NULL,
  `perms` longtext DEFAULT NULL,
  `power` int(11) DEFAULT 0,
  `color` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `ins_ranks`
--

INSERT INTO `ins_ranks` (`id`, `label`, `rank`, `perms`, `power`, `color`) VALUES
(1, 'Owner', 'owner', 'true', 100, 'red');

-- --------------------------------------------------------

--
-- Structure de la table `ins_sanctions`
--

CREATE TABLE `ins_sanctions` (
  `id` int(11) NOT NULL,
  `uid` longtext DEFAULT NULL,
  `staff` blob DEFAULT NULL,
  `name` blob DEFAULT NULL,
  `sanctionType` longtext DEFAULT NULL,
  `sanctionDesc` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ins_teleports`
--

CREATE TABLE `ins_teleports` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `coords` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ins_uid`
--

CREATE TABLE `ins_uid` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `uid` longtext DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `ins_uid`
--

INSERT INTO `ins_uid` (`id`, `identifier`, `uid`) VALUES
(1, 'license:a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'kay');

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('bread', 'Bread', 1, 0, 1),
('water', 'Water', 1, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `job2_grades`
--

CREATE TABLE `job2_grades` (
  `id` int(11) NOT NULL,
  `job2_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `job2_grades`
--

INSERT INTO `job2_grades` (`id`, `job2_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed2', 0, 'unemployed2', 'Civil', 200, '{}', '{}'),
(2, 'ballas', 0, 'boss', 'Boss', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('bennys', 'Benny\'s Original Motor'),
('burgershot', 'Burger Shot'),
('hornys', 'Hornys'),
('lscustom', 'Los Santos Customs'),
('police', 'LSPD'),
('realestateagent', 'Realestateagent'),
('samssud', 'SAMS SUD.'),
('unemployed', 'Unemployed');

-- --------------------------------------------------------

--
-- Structure de la table `jobs2`
--

CREATE TABLE `jobs2` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Déchargement des données de la table `jobs2`
--

INSERT INTO `jobs2` (`name`, `label`) VALUES
('ballas', 'Ballas'),
('unemployed2', 'Chomeur');

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'unemployed', 'Unemployed', 50, '{}', '{}'),
(2, 'realestateagent', 0, 'recrue', 'Recrue', 0, '{}', '{}'),
(3, 'realestateagent', 1, 'employé', 'Employé', 0, '{}', '{}'),
(4, 'realestateagent', 2, 'chef', 'Chef', 0, '{}', '{}'),
(5, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}'),
(6, 'burgershot', 0, 'stagiaire', 'Stagiaire', 20, '{}', '{}'),
(7, 'burgershot', 1, 'employer', 'Employé', 40, '{}', '{}'),
(8, 'burgershot', 2, 'respequipe', 'Responsable Equipe', 60, '{}', '{}'),
(9, 'burgershot', 3, 'copdg', 'Co-PDG', 85, '{}', '{}'),
(10, 'burgershot', 4, 'boss', 'PDG', 100, '{}', '{}'),
(11, 'burgershot', 0, 'stagiaire', 'Stagiaire', 20, '{}', '{}'),
(12, 'burgershot', 1, 'employer', 'Employé', 40, '{}', '{}'),
(13, 'burgershot', 2, 'respequipe', 'Responsable Equipe', 60, '{}', '{}'),
(14, 'burgershot', 3, 'copdg', 'Co-PDG', 85, '{}', '{}'),
(15, 'burgershot', 4, 'boss', 'PDG', 100, '{}', '{}'),
(16, 'burgershot', 0, 'stagiaire', 'Stagiaire', 20, '{}', '{}'),
(17, 'burgershot', 1, 'employer', 'Employé', 40, '{}', '{}'),
(18, 'burgershot', 2, 'respequipe', 'Responsable Equipe', 60, '{}', '{}'),
(19, 'burgershot', 3, 'copdg', 'Co-PDG', 85, '{}', '{}'),
(20, 'burgershot', 4, 'boss', 'PDG', 100, '{}', '{}'),
(21, 'police', 0, 'recruit', 'Rookie', 200, '{}', '{}'),
(22, 'police', 1, 'officer', 'Officier I', 300, '{}', '{}'),
(23, 'police', 2, 'officer2', 'Officier II', 350, '{}', '{}'),
(24, 'police', 3, 'officer3', 'Officier III', 400, '{}', '{}'),
(25, 'police', 4, 'slo', 'SLO', 450, '{}', '{}'),
(26, 'police', 5, 'sergeant', 'Sergent', 500, '{}', '{}'),
(27, 'police', 6, 'sergeantchef', 'Sergent Chefs', 550, '{}', '{}'),
(28, 'police', 7, 'lieutenant', 'Lieutenant', 600, '{}', '{}'),
(29, 'police', 8, 'lieutenantchef', 'Lieutenant Chefs', 650, '{}', '{}'),
(30, 'police', 9, 'captain', 'Capitaine', 700, '{}', '{}'),
(31, 'police', 10, 'commander', 'Commandant', 750, '{}', '{}'),
(32, 'police', 11, 'deputychief', 'Chief Adjoint', 800, '{}', '{}'),
(33, 'police', 12, 'chief', 'Chief', 900, '{}', '{}'),
(34, 'hornys', 0, 'stagiaire', 'Stagiaire', 20, '{}', '{}'),
(35, 'hornys', 1, 'employer', 'Employé', 40, '{}', '{}'),
(36, 'hornys', 2, 'respequipe', 'Responsable Equipe', 60, '{}', '{}'),
(37, 'hornys', 3, 'copdg', 'Co-Patron', 85, '{}', '{}'),
(38, 'hornys', 4, 'boss', 'Patron', 100, '{}', '{}'),
(39, 'samssud', 0, 'stagiaire', 'Médecin Stagiaire', 1500, '{}', '{}'),
(40, 'samssud', 1, 'medecin', 'Médecin', 2500, '{}', '{}'),
(41, 'samssud', 2, 'medecinchf', 'Médecin-Chef', 2000, '{}', '{}'),
(42, 'samssud', 3, 'manager', 'Manager', 3000, '{}', '{}'),
(43, 'samssud', 4, 'boss', 'Patron', 6000, '{}', '{}'),
(44, 'bennys', 0, 'recruit', 'Mécanicien Débutant', 150, '{}', '{}'),
(45, 'bennys', 1, 'seller', 'Mécanicien Confirmé', 200, '{}', '{}'),
(46, 'bennys', 2, 'manager', 'Manager', 250, '{}', '{}'),
(47, 'bennys', 3, 'co_boss', 'Co-Gérant', 300, '{}', '{}'),
(48, 'bennys', 4, 'boss', 'Patron', 400, '{}', '{}'),
(49, 'lscustom', 0, 'recruit', 'Mécanicien Débutant', 150, '{}', '{}'),
(50, 'lscustom', 1, 'seller', 'Mécanicien Confirmé', 200, '{}', '{}'),
(51, 'lscustom', 2, 'manager', 'Manager', 250, '{}', '{}'),
(52, 'lscustom', 3, 'co_boss', 'Co-Gérant', 300, '{}', '{}'),
(53, 'lscustom', 4, 'boss', 'Patron', 400, '{}', '{}'),
(54, 'samssud', 0, 'stagiaire', 'Médecin Stagiaire', 1500, '{}', '{}'),
(55, 'samssud', 1, 'medecin', 'Médecin', 2500, '{}', '{}'),
(56, 'samssud', 2, 'medecinchf', 'Médecin-Chef', 2000, '{}', '{}'),
(57, 'samssud', 3, 'manager', 'Manager', 3000, '{}', '{}'),
(58, 'samssud', 4, 'boss', 'Patron', 6000, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `kay_mdt_codagecitoyen`
--

CREATE TABLE `kay_mdt_codagecitoyen` (
  `id` int(10) UNSIGNED NOT NULL,
  `identifier` varchar(60) NOT NULL COMMENT 'Identifier du citoyen (license / citizenid)',
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email` varchar(120) NOT NULL,
  `weight` int(4) DEFAULT NULL,
  `height` int(4) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `hair` varchar(50) DEFAULT NULL,
  `eyes` varchar(50) DEFAULT NULL,
  `affiliation` varchar(100) DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `license` varchar(20) DEFAULT 'invalid',
  `photo` longtext DEFAULT NULL,
  `ppa_civil` tinyint(1) NOT NULL DEFAULT 0,
  `deceased` tinyint(1) NOT NULL DEFAULT 0,
  `wanted` tinyint(1) NOT NULL DEFAULT 0,
  `wanted_reason` varchar(255) DEFAULT NULL,
  `wanted_author_identifier` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `kay_mdt_dossier_arrestation`
--

CREATE TABLE `kay_mdt_dossier_arrestation` (
  `id` int(10) UNSIGNED NOT NULL,
  `citizen_id` int(10) UNSIGNED NOT NULL,
  `author_identifier` varchar(64) DEFAULT NULL,
  `author_badge` varchar(32) DEFAULT NULL,
  `author_firstname` varchar(50) DEFAULT NULL,
  `author_lastname` varchar(50) DEFAULT NULL,
  `display_datetime` varchar(32) DEFAULT NULL,
  `rights_datetime` varchar(32) DEFAULT NULL,
  `station_id` varchar(64) DEFAULT NULL,
  `possession` text DEFAULT NULL,
  `lawyer` varchar(255) DEFAULT NULL,
  `officers` longtext DEFAULT NULL,
  `report_text` longtext DEFAULT NULL,
  `photos` longtext DEFAULT NULL,
  `photos_folder` varchar(120) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `fine_scale_id` varchar(64) DEFAULT NULL,
  `total_fine` int(11) NOT NULL DEFAULT 0,
  `total_up` int(11) NOT NULL DEFAULT 0,
  `force_used` tinyint(1) NOT NULL DEFAULT 0,
  `vehicles` longtext DEFAULT NULL,
  `weapons` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `kay_mdt_informations`
--

CREATE TABLE `kay_mdt_informations` (
  `identifier` varchar(64) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dob` varchar(20) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `iban` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `badge` varchar(20) DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `kay_mdt_informations`
--

INSERT INTO `kay_mdt_informations` (`identifier`, `firstname`, `lastname`, `dob`, `phone`, `iban`, `email`, `badge`, `note`) VALUES
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `kay_mdt_rapport_arrestation`
--

CREATE TABLE `kay_mdt_rapport_arrestation` (
  `id` int(10) UNSIGNED NOT NULL,
  `citizen_id` int(10) UNSIGNED NOT NULL,
  `author_identifier` varchar(64) NOT NULL,
  `author_badge` varchar(32) DEFAULT NULL,
  `author_firstname` varchar(64) DEFAULT NULL,
  `author_lastname` varchar(64) DEFAULT NULL,
  `display_datetime` varchar(32) NOT NULL,
  `rights_datetime` varchar(32) DEFAULT NULL,
  `station_id` varchar(64) DEFAULT NULL,
  `possession` varchar(255) DEFAULT NULL,
  `lawyer` varchar(255) DEFAULT NULL,
  `officers` longtext DEFAULT NULL,
  `report_text` longtext DEFAULT NULL,
  `photos` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `fine_scale_id` varchar(64) DEFAULT NULL,
  `total_fine` int(11) NOT NULL DEFAULT 0,
  `total_up` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `kay_mdt_ticket_routier`
--

CREATE TABLE `kay_mdt_ticket_routier` (
  `id` int(10) UNSIGNED NOT NULL,
  `citizen_id` int(10) UNSIGNED NOT NULL,
  `author_identifier` varchar(64) DEFAULT NULL,
  `author_badge` varchar(32) DEFAULT NULL,
  `author_firstname` varchar(50) DEFAULT NULL,
  `author_lastname` varchar(50) DEFAULT NULL,
  `display_datetime` varchar(32) DEFAULT NULL,
  `station_id` varchar(64) DEFAULT NULL,
  `plate` varchar(32) DEFAULT NULL,
  `location` varchar(128) DEFAULT NULL,
  `photos` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `fine_scale_id` varchar(64) DEFAULT NULL,
  `total_fine` int(11) NOT NULL DEFAULT 0,
  `total_up` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('boat', 'Boat License'),
('dmv', 'Driving Permit'),
('drive', 'Drivers License'),
('drive_bike', 'Motorcycle License'),
('drive_truck', 'Commercial Drivers License'),
('weapon', 'Weapon License'),
('weed_processing', 'Weed Processing License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License'),
('weapon', 'Weapon License');

-- --------------------------------------------------------

--
-- Structure de la table `lockers`
--

CREATE TABLE `lockers` (
  `id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '"Casier vide',
  `code` varchar(10) DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `lockers`
--

INSERT INTO `lockers` (`id`, `point_id`, `title`, `code`, `note`) VALUES
(214, 59, 'Zeno', '1234', ''),
(215, 59, 'Zeno', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `locker_points`
--

CREATE TABLE `locker_points` (
  `id` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT 'Casiers',
  `job` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `locker_points`
--

INSERT INTO `locker_points` (`id`, `x`, `y`, `z`, `title`, `job`) VALUES
(59, -76.0637, -819.64, 326.175, 'Casiers', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `management_outfits`
--

CREATE TABLE `management_outfits` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `manny_bans`
--

CREATE TABLE `manny_bans` (
  `id` int(11) NOT NULL,
  `license` varchar(64) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `staff_license` varchar(64) DEFAULT NULL,
  `staff_name` varchar(64) DEFAULT NULL,
  `is_permanent` tinyint(1) NOT NULL DEFAULT 0,
  `expires_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `manny_kicks`
--

CREATE TABLE `manny_kicks` (
  `id` int(11) NOT NULL,
  `license` varchar(64) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `staff_license` varchar(64) DEFAULT NULL,
  `staff_name` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `markers`
--

CREATE TABLE `markers` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` varchar(10) NOT NULL,
  `size` int(11) NOT NULL,
  `hidden` tinyint(1) DEFAULT 0,
  `color` varchar(50) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float DEFAULT 0,
  `ry` float DEFAULT 0,
  `rz` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `multicharacter_slots`
--

CREATE TABLE `multicharacter_slots` (
  `identifier` varchar(46) NOT NULL,
  `slots` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(46) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) DEFAULT 1,
  `parking` varchar(60) DEFAULT NULL,
  `pound` varchar(60) DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `model` varchar(60) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `displayname` varchar(100) DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `job2` varchar(20) DEFAULT NULL,
  `stolen` tinyint(1) DEFAULT 0,
  `mods` text DEFAULT NULL,
  `garage_name` varchar(50) DEFAULT NULL,
  `etat` text DEFAULT '{"engine_health":1000.0,"body_health":1000.0,"fuel_level":100.0}',
  `last_out_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `job`, `stored`, `parking`, `pound`, `trunk`, `glovebox`, `model`, `id`, `displayname`, `label`, `job2`, `stolen`, `mods`, `garage_name`, `etat`, `last_out_time`) VALUES
('295dd2299cd84e2c358d25f1bdf1c93e39d89b99', '671031', '{\"model\":970598228,\"plate\":\"671031\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', '6Q1C3YAK', '{\"plate\":\"6Q1C3YAK\",\"tankHealth\":1000.0,\"modWindows\":-1,\"tyreBurst\":{\"5\":false,\"1\":false,\"4\":false,\"0\":false},\"modFrontBumper\":-1,\"modLivery\":-1,\"modTransmission\":-1,\"modHydrolic\":-1,\"modEngine\":-1,\"modXenon\":false,\"modBrakes\":-1,\"modRoofLivery\":-1,\"bodyHealth\":1000.0,\"wheels\":0,\"windowsBroken\":{\"2\":false,\"1\":false,\"0\":false,\"7\":false,\"6\":false,\"5\":true,\"4\":true,\"3\":false},\"pearlescentColor\":5,\"interiorColor\":0,\"dashboardColor\":0,\"windowTint\":-1,\"modArchCover\":-1,\"modRightFender\":-1,\"tyreSmokeColor\":[255,255,255],\"modTrunk\":-1,\"modEngineBlock\":-1,\"modOrnaments\":-1,\"engineHealth\":1000.0,\"modSpeakers\":-1,\"modSmokeEnabled\":false,\"modSpoilers\":-1,\"modShifterLeavers\":-1,\"color2\":1,\"modArmor\":-1,\"modGrille\":-1,\"modSteeringWheel\":-1,\"modAirFilter\":-1,\"modDial\":-1,\"extras\":{\"10\":false,\"12\":false},\"dirtLevel\":2.0,\"neonColor\":[255,0,255],\"modLightbar\":-1,\"color1\":1,\"modStruts\":-1,\"modExhaust\":-1,\"modSeats\":-1,\"modTrimB\":-1,\"modRearBumper\":-1,\"modAPlate\":-1,\"modDoorSpeaker\":-1,\"modHood\":-1,\"modCustomFrontWheels\":false,\"fuelLevel\":65.0,\"modTank\":-1,\"modCustomBackWheels\":false,\"modVanityPlate\":-1,\"modFrame\":-1,\"tyresCanBurst\":1,\"wheelColor\":156,\"modBackWheels\":-1,\"model\":970598228,\"modTurbo\":false,\"modFender\":-1,\"doorsBroken\":{\"2\":false,\"1\":false,\"0\":false,\"6\":false,\"5\":false,\"4\":false,\"3\":false},\"modPlateHolder\":-1,\"modSideSkirt\":-1,\"modHorns\":-1,\"modDashboard\":-1,\"neonEnabled\":[false,false,false,false],\"modFrontWheels\":-1,\"modSuspension\":-1,\"modRoof\":-1,\"xenonColor\":255,\"modAerials\":-1,\"modTrimA\":-1,\"plateIndex\":0}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 2, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', '7SM306', '{\"model\":970598228,\"plate\":\"7SM306\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 3, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'B0M398', '{\"plate\":\"B0M398\",\"model\":970598228}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 4, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'BWOLOTCB', '{\"modPlateHolder\":-1,\"modEngineBlock\":-1,\"modAirFilter\":-1,\"bodyHealth\":1000.0,\"modRearBumper\":-1,\"modLightbar\":-1,\"modBrakes\":-1,\"neonColor\":[255,0,255],\"modFrame\":-1,\"modTrimA\":-1,\"modBackWheels\":-1,\"color1\":1,\"pearlescentColor\":5,\"modSideSkirt\":-1,\"modTransmission\":-1,\"xenonColor\":255,\"modSpoilers\":-1,\"modRoofLivery\":-1,\"modSmokeEnabled\":false,\"modArmor\":-1,\"tyresCanBurst\":1,\"engineHealth\":1000.0,\"dirtLevel\":4.0,\"modEngine\":-1,\"modOrnaments\":-1,\"modRightFender\":-1,\"modXenon\":false,\"modTrunk\":-1,\"interiorColor\":0,\"modFrontWheels\":-1,\"modShifterLeavers\":-1,\"wheelColor\":156,\"modTurbo\":false,\"dashboardColor\":0,\"modWindows\":-1,\"modHorns\":-1,\"tankHealth\":1000.0,\"fuelLevel\":65.0,\"modSuspension\":-1,\"modCustomFrontWheels\":false,\"plate\":\"BWOLOTCB\",\"extras\":{\"12\":false,\"10\":1},\"windowsBroken\":{\"2\":false,\"1\":false,\"4\":true,\"3\":false,\"6\":false,\"5\":true,\"0\":false,\"7\":false},\"modGrille\":-1,\"tyreBurst\":{\"1\":false,\"5\":false,\"4\":false,\"0\":false},\"modExhaust\":-1,\"modSeats\":-1,\"modTank\":-1,\"modAPlate\":-1,\"modRoof\":-1,\"modHood\":-1,\"tyreSmokeColor\":[255,255,255],\"color2\":1,\"modTrimB\":-1,\"windowTint\":-1,\"modStruts\":-1,\"neonEnabled\":[false,false,false,false],\"modCustomBackWheels\":false,\"plateIndex\":0,\"modLivery\":-1,\"modSteeringWheel\":-1,\"model\":970598228,\"modDial\":-1,\"modFrontBumper\":-1,\"modFender\":-1,\"modArchCover\":-1,\"modDashboard\":-1,\"doorsBroken\":{\"2\":false,\"1\":false,\"4\":false,\"3\":false,\"6\":false,\"5\":false,\"0\":false},\"modVanityPlate\":-1,\"modAerials\":-1,\"modSpeakers\":-1,\"wheels\":0,\"modDoorSpeaker\":-1,\"modHydrolic\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 5, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'EPL465', '{\"plate\":\"EPL465\",\"model\":2016857647}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 6, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'FVMFX555', '{\"plate\":\"FVMFX555\",\"model\":-1372848492}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 7, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'IRKAVFBI', '{\"tankHealth\":1000.0,\"modHood\":-1,\"plate\":\"IRKAVFBI\",\"modSuspension\":-1,\"bodyHealth\":1000.0,\"modRoofLivery\":-1,\"modTurbo\":false,\"dirtLevel\":4.0,\"modRearBumper\":-1,\"modStruts\":-1,\"modAerials\":-1,\"modRoof\":-1,\"wheelColor\":156,\"modTank\":-1,\"modDial\":-1,\"modTrimB\":-1,\"modDashboard\":-1,\"modEngineBlock\":-1,\"neonEnabled\":[false,false,false,false],\"modFender\":-1,\"modFrontWheels\":-1,\"modXenon\":false,\"tyreBurst\":{\"0\":false,\"4\":false,\"5\":false,\"1\":false},\"modTrunk\":-1,\"modTrimA\":-1,\"modFrontBumper\":-1,\"modEngine\":-1,\"modLightbar\":-1,\"windowsBroken\":{\"4\":true,\"3\":false,\"6\":false,\"5\":true,\"0\":false,\"7\":false,\"2\":false,\"1\":false},\"modSteeringWheel\":-1,\"modGrille\":-1,\"modCustomBackWheels\":false,\"extras\":{\"10\":false,\"12\":1},\"modCustomFrontWheels\":false,\"modOrnaments\":-1,\"modShifterLeavers\":-1,\"xenonColor\":255,\"modArchCover\":-1,\"modWindows\":-1,\"modExhaust\":-1,\"modSpeakers\":-1,\"wheels\":0,\"modAPlate\":-1,\"dashboardColor\":0,\"modSpoilers\":-1,\"fuelLevel\":65.0,\"modArmor\":-1,\"color2\":1,\"modDoorSpeaker\":-1,\"tyreSmokeColor\":[255,255,255],\"doorsBroken\":{\"4\":false,\"3\":false,\"6\":false,\"5\":false,\"0\":false,\"2\":false,\"1\":false},\"modPlateHolder\":-1,\"pearlescentColor\":5,\"modBackWheels\":-1,\"modTransmission\":-1,\"modHorns\":-1,\"engineHealth\":1000.0,\"modVanityPlate\":-1,\"modSmokeEnabled\":false,\"modSideSkirt\":-1,\"modBrakes\":-1,\"modSeats\":-1,\"windowTint\":-1,\"tyresCanBurst\":1,\"modRightFender\":-1,\"modAirFilter\":-1,\"model\":970598228,\"color1\":1,\"modLivery\":-1,\"plateIndex\":0,\"neonColor\":[255,0,255],\"modHydrolic\":-1,\"interiorColor\":0,\"modFrame\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 8, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'J63550', '{\"plate\":\"J63550\",\"model\":788045382}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 9, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'JVH3W60E', '{\"modAirFilter\":-1,\"windowTint\":-1,\"modHydrolic\":-1,\"modDoorSpeaker\":-1,\"modFender\":-1,\"modRoof\":-1,\"modGrille\":-1,\"modRearBumper\":-1,\"doorsBroken\":{\"1\":false,\"0\":false},\"modAerials\":-1,\"modSpeakers\":-1,\"modRightFender\":-1,\"engineHealth\":1000.0,\"modDial\":-1,\"tyreBurst\":{\"0\":false,\"4\":false},\"modFrontWheels\":-1,\"modTurbo\":false,\"windowsBroken\":{\"1\":true,\"0\":true,\"3\":true,\"2\":true,\"5\":true,\"4\":true,\"7\":true,\"6\":true},\"modAPlate\":-1,\"dirtLevel\":3.0,\"modEngineBlock\":-1,\"modEngine\":-1,\"modTank\":-1,\"modFrame\":-1,\"modSteeringWheel\":-1,\"plateIndex\":3,\"dashboardColor\":0,\"modBackWheels\":-1,\"fuelLevel\":65.0,\"modExhaust\":-1,\"modShifterLeavers\":-1,\"modCustomBackWheels\":false,\"extras\":[],\"modSpoilers\":-1,\"modVanityPlate\":-1,\"modWindows\":-1,\"modSeats\":-1,\"modHorns\":-1,\"wheels\":6,\"modFrontBumper\":-1,\"modOrnaments\":-1,\"modArmor\":-1,\"neonColor\":[255,0,255],\"modBrakes\":-1,\"interiorColor\":0,\"modArchCover\":-1,\"modSuspension\":-1,\"pearlescentColor\":0,\"tyresCanBurst\":1,\"modDashboard\":-1,\"modTransmission\":-1,\"modLivery\":0,\"modSmokeEnabled\":false,\"neonEnabled\":[false,false,false,false],\"color2\":0,\"plate\":\"JVH3W60E\",\"modLightbar\":-1,\"modTrimA\":-1,\"model\":788045382,\"modSideSkirt\":-1,\"modPlateHolder\":-1,\"modTrunk\":-1,\"modXenon\":false,\"modHood\":-1,\"xenonColor\":255,\"tyreSmokeColor\":[255,255,255],\"bodyHealth\":1000.0,\"tankHealth\":1000.0,\"wheelColor\":156,\"color1\":0,\"modCustomFrontWheels\":false,\"modStruts\":-1,\"modRoofLivery\":-1,\"modTrimB\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 10, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'K48X6XBE', '{\"modFrontWheels\":-1,\"neonColor\":[255,0,255],\"windowTint\":-1,\"modBrakes\":-1,\"modHorns\":-1,\"modSeats\":-1,\"modArmor\":-1,\"modXenon\":false,\"modFrame\":-1,\"windowsBroken\":{\"4\":true,\"5\":true,\"2\":false,\"3\":false,\"0\":false,\"1\":false,\"6\":false,\"7\":false},\"doorsBroken\":{\"4\":false,\"5\":false,\"2\":false,\"3\":false,\"0\":false,\"1\":false,\"6\":false},\"modTank\":-1,\"modCustomBackWheels\":false,\"interiorColor\":0,\"modSteeringWheel\":-1,\"modSpoilers\":-1,\"tyreBurst\":{\"0\":false,\"1\":false,\"4\":false,\"5\":false},\"modExhaust\":-1,\"xenonColor\":255,\"modRoof\":-1,\"modGrille\":-1,\"modAirFilter\":-1,\"neonEnabled\":[false,false,false,false],\"dashboardColor\":0,\"tyresCanBurst\":1,\"modRearBumper\":-1,\"modFrontBumper\":-1,\"plate\":\"K48X6XBE\",\"modSideSkirt\":-1,\"color2\":1,\"model\":970598228,\"fuelLevel\":65.0,\"modDashboard\":-1,\"modArchCover\":-1,\"modTurbo\":false,\"modTransmission\":-1,\"modDoorSpeaker\":-1,\"modEngine\":-1,\"color1\":1,\"wheels\":0,\"tankHealth\":1000.0,\"extras\":{\"12\":false,\"10\":1},\"modTrimA\":-1,\"modCustomFrontWheels\":false,\"modBackWheels\":-1,\"modTrunk\":-1,\"modWindows\":-1,\"modOrnaments\":-1,\"modRoofLivery\":-1,\"dirtLevel\":9.0,\"modStruts\":-1,\"modAerials\":-1,\"modRightFender\":-1,\"modPlateHolder\":-1,\"engineHealth\":1000.0,\"modFender\":-1,\"modEngineBlock\":-1,\"modLightbar\":-1,\"plateIndex\":0,\"modDial\":-1,\"modAPlate\":-1,\"pearlescentColor\":5,\"modLivery\":-1,\"modSuspension\":-1,\"modVanityPlate\":-1,\"modSpeakers\":-1,\"modHood\":-1,\"modShifterLeavers\":-1,\"bodyHealth\":1000.0,\"tyreSmokeColor\":[255,255,255],\"modTrimB\":-1,\"modHydrolic\":-1,\"wheelColor\":156,\"modSmokeEnabled\":false}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 11, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'KFA56VL9', '{\"modArmor\":-1,\"modRoof\":-1,\"modAPlate\":-1,\"modTrunk\":-1,\"modCustomFrontWheels\":false,\"modFender\":-1,\"modHydrolic\":-1,\"modLightbar\":-1,\"modTrimB\":-1,\"pearlescentColor\":0,\"modAirFilter\":-1,\"modFrontBumper\":-1,\"wheels\":6,\"doorsBroken\":{\"1\":false,\"0\":false},\"extras\":[],\"engineHealth\":1000.0,\"modExhaust\":-1,\"xenonColor\":255,\"modSmokeEnabled\":false,\"tyreBurst\":{\"4\":false,\"0\":false},\"modBackWheels\":-1,\"modPlateHolder\":-1,\"windowsBroken\":{\"3\":true,\"4\":true,\"5\":true,\"6\":true,\"7\":true,\"0\":true,\"1\":true,\"2\":true},\"modDial\":-1,\"modLivery\":1,\"neonEnabled\":[false,false,false,false],\"modSuspension\":-1,\"modTrimA\":-1,\"modEngineBlock\":-1,\"bodyHealth\":1000.0,\"modSeats\":-1,\"modStruts\":-1,\"modShifterLeavers\":-1,\"modTank\":-1,\"dirtLevel\":11.0,\"modRoofLivery\":-1,\"tankHealth\":1000.0,\"modWindows\":-1,\"modGrille\":-1,\"modRightFender\":-1,\"model\":788045382,\"plate\":\"KFA56VL9\",\"wheelColor\":156,\"neonColor\":[255,0,255],\"modSpoilers\":-1,\"windowTint\":-1,\"modSteeringWheel\":-1,\"color2\":0,\"modBrakes\":-1,\"modXenon\":false,\"modEngine\":-1,\"modTransmission\":-1,\"modCustomBackWheels\":false,\"modHorns\":-1,\"tyreSmokeColor\":[255,255,255],\"fuelLevel\":65.0,\"modHood\":-1,\"color1\":0,\"modOrnaments\":-1,\"modVanityPlate\":-1,\"modTurbo\":false,\"interiorColor\":0,\"modSideSkirt\":-1,\"dashboardColor\":0,\"modFrontWheels\":-1,\"modAerials\":-1,\"plateIndex\":0,\"modFrame\":-1,\"modArchCover\":-1,\"modRearBumper\":-1,\"modSpeakers\":-1,\"tyresCanBurst\":1,\"modDashboard\":-1,\"modDoorSpeaker\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 12, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('295dd2299cd84e2c358d25f1bdf1c93e39d89b99', 'KH3434', '{\"plate\":\"KH3434\",\"model\":788045382}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 13, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'L3P95FWB', '{\"windowsBroken\":{\"6\":true,\"5\":true,\"0\":true,\"7\":true,\"2\":true,\"1\":true,\"4\":true,\"3\":true},\"engineHealth\":1000.0,\"modVanityPlate\":-1,\"windowTint\":-1,\"modOrnaments\":-1,\"modDashboard\":-1,\"modSeats\":-1,\"modAPlate\":-1,\"modEngineBlock\":-1,\"modRoofLivery\":-1,\"fuelLevel\":65.0,\"modFrontWheels\":-1,\"extras\":[],\"color1\":0,\"modRearBumper\":-1,\"wheels\":6,\"modBackWheels\":-1,\"modSpeakers\":-1,\"modAerials\":-1,\"modArmor\":-1,\"modTank\":-1,\"modHorns\":-1,\"plate\":\"L3P95FWB\",\"modCustomBackWheels\":false,\"modFrame\":-1,\"modPlateHolder\":-1,\"neonEnabled\":[false,false,false,false],\"modRightFender\":-1,\"modTrimB\":-1,\"modGrille\":-1,\"modDoorSpeaker\":-1,\"color2\":0,\"interiorColor\":0,\"modTurbo\":false,\"modLightbar\":-1,\"modHood\":-1,\"modTrunk\":-1,\"modExhaust\":-1,\"modEngine\":-1,\"tyreSmokeColor\":[255,255,255],\"model\":788045382,\"modTrimA\":-1,\"modXenon\":false,\"dirtLevel\":6.0,\"plateIndex\":0,\"modStruts\":-1,\"modFender\":-1,\"neonColor\":[255,0,255],\"modCustomFrontWheels\":false,\"modSmokeEnabled\":false,\"modAirFilter\":-1,\"tankHealth\":1000.0,\"modSuspension\":-1,\"modSideSkirt\":-1,\"modShifterLeavers\":-1,\"modTransmission\":-1,\"tyreBurst\":{\"4\":false,\"0\":false},\"modLivery\":0,\"tyresCanBurst\":1,\"dashboardColor\":0,\"modSpoilers\":-1,\"modBrakes\":-1,\"wheelColor\":156,\"doorsBroken\":{\"0\":false,\"1\":false},\"modHydrolic\":-1,\"modWindows\":-1,\"modSteeringWheel\":-1,\"modRoof\":-1,\"modFrontBumper\":-1,\"bodyHealth\":1000.0,\"pearlescentColor\":0,\"xenonColor\":255,\"modArchCover\":-1,\"modDial\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 14, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'NLW988', '{\"plate\":\"NLW988\",\"model\":970598228}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 15, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'PCKRWTR1', '{\"modHood\":-1,\"neonColor\":[255,0,255],\"modRoofLivery\":-1,\"dirtLevel\":9.0,\"extras\":[],\"model\":788045382,\"modEngineBlock\":-1,\"modHorns\":-1,\"interiorColor\":0,\"modAirFilter\":-1,\"modSeats\":-1,\"modTrimB\":-1,\"xenonColor\":255,\"modShifterLeavers\":-1,\"modAPlate\":-1,\"tyresCanBurst\":1,\"dashboardColor\":0,\"neonEnabled\":[false,false,false,false],\"bodyHealth\":1000.0,\"modDial\":-1,\"modBackWheels\":-1,\"modExhaust\":-1,\"modXenon\":false,\"wheels\":6,\"modCustomBackWheels\":false,\"modGrille\":-1,\"modArmor\":-1,\"modTank\":-1,\"modRoof\":-1,\"modFrontBumper\":-1,\"modSuspension\":-1,\"modStruts\":-1,\"modSteeringWheel\":-1,\"engineHealth\":1000.0,\"modFrame\":-1,\"modFender\":-1,\"color1\":0,\"modHydrolic\":-1,\"tyreBurst\":{\"4\":false,\"0\":false},\"modLivery\":0,\"modSpoilers\":-1,\"fuelLevel\":65.0,\"modArchCover\":-1,\"modLightbar\":-1,\"modTransmission\":-1,\"modAerials\":-1,\"modSmokeEnabled\":false,\"modFrontWheels\":-1,\"modSpeakers\":-1,\"modPlateHolder\":-1,\"plate\":\"PCKRWTR1\",\"modDashboard\":-1,\"tankHealth\":1000.0,\"plateIndex\":0,\"tyreSmokeColor\":[255,255,255],\"modCustomFrontWheels\":false,\"modRightFender\":-1,\"modTurbo\":false,\"windowsBroken\":{\"4\":true,\"3\":true,\"2\":true,\"1\":true,\"0\":true,\"7\":true,\"6\":true,\"5\":true},\"doorsBroken\":{\"0\":false,\"1\":false},\"wheelColor\":156,\"modEngine\":-1,\"modDoorSpeaker\":-1,\"modTrimA\":-1,\"modVanityPlate\":-1,\"modOrnaments\":-1,\"modTrunk\":-1,\"modWindows\":-1,\"pearlescentColor\":0,\"windowTint\":-1,\"modRearBumper\":-1,\"modBrakes\":-1,\"modSideSkirt\":-1,\"color2\":0}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 16, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'PW2044', '{\"plate\":\"PW2044\",\"model\":788045382}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 17, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'PWEMR641', '{\"model\":-1842748181,\"plate\":\"PWEMR641\"}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 18, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'RFE543', '{\"plate\":\"RFE543\",\"model\":970598228}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 19, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'RXO517', '{\"model\":970598228,\"plate\":\"RXO517\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 20, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'Y6VRMXYW', '{\"windowTint\":-1,\"modSmokeEnabled\":false,\"modHorns\":-1,\"modTrimA\":-1,\"windowsBroken\":{\"4\":true,\"5\":true,\"6\":true,\"7\":true,\"0\":true,\"1\":true,\"2\":true,\"3\":true},\"pearlescentColor\":0,\"plate\":\"Y6VRMXYW\",\"modFrontWheels\":-1,\"color2\":0,\"bodyHealth\":1000.0,\"modStruts\":-1,\"modSpoilers\":-1,\"modRoofLivery\":-1,\"modRearBumper\":-1,\"modSeats\":-1,\"modDashboard\":-1,\"modSuspension\":-1,\"modAerials\":-1,\"modTrunk\":-1,\"tankHealth\":1000.0,\"modTurbo\":false,\"modCustomFrontWheels\":false,\"plateIndex\":0,\"wheels\":6,\"modPlateHolder\":-1,\"modBrakes\":-1,\"tyreBurst\":{\"4\":false,\"0\":false},\"modAPlate\":-1,\"tyresCanBurst\":1,\"modXenon\":false,\"modRightFender\":-1,\"modLightbar\":-1,\"modHood\":-1,\"modRoof\":-1,\"modSideSkirt\":-1,\"modWindows\":-1,\"model\":788045382,\"modArchCover\":-1,\"modHydrolic\":-1,\"dashboardColor\":0,\"engineHealth\":1000.0,\"neonColor\":[255,0,255],\"modEngine\":-1,\"doorsBroken\":{\"0\":false,\"1\":false},\"dirtLevel\":10.0,\"modTank\":-1,\"modLivery\":4,\"modArmor\":-1,\"modShifterLeavers\":-1,\"modAirFilter\":-1,\"modDoorSpeaker\":-1,\"modSteeringWheel\":-1,\"modTransmission\":-1,\"modFrame\":-1,\"modGrille\":-1,\"modFrontBumper\":-1,\"neonEnabled\":[false,false,false,false],\"fuelLevel\":65.0,\"modFender\":-1,\"tyreSmokeColor\":[255,255,255],\"wheelColor\":156,\"modSpeakers\":-1,\"modOrnaments\":-1,\"modDial\":-1,\"modTrimB\":-1,\"interiorColor\":0,\"xenonColor\":255,\"modBackWheels\":-1,\"modExhaust\":-1,\"extras\":[],\"modCustomBackWheels\":false,\"color1\":0,\"modEngineBlock\":-1,\"modVanityPlate\":-1}', 'car', 'unemployed', 1, '[]', '0', '[]', '[]', NULL, 21, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('295dd2299cd84e2c358d25f1bdf1c93e39d89b99', 'ZW9917', '{\"model\":-1150599089,\"plate\":\"ZW9917\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 22, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 06:42:48'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'JUCU4W3E', '{\"model\":970598228,\"plate\":\"JUCU4W3E\"}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 23, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-23 07:04:32'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'CUSTOM', '{\"plate\":\"CUSTOM\",\"model\":970598228}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 24, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-30 19:50:20'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'OED72LU1', '{\"model\":970598228,\"plate\":\"OED72LU1\"}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 25, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-30 19:50:43'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'GZOEN694', '{\"plate\":\"GZOEN694\",\"model\":-1403128555}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 26, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-30 19:55:09'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'SPGIU4KT', '{\"model\":552981034,\"plate\":\"SPGIU4KT\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 27, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-31 10:47:37'),
('a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'EESPGIU4', '{\"model\":970598228,\"plate\":\"EESPGIU4\"}', 'car', NULL, 1, NULL, NULL, NULL, NULL, NULL, 28, NULL, NULL, NULL, 0, NULL, NULL, '{\"engine_health\":1000.0,\"body_health\":1000.0,\"fuel_level\":100.0}', '2026-01-31 11:55:23');

-- --------------------------------------------------------

--
-- Structure de la table `ox_inventory`
--

CREATE TABLE `ox_inventory` (
  `owner` varchar(46) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ox_inventory`
--

INSERT INTO `ox_inventory` (`owner`, `name`, `data`, `lastupdated`) VALUES
('1840348988', '18403489881open', NULL, '2026-01-23 07:05:00');

-- --------------------------------------------------------

--
-- Structure de la table `persist2_car`
--

CREATE TABLE `persist2_car` (
  `owner` varchar(46) DEFAULT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0,
  `idnetworkcar` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `persist_car`
--

CREATE TABLE `persist_car` (
  `owner` varchar(46) DEFAULT NULL,
  `plate` varchar(10) NOT NULL,
  `vehicle` longtext NOT NULL,
  `classcar` varchar(30) NOT NULL DEFAULT '0',
  `position` varchar(255) NOT NULL,
  `heading` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `persist_car`
--

INSERT INTO `persist_car` (`owner`, `plate`, `vehicle`, `classcar`, `position`, `heading`) VALUES
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'GX7J8K09', '{\"modAPlate\":-1,\"modWindows\":-1,\"tyreSmokeColor\":[255,255,255],\"modHood\":-1,\"modLightbar\":-1,\"modBackWheels\":-1,\"modSmokeEnabled\":1,\"modFrame\":-1,\"model\":80636076,\"extras\":{\"11\":false,\"12\":1,\"10\":false},\"bodyHealth\":1000.0,\"dashboardColor\":0,\"engineHealth\":1000.0,\"modExhaust\":-1,\"windowTint\":-1,\"dirtLevel\":3.0,\"modTrimA\":-1,\"plateIndex\":0,\"modSideSkirt\":-1,\"neonColor\":[255,0,255],\"wheels\":1,\"modCustomFrontWheels\":false,\"modEngineBlock\":-1,\"neonEnabled\":[false,false,false,false],\"modRightFender\":-1,\"modAirFilter\":-1,\"modTurbo\":false,\"modRoofLivery\":-1,\"modArchCover\":-1,\"tyreBurst\":{\"5\":false,\"1\":false,\"4\":false,\"0\":false},\"fuelLevel\":41.1,\"xenonColor\":255,\"modFrontWheels\":-1,\"modBrakes\":-1,\"modArmor\":-1,\"modLivery\":-1,\"plate\":\"GX7J8K09\",\"modDial\":-1,\"interiorColor\":0,\"modTransmission\":-1,\"modEngine\":-1,\"modFender\":-1,\"modPlateHolder\":-1,\"modOrnaments\":-1,\"modSpeakers\":-1,\"color2\":0,\"tyresCanBurst\":1,\"wheelColor\":156,\"windowsBroken\":{\"1\":false,\"2\":false,\"7\":false,\"0\":false,\"5\":true,\"6\":false,\"3\":false,\"4\":true},\"color1\":1,\"modHydrolic\":-1,\"modGrille\":-1,\"modSpoilers\":-1,\"modDoorSpeaker\":-1,\"modHorns\":-1,\"doorsBroken\":{\"1\":false,\"2\":false,\"0\":false,\"3\":false,\"4\":false},\"modFrontBumper\":-1,\"tankHealth\":1000.0,\"modSeats\":-1,\"modXenon\":false,\"modVanityPlate\":-1,\"modTrimB\":-1,\"modShifterLeavers\":-1,\"modRearBumper\":-1,\"modSteeringWheel\":-1,\"modCustomBackWheels\":false,\"modDashboard\":-1,\"modStruts\":-1,\"modRoof\":-1,\"modTank\":-1,\"modTrunk\":-1,\"modSuspension\":-1,\"pearlescentColor\":4,\"modAerials\":-1}', '4', '{\"x\":305.90753173828127,\"y\":-1355.9520263671876,\"z\":31.10052871704101}', 139.282),
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'P92FQ7NA', '{\"modFrontWheels\":-1,\"modHorns\":-1,\"modVanityPlate\":-1,\"modArmor\":-1,\"modDoorSpeaker\":-1,\"model\":2006918058,\"modCustomFrontWheels\":false,\"modFrontBumper\":-1,\"bodyHealth\":1000.0,\"modTransmission\":-1,\"modRightFender\":-1,\"modLivery\":-1,\"modHydrolic\":-1,\"modSuspension\":-1,\"modFrame\":-1,\"modAerials\":-1,\"modSideSkirt\":-1,\"interiorColor\":0,\"color1\":11,\"modXenon\":false,\"modEngineBlock\":-1,\"tankHealth\":1000.0,\"windowTint\":-1,\"modSpeakers\":-1,\"modSmokeEnabled\":1,\"modBrakes\":-1,\"modTank\":-1,\"modSteeringWheel\":-1,\"modGrille\":-1,\"modCustomBackWheels\":false,\"modLightbar\":-1,\"fuelLevel\":35.0,\"modSpoilers\":-1,\"modAirFilter\":-1,\"extras\":{\"10\":false,\"11\":false},\"modRoofLivery\":-1,\"windowsBroken\":{\"0\":false,\"1\":false,\"2\":false,\"3\":false,\"4\":false,\"5\":false,\"6\":false,\"7\":false},\"modRearBumper\":-1,\"engineHealth\":1000.0,\"modShifterLeavers\":-1,\"tyreBurst\":{\"4\":false,\"1\":false,\"5\":false,\"0\":false},\"plate\":\"P92FQ7NA\",\"modSeats\":-1,\"modExhaust\":-1,\"xenonColor\":255,\"modTurbo\":false,\"tyresCanBurst\":1,\"modDial\":-1,\"pearlescentColor\":5,\"dashboardColor\":0,\"modAPlate\":-1,\"modBackWheels\":-1,\"modTrunk\":-1,\"modWindows\":-1,\"plateIndex\":3,\"modTrimA\":-1,\"neonEnabled\":[false,false,false,false],\"modRoof\":-1,\"modOrnaments\":-1,\"modFender\":-1,\"dirtLevel\":5.0,\"doorsBroken\":{\"0\":false,\"1\":false,\"2\":false,\"3\":false,\"4\":false,\"5\":false,\"6\":false},\"wheels\":3,\"modDashboard\":-1,\"modPlateHolder\":-1,\"modStruts\":-1,\"wheelColor\":156,\"tyreSmokeColor\":[255,255,255],\"modArchCover\":-1,\"neonColor\":[255,0,255],\"modEngine\":-1,\"modHood\":-1,\"modTrimB\":-1,\"color2\":11}', 'imp_prop_covered_vehicle_07a', '{\"x\":203.25730895996095,\"y\":-1470.0135498046876,\"z\":28.9526309967041}', 225.01);

-- --------------------------------------------------------

--
-- Structure de la table `phone_backups`
--

CREATE TABLE `phone_backups` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_clock_alarms`
--

CREATE TABLE `phone_clock_alarms` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `hours` int(2) NOT NULL DEFAULT 0,
  `minutes` int(2) NOT NULL DEFAULT 0,
  `label` varchar(50) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_crypto`
--

CREATE TABLE `phone_crypto` (
  `id` varchar(100) NOT NULL,
  `coin` varchar(15) NOT NULL,
  `amount` double NOT NULL DEFAULT 0,
  `invested` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_accounts`
--

CREATE TABLE `phone_darkchat_accounts` (
  `phone_number` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_channels`
--

CREATE TABLE `phone_darkchat_channels` (
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_members`
--

CREATE TABLE `phone_darkchat_members` (
  `channel_name` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_darkchat_messages`
--

CREATE TABLE `phone_darkchat_messages` (
  `id` int(11) NOT NULL,
  `channel` varchar(50) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_accounts`
--

CREATE TABLE `phone_instagram_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `post_count` int(11) NOT NULL DEFAULT 0,
  `story_count` int(11) NOT NULL DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `phone_number` varchar(15) NOT NULL,
  `private` tinyint(1) DEFAULT 0,
  `verified` tinyint(1) DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_comments`
--

CREATE TABLE `phone_instagram_comments` (
  `id` varchar(10) NOT NULL,
  `post_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(500) NOT NULL DEFAULT '',
  `like_count` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_follows`
--

CREATE TABLE `phone_instagram_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_follow_requests`
--

CREATE TABLE `phone_instagram_follow_requests` (
  `requester` varchar(20) NOT NULL,
  `requestee` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_likes`
--

CREATE TABLE `phone_instagram_likes` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `is_comment` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_messages`
--

CREATE TABLE `phone_instagram_messages` (
  `id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_notifications`
--

CREATE TABLE `phone_instagram_notifications` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `post_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_posts`
--

CREATE TABLE `phone_instagram_posts` (
  `id` varchar(10) NOT NULL,
  `media` text DEFAULT NULL,
  `caption` varchar(500) NOT NULL DEFAULT '',
  `location` varchar(50) DEFAULT NULL,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `comment_count` int(11) NOT NULL DEFAULT 0,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_stories`
--

CREATE TABLE `phone_instagram_stories` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `image` varchar(500) NOT NULL,
  `metadata` longtext DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_instagram_stories_views`
--

CREATE TABLE `phone_instagram_stories_views` (
  `story_id` varchar(50) NOT NULL,
  `viewer` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_last_phone`
--

CREATE TABLE `phone_last_phone` (
  `id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_logged_in_accounts`
--

CREATE TABLE `phone_logged_in_accounts` (
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_accounts`
--

CREATE TABLE `phone_mail_accounts` (
  `address` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_deleted`
--

CREATE TABLE `phone_mail_deleted` (
  `message_id` int(10) UNSIGNED NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_mail_messages`
--

CREATE TABLE `phone_mail_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `recipient` varchar(100) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `attachments` longtext DEFAULT NULL,
  `actions` longtext DEFAULT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_maps_locations`
--

CREATE TABLE `phone_maps_locations` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `x_pos` float NOT NULL,
  `y_pos` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_marketplace_posts`
--

CREATE TABLE `phone_marketplace_posts` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachments` text DEFAULT NULL,
  `price` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_channels`
--

CREATE TABLE `phone_message_channels` (
  `id` int(11) NOT NULL,
  `is_group` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(50) DEFAULT NULL,
  `last_message` varchar(50) NOT NULL DEFAULT '',
  `last_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_members`
--

CREATE TABLE `phone_message_members` (
  `channel_id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `is_owner` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `unread` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_message_messages`
--

CREATE TABLE `phone_message_messages` (
  `id` int(11) NOT NULL,
  `channel_id` int(11) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_playlists`
--

CREATE TABLE `phone_music_playlists` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cover` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_saved_playlists`
--

CREATE TABLE `phone_music_saved_playlists` (
  `playlist_id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_music_songs`
--

CREATE TABLE `phone_music_songs` (
  `song_id` varchar(100) NOT NULL,
  `playlist_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_notes`
--

CREATE TABLE `phone_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` longtext DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_notifications`
--

CREATE TABLE `phone_notifications` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `app` varchar(50) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` varchar(500) DEFAULT NULL,
  `thumbnail` varchar(500) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `show_avatar` tinyint(1) DEFAULT 0,
  `custom_data` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phones`
--

CREATE TABLE `phone_phones` (
  `id` varchar(100) NOT NULL,
  `owner_id` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pin` varchar(4) DEFAULT NULL,
  `face_id` varchar(100) DEFAULT NULL,
  `settings` longtext DEFAULT NULL,
  `is_setup` tinyint(1) DEFAULT 0,
  `assigned` tinyint(1) DEFAULT 0,
  `battery` int(11) NOT NULL DEFAULT 100,
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_blocked_numbers`
--

CREATE TABLE `phone_phone_blocked_numbers` (
  `phone_number` varchar(15) NOT NULL,
  `blocked_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_calls`
--

CREATE TABLE `phone_phone_calls` (
  `id` int(10) UNSIGNED NOT NULL,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `answered` tinyint(1) DEFAULT 0,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_contacts`
--

CREATE TABLE `phone_phone_contacts` (
  `contact_phone_number` varchar(15) NOT NULL,
  `firstname` varchar(50) NOT NULL DEFAULT '',
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `profile_image` varchar(500) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `favourite` tinyint(1) DEFAULT 0,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_phone_voicemail`
--

CREATE TABLE `phone_phone_voicemail` (
  `id` int(10) UNSIGNED NOT NULL,
  `caller` varchar(15) NOT NULL,
  `callee` varchar(15) NOT NULL,
  `url` varchar(500) NOT NULL,
  `duration` int(11) NOT NULL,
  `hide_caller_id` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_photos`
--

CREATE TABLE `phone_photos` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `link` varchar(500) NOT NULL,
  `is_video` tinyint(1) DEFAULT 0,
  `size` float NOT NULL DEFAULT 0,
  `metadata` varchar(20) DEFAULT NULL,
  `is_favourite` tinyint(1) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_photo_albums`
--

CREATE TABLE `phone_photo_albums` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(100) NOT NULL,
  `shared` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_photo_album_members`
--

CREATE TABLE `phone_photo_album_members` (
  `album_id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_photo_album_photos`
--

CREATE TABLE `phone_photo_album_photos` (
  `album_id` int(11) NOT NULL,
  `photo_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_services_channels`
--

CREATE TABLE `phone_services_channels` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `company` varchar(50) NOT NULL,
  `last_message` varchar(100) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_services_messages`
--

CREATE TABLE `phone_services_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `channel_id` int(10) UNSIGNED NOT NULL,
  `sender` varchar(15) NOT NULL,
  `message` varchar(1000) NOT NULL,
  `x_pos` int(11) DEFAULT NULL,
  `y_pos` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_accounts`
--

CREATE TABLE `phone_tiktok_accounts` (
  `name` varchar(30) NOT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `like_count` int(11) NOT NULL DEFAULT 0,
  `video_count` int(11) NOT NULL DEFAULT 0,
  `twitter` varchar(20) DEFAULT NULL,
  `instagram` varchar(20) DEFAULT NULL,
  `show_likes` tinyint(1) DEFAULT 1,
  `phone_number` varchar(15) NOT NULL,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_channels`
--

CREATE TABLE `phone_tiktok_channels` (
  `id` varchar(10) NOT NULL,
  `last_message` varchar(50) NOT NULL,
  `member_1` varchar(20) NOT NULL,
  `member_2` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_comments`
--

CREATE TABLE `phone_tiktok_comments` (
  `id` varchar(10) NOT NULL,
  `reply_to` varchar(10) DEFAULT NULL,
  `video_id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `comment` varchar(550) NOT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `replies` int(11) NOT NULL DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_comments_likes`
--

CREATE TABLE `phone_tiktok_comments_likes` (
  `username` varchar(20) NOT NULL,
  `comment_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_follows`
--

CREATE TABLE `phone_tiktok_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_likes`
--

CREATE TABLE `phone_tiktok_likes` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_messages`
--

CREATE TABLE `phone_tiktok_messages` (
  `id` varchar(10) NOT NULL,
  `channel_id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `content` varchar(500) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_notifications`
--

CREATE TABLE `phone_tiktok_notifications` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `video_id` varchar(10) DEFAULT NULL,
  `comment_id` varchar(10) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_pinned_videos`
--

CREATE TABLE `phone_tiktok_pinned_videos` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_saves`
--

CREATE TABLE `phone_tiktok_saves` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_unread_messages`
--

CREATE TABLE `phone_tiktok_unread_messages` (
  `username` varchar(20) NOT NULL,
  `channel_id` varchar(10) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_videos`
--

CREATE TABLE `phone_tiktok_videos` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `src` varchar(500) NOT NULL,
  `caption` varchar(100) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `music` text DEFAULT NULL,
  `likes` int(11) NOT NULL DEFAULT 0,
  `comments` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0,
  `saves` int(11) NOT NULL DEFAULT 0,
  `pinned_comment` varchar(10) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tiktok_views`
--

CREATE TABLE `phone_tiktok_views` (
  `username` varchar(20) NOT NULL,
  `video_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_accounts`
--

CREATE TABLE `phone_tinder_accounts` (
  `name` varchar(50) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `photos` text DEFAULT NULL,
  `bio` varchar(500) DEFAULT NULL,
  `dob` date NOT NULL,
  `is_male` tinyint(1) NOT NULL,
  `interested_men` tinyint(1) NOT NULL,
  `interested_women` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `last_seen` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_matches`
--

CREATE TABLE `phone_tinder_matches` (
  `phone_number_1` varchar(15) NOT NULL,
  `phone_number_2` varchar(15) NOT NULL,
  `latest_message` varchar(1000) DEFAULT NULL,
  `latest_message_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_messages`
--

CREATE TABLE `phone_tinder_messages` (
  `id` int(11) NOT NULL,
  `sender` varchar(15) NOT NULL,
  `recipient` varchar(15) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_tinder_swipes`
--

CREATE TABLE `phone_tinder_swipes` (
  `swiper` varchar(15) NOT NULL,
  `swipee` varchar(15) NOT NULL,
  `liked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_accounts`
--

CREATE TABLE `phone_twitter_accounts` (
  `display_name` varchar(30) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `bio` varchar(100) DEFAULT NULL,
  `profile_image` varchar(500) DEFAULT NULL,
  `profile_header` varchar(500) DEFAULT NULL,
  `pinned_tweet` varchar(50) DEFAULT NULL,
  `verified` tinyint(1) DEFAULT 0,
  `follower_count` int(11) NOT NULL DEFAULT 0,
  `following_count` int(11) NOT NULL DEFAULT 0,
  `private` tinyint(1) DEFAULT 0,
  `date_joined` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_follows`
--

CREATE TABLE `phone_twitter_follows` (
  `followed` varchar(20) NOT NULL,
  `follower` varchar(20) NOT NULL,
  `notifications` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_follow_requests`
--

CREATE TABLE `phone_twitter_follow_requests` (
  `requester` varchar(20) NOT NULL,
  `requestee` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_hashtags`
--

CREATE TABLE `phone_twitter_hashtags` (
  `hashtag` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `last_used` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_likes`
--

CREATE TABLE `phone_twitter_likes` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_messages`
--

CREATE TABLE `phone_twitter_messages` (
  `id` varchar(10) NOT NULL,
  `sender` varchar(20) NOT NULL,
  `recipient` varchar(20) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_notifications`
--

CREATE TABLE `phone_twitter_notifications` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `from` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `tweet_id` varchar(50) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_promoted`
--

CREATE TABLE `phone_twitter_promoted` (
  `tweet_id` varchar(50) NOT NULL,
  `promotions` int(11) NOT NULL DEFAULT 0,
  `views` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_retweets`
--

CREATE TABLE `phone_twitter_retweets` (
  `tweet_id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_twitter_tweets`
--

CREATE TABLE `phone_twitter_tweets` (
  `id` varchar(10) NOT NULL,
  `username` varchar(20) NOT NULL,
  `content` varchar(280) DEFAULT NULL,
  `attachments` text DEFAULT NULL,
  `reply_to` varchar(50) DEFAULT NULL,
  `like_count` int(11) DEFAULT 0,
  `reply_count` int(11) DEFAULT 0,
  `retweet_count` int(11) DEFAULT 0,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_voice_memos_recordings`
--

CREATE TABLE `phone_voice_memos_recordings` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `file_name` varchar(50) NOT NULL,
  `file_url` varchar(500) NOT NULL,
  `file_length` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_wallet_transactions`
--

CREATE TABLE `phone_wallet_transactions` (
  `id` int(11) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `amount` int(11) NOT NULL,
  `company` varchar(50) NOT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `phone_yellow_pages_posts`
--

CREATE TABLE `phone_yellow_pages_posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `placed_lights`
--

CREATE TABLE `placed_lights` (
  `id` varchar(60) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `placed_pots`
--

CREATE TABLE `placed_pots` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` float NOT NULL,
  `type` varchar(50) DEFAULT 'empty',
  `stage` int(11) DEFAULT 1,
  `growth` float DEFAULT 0,
  `waterLevel` float DEFAULT 0,
  `lightLevel` float DEFAULT 0,
  `fertilizerLevel` float DEFAULT 0,
  `plantTime` bigint(20) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `state` varchar(50) DEFAULT 'empty'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `playerskins`
--

CREATE TABLE `playerskins` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `player_fishing`
--

CREATE TABLE `player_fishing` (
  `UniqueID` int(11) DEFAULT NULL,
  `level` longtext DEFAULT 0,
  `fishList` longtext DEFAULT NULL,
  `permit` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_fishing`
--

INSERT INTO `player_fishing` (`UniqueID`, `level`, `fishList`, `permit`) VALUES
(1, '0', '[]', '0'),
(11, '0', '[]', '0'),
(61, '0', '[]', '0'),
(2, '0', '[]', '0'),
(1, '0', '[]', '0'),
(11, '0', '[]', '0'),
(61, '0', '[]', '0'),
(2, '0', '[]', '0');

-- --------------------------------------------------------

--
-- Structure de la table `player_outfits`
--

CREATE TABLE `player_outfits` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player_outfits`
--

INSERT INTO `player_outfits` (`id`, `citizenid`, `outfitname`, `model`, `props`, `components`) VALUES
(26, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'T', 'mp_m_freemode_01', '[{\"texture\":-1,\"drawable\":-1,\"prop_id\":0},{\"texture\":-1,\"drawable\":-1,\"prop_id\":1},{\"texture\":-1,\"drawable\":-1,\"prop_id\":2},{\"texture\":-1,\"drawable\":-1,\"prop_id\":6},{\"texture\":-1,\"drawable\":-1,\"prop_id\":7}]', '[{\"texture\":0,\"drawable\":0,\"component_id\":0},{\"texture\":0,\"drawable\":0,\"component_id\":1},{\"texture\":0,\"drawable\":90,\"component_id\":2},{\"texture\":0,\"drawable\":11,\"component_id\":3},{\"texture\":2,\"drawable\":37,\"component_id\":4},{\"texture\":0,\"drawable\":0,\"component_id\":5},{\"texture\":0,\"drawable\":37,\"component_id\":6},{\"texture\":0,\"drawable\":0,\"component_id\":7},{\"texture\":0,\"drawable\":15,\"component_id\":8},{\"texture\":0,\"drawable\":0,\"component_id\":9},{\"texture\":0,\"drawable\":0,\"component_id\":10},{\"texture\":0,\"drawable\":36,\"component_id\":11}]'),
(27, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'DDD', 'mp_m_freemode_01', '[{\"drawable\":-1,\"texture\":-1,\"prop_id\":0},{\"drawable\":-1,\"texture\":-1,\"prop_id\":1},{\"drawable\":-1,\"texture\":-1,\"prop_id\":2},{\"drawable\":-1,\"texture\":-1,\"prop_id\":6},{\"drawable\":-1,\"texture\":-1,\"prop_id\":7}]', '[{\"drawable\":0,\"texture\":0,\"component_id\":0},{\"drawable\":0,\"texture\":0,\"component_id\":1},{\"drawable\":90,\"texture\":0,\"component_id\":2},{\"drawable\":11,\"texture\":0,\"component_id\":3},{\"drawable\":37,\"texture\":2,\"component_id\":4},{\"drawable\":0,\"texture\":0,\"component_id\":5},{\"drawable\":37,\"texture\":0,\"component_id\":6},{\"drawable\":0,\"texture\":0,\"component_id\":7},{\"drawable\":15,\"texture\":0,\"component_id\":8},{\"drawable\":0,\"texture\":0,\"component_id\":9},{\"drawable\":0,\"texture\":0,\"component_id\":10},{\"drawable\":8,\"texture\":1,\"component_id\":11}]'),
(28, 'f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 'ZZZ', 'mp_m_freemode_01', '[{\"prop_id\":0,\"drawable\":-1,\"texture\":-1},{\"prop_id\":1,\"drawable\":-1,\"texture\":-1},{\"prop_id\":2,\"drawable\":-1,\"texture\":-1},{\"prop_id\":6,\"drawable\":-1,\"texture\":-1},{\"prop_id\":7,\"drawable\":-1,\"texture\":-1}]', '[{\"component_id\":0,\"drawable\":0,\"texture\":0},{\"component_id\":1,\"drawable\":0,\"texture\":0},{\"component_id\":2,\"drawable\":90,\"texture\":0},{\"component_id\":3,\"drawable\":11,\"texture\":0},{\"component_id\":4,\"drawable\":37,\"texture\":2},{\"component_id\":5,\"drawable\":0,\"texture\":0},{\"component_id\":6,\"drawable\":37,\"texture\":0},{\"component_id\":7,\"drawable\":0,\"texture\":0},{\"component_id\":8,\"drawable\":15,\"texture\":0},{\"component_id\":9,\"drawable\":0,\"texture\":0},{\"component_id\":10,\"drawable\":0,\"texture\":0},{\"component_id\":11,\"drawable\":8,\"texture\":1}]');

-- --------------------------------------------------------

--
-- Structure de la table `player_outfit_codes`
--

CREATE TABLE `player_outfit_codes` (
  `id` int(11) NOT NULL,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_actions`
--

CREATE TABLE `police_actions` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `action_type` varchar(50) NOT NULL COMMENT 'tracker_placed, tracker_removed, bracelet_placed, bracelet_removed, zone_created, zone_removed, etc.',
  `target_identifier` varchar(60) DEFAULT NULL,
  `target_name` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `police_actions`
--

INSERT INTO `police_actions` (`id`, `officer_identifier`, `officer_name`, `action_type`, `target_identifier`, `target_name`, `details`, `created_at`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'tracker_placed', NULL, NULL, 'Plaque: 199ITUC1', '2026-01-23 04:50:23');

-- --------------------------------------------------------

--
-- Structure de la table `police_backup_requests`
--

CREATE TABLE `police_backup_requests` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `priority` enum('petit','importante','omgad') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `police_backup_requests`
--

INSERT INTO `police_backup_requests` (`id`, `officer_identifier`, `officer_name`, `x`, `y`, `z`, `priority`, `created_at`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 121.029, 120.924, 113.781, 'petit', '2026-01-23 04:21:13');

-- --------------------------------------------------------

--
-- Structure de la table `police_bracelets`
--

CREATE TABLE `police_bracelets` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `target_identifier` varchar(60) NOT NULL,
  `target_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_fines`
--

CREATE TABLE `police_fines` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `target_identifier` varchar(60) NOT NULL,
  `target_name` varchar(100) NOT NULL,
  `amount` int(11) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_searches`
--

CREATE TABLE `police_searches` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `target_identifier` varchar(60) NOT NULL,
  `target_name` varchar(100) NOT NULL,
  `items_confiscated` text DEFAULT NULL COMMENT 'JSON des items confisqués',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_service_logs`
--

CREATE TABLE `police_service_logs` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `action` enum('prise','fin','pause','control','refus','crime') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `police_service_logs`
--

INSERT INTO `police_service_logs` (`id`, `officer_identifier`, `officer_name`, `action`, `created_at`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:21:08'),
(2, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:25:10'),
(3, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:25:30'),
(4, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:33:59'),
(5, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-23 04:34:00'),
(6, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:45:56'),
(7, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:49:02'),
(8, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'pause', '2026-01-23 04:50:02'),
(9, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:52:03'),
(10, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-23 04:52:12'),
(11, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:52:17'),
(12, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-23 04:52:29'),
(13, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:52:30'),
(14, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 04:53:42'),
(15, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-23 04:53:44'),
(16, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 05:03:33'),
(17, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 05:40:43'),
(18, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-23 06:04:36'),
(19, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-28 16:32:40'),
(20, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-30 17:56:52'),
(21, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:15:56'),
(22, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:16:19'),
(23, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:16:20'),
(24, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:16:20'),
(25, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:16:20'),
(26, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:16:21'),
(27, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:16:21'),
(28, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:16:37'),
(29, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:16:38'),
(30, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:16:57'),
(31, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:16:57'),
(32, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:10'),
(33, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:10'),
(34, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:11'),
(35, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:11'),
(36, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:11'),
(37, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:23'),
(38, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:23'),
(39, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:24'),
(40, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:24'),
(41, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:24'),
(42, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:24'),
(43, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:24'),
(44, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:38'),
(45, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:38'),
(46, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:39'),
(47, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:53'),
(48, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:53'),
(49, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 13:17:53'),
(50, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'fin', '2026-01-31 13:17:54'),
(51, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'Angel Holl', 'prise', '2026-01-31 16:25:09');

-- --------------------------------------------------------

--
-- Structure de la table `police_tests`
--

CREATE TABLE `police_tests` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `target_identifier` varchar(60) NOT NULL,
  `target_name` varchar(100) NOT NULL,
  `test_type` enum('alcool','drogue') NOT NULL,
  `result` enum('positif','negatif') NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_trackers`
--

CREATE TABLE `police_trackers` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `vehicle_plate` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `police_zones`
--

CREATE TABLE `police_zones` (
  `id` int(11) NOT NULL,
  `officer_identifier` varchar(60) NOT NULL,
  `officer_name` varchar(100) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `radius` float NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `propcreator`
--

CREATE TABLE `propcreator` (
  `id` int(11) NOT NULL,
  `propname` varchar(255) NOT NULL,
  `x` double NOT NULL,
  `y` double NOT NULL,
  `z` double NOT NULL,
  `rotationx` double DEFAULT NULL,
  `rotationy` double DEFAULT NULL,
  `rotationz` double DEFAULT NULL,
  `freeze` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `props_placed`
--

CREATE TABLE `props_placed` (
  `id` int(11) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `heading` float DEFAULT 0,
  `frozen` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `props_placed`
--

INSERT INTO `props_placed` (`id`, `model`, `x`, `y`, `z`, `heading`, `frozen`) VALUES
(5, '1710403596', 200.085, -1467.72, 28.1508, 0, 0),
(6, '1710403596', 94.7604, -1402.37, 28.1859, 0, 0),
(7, '1710403596', 94.303, -1401.32, 28.1936, 0, 0),
(8, '1710403596', 92.9305, -1397.94, 28.2213, 0, 0),
(9, '1710403596', 92.8644, -1398.58, 28.2129, 0, 0),
(10, '1710403596', 85.8011, -1382.57, 28.3008, 0, 0),
(11, '766375082', -13.5073, 11.3569, 71.4359, 0.0352577, 0),
(12, '896078401', -11.6163, 10.501, 70.2809, 0.033061, 0);

-- --------------------------------------------------------

--
-- Structure de la table `sakakak_cooldowns`
--

CREATE TABLE `sakakak_cooldowns` (
  `identifier` varchar(60) NOT NULL,
  `last_mission` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `seyo_hairpos`
--

CREATE TABLE `seyo_hairpos` (
  `id` int(11) NOT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `marker_type` int(11) DEFAULT NULL,
  `marker_color_r` int(11) DEFAULT 255,
  `marker_color_g` int(11) DEFAULT 255,
  `marker_color_b` int(11) DEFAULT 255,
  `blip_name` varchar(64) DEFAULT NULL,
  `blip_color` int(11) DEFAULT NULL,
  `blip_scale` float DEFAULT 0.8
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `shop_accounts`
--

CREATE TABLE `shop_accounts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `shop_code` varchar(10) NOT NULL,
  `coins` int(11) NOT NULL DEFAULT 0,
  `loyalty_points` int(11) NOT NULL DEFAULT 0,
  `vip_level` varchar(20) DEFAULT NULL,
  `vip_expiration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `shop_accounts`
--

INSERT INTO `shop_accounts` (`id`, `identifier`, `shop_code`, `coins`, `loyalty_points`, `vip_level`, `vip_expiration`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '520523', 43810, 520, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `shop_transactions`
--

CREATE TABLE `shop_transactions` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `item_id` varchar(50) NOT NULL,
  `item_title` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `shop_transactions`
--

INSERT INTO `shop_transactions` (`id`, `identifier`, `item_id`, `item_title`, `price`, `timestamp`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'vehicle_sultan', 'Sultan', 800, 1769151865),
(2, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'vehicle_sultan', 'Sultan', 800, 1769802635),
(3, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'vehicle_gbcomets2r', 'Comet S2R', 3000, 1769856457),
(4, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'item_boombox', 'Enciente portative', 100, 1769859423),
(5, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', 'pack_premium', 'Pack Premium', 1500, 1769860523);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(46) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `story` longtext DEFAULT NULL,
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `job2` varchar(20) DEFAULT 'unemployed2',
  `job2_grade` int(11) DEFAULT 0,
  `is_dead` tinyint(1) DEFAULT 0,
  `nationality` varchar(50) DEFAULT NULL,
  `playtime_minutes` int(11) NOT NULL DEFAULT 0,
  `emote_favorites` longtext DEFAULT NULL,
  `timecycle` varchar(255) DEFAULT NULL,
  `strength` float DEFAULT NULL,
  `walk` varchar(255) DEFAULT NULL,
  `expression_anim` varchar(255) DEFAULT NULL,
  `overlay` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `current_property_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users_outfits`
--

CREATE TABLE `users_outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `outfit` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`outfit`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user_outfits`
--

CREATE TABLE `user_outfits` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `outfit_data` longtext NOT NULL,
  `slot` int(11) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_outfits`
--

INSERT INTO `user_outfits` (`id`, `identifier`, `outfit_data`, `slot`, `active`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '{\"comp6_2\":0,\"comp8\":15,\"comp6\":341,\"comp4_2\":0,\"comp8_2\":0,\"comp11_2\":2,\"comp3\":1,\"comp7\":0,\"comp4\":11,\"comp7_2\":0,\"comp11\":1125,\"comp3_2\":0}', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `user_outfit_save`
--

CREATE TABLE `user_outfit_save` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `outfit_data` longtext NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Tenue personnalisée'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_outfit_save`
--

INSERT INTO `user_outfit_save` (`id`, `identifier`, `outfit_data`, `name`) VALUES
(1, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '{\"comp7\":79,\"comp9\":79,\"comp4_2\":0,\"comp11_2\":5,\"comp11\":193,\"comp3\":1,\"comp9_2\":0,\"comp3_2\":0,\"comp6\":299,\"comp4\":35,\"comp8\":211,\"comp8_2\":0,\"comp6_2\":0,\"comp7_2\":0}', 'SASP'),
(2, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '{\"comp4\":11,\"comp11\":1125,\"comp11_2\":2,\"comp6_2\":0,\"comp4_2\":0,\"comp6\":341}', 'Costume'),
(3, 'a8fa0dee473760971f7d4b1ab6fbc5e60b3413d0', '{\"comp11\":1125,\"comp6_2\":0,\"comp3_2\":0,\"comp6\":341,\"comp4\":11,\"comp8_2\":0,\"comp8\":15,\"comp4_2\":0,\"comp3\":1,\"comp11_2\":2}', 'News');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 900000, 'super'),
('Akuma', 'akuma', 7500, 'motorcycles'),
('Aleutian', 'aleutian', 100000, 'suvs'),
('Alpha', 'alpha', 60000, 'sports'),
('Ardent', 'ardent', 1150000, 'sportsclassics'),
('Asbo', 'asbo', 5000, 'compacts'),
('Asea', 'asea', 5500, 'sedans'),
('Asea2', 'asea2', 4600, 'sedans'),
('Asterope', 'asterope', 6000, 'sedans'),
('Asterope2', 'asterope2', 6000, 'sedans'),
('Astron', 'astron', 65000, 'suvs'),
('Autarch', 'autarch', 1955000, 'super'),
('Avarus', 'avarus', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller', 14190, 'suvs'),
('Baller', 'baller2', 40000, 'suvs'),
('Baller Sport', 'baller3', 60000, 'suvs'),
('Baller4', 'baller4', 150000, 'suvs'),
('Baller5', 'baller5', 93450, 'suvs'),
('Baller6', 'baller6', 180000, 'suvs'),
('Baller7', 'baller7', 180000, 'suvs'),
('Baller8', 'baller8', 14190, 'suvs'),
('Banshee', 'banshee', 70000, 'sports'),
('Banshee 900R', 'banshee2', 255000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 55000, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bf Injection', 'bfinjection', 16000, 'offroad'),
('Bifta', 'bifta', 11900, 'offroad'),
('Bison', 'bison', 45000, 'vans'),
('Bison2', 'bison2', 29595, 'vans'),
('Bison3', 'bison3', 29595, 'vans'),
('Bjxl', 'bjxl', 100000, 'suvs'),
('Blade', 'blade', 15000, 'muscle'),
('Blazer', 'blazer', 2100, 'offroad'),
('Blazer2', 'blazer2', 1500, 'offroad'),
('Blazer3', 'blazer3', 1600, 'offroad'),
('Blazer Sport', 'blazer4', 8500, 'offroad'),
('blazer5', 'blazer5', 1755600, 'offroad'),
('Blista', 'blista', 8000, 'compacts'),
('Blista2', 'blista2', 15000, 'sports'),
('Blista3', 'blista3', 7250, 'sports'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 32000, 'vans'),
('Bodhi2', 'bodhi2', 31460, 'offroad'),
('Boor', 'boor', 10000, 'offroad'),
('Boxville', 'boxville', 34630, 'vans'),
('Boxville2', 'boxville2', 34630, 'vans'),
('Boxville3', 'boxville3', 34630, 'vans'),
('Boxville4', 'boxville4', 34630, 'vans'),
('Boxville5', 'boxville5', 34630, 'vans'),
('Boxville6', 'boxville6', 34630, 'vans'),
('Brawler', 'brawler', 45000, 'offroad'),
('Brigham', 'brigham', 37600, 'muscle'),
('Brioso R/A', 'brioso', 18000, 'compacts'),
('Brioso2', 'brioso2', 7300, 'compacts'),
('Brioso3', 'brioso3', 15000, 'compacts'),
('Broadway', 'broadway', 35000, 'muscle'),
('Bruiser', 'bruiser', 24000, 'offroad'),
('Bruiser2', 'bruiser2', 24000, 'offroad'),
('Bruiser3', 'bruiser3', 24000, 'offroad'),
('Brutus', 'brutus', 24000, 'offroad'),
('Brutus2', 'brutus2', 24000, 'offroad'),
('Brutus3', 'brutus3', 24000, 'offroad'),
('Btype', 'btype', 62000, 'sportsclassics'),
('Btype Hotroad', 'btype2', 155000, 'sportsclassics'),
('Btype Luxe', 'btype3', 85000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 30000, 'muscle'),
('Buccaneer Rider', 'buccaneer2', 24000, 'muscle'),
('Buffalo', 'buffalo', 12000, 'sports'),
('Buffalo S', 'buffalo2', 20000, 'sports'),
('Buffalo3', 'buffalo3', 28000, 'sports'),
('Buffalo4', 'buffalo4', 70000, 'muscle'),
('Buffalo5', 'buffalo5', 70000, 'muscle'),
('Bullet', 'bullet', 90000, 'super'),
('Burrito', 'burrito', 29595, 'vans'),
('Burrito2', 'burrito2', 29595, 'vans'),
('Burrito', 'burrito3', 19000, 'vans'),
('Burrito4', 'burrito4', 29595, 'vans'),
('Burrito5', 'burrito5', 29595, 'vans'),
('Calico', 'calico', 35000, 'sports'),
('Camper', 'camper', 42000, 'vans'),
('Caracara', 'caracara', 90000, 'offroad'),
('Caracara2', 'caracara2', 75000, 'offroad'),
('Carbonizzare', 'carbonizzare', 75000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Casco', 'casco', 30000, 'sportsclassics'),
('Cavalcade', 'cavalcade', 6700, 'suvs'),
('Cavalcade', 'cavalcade2', 75100, 'suvs'),
('Cavalcade3', 'cavalcade3', 6700, 'suvs'),
('Champion', 'champion', 212000, 'super'),
('Cheburek', 'cheburek', 28400, 'sportsclassics'),
('Cheetah', 'cheetah', 375000, 'super'),
('Cheetah2', 'cheetah2', 1500000, 'sportsclassics'),
('Chimera', 'chimera', 15000, 'motorcycles'),
('Chino', 'chino', 20000, 'muscle'),
('Chino Luxe', 'chino2', 20000, 'muscle'),
('Cinquemila', 'cinquemila', 60000, 'sedans'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('Clique', 'clique', 47000, 'muscle'),
('Clique2', 'clique2', 47000, 'muscle'),
('Club', 'club', 5400, 'compacts'),
('Cog55', 'cog55', 170000, 'sedans'),
('Cog552', 'cog552', 170000, 'sedans'),
('Cognoscenti Cabrio', 'cogcabrio', 165000, 'coupes'),
('Cognoscenti', 'cognoscenti', 315000, 'sedans'),
('Cognoscenti2', 'cognoscenti2', 315000, 'sedans'),
('Comet', 'comet2', 23000, 'sports'),
('Comet3', 'comet3', 75000, 'sports'),
('Comet4', 'comet4', 148000, 'sports'),
('Comet 5', 'comet5', 120000, 'sports'),
('Comet6', 'comet6', 117000, 'sports'),
('Comet7', 'comet7', 130000, 'sports'),
('Contender', 'contender', 70000, 'suvs'),
('Coquette', 'coquette', 65000, 'sports'),
('Coquette Classic', 'coquette2', 40000, 'sportsclassics'),
('Coquette BlackFin', 'coquette3', 55000, 'muscle'),
('Coquette4', 'coquette4', 60000, 'sports'),
('Corsita', 'corsita', 50000, 'sports'),
('Coureur', 'coureur', 75000, 'sports'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cyclone', 'cyclone', 1890000, 'super'),
('Cypher', 'cypher', 62500, 'sports'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon High', 'daemon2', 13500, 'motorcycles'),
('Deathbike', 'deathbike', 100000, 'motorcycles'),
('Deathbike2', 'deathbike2', 100000, 'motorcycles'),
('Deathbike3', 'deathbike3', 100000, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deity', 'deity', 250000, 'sedans'),
('Deluxo', 'deluxo', 4721500, 'sportsclassics'),
('Deveste', 'deveste', 500000, 'super'),
('Deviant', 'deviant', 500000, 'muscle'),
('Diablous', 'diablous', 12500, 'motorcycles'),
('Diablous2', 'diablous2', 20000, 'motorcycles'),
('Dilettante', 'dilettante', 19600, 'compacts'),
('Dilettante2', 'dilettante2', 19600, 'compacts'),
('Dloader', 'dloader', 200000, 'offroad'),
('Dominator', 'dominator', 35000, 'muscle'),
('Dominator2', 'dominator2', 10000, 'muscle'),
('Dominator3', 'dominator3', 22200, 'muscle'),
('Dominator4', 'dominator4', 45000, 'muscle'),
('Dominator5', 'dominator5', 45000, 'muscle'),
('Dominator6', 'dominator6', 65000, 'muscle'),
('Dominator7', 'dominator7', 65000, 'muscle'),
('Dominator8', 'dominator8', 45000, 'muscle'),
('Dominator9', 'dominator9', 45000, 'muscle'),
('Dorado', 'dorado', 65000, 'suvs'),
('Double T', 'double', 24250, 'motorcycles'),
('Drafter', 'drafter', 100000, 'sports'),
('Draugur', 'draugur', 50000, 'offroad'),
('Drifteuros', 'drifteuros', 19000, 'sports'),
('Driftfr36', 'driftfr36', 34000, 'coupes'),
('Driftfuto', 'driftfuto', 19000, 'sports'),
('Driftjester', 'driftjester', 100000, 'sports'),
('Driftremus', 'driftremus', 24500, 'sports'),
('Drifttampa', 'drifttampa', 475000, 'sports'),
('Driftyosemite', 'driftyosemite', 133000, 'muscle'),
('Driftzr350', 'driftzr350', 14500, 'sports'),
('Dubsta', 'dubsta', 45000, 'suvs'),
('Dubsta Luxuary', 'dubsta2', 60000, 'suvs'),
('Bubsta 6x6', 'dubsta3', 120000, 'offroad'),
('Dukes', 'dukes', 35000, 'muscle'),
('Dukes2', 'dukes2', 35000, 'muscle'),
('Dukes3', 'dukes3', 35000, 'muscle'),
('Dune Buggy', 'dune', 8000, 'offroad'),
('Dune2', 'dune2', 5000, 'offroad'),
('Dune3', 'dune3', 5000, 'offroad'),
('Dune4', 'dune4', 5000, 'offroad'),
('Dune5', 'dune5', 5000, 'offroad'),
('Dynasty', 'Dynasty', 20000, 'sportsclassics'),
('Elegy', 'elegy', 4090, 'sports'),
('Elegy', 'elegy2', 38500, 'sports'),
('Ellie', 'ellie', 111700, 'muscle'),
('Emerus', 'emerus', 500000, 'super'),
('Emperor', 'emperor', 7700, 'sedans'),
('Emperor2', 'emperor2', 7700, 'sedans'),
('Emperor3', 'emperor3', 7700, 'sedans'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity2', 'entity2', 325000, 'super'),
('Entity3', 'entity3', 325000, 'super'),
('Entity XF', 'entityxf', 425000, 'super'),
('Esskey', 'esskey', 15900, 'motorcycles'),
('Eudora', 'eudora', 37600, 'muscle'),
('Euros', 'euros', 19000, 'sports'),
('Everon', 'everon', 68500, 'offroad'),
('Everon2', 'everon2', 68500, 'sports'),
('Exemplar', 'exemplar', 49000, 'coupes'),
('F620', 'f620', 87700, 'coupes'),
('Faction', 'faction', 20000, 'muscle'),
('Faction Rider', 'faction2', 30000, 'muscle'),
('Faction XL', 'faction3', 40000, 'muscle'),
('Fagaloa', 'fagaloa', 5000, 'sportsclassics'),
('Faggio', 'faggio', 1900, 'motorcycles'),
('Vespa', 'faggio2', 2700, 'motorcycles'),
('Faggio3', 'faggio3', 900, 'motorcycles'),
('Fcr', 'fcr', 4450, 'motorcycles'),
('Fcr2', 'fcr2', 12000, 'motorcycles'),
('Felon', 'felon', 50000, 'coupes'),
('Felon GT', 'felon2', 72000, 'coupes'),
('Feltzer', 'feltzer2', 55000, 'sports'),
('Stirling GT', 'feltzer3', 2650000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('Flashgt', 'flashgt', 100000, 'sports'),
('FMJ', 'fmj', 185000, 'super'),
('Fhantom', 'fq2', 17000, 'suvs'),
('Fr36', 'fr36', 34000, 'coupes'),
('Freecrawler', 'freecrawler', 120000, 'offroad'),
('Fugitive', 'fugitive', 12000, 'sedans'),
('Furia', 'furia', 450000, 'super'),
('Furore GT', 'furoregt', 200000, 'sports'),
('Fusilade', 'fusilade', 40000, 'sports'),
('Futo', 'futo', 5206, 'sports'),
('Futo2', 'futo2', 5206, 'sports'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 3100, 'muscle'),
('Gauntlet2', 'gauntlet2', 3400, 'muscle'),
('Gauntlet3', 'gauntlet3', 68000, 'muscle'),
('Gauntlet4', 'gauntlet4', 46000, 'muscle'),
('Gauntlet5', 'gauntlet5', 900000, 'muscle'),
('Gauntlet6', 'gauntlet6', 127350, 'sports'),
('Gb200', 'gb200', 280000, 'sports'),
('Gang Burrito', 'gburrito', 45000, 'vans'),
('Burrito', 'gburrito2', 29000, 'vans'),
('Glendale', 'glendale', 37000, 'sedans'),
('Glendale2', 'glendale2', 4000, 'sedans'),
('Gp1', 'gp1', 350000, 'super'),
('Grabger', 'granger', 48000, 'suvs'),
('Granger2', 'granger2', 110000, 'suvs'),
('Greenwood', 'greenwood', 34500, 'muscle'),
('Gresley', 'gresley', 47500, 'suvs'),
('Growler', 'growler', 62000, 'sports'),
('GT 500', 'gt500', 785000, 'sportsclassics'),
('Guardian', 'guardian', 45000, 'offroad'),
('Habanero', 'habanero', 8500, 'suvs'),
('Hakuchou', 'hakuchou', 20310, 'motorcycles'),
('Hakuchou Sport', 'hakuchou2', 27000, 'motorcycles'),
('Hellion', 'hellion', 24250, 'offroad'),
('Hermes', 'hermes', 535000, 'muscle'),
('Hexer', 'hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 125000, 'muscle'),
('Hotring', 'hotring', 45000, 'sports'),
('Huntley S', 'huntley', 40000, 'suvs'),
('Hustler', 'hustler', 625000, 'muscle'),
('Ignus', 'ignus', 300000, 'super'),
('Imorgon', 'imorgon', 420000, 'sports'),
('Impaler', 'impaler', 59500, 'muscle'),
('Impaler2', 'impaler2', 59500, 'muscle'),
('Impaler3', 'impaler3', 59500, 'muscle'),
('Impaler4', 'impaler4', 59500, 'muscle'),
('Impaler5', 'impaler5', 59500, 'sedans'),
('Impaler6', 'impaler6', 59500, 'muscle'),
('Imperator', 'imperator', 90000, 'muscle'),
('Imperator2', 'imperator2', 90000, 'muscle'),
('Imperator3', 'imperator3', 90000, 'muscle'),
('Infernus', 'infernus', 180000, 'super'),
('Infernus2', 'infernus2', 133600, 'sportsclassics'),
('Ingot', 'ingot', 2123, 'sedans'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Insurgent', 'insurgent', 90000, 'offroad'),
('Insurgent2', 'insurgent2', 90000, 'offroad'),
('Insurgent3', 'insurgent3', 90000, 'offroad'),
('Intruder', 'intruder', 7500, 'sedans'),
('Issi', 'issi2', 10000, 'compacts'),
('Issi3', 'issi3', 3100, 'compacts'),
('Issi4', 'issi4', 3100, 'compacts'),
('Issi5', 'issi5', 3100, 'compacts'),
('Issi6', 'issi6', 3100, 'compacts'),
('Issi7', 'issi7', 32000, 'sports'),
('Issi8', 'issi8', 65000, 'suvs'),
('Italigtb', 'italigtb', 500000, 'super'),
('Italigtb2', 'italigtb2', 500000, 'super'),
('Italigto', 'italigto', 500000, 'sports'),
('Italirsx', 'italirsx', 500000, 'sports'),
('Iwagen', 'iwagen', 70000, 'suvs'),
('Jackal', 'jackal', 38000, 'coupes'),
('Jb700', 'jb700', 5500000, 'sportsclassics'),
('Jb7002', 'jb7002', 5500000, 'sportsclassics'),
('Jester', 'jester', 65000, 'sports'),
('Jester(Racecar)', 'jester2', 135000, 'sports'),
('Jester3', 'jester3', 67500, 'sports'),
('Jester4', 'jester4', 50000, 'sports'),
('Journey', 'journey', 6500, 'vans'),
('Journey2', 'journey2', 6500, 'vans'),
('Jubilee', 'jubilee', 334000, 'suvs'),
('Jugular', 'jugular', 170000, 'sports'),
('Kalahari', 'kalahari', 17000, 'offroad'),
('Kamacho', 'kamacho', 70000, 'offroad'),
('Kanjo', 'kanjo', 8000, 'compacts'),
('Kanjosj', 'kanjosj', 8000, 'coupes'),
('Khamelion', 'khamelion', 38000, 'sports'),
('Komoda', 'komoda', 74000, 'sports'),
('Krieger', 'krieger', 1000000, 'super'),
('Kuruma', 'kuruma', 34500, 'sports'),
('Kuruma2', 'kuruma2', 34500, 'sports'),
('L35', 'l35', 13400, 'offroad'),
('Landstalker', 'landstalker', 35000, 'suvs'),
('Landstalker2', 'landstalker2', 84400, 'suvs'),
('RE-7B', 'le7b', 325000, 'super'),
('Lectro', 'lectro', 31550, 'motorcycles'),
('Limo2', 'limo2', 290000, 'sedans'),
('Lm87', 'lm87', 500000, 'super'),
('Locust', 'locust', 210000, 'sports'),
('Lurcher', 'Lurcher', 35000, 'muscle'),
('Lynx', 'lynx', 40000, 'sports'),
('Mamba', 'mamba', 70000, 'sports'),
('Manana', 'manana', 12800, 'sportsclassics'),
('Manana2', 'manana2', 19250, 'muscle'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Manchez2', 'manchez2', 11000, 'motorcycles'),
('Manchez3', 'manchez3', 5300, 'motorcycles'),
('Marshall', 'marshall', 24000, 'offroad'),
('Massacro', 'massacro', 27500, 'sports'),
('Massacro(Racecar)', 'massacro2', 130000, 'sports'),
('Menacer', 'menacer', 100000, 'offroad'),
('Mesa', 'mesa', 16000, 'suvs'),
('Mesa2', 'mesa2', 16000, 'suvs'),
('Mesa Trail', 'mesa3', 40000, 'suvs'),
('Michelli', 'michelli', 35400, 'sportsclassics'),
('Minivan', 'minivan', 13000, 'vans'),
('Minivan2', 'minivan2', 15000, 'vans'),
('Monroe', 'monroe', 55000, 'sportsclassics'),
('The Liberator', 'monster', 30000, 'offroad'),
('Monster3', 'monster3', 24000, 'offroad'),
('Monster4', 'monster4', 24000, 'offroad'),
('Monster5', 'monster5', 24000, 'offroad'),
('Monstrociti', 'monstrociti', 24000, 'offroad'),
('Moonbeam', 'moonbeam', 18000, 'vans'),
('Moonbeam Rider', 'moonbeam2', 35000, 'vans'),
('Nebula', 'nebula', 13000, 'sportsclassics'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neo', 'neo', 355000, 'sports'),
('Neon', 'neon', 1500000, 'sports'),
('Nero', 'nero', 1000000, 'super'),
('Nero2', 'nero2', 1000000, 'super'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 65000, 'muscle'),
('Nightshark', 'nightshark', 100000, 'offroad'),
('9F', 'ninef', 65000, 'sports'),
('9F Cabrio', 'ninef2', 80000, 'sports'),
('Novak', 'Novak', 88000, 'suvs'),
('Omnis', 'omnis', 35000, 'sports'),
('Omnisegt', 'omnisegt', 50000, 'sports'),
('Oppressor', 'oppressor', 3524500, 'super'),
('Oppressor2', 'oppressor2', 3000000, 'motorcycles'),
('Oracle', 'oracle', 24850, 'coupes'),
('Oracle XS', 'oracle2', 8900, 'coupes'),
('Osiris', 'osiris', 160000, 'super'),
('Outlaw', 'outlaw', 29900, 'offroad'),
('Panthere', 'panthere', 50000, 'sports'),
('Panto', 'panto', 10000, 'compacts'),
('Paradise', 'paradise', 19000, 'vans'),
('Paragon', 'paragon', 215000, 'sports'),
('Paragon2', 'paragon2', 215000, 'sports'),
('Pariah', 'pariah', 1420000, 'sports'),
('Patriot', 'patriot', 12000, 'suvs'),
('Patriot2', 'patriot2', 79000, 'suvs'),
('Patriot3', 'patriot3', 200000, 'offroad'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penetrator', 'penetrator', 500000, 'super'),
('Penumbra', 'penumbra', 28000, 'sports'),
('Penumbra2', 'penumbra2', 13400, 'sports'),
('Peyote', 'peyote', 15000, 'sportsclassics'),
('Peyote2', 'peyote2', 37500, 'muscle'),
('Peyote3', 'peyote3', 37500, 'sportsclassics'),
('Pfister', 'pfister811', 85000, 'super'),
('Phoenix', 'phoenix', 12500, 'muscle'),
('Picador', 'picador', 18000, 'muscle'),
('Pigalle', 'pigalle', 20000, 'sportsclassics'),
('Pony', 'pony', 19000, 'vans'),
('Pony2', 'pony2', 19000, 'vans'),
('Postlude', 'postlude', 34000, 'coupes'),
('Powersurge', 'powersurge', 20000, 'motorcycles'),
('Prairie', 'prairie', 12000, 'compacts'),
('Premier', 'premier', 8000, 'sedans'),
('Previon', 'previon', 4200, 'coupes'),
('Primo', 'primo', 4990, 'sedans'),
('Primo Custom', 'primo2', 6000, 'sedans'),
('X80 Proto', 'prototipo', 2500000, 'super'),
('R300', 'r300', 35000, 'sports'),
('Radius', 'radi', 29000, 'suvs'),
('raiden', 'raiden', 1375000, 'sports'),
('Rancherxl', 'rancherxl', 6000, 'offroad'),
('Rancherxl2', 'rancherxl2', 6000, 'offroad'),
('Rapid GT', 'rapidgt', 35000, 'sports'),
('Rapid GT Convertible', 'rapidgt2', 45000, 'sports'),
('Rapid GT3', 'rapidgt3', 885000, 'sportsclassics'),
('Raptor', 'raptor', 60000, 'sports'),
('Ratbike', 'ratbike', 37000, 'motorcycles'),
('Ratel', 'ratel', 37000, 'offroad'),
('Ratloader', 'ratloader', 22000, 'muscle'),
('Ratloader2', 'ratloader2', 22000, 'muscle'),
('Rcbandito', 'rcbandito', 300000, 'offroad'),
('Reaper', 'reaper', 150000, 'super'),
('Rebel', 'rebel', 38000, 'offroad'),
('Rebel', 'rebel2', 38000, 'offroad'),
('Rebla', 'rebla', 60700, 'suvs'),
('Reever', 'reever', 85000, 'motorcycles'),
('Regina', 'regina', 5000, 'sedans'),
('Remus', 'remus', 24500, 'sports'),
('Retinue', 'retinue', 615000, 'sportsclassics'),
('Retinue2', 'retinue2', 21000, 'sportsclassics'),
('Revolter', 'revolter', 1610000, 'sports'),
('Rhapsody', 'rhapsody', 31000, 'compacts'),
('Rhinehart', 'rhinehart', 19500, 'sedans'),
('riata', 'riata', 380000, 'offroad'),
('Rocoto', 'rocoto', 45000, 'suvs'),
('Romero', 'romero', 18000, 'sedans'),
('Rrocket', 'rrocket', 240000, 'motorcycles'),
('Rt3000', 'rt3000', 35000, 'sports'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner', 'ruiner', 5000, 'muscle'),
('Ruiner 2', 'ruiner2', 5745600, 'muscle'),
('Ruiner3', 'ruiner3', 24000, 'muscle'),
('Ruiner4', 'ruiner4', 24000, 'muscle'),
('Rumpo', 'rumpo', 15000, 'vans'),
('Rumpo2', 'rumpo2', 19500, 'vans'),
('Rumpo Trail', 'rumpo3', 19500, 'vans'),
('Ruston', 'ruston', 80000, 'sports'),
('S80', 's80', 24000, 'super'),
('Sabre Turbo', 'sabregt', 20000, 'muscle'),
('Sabre GT', 'sabregt2', 25000, 'muscle'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('Sanctus', 'sanctus', 25000, 'motorcycles'),
('Sandking', 'sandking', 55000, 'offroad'),
('Sandking2', 'sandking2', 55000, 'offroad'),
('Savestra', 'savestra', 99000, 'sportsclassics'),
('SC 1', 'sc1', 1603000, 'super'),
('Schafter', 'schafter2', 25000, 'sedans'),
('Schafter V12', 'schafter3', 50000, 'sports'),
('Schafter4', 'schafter4', 78000, 'sports'),
('Schafter5', 'schafter5', 78000, 'sedans'),
('Schafter6', 'schafter6', 78000, 'sedans'),
('Schlagen', 'schlagen', 212000, 'sports'),
('Schwarzer', 'schwarzer', 76450, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Scramjet', 'scramjet', 2500000, 'super'),
('Seminole', 'seminole', 25000, 'suvs'),
('Seminole2', 'seminole2', 84400, 'suvs'),
('Sentinel', 'sentinel', 32000, 'coupes'),
('Sentinel XS', 'sentinel2', 40000, 'coupes'),
('Sentinel3', 'sentinel3', 34000, 'sports'),
('Sentinel4', 'sentinel4', 34000, 'sports'),
('Serrano', 'serrano', 8400, 'suvs'),
('Seven 70', 'seven70', 39500, 'sports'),
('ETR1', 'sheava', 220000, 'super'),
('Shinobi', 'shinobi', 8500, 'motorcycles'),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
('Slamvan', 'slamvan', 32000, 'muscle'),
('Slamvan2', 'slamvan2', 32000, 'muscle'),
('Slam Van', 'slamvan3', 11500, 'muscle'),
('Slamvan4', 'slamvan4', 32000, 'muscle'),
('Slamvan5', 'slamvan5', 32000, 'muscle'),
('Slamvan6', 'slamvan6', 32000, 'muscle'),
('Sm722', 'sm722', 32000, 'sports'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Specter', 'specter', 3000000, 'sports'),
('Specter2', 'specter2', 3002000, 'sports'),
('Speedo', 'speedo', 19000, 'vans'),
('Speedo2', 'speedo2', 19000, 'vans'),
('Speedo4', 'speedo4', 19000, 'vans'),
('Speedo5', 'speedo5', 19000, 'vans'),
('Squaddie', 'squaddie', 30000, 'suvs'),
('Stafford', 'stafford', 26000, 'sedans'),
('Stalion', 'stalion', 22000, 'muscle'),
('Stalion2', 'stalion2', 25000, 'muscle'),
('Stanier', 'stanier', 5000, 'sedans'),
('Stinger', 'stinger', 80000, 'sportsclassics'),
('Stinger GT', 'stingergt', 75000, 'sportsclassics'),
('Stingertt', 'stingertt', 75000, 'sports'),
('Stratum', 'stratum', 5000, 'sedans'),
('Streiter', 'streiter', 500000, 'sports'),
('Stretch', 'stretch', 90000, 'sedans'),
('Stromberg', 'stromberg', 3185350, 'sports'),
('Stryder', 'Stryder', 60000, 'motorcycles'),
('Sugoi', 'Sugoi', 45000, 'sports'),
('Sultan', 'sultan', 15000, 'sports'),
('Sultan2', 'sultan2', 12500, 'sports'),
('Sultan3', 'sultan3', 115000, 'sports'),
('Sultan RS', 'sultanrs', 65000, 'super'),
('Super Diamond', 'superd', 130000, 'sedans'),
('Surano', 'surano', 50000, 'sports'),
('Surfer', 'surfer', 12000, 'vans'),
('Surfer2', 'surfer2', 12000, 'vans'),
('Surfer3', 'surfer3', 12000, 'vans'),
('Surge', 'surge', 31200, 'sedans'),
('Swinger', 'swinger', 31200, 'sportsclassics'),
('T20', 't20', 300000, 'super'),
('Taco', 'taco', 10000, 'vans'),
('Tahoma', 'tahoma', 13450, 'muscle'),
('Tailgater', 'tailgater', 30000, 'sedans'),
('Tailgater2', 'tailgater2', 30000, 'sedans'),
('Taipan', 'taipan', 1345000, 'super'),
('Tampa', 'tampa', 16000, 'muscle'),
('Drift Tampa', 'tampa2', 475000, 'sports'),
('Tampa3', 'tampa3', 30000, 'muscle'),
('Technical', 'technical', 134500, 'offroad'),
('Technical2', 'technical2', 134500, 'offroad'),
('Technical3', 'technical3', 134500, 'offroad'),
('Tempesta', 'tempesta', 500000, 'super'),
('Tenf', 'tenf', 75000, 'sports'),
('Tenf2', 'tenf2', 75000, 'sports'),
('Terminus', 'terminus', 25000, 'offroad'),
('Tezeract', 'tezeract', 500000, 'super'),
('Thrax', 'thrax', 300000, 'super'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Tigon', 'tigon', 2500000, 'super'),
('Toreador', 'toreador', 1250000, 'sportsclassics'),
('Torero', 'torero', 150000, 'sportsclassics'),
('Torero2', 'torero2', 150000, 'super'),
('Tornado', 'tornado', 5000, 'sportsclassics'),
('Tornado2', 'tornado2', 5000, 'sportsclassics'),
('Tornado3', 'tornado3', 5000, 'sportsclassics'),
('Tornado4', 'tornado4', 5000, 'sportsclassics'),
('Tornado5', 'tornado5', 5000, 'sportsclassics'),
('Tornado6', 'tornado6', 5000, 'sportsclassics'),
('Toros', 'toros', 121600, 'suvs'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 60000, 'offroad'),
('Trophy Truck Limited', 'trophytruck2', 80000, 'offroad'),
('Tropos', 'tropos', 40000, 'sports'),
('Tulip', 'tulip', 35000, 'muscle'),
('Tulip2', 'tulip2', 35000, 'muscle'),
('Turismo2', 'turismo2', 350000, 'sportsclassics'),
('Turismo3', 'turismo3', 350000, 'super'),
('Turismo R', 'turismor', 350000, 'super'),
('Tyrant', 'tyrant', 600000, 'super'),
('Tyrus', 'tyrus', 600000, 'super'),
('Vacca', 'vacca', 120000, 'super'),
('Vader', 'vader', 7200, 'motorcycles'),
('Vagner', 'vagner', 800000, 'super'),
('Vagrant', 'vagrant', 450000, 'offroad'),
('Vamos', 'vamos', 34500, 'muscle'),
('Vectre', 'vectre', 89000, 'sports'),
('Verlierer', 'verlierer2', 70000, 'sports'),
('Verus', 'verus', 36000, 'offroad'),
('Veto', 'veto', 6000, 'sports'),
('Veto2', 'veto2', 6000, 'sports'),
('Vigero', 'vigero', 12500, 'muscle'),
('Vigero2', 'vigero2', 12500, 'muscle'),
('Vigero3', 'Vigero3', 65000, 'muscle'),
('Vigilante', 'vigilante', 120000, 'super'),
('Vindicator', 'vindicator', 11300, 'motorcycles'),
('Virgo', 'virgo', 14000, 'muscle'),
('Virgo2', 'virgo2', 6300, 'muscle'),
('Virgo3', 'virgo3', 6300, 'muscle'),
('Virtue', 'virtue', 85000, 'super'),
('Viseris', 'viseris', 875000, 'sportsclassics'),
('Visione', 'visione', 2250000, 'super'),
('Vivanite', 'vivanite', 121600, 'suvs'),
('Voltic', 'voltic', 90000, 'super'),
('Voltic 2', 'voltic2', 3830400, 'super'),
('Voodoo', 'voodoo', 7200, 'muscle'),
('Voodoo2', 'voodoo2', 8000, 'muscle'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('Vstr', 'vstr', 110000, 'sports'),
('Warrener', 'warrener', 4000, 'sedans'),
('Warrener2', 'warrener2', 11000, 'sedans'),
('Washington', 'washington', 9000, 'sedans'),
('Weevil', 'weevil', 5000, 'compacts'),
('Weevil2', 'weevil2', 2500, 'muscle'),
('Windsor', 'windsor', 95000, 'coupes'),
('Windsor Drop', 'windsor2', 125000, 'coupes'),
('Winky', 'winky', 25000, 'offroad'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('Xa21', 'xa21', 800000, 'super'),
('XLS', 'xls', 32000, 'suvs'),
('Xls2', 'xls2', 82000, 'suvs'),
('Yosemite', 'yosemite', 485000, 'muscle'),
('Yosemite2', 'yosemite2', 133000, 'muscle'),
('Yosemite3', 'yosemite3', 120000, 'offroad'),
('Youga', 'youga', 10800, 'vans'),
('Youga Luxuary', 'youga2', 14500, 'vans'),
('Youga3', 'youga3', 14500, 'vans'),
('Youga4', 'youga4', 14500, 'vans'),
('Z190', 'z190', 900000, 'sportsclassics'),
('Zeno', 'zeno', 2250000, 'super'),
('Zentorno', 'zentorno', 1500000, 'super'),
('Zhaba', 'zhaba', 800000, 'offroad'),
('Zion', 'zion', 36000, 'coupes'),
('Zion Cabrio', 'zion2', 45000, 'coupes'),
('Zion3', 'zion3', 133600, 'sportsclassics'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Zorrusso', 'zorrusso', 200000, 'super'),
('Zr350', 'zr350', 14500, 'sports'),
('Zr380', 'zr380', 10000, 'sports'),
('Zr3802', 'zr3802', 10000, 'sports'),
('Zr3803', 'zr3803', 10000, 'sports'),
('Z-Type', 'ztype', 220000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupés'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `veh_km`
--

CREATE TABLE `veh_km` (
  `carplate` varchar(10) NOT NULL,
  `km` varchar(255) NOT NULL DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT 0,
  `reset` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ventes_ble`
--

CREATE TABLE `ventes_ble` (
  `identifier` varchar(46) NOT NULL,
  `ventes` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vip_users`
--

CREATE TABLE `vip_users` (
  `identifier` varchar(46) NOT NULL,
  `expire_at` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vip_users`
--

INSERT INTO `vip_users` (`identifier`, `expire_at`) VALUES
('f5d870bb4d630cac9a5b19d196c60c7e846eb0dc', 1748556370000);

-- --------------------------------------------------------

--
-- Structure de la table `xl_postattoo`
--

CREATE TABLE `xl_postattoo` (
  `id` int(11) NOT NULL,
  `x` float DEFAULT NULL,
  `y` float DEFAULT NULL,
  `z` float DEFAULT NULL,
  `marker_type` int(11) DEFAULT NULL,
  `marker_color_r` int(11) DEFAULT 255,
  `marker_color_g` int(11) DEFAULT 255,
  `marker_color_b` int(11) DEFAULT 255,
  `blip_name` varchar(64) DEFAULT NULL,
  `blip_color` int(11) DEFAULT NULL,
  `blip_scale` float DEFAULT 0.8
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `xl_tattoos`
--

CREATE TABLE `xl_tattoos` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `collection` varchar(50) NOT NULL,
  `overlay` varchar(50) NOT NULL,
  `zone` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`);

--
-- Index pour la table `annonces_entreprise`
--
ALTER TABLE `annonces_entreprise`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_job` (`job`);

--
-- Index pour la table `annonces_icons`
--
ALTER TABLE `annonces_icons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_job` (`job`);

--
-- Index pour la table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bank_datas`
--
ALTER TABLE `bank_datas`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bank_transactions`
--
ALTER TABLE `bank_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blips`
--
ALTER TABLE `blips`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blips_groups`
--
ALTER TABLE `blips_groups`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blips_shared`
--
ALTER TABLE `blips_shared`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blip_id` (`blip_id`);

--
-- Index pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `carnet_sante`
--
ALTER TABLE `carnet_sante`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `casierambulance`
--
ALTER TABLE `casierambulance`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `casierambulancecontent`
--
ALTER TABLE `casierambulancecontent`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `chests`
--
ALTER TABLE `chests`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  ADD KEY `index_datastore_data_name` (`name`);

--
-- Index pour la table `dispatch_adv_records`
--
ALTER TABLE `dispatch_adv_records`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dispatch_adv_records_citizen`
--
ALTER TABLE `dispatch_adv_records_citizen`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dispatch_bracelets`
--
ALTER TABLE `dispatch_bracelets`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dispatch_unitnumbers`
--
ALTER TABLE `dispatch_unitnumbers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_identifier` (`identifier`);

--
-- Index pour la table `duty_states`
--
ALTER TABLE `duty_states`
  ADD PRIMARY KEY (`identifier`,`job_name`);

--
-- Index pour la table `elevators`
--
ALTER TABLE `elevators`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `elevator_floors`
--
ALTER TABLE `elevator_floors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `elevator_id` (`elevator_id`);

--
-- Index pour la table `emote_favorites`
--
ALTER TABLE `emote_favorites`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `ex_groups`
--
ALTER TABLE `ex_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_type` (`group_type`);

--
-- Index pour la table `ex_groupsplayer`
--
ALTER TABLE `ex_groupsplayer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_player_group` (`identifier`,`group_id`),
  ADD KEY `idx_identifier` (`identifier`),
  ADD KEY `idx_group` (`group_id`);

--
-- Index pour la table `ex_groupstashes`
--
ALTER TABLE `ex_groupstashes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_group` (`group`);

--
-- Index pour la table `ex_zones`
--
ALTER TABLE `ex_zones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `idx_owned` (`owned`);

--
-- Index pour la table `fb_emote_binds`
--
ALTER TABLE `fb_emote_binds`
  ADD PRIMARY KEY (`identifier`,`command_name`);

--
-- Index pour la table `fb_emote_favorites`
--
ALTER TABLE `fb_emote_favorites`
  ADD PRIMARY KEY (`identifier`,`emote_name`);

--
-- Index pour la table `fb_emote_states`
--
ALTER TABLE `fb_emote_states`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `fb_groups`
--
ALTER TABLE `fb_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `group_name` (`group_name`);

--
-- Index pour la table `fb_groupsplayer`
--
ALTER TABLE `fb_groupsplayer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `group_id` (`group_id`);

--
-- Index pour la table `fb_mailbox`
--
ALTER TABLE `fb_mailbox`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_owner` (`owner`),
  ADD KEY `idx_spawned` (`spawned`);

--
-- Index pour la table `fb_multichest`
--
ALTER TABLE `fb_multichest`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `fb_props`
--
ALTER TABLE `fb_props`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_owner` (`owner`);

--
-- Index pour la table `fourrieres_pos`
--
ALTER TABLE `fourrieres_pos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fourriere_name_unique` (`name`);

--
-- Index pour la table `fourriere_vehicles`
--
ALTER TABLE `fourriere_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_vehicle_id` (`vehicle_id`),
  ADD KEY `idx_plate` (`plate`),
  ADD KEY `idx_fourriere_id` (`fourriere_id`);

--
-- Index pour la table `garages`
--
ALTER TABLE `garages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_unique` (`name`);

--
-- Index pour la table `ins_bans`
--
ALTER TABLE `ins_bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_jail`
--
ALTER TABLE `ins_jail`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_players`
--
ALTER TABLE `ins_players`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_ranks`
--
ALTER TABLE `ins_ranks`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_sanctions`
--
ALTER TABLE `ins_sanctions`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_teleports`
--
ALTER TABLE `ins_teleports`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ins_uid`
--
ALTER TABLE `ins_uid`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job2_grades`
--
ALTER TABLE `job2_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `jobs2`
--
ALTER TABLE `jobs2`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `kay_mdt_codagecitoyen`
--
ALTER TABLE `kay_mdt_codagecitoyen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_name` (`lastname`,`firstname`),
  ADD KEY `idx_phone` (`phone`),
  ADD KEY `idx_identifier` (`identifier`),
  ADD KEY `idx_wanted` (`wanted`);

--
-- Index pour la table `kay_mdt_dossier_arrestation`
--
ALTER TABLE `kay_mdt_dossier_arrestation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_citizen` (`citizen_id`),
  ADD KEY `idx_author` (`author_identifier`);

--
-- Index pour la table `kay_mdt_informations`
--
ALTER TABLE `kay_mdt_informations`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `kay_mdt_rapport_arrestation`
--
ALTER TABLE `kay_mdt_rapport_arrestation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_citizen` (`citizen_id`),
  ADD KEY `idx_author` (`author_identifier`);

--
-- Index pour la table `kay_mdt_ticket_routier`
--
ALTER TABLE `kay_mdt_ticket_routier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_citizen` (`citizen_id`),
  ADD KEY `idx_author` (`author_identifier`);

--
-- Index pour la table `lockers`
--
ALTER TABLE `lockers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `point_id` (`point_id`);

--
-- Index pour la table `locker_points`
--
ALTER TABLE `locker_points`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `management_outfits`
--
ALTER TABLE `management_outfits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `manny_bans`
--
ALTER TABLE `manny_bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_license` (`license`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Index pour la table `manny_kicks`
--
ALTER TABLE `manny_kicks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_license` (`license`);

--
-- Index pour la table `markers`
--
ALTER TABLE `markers`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `multicharacter_slots`
--
ALTER TABLE `multicharacter_slots`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD KEY `slots` (`slots`) USING BTREE;

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate_unique` (`plate`);

--
-- Index pour la table `ox_inventory`
--
ALTER TABLE `ox_inventory`
  ADD UNIQUE KEY `owner` (`owner`,`name`);

--
-- Index pour la table `persist2_car`
--
ALTER TABLE `persist2_car`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `persist_car`
--
ALTER TABLE `persist_car`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `phone_backups`
--
ALTER TABLE `phone_backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_clock_alarms`
--
ALTER TABLE `phone_clock_alarms`
  ADD PRIMARY KEY (`id`,`phone_number`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_crypto`
--
ALTER TABLE `phone_crypto`
  ADD PRIMARY KEY (`id`,`coin`);

--
-- Index pour la table `phone_darkchat_accounts`
--
ALTER TABLE `phone_darkchat_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_darkchat_channels`
--
ALTER TABLE `phone_darkchat_channels`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `phone_darkchat_members`
--
ALTER TABLE `phone_darkchat_members`
  ADD PRIMARY KEY (`channel_name`,`username`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_darkchat_messages`
--
ALTER TABLE `phone_darkchat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel` (`channel`),
  ADD KEY `sender` (`sender`);

--
-- Index pour la table `phone_instagram_accounts`
--
ALTER TABLE `phone_instagram_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_instagram_comments`
--
ALTER TABLE `phone_instagram_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_instagram_follows`
--
ALTER TABLE `phone_instagram_follows`
  ADD PRIMARY KEY (`followed`,`follower`),
  ADD KEY `follower` (`follower`);

--
-- Index pour la table `phone_instagram_follow_requests`
--
ALTER TABLE `phone_instagram_follow_requests`
  ADD PRIMARY KEY (`requester`,`requestee`),
  ADD KEY `requestee` (`requestee`);

--
-- Index pour la table `phone_instagram_likes`
--
ALTER TABLE `phone_instagram_likes`
  ADD PRIMARY KEY (`id`,`username`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_instagram_messages`
--
ALTER TABLE `phone_instagram_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `recipient` (`recipient`);

--
-- Index pour la table `phone_instagram_notifications`
--
ALTER TABLE `phone_instagram_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `from` (`from`);

--
-- Index pour la table `phone_instagram_posts`
--
ALTER TABLE `phone_instagram_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_instagram_stories`
--
ALTER TABLE `phone_instagram_stories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_instagram_stories_views`
--
ALTER TABLE `phone_instagram_stories_views`
  ADD PRIMARY KEY (`story_id`,`viewer`),
  ADD KEY `viewer` (`viewer`);

--
-- Index pour la table `phone_last_phone`
--
ALTER TABLE `phone_last_phone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_logged_in_accounts`
--
ALTER TABLE `phone_logged_in_accounts`
  ADD PRIMARY KEY (`phone_number`,`app`,`username`);

--
-- Index pour la table `phone_mail_accounts`
--
ALTER TABLE `phone_mail_accounts`
  ADD PRIMARY KEY (`address`);

--
-- Index pour la table `phone_mail_deleted`
--
ALTER TABLE `phone_mail_deleted`
  ADD PRIMARY KEY (`message_id`,`address`),
  ADD KEY `address` (`address`);

--
-- Index pour la table `phone_mail_messages`
--
ALTER TABLE `phone_mail_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_recipient` (`recipient`),
  ADD KEY `idx_sender` (`sender`);

--
-- Index pour la table `phone_maps_locations`
--
ALTER TABLE `phone_maps_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_marketplace_posts`
--
ALTER TABLE `phone_marketplace_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_message_channels`
--
ALTER TABLE `phone_message_channels`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_message_members`
--
ALTER TABLE `phone_message_members`
  ADD PRIMARY KEY (`channel_id`,`phone_number`),
  ADD KEY `idx_members_phone_number` (`phone_number`);

--
-- Index pour la table `phone_message_messages`
--
ALTER TABLE `phone_message_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id` (`channel_id`);

--
-- Index pour la table `phone_music_playlists`
--
ALTER TABLE `phone_music_playlists`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_music_saved_playlists`
--
ALTER TABLE `phone_music_saved_playlists`
  ADD PRIMARY KEY (`playlist_id`,`phone_number`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_music_songs`
--
ALTER TABLE `phone_music_songs`
  ADD PRIMARY KEY (`song_id`,`playlist_id`),
  ADD KEY `playlist_id` (`playlist_id`);

--
-- Index pour la table `phone_notes`
--
ALTER TABLE `phone_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_notifications`
--
ALTER TABLE `phone_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_phones`
--
ALTER TABLE `phone_phones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_phone_blocked_numbers`
--
ALTER TABLE `phone_phone_blocked_numbers`
  ADD PRIMARY KEY (`phone_number`,`blocked_number`);

--
-- Index pour la table `phone_phone_calls`
--
ALTER TABLE `phone_phone_calls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_calls_missed` (`callee`,`answered`),
  ADD KEY `idx_calls_callee_id` (`callee`),
  ADD KEY `idx_calls_caller_id` (`caller`);

--
-- Index pour la table `phone_phone_contacts`
--
ALTER TABLE `phone_phone_contacts`
  ADD PRIMARY KEY (`contact_phone_number`,`phone_number`);

--
-- Index pour la table `phone_phone_voicemail`
--
ALTER TABLE `phone_phone_voicemail`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_photos`
--
ALTER TABLE `phone_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_photo_albums`
--
ALTER TABLE `phone_photo_albums`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_photo_album_members`
--
ALTER TABLE `phone_photo_album_members`
  ADD PRIMARY KEY (`album_id`,`phone_number`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_photo_album_photos`
--
ALTER TABLE `phone_photo_album_photos`
  ADD PRIMARY KEY (`album_id`,`photo_id`),
  ADD KEY `photo_id` (`photo_id`);

--
-- Index pour la table `phone_services_channels`
--
ALTER TABLE `phone_services_channels`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_services_messages`
--
ALTER TABLE `phone_services_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id` (`channel_id`);

--
-- Index pour la table `phone_tiktok_accounts`
--
ALTER TABLE `phone_tiktok_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_tiktok_channels`
--
ALTER TABLE `phone_tiktok_channels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `member_1` (`member_1`,`member_2`),
  ADD KEY `member_2` (`member_2`);

--
-- Index pour la table `phone_tiktok_comments`
--
ALTER TABLE `phone_tiktok_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `video_id` (`video_id`),
  ADD KEY `username` (`username`),
  ADD KEY `reply_to` (`reply_to`);

--
-- Index pour la table `phone_tiktok_comments_likes`
--
ALTER TABLE `phone_tiktok_comments_likes`
  ADD PRIMARY KEY (`username`,`comment_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Index pour la table `phone_tiktok_follows`
--
ALTER TABLE `phone_tiktok_follows`
  ADD PRIMARY KEY (`followed`,`follower`),
  ADD KEY `follower` (`follower`);

--
-- Index pour la table `phone_tiktok_likes`
--
ALTER TABLE `phone_tiktok_likes`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_messages`
--
ALTER TABLE `phone_tiktok_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel_id` (`channel_id`),
  ADD KEY `sender` (`sender`);

--
-- Index pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `from` (`from`),
  ADD KEY `video_id` (`video_id`),
  ADD KEY `comment_id` (`comment_id`);

--
-- Index pour la table `phone_tiktok_pinned_videos`
--
ALTER TABLE `phone_tiktok_pinned_videos`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_saves`
--
ALTER TABLE `phone_tiktok_saves`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tiktok_unread_messages`
--
ALTER TABLE `phone_tiktok_unread_messages`
  ADD PRIMARY KEY (`username`,`channel_id`),
  ADD KEY `channel_id` (`channel_id`);

--
-- Index pour la table `phone_tiktok_videos`
--
ALTER TABLE `phone_tiktok_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_tiktok_views`
--
ALTER TABLE `phone_tiktok_views`
  ADD PRIMARY KEY (`username`,`video_id`),
  ADD KEY `video_id` (`video_id`);

--
-- Index pour la table `phone_tinder_accounts`
--
ALTER TABLE `phone_tinder_accounts`
  ADD PRIMARY KEY (`phone_number`);

--
-- Index pour la table `phone_tinder_matches`
--
ALTER TABLE `phone_tinder_matches`
  ADD PRIMARY KEY (`phone_number_1`,`phone_number_2`),
  ADD KEY `phone_number_2` (`phone_number_2`);

--
-- Index pour la table `phone_tinder_messages`
--
ALTER TABLE `phone_tinder_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `recipient` (`recipient`);

--
-- Index pour la table `phone_tinder_swipes`
--
ALTER TABLE `phone_tinder_swipes`
  ADD PRIMARY KEY (`swiper`,`swipee`),
  ADD KEY `swipee` (`swipee`);

--
-- Index pour la table `phone_twitter_accounts`
--
ALTER TABLE `phone_twitter_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_twitter_follows`
--
ALTER TABLE `phone_twitter_follows`
  ADD PRIMARY KEY (`followed`,`follower`),
  ADD KEY `follower` (`follower`);

--
-- Index pour la table `phone_twitter_follow_requests`
--
ALTER TABLE `phone_twitter_follow_requests`
  ADD PRIMARY KEY (`requester`,`requestee`),
  ADD KEY `requestee` (`requestee`);

--
-- Index pour la table `phone_twitter_hashtags`
--
ALTER TABLE `phone_twitter_hashtags`
  ADD PRIMARY KEY (`hashtag`);

--
-- Index pour la table `phone_twitter_likes`
--
ALTER TABLE `phone_twitter_likes`
  ADD PRIMARY KEY (`tweet_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_twitter_messages`
--
ALTER TABLE `phone_twitter_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `recipient` (`recipient`);

--
-- Index pour la table `phone_twitter_notifications`
--
ALTER TABLE `phone_twitter_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`),
  ADD KEY `from` (`from`);

--
-- Index pour la table `phone_twitter_promoted`
--
ALTER TABLE `phone_twitter_promoted`
  ADD PRIMARY KEY (`tweet_id`);

--
-- Index pour la table `phone_twitter_retweets`
--
ALTER TABLE `phone_twitter_retweets`
  ADD PRIMARY KEY (`tweet_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_twitter_tweets`
--
ALTER TABLE `phone_twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Index pour la table `phone_voice_memos_recordings`
--
ALTER TABLE `phone_voice_memos_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_wallet_transactions`
--
ALTER TABLE `phone_wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `phone_number` (`phone_number`);

--
-- Index pour la table `phone_yellow_pages_posts`
--
ALTER TABLE `phone_yellow_pages_posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `placed_lights`
--
ALTER TABLE `placed_lights`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `placed_pots`
--
ALTER TABLE `placed_pots`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `playerskins`
--
ALTER TABLE `playerskins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizenid` (`citizenid`),
  ADD KEY `active` (`active`);

--
-- Index pour la table `player_outfits`
--
ALTER TABLE `player_outfits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  ADD KEY `citizenid` (`citizenid`);

--
-- Index pour la table `player_outfit_codes`
--
ALTER TABLE `player_outfit_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_player_outfit_codes_player_outfits` (`outfitid`);

--
-- Index pour la table `police_actions`
--
ALTER TABLE `police_actions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `action_type` (`action_type`),
  ADD KEY `created_at` (`created_at`);

--
-- Index pour la table `police_backup_requests`
--
ALTER TABLE `police_backup_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `priority` (`priority`);

--
-- Index pour la table `police_bracelets`
--
ALTER TABLE `police_bracelets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `target_identifier` (`target_identifier`);

--
-- Index pour la table `police_fines`
--
ALTER TABLE `police_fines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `target_identifier` (`target_identifier`);

--
-- Index pour la table `police_searches`
--
ALTER TABLE `police_searches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `target_identifier` (`target_identifier`);

--
-- Index pour la table `police_service_logs`
--
ALTER TABLE `police_service_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `action` (`action`);

--
-- Index pour la table `police_tests`
--
ALTER TABLE `police_tests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `target_identifier` (`target_identifier`),
  ADD KEY `test_type` (`test_type`);

--
-- Index pour la table `police_trackers`
--
ALTER TABLE `police_trackers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`),
  ADD KEY `vehicle_plate` (`vehicle_plate`);

--
-- Index pour la table `police_zones`
--
ALTER TABLE `police_zones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `officer_identifier` (`officer_identifier`);

--
-- Index pour la table `propcreator`
--
ALTER TABLE `propcreator`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `props_placed`
--
ALTER TABLE `props_placed`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sakakak_cooldowns`
--
ALTER TABLE `sakakak_cooldowns`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `seyo_hairpos`
--
ALTER TABLE `seyo_hairpos`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `shop_accounts`
--
ALTER TABLE `shop_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`),
  ADD UNIQUE KEY `shop_code` (`shop_code`);

--
-- Index pour la table `shop_transactions`
--
ALTER TABLE `shop_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `users_outfits`
--
ALTER TABLE `users_outfits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_outfits`
--
ALTER TABLE `user_outfits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `user_outfit_save`
--
ALTER TABLE `user_outfit_save`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`);

--
-- Index pour la table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `veh_km`
--
ALTER TABLE `veh_km`
  ADD PRIMARY KEY (`carplate`),
  ADD UNIQUE KEY `carplate` (`carplate`),
  ADD KEY `carplate_2` (`carplate`);

--
-- Index pour la table `ventes_ble`
--
ALTER TABLE `ventes_ble`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `vip_users`
--
ALTER TABLE `vip_users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `xl_postattoo`
--
ALTER TABLE `xl_postattoo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `xl_tattoos`
--
ALTER TABLE `xl_tattoos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_tattoo` (`identifier`,`collection`,`overlay`,`zone`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `annonces_entreprise`
--
ALTER TABLE `annonces_entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `annonces_icons`
--
ALTER TABLE `annonces_icons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `bank_datas`
--
ALTER TABLE `bank_datas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `bank_transactions`
--
ALTER TABLE `bank_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `blips`
--
ALTER TABLE `blips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `blips_groups`
--
ALTER TABLE `blips_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `blips_shared`
--
ALTER TABLE `blips_shared`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `carnet_sante`
--
ALTER TABLE `carnet_sante`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pour la table `casierambulance`
--
ALTER TABLE `casierambulance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `casierambulancecontent`
--
ALTER TABLE `casierambulancecontent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `chests`
--
ALTER TABLE `chests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `dispatch_adv_records`
--
ALTER TABLE `dispatch_adv_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dispatch_adv_records_citizen`
--
ALTER TABLE `dispatch_adv_records_citizen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dispatch_bracelets`
--
ALTER TABLE `dispatch_bracelets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dispatch_unitnumbers`
--
ALTER TABLE `dispatch_unitnumbers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `elevators`
--
ALTER TABLE `elevators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `elevator_floors`
--
ALTER TABLE `elevator_floors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT pour la table `ex_groups`
--
ALTER TABLE `ex_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ex_groupsplayer`
--
ALTER TABLE `ex_groupsplayer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ex_groupstashes`
--
ALTER TABLE `ex_groupstashes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ex_zones`
--
ALTER TABLE `ex_zones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fb_groups`
--
ALTER TABLE `fb_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fb_groupsplayer`
--
ALTER TABLE `fb_groupsplayer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fb_mailbox`
--
ALTER TABLE `fb_mailbox`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fb_props`
--
ALTER TABLE `fb_props`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `fourrieres_pos`
--
ALTER TABLE `fourrieres_pos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `fourriere_vehicles`
--
ALTER TABLE `fourriere_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `garages`
--
ALTER TABLE `garages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `ins_bans`
--
ALTER TABLE `ins_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ins_jail`
--
ALTER TABLE `ins_jail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `ins_players`
--
ALTER TABLE `ins_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `ins_ranks`
--
ALTER TABLE `ins_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `ins_sanctions`
--
ALTER TABLE `ins_sanctions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ins_teleports`
--
ALTER TABLE `ins_teleports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ins_uid`
--
ALTER TABLE `ins_uid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `kay_mdt_codagecitoyen`
--
ALTER TABLE `kay_mdt_codagecitoyen`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `kay_mdt_dossier_arrestation`
--
ALTER TABLE `kay_mdt_dossier_arrestation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `kay_mdt_rapport_arrestation`
--
ALTER TABLE `kay_mdt_rapport_arrestation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `kay_mdt_ticket_routier`
--
ALTER TABLE `kay_mdt_ticket_routier`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `lockers`
--
ALTER TABLE `lockers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT pour la table `locker_points`
--
ALTER TABLE `locker_points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `management_outfits`
--
ALTER TABLE `management_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `manny_bans`
--
ALTER TABLE `manny_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `manny_kicks`
--
ALTER TABLE `manny_kicks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `phone_clock_alarms`
--
ALTER TABLE `phone_clock_alarms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_darkchat_messages`
--
ALTER TABLE `phone_darkchat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_mail_messages`
--
ALTER TABLE `phone_mail_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_maps_locations`
--
ALTER TABLE `phone_maps_locations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_marketplace_posts`
--
ALTER TABLE `phone_marketplace_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_message_channels`
--
ALTER TABLE `phone_message_channels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_message_messages`
--
ALTER TABLE `phone_message_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_music_playlists`
--
ALTER TABLE `phone_music_playlists`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_notes`
--
ALTER TABLE `phone_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_notifications`
--
ALTER TABLE `phone_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_phone_calls`
--
ALTER TABLE `phone_phone_calls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_phone_voicemail`
--
ALTER TABLE `phone_phone_voicemail`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_photos`
--
ALTER TABLE `phone_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_photo_albums`
--
ALTER TABLE `phone_photo_albums`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_services_channels`
--
ALTER TABLE `phone_services_channels`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_services_messages`
--
ALTER TABLE `phone_services_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_tinder_messages`
--
ALTER TABLE `phone_tinder_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_voice_memos_recordings`
--
ALTER TABLE `phone_voice_memos_recordings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_wallet_transactions`
--
ALTER TABLE `phone_wallet_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_yellow_pages_posts`
--
ALTER TABLE `phone_yellow_pages_posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `placed_pots`
--
ALTER TABLE `placed_pots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `playerskins`
--
ALTER TABLE `playerskins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `player_outfits`
--
ALTER TABLE `player_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `player_outfit_codes`
--
ALTER TABLE `player_outfit_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `police_actions`
--
ALTER TABLE `police_actions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `police_backup_requests`
--
ALTER TABLE `police_backup_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `police_bracelets`
--
ALTER TABLE `police_bracelets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `police_fines`
--
ALTER TABLE `police_fines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `police_searches`
--
ALTER TABLE `police_searches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `police_service_logs`
--
ALTER TABLE `police_service_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT pour la table `police_tests`
--
ALTER TABLE `police_tests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `police_trackers`
--
ALTER TABLE `police_trackers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `police_zones`
--
ALTER TABLE `police_zones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `propcreator`
--
ALTER TABLE `propcreator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `props_placed`
--
ALTER TABLE `props_placed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `seyo_hairpos`
--
ALTER TABLE `seyo_hairpos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `shop_accounts`
--
ALTER TABLE `shop_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `shop_transactions`
--
ALTER TABLE `shop_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users_outfits`
--
ALTER TABLE `users_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pour la table `user_outfits`
--
ALTER TABLE `user_outfits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `user_outfit_save`
--
ALTER TABLE `user_outfit_save`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `xl_postattoo`
--
ALTER TABLE `xl_postattoo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `xl_tattoos`
--
ALTER TABLE `xl_tattoos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `blips_shared`
--
ALTER TABLE `blips_shared`
  ADD CONSTRAINT `blips_shared_ibfk_1` FOREIGN KEY (`blip_id`) REFERENCES `blips` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `elevator_floors`
--
ALTER TABLE `elevator_floors`
  ADD CONSTRAINT `elevator_floors_ibfk_1` FOREIGN KEY (`elevator_id`) REFERENCES `elevators` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ex_groupsplayer`
--
ALTER TABLE `ex_groupsplayer`
  ADD CONSTRAINT `ex_groupsplayer_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `ex_groups` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fb_groupsplayer`
--
ALTER TABLE `fb_groupsplayer`
  ADD CONSTRAINT `fk_fb_groupsplayer_group` FOREIGN KEY (`group_id`) REFERENCES `fb_groups` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fourriere_vehicles`
--
ALTER TABLE `fourriere_vehicles`
  ADD CONSTRAINT `fk_fourriere_vehicles_fourrieres_pos` FOREIGN KEY (`fourriere_id`) REFERENCES `fourrieres_pos` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_backups`
--
ALTER TABLE `phone_backups`
  ADD CONSTRAINT `phone_backups_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_clock_alarms`
--
ALTER TABLE `phone_clock_alarms`
  ADD CONSTRAINT `phone_clock_alarms_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_darkchat_accounts`
--
ALTER TABLE `phone_darkchat_accounts`
  ADD CONSTRAINT `phone_darkchat_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_darkchat_members`
--
ALTER TABLE `phone_darkchat_members`
  ADD CONSTRAINT `phone_darkchat_members_ibfk_1` FOREIGN KEY (`channel_name`) REFERENCES `phone_darkchat_channels` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_darkchat_members_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_darkchat_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_darkchat_messages`
--
ALTER TABLE `phone_darkchat_messages`
  ADD CONSTRAINT `phone_darkchat_messages_ibfk_1` FOREIGN KEY (`channel`) REFERENCES `phone_darkchat_channels` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_darkchat_messages_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `phone_darkchat_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_accounts`
--
ALTER TABLE `phone_instagram_accounts`
  ADD CONSTRAINT `phone_instagram_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_comments`
--
ALTER TABLE `phone_instagram_comments`
  ADD CONSTRAINT `phone_instagram_comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `phone_instagram_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `phone_instagram_comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_follows`
--
ALTER TABLE `phone_instagram_follows`
  ADD CONSTRAINT `phone_instagram_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_instagram_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_follow_requests`
--
ALTER TABLE `phone_instagram_follow_requests`
  ADD CONSTRAINT `phone_instagram_follow_requests_ibfk_1` FOREIGN KEY (`requester`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_instagram_follow_requests_ibfk_2` FOREIGN KEY (`requestee`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_likes`
--
ALTER TABLE `phone_instagram_likes`
  ADD CONSTRAINT `phone_instagram_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_messages`
--
ALTER TABLE `phone_instagram_messages`
  ADD CONSTRAINT `phone_instagram_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_instagram_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_notifications`
--
ALTER TABLE `phone_instagram_notifications`
  ADD CONSTRAINT `phone_instagram_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_instagram_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_posts`
--
ALTER TABLE `phone_instagram_posts`
  ADD CONSTRAINT `phone_instagram_posts_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_stories`
--
ALTER TABLE `phone_instagram_stories`
  ADD CONSTRAINT `phone_instagram_stories_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_instagram_stories_views`
--
ALTER TABLE `phone_instagram_stories_views`
  ADD CONSTRAINT `phone_instagram_stories_views_ibfk_1` FOREIGN KEY (`story_id`) REFERENCES `phone_instagram_stories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `phone_instagram_stories_views_ibfk_2` FOREIGN KEY (`viewer`) REFERENCES `phone_instagram_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_last_phone`
--
ALTER TABLE `phone_last_phone`
  ADD CONSTRAINT `phone_last_phone_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_logged_in_accounts`
--
ALTER TABLE `phone_logged_in_accounts`
  ADD CONSTRAINT `phone_logged_in_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_mail_deleted`
--
ALTER TABLE `phone_mail_deleted`
  ADD CONSTRAINT `phone_mail_deleted_ibfk_1` FOREIGN KEY (`message_id`) REFERENCES `phone_mail_messages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `phone_mail_deleted_ibfk_2` FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts` (`address`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_maps_locations`
--
ALTER TABLE `phone_maps_locations`
  ADD CONSTRAINT `phone_maps_locations_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_marketplace_posts`
--
ALTER TABLE `phone_marketplace_posts`
  ADD CONSTRAINT `phone_marketplace_posts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_message_members`
--
ALTER TABLE `phone_message_members`
  ADD CONSTRAINT `phone_message_members_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_message_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_message_messages`
--
ALTER TABLE `phone_message_messages`
  ADD CONSTRAINT `phone_message_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_message_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_music_playlists`
--
ALTER TABLE `phone_music_playlists`
  ADD CONSTRAINT `phone_music_playlists_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_music_saved_playlists`
--
ALTER TABLE `phone_music_saved_playlists`
  ADD CONSTRAINT `phone_music_saved_playlists_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `phone_music_saved_playlists_ibfk_2` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_music_songs`
--
ALTER TABLE `phone_music_songs`
  ADD CONSTRAINT `phone_music_songs_ibfk_1` FOREIGN KEY (`playlist_id`) REFERENCES `phone_music_playlists` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_notes`
--
ALTER TABLE `phone_notes`
  ADD CONSTRAINT `phone_notes_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_notifications`
--
ALTER TABLE `phone_notifications`
  ADD CONSTRAINT `phone_notifications_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_photos`
--
ALTER TABLE `phone_photos`
  ADD CONSTRAINT `phone_photos_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_photo_albums`
--
ALTER TABLE `phone_photo_albums`
  ADD CONSTRAINT `phone_photo_albums_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_photo_album_members`
--
ALTER TABLE `phone_photo_album_members`
  ADD CONSTRAINT `phone_photo_album_members_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `phone_photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_photo_album_members_ibfk_2` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_photo_album_photos`
--
ALTER TABLE `phone_photo_album_photos`
  ADD CONSTRAINT `phone_photo_album_photos_ibfk_1` FOREIGN KEY (`album_id`) REFERENCES `phone_photo_albums` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_photo_album_photos_ibfk_2` FOREIGN KEY (`photo_id`) REFERENCES `phone_photos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_services_messages`
--
ALTER TABLE `phone_services_messages`
  ADD CONSTRAINT `phone_services_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_services_channels` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_accounts`
--
ALTER TABLE `phone_tiktok_accounts`
  ADD CONSTRAINT `phone_tiktok_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_channels`
--
ALTER TABLE `phone_tiktok_channels`
  ADD CONSTRAINT `phone_tiktok_channels_ibfk_1` FOREIGN KEY (`member_1`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_channels_ibfk_2` FOREIGN KEY (`member_2`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_comments`
--
ALTER TABLE `phone_tiktok_comments`
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_1` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_2` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_ibfk_3` FOREIGN KEY (`reply_to`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_comments_likes`
--
ALTER TABLE `phone_tiktok_comments_likes`
  ADD CONSTRAINT `phone_tiktok_comments_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_comments_likes_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_follows`
--
ALTER TABLE `phone_tiktok_follows`
  ADD CONSTRAINT `phone_tiktok_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_likes`
--
ALTER TABLE `phone_tiktok_likes`
  ADD CONSTRAINT `phone_tiktok_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_likes_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_messages`
--
ALTER TABLE `phone_tiktok_messages`
  ADD CONSTRAINT `phone_tiktok_messages_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_messages_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_notifications`
--
ALTER TABLE `phone_tiktok_notifications`
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_3` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `phone_tiktok_comments` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_pinned_videos`
--
ALTER TABLE `phone_tiktok_pinned_videos`
  ADD CONSTRAINT `phone_tiktok_pinned_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_pinned_videos_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_saves`
--
ALTER TABLE `phone_tiktok_saves`
  ADD CONSTRAINT `phone_tiktok_saves_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_saves_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_unread_messages`
--
ALTER TABLE `phone_tiktok_unread_messages`
  ADD CONSTRAINT `phone_tiktok_unread_messages_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_unread_messages_ibfk_2` FOREIGN KEY (`channel_id`) REFERENCES `phone_tiktok_channels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_videos`
--
ALTER TABLE `phone_tiktok_videos`
  ADD CONSTRAINT `phone_tiktok_videos_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tiktok_views`
--
ALTER TABLE `phone_tiktok_views`
  ADD CONSTRAINT `phone_tiktok_views_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_tiktok_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tiktok_views_ibfk_2` FOREIGN KEY (`video_id`) REFERENCES `phone_tiktok_videos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tinder_accounts`
--
ALTER TABLE `phone_tinder_accounts`
  ADD CONSTRAINT `phone_tinder_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tinder_matches`
--
ALTER TABLE `phone_tinder_matches`
  ADD CONSTRAINT `phone_tinder_matches_ibfk_1` FOREIGN KEY (`phone_number_1`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tinder_matches_ibfk_2` FOREIGN KEY (`phone_number_2`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tinder_messages`
--
ALTER TABLE `phone_tinder_messages`
  ADD CONSTRAINT `phone_tinder_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tinder_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_tinder_swipes`
--
ALTER TABLE `phone_tinder_swipes`
  ADD CONSTRAINT `phone_tinder_swipes_ibfk_1` FOREIGN KEY (`swiper`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_tinder_swipes_ibfk_2` FOREIGN KEY (`swipee`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_accounts`
--
ALTER TABLE `phone_twitter_accounts`
  ADD CONSTRAINT `phone_twitter_accounts_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_follows`
--
ALTER TABLE `phone_twitter_follows`
  ADD CONSTRAINT `phone_twitter_follows_ibfk_1` FOREIGN KEY (`followed`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_twitter_follows_ibfk_2` FOREIGN KEY (`follower`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_follow_requests`
--
ALTER TABLE `phone_twitter_follow_requests`
  ADD CONSTRAINT `phone_twitter_follow_requests_ibfk_1` FOREIGN KEY (`requester`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_twitter_follow_requests_ibfk_2` FOREIGN KEY (`requestee`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_likes`
--
ALTER TABLE `phone_twitter_likes`
  ADD CONSTRAINT `phone_twitter_likes_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_messages`
--
ALTER TABLE `phone_twitter_messages`
  ADD CONSTRAINT `phone_twitter_messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_twitter_messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_notifications`
--
ALTER TABLE `phone_twitter_notifications`
  ADD CONSTRAINT `phone_twitter_notifications_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `phone_twitter_notifications_ibfk_2` FOREIGN KEY (`from`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_promoted`
--
ALTER TABLE `phone_twitter_promoted`
  ADD CONSTRAINT `phone_twitter_promoted_ibfk_1` FOREIGN KEY (`tweet_id`) REFERENCES `phone_twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `phone_twitter_retweets`
--
ALTER TABLE `phone_twitter_retweets`
  ADD CONSTRAINT `phone_twitter_retweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_twitter_tweets`
--
ALTER TABLE `phone_twitter_tweets`
  ADD CONSTRAINT `phone_twitter_tweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `phone_twitter_accounts` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_voice_memos_recordings`
--
ALTER TABLE `phone_voice_memos_recordings`
  ADD CONSTRAINT `phone_voice_memos_recordings_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `phone_wallet_transactions`
--
ALTER TABLE `phone_wallet_transactions`
  ADD CONSTRAINT `phone_wallet_transactions_ibfk_1` FOREIGN KEY (`phone_number`) REFERENCES `phone_phones` (`phone_number`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Évènements
--
CREATE DEFINER=`root`@`localhost` EVENT `clean_expired_trackers` ON SCHEDULE EVERY 1 HOUR STARTS '2026-01-23 05:10:56' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM `police_trackers` 
  WHERE `expires_at` IS NOT NULL 
  AND `expires_at` < NOW();
END$$

CREATE DEFINER=`root`@`localhost` EVENT `clean_expired_bracelets` ON SCHEDULE EVERY 1 HOUR STARTS '2026-01-23 05:10:56' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM `police_bracelets` 
  WHERE `expires_at` IS NOT NULL 
  AND `expires_at` < NOW();
END$$

CREATE DEFINER=`root`@`localhost` EVENT `clean_expired_zones` ON SCHEDULE EVERY 1 HOUR STARTS '2026-01-23 05:10:56' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM `police_zones` 
  WHERE `expires_at` IS NOT NULL 
  AND `expires_at` < NOW();
END$$

CREATE DEFINER=`root`@`localhost` EVENT `clean_old_history` ON SCHEDULE EVERY 1 DAY STARTS '2026-01-23 05:10:56' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
  DELETE FROM `police_tests` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
  DELETE FROM `police_actions` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
  DELETE FROM `police_searches` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
  DELETE FROM `police_fines` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
  DELETE FROM `police_service_logs` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
  DELETE FROM `police_backup_requests` WHERE `created_at` < DATE_SUB(NOW(), INTERVAL 30 DAY);
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
