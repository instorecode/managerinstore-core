SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema instore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `instore` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `instore` ;

-- -----------------------------------------------------
-- Table `instore`.`regiao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`regiao` (
  `idregiao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idregiao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `idregiao` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `sigla` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`idestado`),
  INDEX `fk_estado_regiao1_idx` (`idregiao` ASC),
  CONSTRAINT `fk_estado_regiao1`
    FOREIGN KEY (`idregiao`)
    REFERENCES `instore`.`regiao` (`idregiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`cidade` (
  `idcidade` INT NOT NULL AUTO_INCREMENT,
  `idestado` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idcidade`),
  INDEX `fk_cidade_estado1_idx` (`idestado` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`idestado`)
    REFERENCES `instore`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`bairro` (
  `idbairro` INT NOT NULL AUTO_INCREMENT,
  `idcidade` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_cidade1_idx` (`idcidade` ASC),
  CONSTRAINT `fk_bairro_cidade1`
    FOREIGN KEY (`idcidade`)
    REFERENCES `instore`.`cidade` (`idcidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`cep`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`cep` (
  `idcep` INT NOT NULL AUTO_INCREMENT,
  `idbairro` INT NOT NULL,
  `numero` VARCHAR(10) NULL,
  PRIMARY KEY (`idcep`),
  INDEX `fk_cep_bairro1_idx` (`idbairro` ASC),
  CONSTRAINT `fk_cep_bairro1`
    FOREIGN KEY (`idbairro`)
    REFERENCES `instore`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `idcep` INT NOT NULL,
  `numero` VARCHAR(255) NOT NULL,
  `complemento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_cep1_idx` (`idcep` ASC),
  CONSTRAINT `fk_endereco_cep1`
    FOREIGN KEY (`idcep`)
    REFERENCES `instore`.`cep` (`idcep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`usuario` (
  `idusuario` INT NOT NULL AUTO_INCREMENT,
  `idendereco` INT NULL,
  `data_cadastro` DATETIME NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_usuario_endereco1_idx` (`idendereco` ASC),
  CONSTRAINT `fk_usuario_endereco1`
    FOREIGN KEY (`idendereco`)
    REFERENCES `instore`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `idendereco` INT NULL,
  `parente` INT(11) NOT NULL DEFAULT 0,
  `nome` VARCHAR(255) NOT NULL,
  `matriz` TINYINT(1) NOT NULL DEFAULT 0,
  `instore` TINYINT(1) NOT NULL,
  `situacao` TINYINT(1) NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_empresa_endereco1_idx` (`idendereco` ASC),
  CONSTRAINT `fk_empresa_endereco1`
    FOREIGN KEY (`idendereco`)
    REFERENCES `instore`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`perfil` (
  `idperfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`funcionalidade` (
  `idfuncionalidade` INT NOT NULL AUTO_INCREMENT,
  `mapping_id` VARCHAR(255) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `icone` VARCHAR(30) NULL,
  `parente` INT(11) NOT NULL DEFAULT 0,
  `visivel` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idfuncionalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`perfil_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`perfil_usuario` (
  `idperfil_usuario` INT NOT NULL AUTO_INCREMENT,
  `idperfil` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idperfil_usuario`),
  INDEX `fk_perfil_usuario_perfil1_idx` (`idperfil` ASC),
  INDEX `fk_perfil_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_perfil_usuario_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `instore`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `instore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`perfil_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`perfil_funcionalidade` (
  `idperfil_funcionalidade` INT NOT NULL AUTO_INCREMENT,
  `idfuncionalidade` INT NOT NULL,
  `idperfil` INT NOT NULL,
  PRIMARY KEY (`idperfil_funcionalidade`),
  INDEX `fk_perfil_funcionalidade_funcionalidade1_idx` (`idfuncionalidade` ASC),
  INDEX `fk_perfil_funcionalidade_perfil1_idx` (`idperfil` ASC),
  CONSTRAINT `fk_perfil_funcionalidade_funcionalidade1`
    FOREIGN KEY (`idfuncionalidade`)
    REFERENCES `instore`.`funcionalidade` (`idfuncionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_funcionalidade_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `instore`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`usuario_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`usuario_cliente` (
  `idusuario_empresa` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuario_empresa`),
  INDEX `fk_usuario_empresa_empresa1_idx` (`idcliente` ASC),
  INDEX `fk_usuario_empresa_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_usuario_empresa_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_empresa_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `instore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`dados_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`dados_cliente` (
  `iddados_cliente` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `razao_social` TEXT NOT NULL,
  `nome_fantasia` VARCHAR(255) NOT NULL,
  `indice_reajuste_contrato` DECIMAL NOT NULL,
  `data_inicio_contrato` DATE NOT NULL,
  `data_termino_contrato` DATE NOT NULL,
  `renovacao_automatica` TINYINT(1) NOT NULL,
  PRIMARY KEY (`iddados_cliente`),
  INDEX `fk_dados_empresa_empresa1_idx` (`idcliente` ASC),
  CONSTRAINT `fk_dados_empresa_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`dados_bancario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`dados_bancario` (
  `iddados_bancario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `agencia` VARCHAR(45) NOT NULL,
  `numero_conta` VARCHAR(45) NOT NULL,
  `carteira` VARCHAR(45) NOT NULL,
  `nosso_numero` VARCHAR(45) NOT NULL,
  `nosso_numero_digito` VARCHAR(45) NOT NULL,
  `codigo_banco` VARCHAR(45) NOT NULL,
  `ultimo_documento` INT(11) NOT NULL,
  PRIMARY KEY (`iddados_bancario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`boleto` (
  `idboleto` INT NOT NULL,
  `idcliente` INT NOT NULL,
  `iddados_bancario` INT NOT NULL,
  `data_emissao` DATE NOT NULL,
  `arquivo` BLOB NOT NULL,
  `pagamento_efetuado` TINYINT(1) NOT NULL,
  `data_pagamento` DATE NULL,
  `valor_pagamento` DOUBLE NULL,
  `numero_documento` INT(11) NOT NULL,
  PRIMARY KEY (`idboleto`),
  INDEX `fk_boleto_empresa1_idx` (`idcliente` ASC),
  INDEX `fk_boleto_dados_bancario1_idx` (`iddados_bancario` ASC),
  CONSTRAINT `fk_boleto_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boleto_dados_bancario1`
    FOREIGN KEY (`iddados_bancario`)
    REFERENCES `instore`.`dados_bancario` (`iddados_bancario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_categoria` (
  `codigo` SMALLINT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `categoria` VARCHAR(30) NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NOT NULL,
  `tipo` SMALLINT NOT NULL,
  `tempo` TIME NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_audiostore_categoria_empresa1_idx` (`idcliente` ASC),
  CONSTRAINT `fk_audiostore_categoria_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_programacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_programacao` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(20) NOT NULL,
  `idcliente` INT NOT NULL,
  `data_inicio` DATE NOT NULL,
  `data_final` DATE NOT NULL,
  `hora_inicio` TIME NULL,
  `hora_final` TIME NULL,
  `segunda_feira` TINYINT(1) NOT NULL,
  `terca_feira` TINYINT(1) NOT NULL,
  `quarta_feira` TINYINT(1) NOT NULL,
  `quinta_feira` TINYINT(1) NOT NULL,
  `sexta_feira` TINYINT(1) NOT NULL,
  `sabado` TINYINT(1) NOT NULL,
  `domingo` TINYINT(1) NOT NULL,
  INDEX `fk_audiostore_programacao_empresa1_idx` (`idcliente` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC),
  CONSTRAINT `fk_audiostore_programacao_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_programacao_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_programacao_categoria` (
  `idaudiostore_programacao_categoria` INT NOT NULL AUTO_INCREMENT,
  `codigo` SMALLINT NOT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`idaudiostore_programacao_categoria`),
  INDEX `fk_audiostore_programacao_categoria_audiostore_categoria1_idx` (`codigo` ASC),
  INDEX `fk_audiostore_programacao_categoria_audiostore_programacao1_idx` (`id` ASC),
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_categoria1`
    FOREIGN KEY (`codigo`)
    REFERENCES `instore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_programacao1`
    FOREIGN KEY (`id`)
    REFERENCES `instore`.`audiostore_programacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`config_app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`config_app` (
  `idconfig_app` INT NOT NULL,
  `data_path` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idconfig_app`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`auditoria` (
  `idauditoria` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `acao` SMALLINT NOT NULL,
  `entidade` VARCHAR(255) NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`idauditoria`),
  INDEX `fk_auditoria_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_auditoria_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `instore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`auditoria_dados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`auditoria_dados` (
  `idauditoria_dados` INT NOT NULL AUTO_INCREMENT,
  `idauditoria` INT NOT NULL,
  `coluna` VARCHAR(45) NULL,
  `valor_atual` TEXT NULL,
  `valor_novo` TEXT NULL,
  PRIMARY KEY (`idauditoria_dados`),
  INDEX `fk_auditoria_colunas_auditoria1_idx` (`idauditoria` ASC),
  CONSTRAINT `fk_auditoria_colunas_auditoria1`
    FOREIGN KEY (`idauditoria`)
    REFERENCES `instore`.`auditoria` (`idauditoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`historico_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`historico_usuario` (
  `idhistorico_usuario` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `login` DATETIME NOT NULL,
  `logout` DATETIME NOT NULL,
  PRIMARY KEY (`idhistorico_usuario`),
  INDEX `fk_historico_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_historico_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `instore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`voz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`voz` (
  `idvoz` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `genero` TINYINT(1) NOT NULL,
  `tipo` SMALLINT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `tel` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idvoz`),
  INDEX `fk_voz_cliente1_idx` (`idcliente` ASC),
  CONSTRAINT `fk_voz_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`contato_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`contato_cliente` (
  `idcontato_cliente` INT NOT NULL AUTO_INCREMENT,
  `iddados_cliente` INT NOT NULL,
  `nome` VARCHAR(255) NULL,
  `principal` TINYINT(1) NOT NULL,
  `email` VARCHAR(255) NULL,
  `tel` VARCHAR(20) NULL,
  `setor` VARCHAR(255) NULL,
  PRIMARY KEY (`idcontato_cliente`),
  INDEX `fk_contato_cliente_dados_cliente1_idx` (`iddados_cliente` ASC),
  CONSTRAINT `fk_contato_cliente_dados_cliente1`
    FOREIGN KEY (`iddados_cliente`)
    REFERENCES `instore`.`dados_cliente` (`iddados_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_gravadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_gravadora` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_musica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_musica` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `gravadora` INT NOT NULL,
  `categoria1` SMALLINT NOT NULL,
  `categoria2` SMALLINT NULL,
  `categoria3` SMALLINT NULL,
  `arquivo` VARCHAR(30) NOT NULL,
  `interprete` VARCHAR(30) NOT NULL,
  `tipo_interprete` SMALLINT NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `cut` TINYINT(1) NOT NULL,
  `crossover` TINYINT(1) NOT NULL,
  `data_vencimento_crossover` DATE NOT NULL,
  `dias_execucao1` INT(11) NOT NULL,
  `dias_execucao2` INT(11) NOT NULL,
  `afinidade1` VARCHAR(30) NOT NULL,
  `afinidade2` VARCHAR(30) NOT NULL,
  `afinidade3` VARCHAR(30) NOT NULL,
  `afinidade4` VARCHAR(30) NOT NULL,
  `ano_gravacao` INT(11) NOT NULL,
  `velocidade` SMALLINT NOT NULL,
  `data` DATE NOT NULL,
  `ultima_execucao` DATETIME NOT NULL,
  `ultima_execucao_data` DATE NOT NULL,
  `tempo_total` TIME NOT NULL,
  `random` INT(11) NOT NULL,
  `qtde_player` INT(11) NOT NULL,
  `qtde` INT(11) NOT NULL,
  `data_vencimento` DATE NOT NULL,
  `frame_inicio` INT(11) NOT NULL,
  `frame_final` INT(11) NOT NULL,
  `msg` VARCHAR(40) NOT NULL,
  `sem_som` TINYINT(1) NOT NULL,
  `super_crossover` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_audiostore_musica_audiostore_categoria1_idx` (`categoria1` ASC),
  INDEX `fk_audiostore_musica_audiostore_categoria2_idx` (`categoria2` ASC),
  INDEX `fk_audiostore_musica_audiostore_categoria3_idx` (`categoria3` ASC),
  INDEX `fk_audiostore_musica_audiostoregravadora1_idx` (`gravadora` ASC),
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria1`
    FOREIGN KEY (`categoria1`)
    REFERENCES `instore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria2`
    FOREIGN KEY (`categoria2`)
    REFERENCES `instore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria3`
    FOREIGN KEY (`categoria3`)
    REFERENCES `instore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostoregravadora1`
    FOREIGN KEY (`gravadora`)
    REFERENCES `instore`.`audiostore_gravadora` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_comercial_sh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_comercial_sh` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `semana` VARCHAR(7) NULL,
  `horario` TIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `instore`.`audiostore_comercial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `instore`.`audiostore_comercial` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente` INT NOT NULL,
  `categoria` SMALLINT NOT NULL,
  `audiostore_comercial_sh` INT NOT NULL,
  `arquivo` VARCHAR(30) NOT NULL,
  `titulo` VARCHAR(30) NOT NULL,
  `tipo_interprete` SMALLINT NOT NULL,
  `periodo_inicial` DATE NOT NULL,
  `periodo_final` DATE NOT NULL,
  `tipo_horario` SMALLINT NOT NULL,
  `dias_semana` VARCHAR(7) NOT NULL,
  `dias_alternados` TINYINT(1) NOT NULL,
  `data` DATE NOT NULL,
  `ultima_execucao` DATETIME NOT NULL,
  `tempo_total` TIME NOT NULL,
  `random` INT(11) NOT NULL,
  `qtde_player` INT(11) NOT NULL,
  `qtde` INT(11) NOT NULL,
  `data_vencimento` DATE NOT NULL,
  `dependencia1` VARCHAR(30) NOT NULL,
  `dependencia2` VARCHAR(30) NOT NULL,
  `dependencia3` VARCHAR(30) NOT NULL,
  `frame_inicio` INT(11) NOT NULL,
  `frame_final` INT(11) NOT NULL,
  `msg` VARCHAR(40) NOT NULL,
  `sem_som` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_audiostore_comercial_cliente1_idx` (`cliente` ASC),
  INDEX `fk_audiostore_comercial_audiostore_categoria1_idx` (`categoria` ASC),
  INDEX `fk_audiostore_comercial_audiostore_comercial_sh1_idx` (`audiostore_comercial_sh` ASC),
  CONSTRAINT `fk_audiostore_comercial_cliente1`
    FOREIGN KEY (`cliente`)
    REFERENCES `instore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_comercial_audiostore_categoria1`
    FOREIGN KEY (`categoria`)
    REFERENCES `instore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_comercial_audiostore_comercial_sh1`
    FOREIGN KEY (`audiostore_comercial_sh`)
    REFERENCES `instore`.`audiostore_comercial_sh` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
