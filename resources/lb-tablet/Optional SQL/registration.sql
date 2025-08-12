CREATE TABLE IF NOT EXISTS `lbtablet_registration_characters` (
    `identifier` VARCHAR(100) NOT NULL,
    `character_id` VARCHAR(100) NOT NULL,

    `firstname` VARCHAR(100) NOT NULL,
    `lastname` VARCHAR(100) NOT NULL,
    `dateofbirth` VARCHAR(20) NOT NULL,
    `is_male` BOOLEAN NOT NULL,
    `job` VARCHAR(100) NOT NULL DEFAULT 'unemployed',
    `height` SMALLINT UNSIGNED NOT NULL,

    `avatar` VARCHAR(500) DEFAULT NULL,
    `description` TEXT NOT NULL DEFAULT "",
    `phone_number` VARCHAR(20) NOT NULL DEFAULT "",

    `jail` INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`character_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_registration_vehicles` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `character_id` VARCHAR(100) NOT NULL,

    `plate` VARCHAR(20) NOT NULL,
    `model` VARCHAR(100) NOT NULL,
    `color` VARCHAR(20) NOT NULL,

    `picture` VARCHAR(500) DEFAULT NULL,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`plate`),
    FOREIGN KEY (`character_id`) REFERENCES `lbtablet_registration_characters`(`character_id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_registration_licenses` (
    `character_id` VARCHAR(100) NOT NULL,
    `license` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`character_id`, `license`),
    FOREIGN KEY (`character_id`) REFERENCES `lbtablet_registration_characters`(`character_id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_registration_properties` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `character_id` VARCHAR(100) NOT NULL,
    `label` VARCHAR(100) NOT NULL,
    `address` VARCHAR(100) DEFAULT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`character_id`) REFERENCES `lbtablet_registration_characters`(`character_id`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
