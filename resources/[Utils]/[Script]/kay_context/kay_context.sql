
CREATE TABLE IF NOT EXISTS `props_placed` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `model` VARCHAR(100) NOT NULL,
    `x` FLOAT NOT NULL,
    `y` FLOAT NOT NULL,
    `z` FLOAT NOT NULL,
    `heading` FLOAT NOT NULL DEFAULT 0.0,
    `frozen` TINYINT(1) NOT NULL DEFAULT 1,
    `owner_identifier` VARCHAR(60) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
)


CREATE TABLE IF NOT EXISTS `persist_car` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `owner` VARCHAR(60) NOT NULL,
    `plate` VARCHAR(12) NOT NULL,
    `vehicle` LONGTEXT DEFAULT NULL,
    `classcar` VARCHAR(50) DEFAULT 'car',
    `position` LONGTEXT DEFAULT NULL,
    `heading` FLOAT NOT NULL DEFAULT 0.0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `plate` (`plate`),
    KEY `owner` (`owner`)
)

CREATE TABLE IF NOT EXISTS `fb_Groups` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `group_name` VARCHAR(100) NOT NULL,
    `group_type` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `group_name` (`group_name`)
)

CREATE TABLE IF NOT EXISTS `fb_GroupsPlayer` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `group_id` INT(11) NOT NULL,
    `joined_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `identifier` (`identifier`),
    KEY `group_id` (`group_id`),
    CONSTRAINT `fk_fb_groupsplayer_group` FOREIGN KEY (`group_id`) REFERENCES `fb_Groups` (`id`) ON DELETE CASCADE
)
