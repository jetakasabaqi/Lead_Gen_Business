-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema lead_gen_business
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lead_gen_business
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lead_gen_business` DEFAULT CHARACTER SET utf8 ;
USE `lead_gen_business` ;

-- -----------------------------------------------------
-- Table `lead_gen_business`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_gen_business`.`clients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(25) NULL,
  `last_name` VARCHAR(25) NULL,
  `email` VARCHAR(50) NULL,
  `joined_datetime` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lead_gen_business`.`billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_gen_business`.`billing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` FLOAT NULL,
  `charged_datetime` DATETIME NULL DEFAULT NOW(),
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_billing_clients_idx` (`client_id` ASC),
  CONSTRAINT `fk_billing_clients`
    FOREIGN KEY (`client_id`)
    REFERENCES `lead_gen_business`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lead_gen_business`.`sites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_gen_business`.`sites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `domain_name` VARCHAR(100) NULL,
  `created_datetime` DATETIME NULL DEFAULT NOW(),
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sites_clients1_idx` (`client_id` ASC),
  CONSTRAINT `fk_sites_clients1`
    FOREIGN KEY (`client_id`)
    REFERENCES `lead_gen_business`.`clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lead_gen_business`.`leads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lead_gen_business`.`leads` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NULL,
  `last_name` VARCHAR(50) NULL,
  `registred_datetime` DATETIME NULL DEFAULT NOW(),
  `email` VARCHAR(50) NULL,
  `site_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_leads_sites1_idx` (`site_id` ASC),
  CONSTRAINT `fk_leads_sites1`
    FOREIGN KEY (`site_id`)
    REFERENCES `lead_gen_business`.`sites` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
