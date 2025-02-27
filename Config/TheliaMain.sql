
# This is a fix for InnoDB in MySQL >= 4.1.x
# It "suspends judgement" for fkey relationships until are tables are set.
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- rewriting_redirect_type
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `rewriting_redirect_type`;

CREATE TABLE `rewriting_redirect_type`
(
    `id` INTEGER NOT NULL,
    `httpcode` INTEGER,
    PRIMARY KEY (`id`),
    CONSTRAINT `rewriting_redirect_type_FK_1`
        FOREIGN KEY (`id`)
        REFERENCES `rewriting_url` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- rewriteurl_rule
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `rewriteurl_rule`;

CREATE TABLE `rewriteurl_rule`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `rule_type` VARCHAR(64) NOT NULL,
    `value` VARCHAR(255),
    `only404` TINYINT(1) NOT NULL,
    `redirect_url` VARCHAR(255) NOT NULL,
    `position` INTEGER(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- rewriteurl_rule_param
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `rewriteurl_rule_param`;

CREATE TABLE `rewriteurl_rule_param`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `id_rule` INTEGER NOT NULL,
    `param_name` VARCHAR(255) NOT NULL,
    `param_condition` VARCHAR(64) NOT NULL,
    `param_value` VARCHAR(255),
    PRIMARY KEY (`id`),
    INDEX `fi_riteurl_rule_rule_param_FK_id` (`id_rule`),
    CONSTRAINT `rewriteurl_rule_rule_param_FK_id`
        FOREIGN KEY (`id_rule`)
        REFERENCES `rewriteurl_rule` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- rewriteurl_error_url
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `rewriteurl_error_url`;

CREATE TABLE `rewriteurl_error_url`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `url_source` VARCHAR(255) NOT NULL,
    `count` INTEGER NOT NULL,
    `user_agent` VARCHAR(255) NOT NULL,
    `rewriteurl_rule_id` INTEGER,
    `created_at` DATETIME,
    `updated_at` DATETIME,
    PRIMARY KEY (`id`),
    INDEX `fi_riteurl_error_url_param_FK_id` (`rewriteurl_rule_id`),
    CONSTRAINT `rewriteurl_error_url_param_FK_id`
        FOREIGN KEY (`rewriteurl_rule_id`)
        REFERENCES `rewriteurl_rule` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- rewriteurl_error_url_referer
-- ---------------------------------------------------------------------

DROP TABLE IF EXISTS `rewriteurl_error_url_referer`;

CREATE TABLE `rewriteurl_error_url_referer`
(
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `rewriteurl_error_url_id` INTEGER NOT NULL,
    `referer` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `rewriteurl_error_url_referer_fi_e0277e` (`rewriteurl_error_url_id`),
    CONSTRAINT `rewriteurl_error_url_referer_fk_e0277e`
        FOREIGN KEY (`rewriteurl_error_url_id`)
        REFERENCES `rewriteurl_error_url` (`id`)
        ON DELETE CASCADE
) ENGINE=InnoDB;

# This restores the fkey checks, after having unset them earlier
SET FOREIGN_KEY_CHECKS = 1;
