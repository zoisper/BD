-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mercearia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mercearia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mercearia` ;
USE `mercearia` ;

-- -----------------------------------------------------
-- Table `mercearia`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercearia`.`Cliente` (
  `Numero` INT NOT NULL,
  `Nome` VARCHAR(75) NOT NULL,
  `DataNascimento` DATETIME NULL,
  `Profissao` VARCHAR(75) NULL,
  `Rua` VARCHAR(75) NOT NULL,
  `Localidade` VARCHAR(50) NOT NULL,
  `CodPostal` VARCHAR(75) NOT NULL,
  `Contribuinte` INT NOT NULL,
  `eMail` VARCHAR(100) NULL,
  `Compras` VARCHAR(45) NULL,
  `RecomendadoPor` INT NULL,
  PRIMARY KEY (`Numero`),
  INDEX `fk_Cliente_1_idx` (`RecomendadoPor` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_1`
    FOREIGN KEY (`RecomendadoPor`)
    REFERENCES `mercearia`.`Cliente` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercearia`.`Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercearia`.`Venda` (
  `Numero` INT NOT NULL,
  `Data` DATETIME NOT NULL,
  `Estado` CHAR(1) NOT NULL,
  `Total` DECIMAL(8,2) NOT NULL,
  `Cliente` INT NOT NULL,
  PRIMARY KEY (`Numero`),
  INDEX `fk_Venda_1_idx` (`Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Venda_1`
    FOREIGN KEY (`Cliente`)
    REFERENCES `mercearia`.`Cliente` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercearia`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercearia`.`Produto` (
  `Numero` INT NOT NULL,
  `Designacao` VARCHAR(75) NOT NULL,
  `Unidade` CHAR(3) NOT NULL,
  `Preco` DECIMAL(6,2) NOT NULL,
  `Tipo` VARCHAR(50) NULL,
  PRIMARY KEY (`Numero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mercearia`.`VendaProduto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mercearia`.`VendaProduto` (
  `Venda` INT NOT NULL,
  `Produto` INT NOT NULL,
  `Quantidade` DECIMAL(5,2) NOT NULL,
  `Preco` DECIMAL(6,2) NOT NULL,
  `Valor` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`Venda`, `Produto`),
  INDEX `fk_VendaProduto_2_idx` (`Produto` ASC) VISIBLE,
  CONSTRAINT `fk_VendaProduto_1`
    FOREIGN KEY (`Venda`)
    REFERENCES `mercearia`.`Venda` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VendaProduto_2`
    FOREIGN KEY (`Produto`)
    REFERENCES `mercearia`.`Produto` (`Numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
