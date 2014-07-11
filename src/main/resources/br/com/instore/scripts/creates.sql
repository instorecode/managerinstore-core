SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema managerinstore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `managerinstore` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `managerinstore` ;

-- -----------------------------------------------------
-- Table `managerinstore`.`regiao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`regiao` (
  `idregiao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idregiao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `idregiao` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `sigla` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`idestado`),
  INDEX `fk_estado_regiao1_idx` (`idregiao` ASC),
  CONSTRAINT `fk_estado_regiao1`
    FOREIGN KEY (`idregiao`)
    REFERENCES `managerinstore`.`regiao` (`idregiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`cidade` (
  `idcidade` INT NOT NULL AUTO_INCREMENT,
  `idestado` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idcidade`),
  INDEX `fk_cidade_estado1_idx` (`idestado` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`idestado`)
    REFERENCES `managerinstore`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`bairro` (
  `idbairro` INT NOT NULL AUTO_INCREMENT,
  `idcidade` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_cidade1_idx` (`idcidade` ASC),
  CONSTRAINT `fk_bairro_cidade1`
    FOREIGN KEY (`idcidade`)
    REFERENCES `managerinstore`.`cidade` (`idcidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`cep`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`cep` (
  `idcep` INT NOT NULL AUTO_INCREMENT,
  `idbairro` INT NOT NULL,
  `numero` VARCHAR(10) NULL,
  PRIMARY KEY (`idcep`),
  INDEX `fk_cep_bairro1_idx` (`idbairro` ASC),
  CONSTRAINT `fk_cep_bairro1`
    FOREIGN KEY (`idbairro`)
    REFERENCES `managerinstore`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `idcep` INT NOT NULL,
  `numero` VARCHAR(255) NOT NULL,
  `complemento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_cep1_idx` (`idcep` ASC),
  CONSTRAINT `fk_endereco_cep1`
    FOREIGN KEY (`idcep`)
    REFERENCES `managerinstore`.`cep` (`idcep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`usuario` (
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
    REFERENCES `managerinstore`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`cliente` (
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
    REFERENCES `managerinstore`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`perfil` (
  `idperfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`funcionalidade` (
  `idfuncionalidade` INT NOT NULL AUTO_INCREMENT,
  `mapping_id` VARCHAR(255) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `icone` VARCHAR(30) NULL,
  `parente` INT(11) NOT NULL DEFAULT 0,
  `visivel` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idfuncionalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`perfil_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`perfil_usuario` (
  `idperfil_usuario` INT NOT NULL AUTO_INCREMENT,
  `idperfil` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idperfil_usuario`),
  INDEX `fk_perfil_usuario_perfil1_idx` (`idperfil` ASC),
  INDEX `fk_perfil_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_perfil_usuario_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `managerinstore`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`perfil_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`perfil_funcionalidade` (
  `idperfil_funcionalidade` INT NOT NULL AUTO_INCREMENT,
  `idfuncionalidade` INT NOT NULL,
  `idperfil` INT NOT NULL,
  PRIMARY KEY (`idperfil_funcionalidade`),
  INDEX `fk_perfil_funcionalidade_funcionalidade1_idx` (`idfuncionalidade` ASC),
  INDEX `fk_perfil_funcionalidade_perfil1_idx` (`idperfil` ASC),
  CONSTRAINT `fk_perfil_funcionalidade_funcionalidade1`
    FOREIGN KEY (`idfuncionalidade`)
    REFERENCES `managerinstore`.`funcionalidade` (`idfuncionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_funcionalidade_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `managerinstore`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`usuario_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`usuario_cliente` (
  `idusuario_empresa` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuario_empresa`),
  INDEX `fk_usuario_empresa_empresa1_idx` (`idcliente` ASC),
  INDEX `fk_usuario_empresa_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_usuario_empresa_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_empresa_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`dados_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`dados_cliente` (
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
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`dados_bancario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`dados_bancario` (
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
-- Table `managerinstore`.`boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`boleto` (
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
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boleto_dados_bancario1`
    FOREIGN KEY (`iddados_bancario`)
    REFERENCES `managerinstore`.`dados_bancario` (`iddados_bancario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_categoria` (
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
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_programacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_programacao` (
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
  `conteudo` VARCHAR(70) NOT NULL,
  `loopback` TINYINT(1) NOT NULL,
  INDEX `fk_audiostore_programacao_empresa1_idx` (`idcliente` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC),
  CONSTRAINT `fk_audiostore_programacao_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_programacao_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_programacao_categoria` (
  `idaudiostore_programacao_categoria` INT NOT NULL AUTO_INCREMENT,
  `codigo` SMALLINT NOT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`idaudiostore_programacao_categoria`),
  INDEX `fk_audiostore_programacao_categoria_audiostore_categoria1_idx` (`codigo` ASC),
  INDEX `fk_audiostore_programacao_categoria_audiostore_programacao1_idx` (`id` ASC),
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_categoria1`
    FOREIGN KEY (`codigo`)
    REFERENCES `managerinstore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_programacao1`
    FOREIGN KEY (`id`)
    REFERENCES `managerinstore`.`audiostore_programacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`config_app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`config_app` (
  `id` INT NOT NULL,
  `data_path` VARCHAR(255) NOT NULL,
  `audiostore_musica_dir_origem` VARCHAR(255) NOT NULL,
  `audiostore_musica_dir_destino` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`auditoria` (
  `idauditoria` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `acao` SMALLINT NOT NULL,
  `entidade` VARCHAR(255) NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`idauditoria`),
  INDEX `fk_auditoria_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_auditoria_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`auditoria_dados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`auditoria_dados` (
  `idauditoria_dados` INT NOT NULL AUTO_INCREMENT,
  `idauditoria` INT NOT NULL,
  `coluna` VARCHAR(45) NULL,
  `valor_atual` TEXT NULL,
  `valor_novo` TEXT NULL,
  PRIMARY KEY (`idauditoria_dados`),
  INDEX `fk_auditoria_colunas_auditoria1_idx` (`idauditoria` ASC),
  CONSTRAINT `fk_auditoria_colunas_auditoria1`
    FOREIGN KEY (`idauditoria`)
    REFERENCES `managerinstore`.`auditoria` (`idauditoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`historico_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`historico_usuario` (
  `idhistorico_usuario` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `login` DATETIME NULL,
  `logout` DATETIME NULL,
  PRIMARY KEY (`idhistorico_usuario`),
  INDEX `fk_historico_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_historico_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`voz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`voz` (
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
    REFERENCES `managerinstore`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`contato_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`contato_cliente` (
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
    REFERENCES `managerinstore`.`dados_cliente` (`iddados_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_gravadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_gravadora` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_musica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_musica` (
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
    REFERENCES `managerinstore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria2`
    FOREIGN KEY (`categoria2`)
    REFERENCES `managerinstore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria3`
    FOREIGN KEY (`categoria3`)
    REFERENCES `managerinstore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostoregravadora1`
    FOREIGN KEY (`gravadora`)
    REFERENCES `managerinstore`.`audiostore_gravadora` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_comercial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_comercial` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria` SMALLINT NOT NULL,
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
  INDEX `fk_audiostore_comercial_audiostore_categoria1_idx` (`categoria` ASC),
  CONSTRAINT `fk_audiostore_comercial_audiostore_categoria1`
    FOREIGN KEY (`categoria`)
    REFERENCES `managerinstore`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`audiostore_comercial_sh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`audiostore_comercial_sh` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comercial` INT NOT NULL,
  `semana` VARCHAR(7) NOT NULL,
  `horario` TIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_audiostore_comercial_sh_audiostore_comercial1_idx` (`comercial` ASC),
  CONSTRAINT `fk_audiostore_comercial_sh_audiostore_comercial1`
    FOREIGN KEY (`comercial`)
    REFERENCES `managerinstore`.`audiostore_comercial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`lancamento_cnpj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`lancamento_cnpj` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(18) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`lancamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`lancamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lancamento_cnpj` INT NOT NULL,
  `usuario` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `debito` TINYINT(1) NOT NULL DEFAULT 0,
  `credito` TINYINT(1) NOT NULL DEFAULT 0,
  `mes` DATE NOT NULL,
  `data_fechamento` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lancamento_lancamento_cnpj1_idx` (`lancamento_cnpj` ASC),
  INDEX `fk_lancamento_usuario1_idx` (`usuario` ASC),
  CONSTRAINT `fk_lancamento_lancamento_cnpj1`
    FOREIGN KEY (`lancamento_cnpj`)
    REFERENCES `managerinstore`.`lancamento_cnpj` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamento_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `managerinstore`.`lancamento_finalizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `managerinstore`.`lancamento_finalizado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lancamento` INT NOT NULL,
  `usuario` INT NOT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lancamento_finalizado_lancamento1_idx` (`lancamento` ASC),
  INDEX `fk_lancamento_finalizado_usuario1_idx` (`usuario` ASC),
  CONSTRAINT `fk_lancamento_finalizado_lancamento1`
    FOREIGN KEY (`lancamento`)
    REFERENCES `managerinstore`.`lancamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamento_finalizado_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `managerinstore`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
