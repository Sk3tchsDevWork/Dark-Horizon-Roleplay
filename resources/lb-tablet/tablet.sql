CREATE TABLE IF NOT EXISTS `lbtablet_tablets` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier. we use id instead of identifier since some scripts automatically changes the max length of columns named identifier
    `tablet_name` VARCHAR(50) NOT NULL,
    `settings` LONGTEXT,

    `battery` TINYINT UNSIGNED NOT NULL DEFAULT 100,

    `is_setup` BOOLEAN DEFAULT FALSE,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_apps_loggedin` (
    `tablet_id` VARCHAR(100) NOT NULL,
    `app` VARCHAR(25) NOT NULL,
    `account` VARCHAR(100) NOT NULL,
    `active` BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (`tablet_id`, `app`, `account`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_notifications` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `app` VARCHAR(50) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `content` VARCHAR(500) NOT NULL,

    `thumbnail` VARCHAR(500) DEFAULT NULL,
    `avatar` VARCHAR(500) DEFAULT NULL,
    `show_avatar` BOOLEAN NOT NULL DEFAULT FALSE,
    `custom_data` TEXT DEFAULT NULL,

    `received_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Camera & photos app
CREATE TABLE IF NOT EXISTS `lbtablet_photo_albums` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `title` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES `lbtablet_tablets`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_photos` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `link` VARCHAR(500),
    `is_video` BOOLEAN DEFAULT FALSE,
    `size` FLOAT NOT NULL DEFAULT 0,
    `metadata` VARCHAR(20) DEFAULT NULL,

    `is_favourite` BOOLEAN NOT NULL DEFAULT FALSE,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_photo_album_photos` (
    `album_id` INT UNSIGNED NOT NULL,
    `photo_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`album_id`, `photo_id`),
    FOREIGN KEY (`album_id`) REFERENCES `lbtablet_photo_albums`(`id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`photo_id`) REFERENCES `lbtablet_photos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Notes app
CREATE TABLE IF NOT EXISTS `lbtablet_notes` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `title` VARCHAR(50) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,

    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Mail app
CREATE TABLE IF NOT EXISTS `phone_mail_accounts` (
    `address` VARCHAR(100) NOT NULL,
    `password` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`address`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_messages` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `recipient` VARCHAR(100) NOT NULL,
    `sender` VARCHAR(100) NOT NULL,

    `subject` VARCHAR(100) NOT NULL,
    `content` TEXT NOT NULL,
    `attachments` LONGTEXT, -- json array of attachments
    `actions` LONGTEXT, -- json array of actions

    `read` BOOLEAN NOT NULL DEFAULT FALSE,

    `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `phone_mail_deleted` (
    `message_id` INT UNSIGNED NOT NULL,
    `address` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`message_id`, `address`),
    FOREIGN KEY (`message_id`) REFERENCES `phone_mail_messages`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`address`) REFERENCES `phone_mail_accounts`(`address`) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- #region Police app

CREATE TABLE IF NOT EXISTS `lbtablet_police_profiles` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier / vehicle plate
    `avatar` VARCHAR(500) DEFAULT NULL,
    `notes` TEXT NOT NULL DEFAULT '',
    `profile_type` VARCHAR(50) NOT NULL DEFAULT 'player',

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_tags` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `color` VARCHAR(10) NOT NULL,
    `type` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_profile_tags` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier / vehicle plate
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`id`, `tag_id`),
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_police_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_accounts` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier
    `display_name` VARCHAR(100) NOT NULL,
    `avatar` VARCHAR(500) DEFAULT NULL,
    `callsign` VARCHAR(10) DEFAULT NULL,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_bulletin` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,
    `pinned` BOOLEAN NOT NULL DEFAULT FALSE,
    `created_by` VARCHAR(100) NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_police_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_offences_categories` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`title`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_offences` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `category_id` INT UNSIGNED NOT NULL,
    `class` VARCHAR(100) NOT NULL, -- misdemeanor, felony, etc
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `fine` INT UNSIGNED NOT NULL DEFAULT 0,
    `jail_time` INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`category_id`, `class`, `title`),
    FOREIGN KEY (`category_id`) REFERENCES lbtablet_police_offences_categories(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_logs` (
    `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_by` VARCHAR(100) DEFAULT NULL,
    `related_id` VARCHAR(500) DEFAULT NULL,
    `log_action` VARCHAR(50) NOT NULL,
    `log_type` VARCHAR(100) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`log_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Reports
CREATE TABLE IF NOT EXISTS `lbtablet_police_reports` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `report_type` VARCHAR(100) NOT NULL,
    `created_by` VARCHAR(100) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_police_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_reports_attachments` (
    `report_id` INT UNSIGNED NOT NULL,
    `attachment` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`report_id`, `attachment`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_reports_involved` (
    `report_id` INT UNSIGNED NOT NULL,
    `involved` VARCHAR(100) NOT NULL, -- the player identifier/weapon id
    `involvement` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`report_id`, `involved`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_reports_tags` (
    `report_id` INT UNSIGNED NOT NULL,
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`report_id`, `tag_id`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_police_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Warrants
CREATE TABLE IF NOT EXISTS `lbtablet_police_warrants` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `created_by` VARCHAR(100) NOT NULL,
    `warrant_type` VARCHAR(100) NOT NULL,
    `warrant_status` VARCHAR(50) NOT NULL DEFAULT 'active',
    `priority` VARCHAR(50) NOT NULL DEFAULT 'low',
    `title` VARCHAR(100) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,
    `linked_profile_id` VARCHAR(100) DEFAULT NULL,
    `linked_profile_type` VARCHAR(50) DEFAULT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_police_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_warrants_linked_reports` (
    `warrant_id` INT UNSIGNED NOT NULL,
    `report_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`warrant_id`, `report_id`),
    FOREIGN KEY (`warrant_id`) REFERENCES lbtablet_police_warrants(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_warrants_attachments` (
    `warrant_id` INT UNSIGNED NOT NULL,
    `attachment` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`warrant_id`, `attachment`),
    FOREIGN KEY (`warrant_id`) REFERENCES lbtablet_police_warrants(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_warrants_tags` (
    `warrant_id` INT UNSIGNED NOT NULL,
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`warrant_id`, `tag_id`),
    FOREIGN KEY (`warrant_id`) REFERENCES lbtablet_police_warrants(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_police_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CASES/INCIDENTS
CREATE TABLE IF NOT EXISTS `lbtablet_police_cases` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `title` VARCHAR(100) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,
    `closed` BOOLEAN NOT NULL DEFAULT FALSE,
    `created_by` VARCHAR(100) NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_police_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_evidence` (
    `case_id` INT UNSIGNED NOT NULL,
    `attachment` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`case_id`, `attachment`),
    FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_tags` (
    `case_id` INT UNSIGNED NOT NULL,
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`case_id`, `tag_id`),
    FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_police_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_involved` (
    `case_id` INT UNSIGNED NOT NULL,
    `involved` VARCHAR(100) NOT NULL, -- the player identifier / vehicle plate
    `involvement` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`case_id`, `involved`),
    FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_criminals` (
    `case_id` INT UNSIGNED NOT NULL,
    `id` VARCHAR(100) NOT NULL,
    `fine` INT UNSIGNED NOT NULL DEFAULT 0,
    `jail_time` INT UNSIGNED NOT NULL DEFAULT 0,
    `fined` BOOLEAN NOT NULL DEFAULT FALSE,
    `jailed` BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (`case_id`, `id`),
    FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_charges` (
    `case_id` INT UNSIGNED NOT NULL,
    `criminal` VARCHAR(100) NOT NULL,
    `offence_id` INT UNSIGNED NOT NULL,
    `charges` TINYINT UNSIGNED NOT NULL DEFAULT 1,

    PRIMARY KEY (`case_id`, `criminal`, `offence_id`),
    FOREIGN KEY (`case_id`, `criminal`) REFERENCES lbtablet_police_cases_criminals(`case_id`, `id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`offence_id`) REFERENCES lbtablet_police_offences(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_cases_linked_reports` (
    `case_id` INT UNSIGNED NOT NULL,
    `report_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`case_id`, `report_id`),
    FOREIGN KEY (`case_id`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_police_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Jail
CREATE TABLE IF NOT EXISTS `lbtablet_police_jail` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `prisoner` VARCHAR(100) NOT NULL,
    `jailed_by` VARCHAR(100) DEFAULT NULL,
    `reason` VARCHAR(100) NOT NULL,
    `original_time` INT UNSIGNED NOT NULL,
    `jail_time` INT UNSIGNED NOT NULL,
    `jailed_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `related_case` INT UNSIGNED DEFAULT NULL,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`related_case`) REFERENCES lbtablet_police_cases(`id`) ON UPDATE CASCADE ON DELETE SET NULL
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Weapons
CREATE TABLE IF NOT EXISTS `lbtablet_police_weapons` (
    `serial_number` VARCHAR(100) NOT NULL,

    `owner` VARCHAR(100) DEFAULT NULL,
    `weapon_name` VARCHAR(100) DEFAULT NULL,

    PRIMARY KEY (`serial_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Wiretapping
CREATE TABLE IF NOT EXISTS `lbtablet_police_wiretaps` (
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the tapped phone
    `creator_tablet_id` VARCHAR(100) NOT NULL, -- the tablet id of the officer who created the wiretap
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`phone_number`),
    FOREIGN KEY (`creator_tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_police_wiretaps_subscribers` (
    `tablet_id` VARCHAR(100) NOT NULL, -- the tablet id of the officer who subscribed to the wiretap
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the tapped phone

    PRIMARY KEY (`tablet_id`, `phone_number`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`phone_number`) REFERENCES lbtablet_police_wiretaps(`phone_number`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Phone unlocking
CREATE TABLE IF NOT EXISTS `lbtablet_police_phone_unlocks` (
    `phone_number` VARCHAR(15) NOT NULL, -- the phone number of the phone to be unlocked
    `attempts` TINYINT UNSIGNED NOT NULL DEFAULT 0, -- the number of attempts used to unlock the phone
    `unlocked` BOOLEAN NOT NULL DEFAULT FALSE, -- whether the phone is unlocked or not
    `finished_at` DATETIME NOT NULL, -- the time when the unlocking process finished

    PRIMARY KEY (`phone_number`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- #endregion

-- #region Ambulance app

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_accounts` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier
    `display_name` VARCHAR(100) NOT NULL,
    `avatar` VARCHAR(500) DEFAULT NULL,
    `callsign` VARCHAR(10) DEFAULT NULL,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_bulletin` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,
    `pinned` BOOLEAN NOT NULL DEFAULT FALSE,
    `created_by` VARCHAR(100) NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_ambulance_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_conditions_categories` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`title`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_conditions` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `severity` VARCHAR(25) NOT NULL, -- critial, serious, moderate, minor
    `category_id` INT UNSIGNED NOT NULL,
    `title` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id`),
    UNIQUE KEY (`severity`, `category_id`, `title`),
    FOREIGN KEY (`category_id`) REFERENCES lbtablet_ambulance_conditions_categories(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_logs` (
    `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `created_by` VARCHAR(100) DEFAULT NULL,
    `related_id` VARCHAR(500) DEFAULT NULL,
    `log_action` VARCHAR(25) NOT NULL, -- create, update, delete
    `log_type` VARCHAR(100) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `content` MEDIUMTEXT NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`log_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_tags` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL,
    `color` VARCHAR(10) NOT NULL,
    `tag_type` VARCHAR(20) NOT NULL, -- profile, report

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_profiles` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier
    `avatar` VARCHAR(500) DEFAULT NULL,
    `notes` TEXT NOT NULL DEFAULT '',

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_profile_tags` (
    `id` VARCHAR(100) NOT NULL, -- the player identifier
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`id`, `tag_id`),
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_ambulance_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_profile_conditions` (
    `profile_id` VARCHAR(100) NOT NULL,
    `condition_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`profile_id`, `condition_id`),
    FOREIGN KEY (`profile_id`) REFERENCES lbtablet_ambulance_profiles(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`condition_id`) REFERENCES lbtablet_ambulance_conditions(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_reports` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `created_by` VARCHAR(100) NOT NULL,
    `patient` VARCHAR(100) NOT NULL,

    `title` VARCHAR(100) NOT NULL,
    `description` MEDIUMTEXT NOT NULL,
    `report_type` VARCHAR(100) NOT NULL,

    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`created_by`) REFERENCES lbtablet_ambulance_accounts(`id`) ON UPDATE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_reports_attachments` (
    `report_id` INT UNSIGNED NOT NULL,
    `attachment` VARCHAR(500) NOT NULL,

    PRIMARY KEY (`report_id`, `attachment`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_ambulance_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_reports_tags` (
    `report_id` INT UNSIGNED NOT NULL,
    `tag_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`report_id`, `tag_id`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_ambulance_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`tag_id`) REFERENCES lbtablet_ambulance_tags(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_reports_doctors` (
    `report_id` INT UNSIGNED NOT NULL,
    `doctor` VARCHAR(100) NOT NULL, -- the player identifier

    PRIMARY KEY (`report_id`, `doctor`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_ambulance_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`doctor`) REFERENCES lbtablet_ambulance_accounts(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_ambulance_reports_conditions` (
    `report_id` INT UNSIGNED NOT NULL,
    `condition_id` INT UNSIGNED NOT NULL,

    PRIMARY KEY (`report_id`, `condition_id`),
    FOREIGN KEY (`report_id`) REFERENCES lbtablet_ambulance_reports(`id`) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (`condition_id`) REFERENCES lbtablet_ambulance_conditions(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- #endregion

-- #region Chat
CREATE TABLE IF NOT EXISTS `lbtablet_chat_rooms` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `terminal_type` VARCHAR(50) NOT NULL, -- police, ambulance etc
    `label` VARCHAR(50) NOT NULL,
    `icon` VARCHAR(500) DEFAULT NULL,
    `private` BOOLEAN NOT NULL DEFAULT FALSE,
    `creator` VARCHAR(100) NOT NULL,
    `last_message` TEXT DEFAULT NULL,
    `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_chat_rooms_messages` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `room_id` INT UNSIGNED NOT NULL,
    `author` VARCHAR(100) NOT NULL,
    `message` TEXT DEFAULT NULL,
    `attachments` TEXT DEFAULT NULL,

    `sent_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`room_id`) REFERENCES lbtablet_chat_rooms(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `lbtablet_chat_rooms_members` (
    `room_id` INT UNSIGNED NOT NULL,
    `account` VARCHAR(100) NOT NULL,
    `notifications` INT UNSIGNED NOT NULL DEFAULT 0,

    PRIMARY KEY (`room_id`, `account`),
    FOREIGN KEY (`room_id`) REFERENCES lbtablet_chat_rooms(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- #endregion

-- Clock
CREATE TABLE IF NOT EXISTS `lbtablet_clock_alarms` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `hours` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `minutes` TINYINT UNSIGNED NOT NULL DEFAULT 0,

    `label` VARCHAR(50),
    `enabled` BOOLEAN NOT NULL DEFAULT TRUE,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Voice memo
CREATE TABLE IF NOT EXISTS `lbtablet_voice_memo_recordings` (
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `tablet_id` VARCHAR(100) NOT NULL,

    `file_name` VARCHAR(50) NOT NULL,
    `file_url` VARCHAR(500) NOT NULL,
    `file_length` INT(11) NOT NULL,

    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (`id`),
    FOREIGN KEY (`tablet_id`) REFERENCES lbtablet_tablets(`id`) ON UPDATE CASCADE ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
