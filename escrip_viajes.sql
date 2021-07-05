-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema viajes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema viajes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `viajes` DEFAULT CHARACTER SET utf8 COLLATE utf8_estonian_ci ;
USE `viajes` ;

-- -----------------------------------------------------
-- Table `viajes`.`avion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`avion` (
  `idavion` INT NOT NULL AUTO_INCREMENT,
  `tipoAvion` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `capacidad` INT NOT NULL,
  `matricula` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `empresa` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `avioncol` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  PRIMARY KEY (`idavion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viajes`.`destino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`destino` (
  `iddestino` INT NOT NULL AUTO_INCREMENT,
  `aeropuerto` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `ciudad` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iddestino`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viajes`.`origen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`origen` (
  `idtable1` INT NOT NULL AUTO_INCREMENT,
  `aeropuerto` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `ciudad` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `pais` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  PRIMARY KEY (`idtable1`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viajes`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `apellido` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `edad` INT NOT NULL,
  `documento` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viajes`.`tiquete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`tiquete` (
  `idtiquete` INT NOT NULL AUTO_INCREMENT,
  `clase` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `asiento` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `hora` TIME NOT NULL,
  `fecha` DATE NOT NULL,
  `avion_idavion` INT NOT NULL,
  `destino_iddestino` INT NOT NULL,
  `origen_idtable1` INT NOT NULL,
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idtiquete`),
  INDEX `fk_tiquete_avion_idx` (`avion_idavion` ASC) VISIBLE,
  INDEX `fk_tiquete_destino1_idx` (`destino_iddestino` ASC) VISIBLE,
  INDEX `fk_tiquete_origen1_idx` (`origen_idtable1` ASC) VISIBLE,
  INDEX `fk_tiquete_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_tiquete_avion`
    FOREIGN KEY (`avion_idavion`)
    REFERENCES `viajes`.`avion` (`idavion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiquete_destino1`
    FOREIGN KEY (`destino_iddestino`)
    REFERENCES `viajes`.`destino` (`iddestino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiquete_origen1`
    FOREIGN KEY (`origen_idtable1`)
    REFERENCES `viajes`.`origen` (`idtable1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiquete_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `viajes`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `viajes`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `viajes`.`reserva` (
  `idreserva` INT NOT NULL AUTO_INCREMENT,
  `fechaReserva` DATE NOT NULL,
  `idaYvuelta` VARCHAR(5) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL DEFAULT 'no',
  `usuario_idusuario` INT NOT NULL,
  PRIMARY KEY (`idreserva`),
  INDEX `fk_reserva_usuario1_idx` (`usuario_idusuario` ASC) VISIBLE,
  CONSTRAINT `fk_reserva_usuario1`
    FOREIGN KEY (`usuario_idusuario`)
    REFERENCES `viajes`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
