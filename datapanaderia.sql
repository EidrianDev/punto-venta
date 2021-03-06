-- MySQL Script generated by MySQL Workbench
-- Thu Nov 11 06:39:29 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema panaderia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `panaderia` ;

-- -----------------------------------------------------
-- Schema panaderia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `panaderia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci ;
USE `panaderia` ;

-- -----------------------------------------------------
-- Table `panaderia`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`categorias` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`categorias` (
  `idcategorias` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idcategorias`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE INDEX `idcategorias` ON `panaderia`.`categorias` (`idcategorias` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`cliente` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `documento` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(14) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `fechaNacimiento` DATE NOT NULL,
  `compras` INT NOT NULL,
  `ultimaCompra` DATETIME NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

CREATE INDEX `idcliente` ON `panaderia`.`cliente` (`idcliente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`producto` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`producto` (
  `idproducto` INT NOT NULL AUTO_INCREMENT,
  `idcategorias` INT NULL DEFAULT NULL,
  `nombreProducto` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `imagen` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  `fecha` DATETIME NOT NULL,
  `precioVenta` FLOAT NOT NULL,
  `codigo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `ventas` INT NOT NULL,
  `idventa` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  CONSTRAINT `idcategorias`
    FOREIGN KEY (`idcategorias`)
    REFERENCES `panaderia`.`categorias` (`idcategorias`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

CREATE INDEX `id` ON `panaderia`.`producto` (`idproducto` ASC) VISIBLE;

CREATE INDEX `idCategorias_idx` ON `panaderia`.`producto` (`idcategorias` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`stock` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`stock` (
  `idstock` INT NOT NULL AUTO_INCREMENT,
  `idproducto` INT NOT NULL,
  `stock` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`idstock`),
  CONSTRAINT `idproducto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `panaderia`.`producto` (`idproducto`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE INDEX `idstock` ON `panaderia`.`stock` (`idstock` ASC) VISIBLE;

CREATE INDEX `idproducto_idx` ON `panaderia`.`stock` (`idproducto` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`sobrante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`sobrante` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`sobrante` (
  `idsobrante` INT NOT NULL AUTO_INCREMENT,
  `idstock` INT NULL DEFAULT NULL,
  `sobrante` INT NOT NULL,
  `fecha` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idsobrante`),
  CONSTRAINT `idstock`
    FOREIGN KEY (`idstock`)
    REFERENCES `panaderia`.`stock` (`idstock`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

CREATE INDEX `idsobrante` ON `panaderia`.`sobrante` (`idsobrante` ASC) VISIBLE;

CREATE INDEX `idstock_idx` ON `panaderia`.`sobrante` (`idstock` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`usuarios` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish2_ci' NOT NULL,
  `usuario` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish2_ci' NOT NULL,
  `password` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish2_ci' NOT NULL,
  `perfil` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish2_ci' NOT NULL,
  `foto` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_spanish2_ci' NULL DEFAULT NULL,
  `estado` TINYINT NOT NULL,
  `ultimoLogin` DATETIME NOT NULL,
  `fecha` DATE NOT NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

CREATE INDEX `idusuarios` ON `panaderia`.`usuarios` (`idusuarios` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `panaderia`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `panaderia`.`ventas` ;

CREATE TABLE IF NOT EXISTS `panaderia`.`ventas` (
  `idventas` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idusuario` INT NOT NULL,
  `idproductos` INT NOT NULL,
  `codigo` INT NOT NULL,
  `producto` VARCHAR(45) NOT NULL,
  `metodopago` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `impuesto` FLOAT NOT NULL,
  `neto` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  PRIMARY KEY (`idventas`),
  CONSTRAINT `idcliente`
    FOREIGN KEY (`idcliente`)
    REFERENCES `panaderia`.`cliente` (`idcliente`),
  CONSTRAINT `idproductos`
    FOREIGN KEY (`idproductos`)
    REFERENCES `panaderia`.`producto` (`idproducto`),
  CONSTRAINT `idusuario`
    FOREIGN KEY (`idusuario`)
    REFERENCES `panaderia`.`usuarios` (`idusuarios`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_spanish_ci;

CREATE INDEX `idventas` ON `panaderia`.`ventas` (`idventas` ASC) VISIBLE;

CREATE INDEX `idcliente_idx` ON `panaderia`.`ventas` (`idcliente` ASC) VISIBLE;

CREATE INDEX `idusuario_idx` ON `panaderia`.`ventas` (`idusuario` ASC) INVISIBLE;

CREATE INDEX `idproductos_idx` ON `panaderia`.`ventas` (`idproductos` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
