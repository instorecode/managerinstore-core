SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema intranet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `intranet` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `intranet` ;

-- -----------------------------------------------------
-- Table `intranet`.`regiao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`regiao` (
  `idregiao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`idregiao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `idregiao` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `sigla` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`idestado`),
  INDEX `fk_estado_regiao1_idx` (`idregiao` ASC),
  CONSTRAINT `fk_estado_regiao1`
    FOREIGN KEY (`idregiao`)
    REFERENCES `intranet`.`regiao` (`idregiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`cidade` (
  `idcidade` INT NOT NULL AUTO_INCREMENT,
  `idestado` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idcidade`),
  INDEX `fk_cidade_estado1_idx` (`idestado` ASC),
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`idestado`)
    REFERENCES `intranet`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`bairro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`bairro` (
  `idbairro` INT NOT NULL AUTO_INCREMENT,
  `idcidade` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idbairro`),
  INDEX `fk_bairro_cidade1_idx` (`idcidade` ASC),
  CONSTRAINT `fk_bairro_cidade1`
    FOREIGN KEY (`idcidade`)
    REFERENCES `intranet`.`cidade` (`idcidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`cep`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`cep` (
  `idcep` INT NOT NULL AUTO_INCREMENT,
  `idbairro` INT NOT NULL,
  `numero` VARCHAR(10) NULL,
  PRIMARY KEY (`idcep`),
  INDEX `fk_cep_bairro1_idx` (`idbairro` ASC),
  CONSTRAINT `fk_cep_bairro1`
    FOREIGN KEY (`idbairro`)
    REFERENCES `intranet`.`bairro` (`idbairro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`endereco` (
  `idendereco` INT NOT NULL AUTO_INCREMENT,
  `idcep` INT NOT NULL,
  `numero` VARCHAR(255) NOT NULL,
  `complemento` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idendereco`),
  INDEX `fk_endereco_cep1_idx` (`idcep` ASC),
  CONSTRAINT `fk_endereco_cep1`
    FOREIGN KEY (`idcep`)
    REFERENCES `intranet`.`cep` (`idcep`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`usuario` (
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
    REFERENCES `intranet`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`cliente` (
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
    REFERENCES `intranet`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`perfil` (
  `idperfil` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL,
  PRIMARY KEY (`idperfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`funcionalidade` (
  `idfuncionalidade` INT NOT NULL AUTO_INCREMENT,
  `mapping_id` VARCHAR(255) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `icone` VARCHAR(30) NULL,
  `parente` INT(11) NOT NULL DEFAULT 0,
  `visivel` TINYINT(1) NOT NULL,
  PRIMARY KEY (`idfuncionalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`perfil_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`perfil_usuario` (
  `idperfil_usuario` INT NOT NULL AUTO_INCREMENT,
  `idperfil` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idperfil_usuario`),
  INDEX `fk_perfil_usuario_perfil1_idx` (`idperfil` ASC),
  INDEX `fk_perfil_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_perfil_usuario_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `intranet`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`perfil_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`perfil_funcionalidade` (
  `idperfil_funcionalidade` INT NOT NULL AUTO_INCREMENT,
  `idfuncionalidade` INT NOT NULL,
  `idperfil` INT NOT NULL,
  PRIMARY KEY (`idperfil_funcionalidade`),
  INDEX `fk_perfil_funcionalidade_funcionalidade1_idx` (`idfuncionalidade` ASC),
  INDEX `fk_perfil_funcionalidade_perfil1_idx` (`idperfil` ASC),
  CONSTRAINT `fk_perfil_funcionalidade_funcionalidade1`
    FOREIGN KEY (`idfuncionalidade`)
    REFERENCES `intranet`.`funcionalidade` (`idfuncionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_perfil_funcionalidade_perfil1`
    FOREIGN KEY (`idperfil`)
    REFERENCES `intranet`.`perfil` (`idperfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`usuario_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`usuario_cliente` (
  `idusuario_empresa` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idusuario` INT NOT NULL,
  PRIMARY KEY (`idusuario_empresa`),
  INDEX `fk_usuario_empresa_empresa1_idx` (`idcliente` ASC),
  INDEX `fk_usuario_empresa_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_usuario_empresa_empresa1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_empresa_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`dados_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`dados_cliente` (
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
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`dados_bancario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`dados_bancario` (
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
-- Table `intranet`.`boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`boleto` (
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
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_boleto_dados_bancario1`
    FOREIGN KEY (`iddados_bancario`)
    REFERENCES `intranet`.`dados_bancario` (`iddados_bancario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_categoria` (
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
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_programacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_programacao` (
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
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_programacao_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_programacao_categoria` (
  `idaudiostore_programacao_categoria` INT NOT NULL AUTO_INCREMENT,
  `codigo` SMALLINT NOT NULL,
  `id` INT(11) NOT NULL,
  PRIMARY KEY (`idaudiostore_programacao_categoria`),
  INDEX `fk_audiostore_programacao_categoria_audiostore_categoria1_idx` (`codigo` ASC),
  INDEX `fk_audiostore_programacao_categoria_audiostore_programacao1_idx` (`id` ASC),
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_categoria1`
    FOREIGN KEY (`codigo`)
    REFERENCES `intranet`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_programacao_categoria_audiostore_programacao1`
    FOREIGN KEY (`id`)
    REFERENCES `intranet`.`audiostore_programacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`config_app`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`config_app` (
  `id` INT NOT NULL,
  `data_path` VARCHAR(255) NOT NULL,
  `audiostore_musica_dir_origem` VARCHAR(255) NOT NULL,
  `audiostore_musica_dir_destino` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`auditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`auditoria` (
  `idauditoria` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `acao` SMALLINT NOT NULL,
  `entidade` VARCHAR(255) NOT NULL,
  `data` DATETIME NOT NULL,
  PRIMARY KEY (`idauditoria`),
  INDEX `fk_auditoria_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_auditoria_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`auditoria_dados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`auditoria_dados` (
  `idauditoria_dados` INT NOT NULL AUTO_INCREMENT,
  `idauditoria` INT NOT NULL,
  `coluna` VARCHAR(45) NULL,
  `valor_atual` TEXT NULL,
  `valor_novo` TEXT NULL,
  PRIMARY KEY (`idauditoria_dados`),
  INDEX `fk_auditoria_colunas_auditoria1_idx` (`idauditoria` ASC),
  CONSTRAINT `fk_auditoria_colunas_auditoria1`
    FOREIGN KEY (`idauditoria`)
    REFERENCES `intranet`.`auditoria` (`idauditoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`historico_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`historico_usuario` (
  `idhistorico_usuario` INT NOT NULL AUTO_INCREMENT,
  `idusuario` INT NOT NULL,
  `login` DATETIME NULL,
  `logout` DATETIME NULL,
  PRIMARY KEY (`idhistorico_usuario`),
  INDEX `fk_historico_usuario_usuario1_idx` (`idusuario` ASC),
  CONSTRAINT `fk_historico_usuario_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`voz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`voz` (
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
    REFERENCES `intranet`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`contato_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`contato_cliente` (
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
    REFERENCES `intranet`.`dados_cliente` (`iddados_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_gravadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_gravadora` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_musica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_musica` (
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
    REFERENCES `intranet`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria2`
    FOREIGN KEY (`categoria2`)
    REFERENCES `intranet`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostore_categoria3`
    FOREIGN KEY (`categoria3`)
    REFERENCES `intranet`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_audiostore_musica_audiostoregravadora1`
    FOREIGN KEY (`gravadora`)
    REFERENCES `intranet`.`audiostore_gravadora` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_comercial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_comercial` (
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
    REFERENCES `intranet`.`audiostore_categoria` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`audiostore_comercial_sh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`audiostore_comercial_sh` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comercial` INT NOT NULL,
  `semana` VARCHAR(7) NOT NULL,
  `horario` TIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_audiostore_comercial_sh_audiostore_comercial1_idx` (`comercial` ASC),
  CONSTRAINT `fk_audiostore_comercial_sh_audiostore_comercial1`
    FOREIGN KEY (`comercial`)
    REFERENCES `intranet`.`audiostore_comercial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`lancamento_cnpj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`lancamento_cnpj` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(18) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `saldo_disponivel` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`lancamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`lancamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lancamento_cnpj` INT NOT NULL,
  `usuario` INT NOT NULL,
  `descricao` TEXT NOT NULL,
  `valor` DECIMAL(10,2) NOT NULL,
  `debito` TINYINT(1) NOT NULL DEFAULT 0,
  `credito` TINYINT(1) NOT NULL DEFAULT 0,
  `mes` DATE NOT NULL,
  `data_fechamento` DATE NULL,
  `positivo` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lancamento_lancamento_cnpj1_idx` (`lancamento_cnpj` ASC),
  INDEX `fk_lancamento_usuario1_idx` (`usuario` ASC),
  CONSTRAINT `fk_lancamento_lancamento_cnpj1`
    FOREIGN KEY (`lancamento_cnpj`)
    REFERENCES `intranet`.`lancamento_cnpj` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamento_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `intranet`.`lancamento_finalizado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `intranet`.`lancamento_finalizado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lancamento` INT NOT NULL,
  `usuario` INT NOT NULL,
  `data` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lancamento_finalizado_lancamento1_idx` (`lancamento` ASC),
  INDEX `fk_lancamento_finalizado_usuario1_idx` (`usuario` ASC),
  CONSTRAINT `fk_lancamento_finalizado_lancamento1`
    FOREIGN KEY (`lancamento`)
    REFERENCES `intranet`.`lancamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lancamento_finalizado_usuario1`
    FOREIGN KEY (`usuario`)
    REFERENCES `intranet`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


    -- SET SESSION wait_timeout = 2;
    -- SHOW VARIABLES LIKE 'wait_timeout';

    -- SET GLOBAL connect_timeout=60;
    -- SHOW VARIABLES LIKE 'connect_timeout';

    -- SHOW GLOBAL STATUS like 'Threads_connected';
    -- show processlist;

    use managerinstore;

    -- empresa origem (INSTORE)
    INSERT INTO config_app VALUES (1, '/', '/', '/');
    INSERT INTO cliente  VALUES (1, null , 0 , 'Instore', 1 , 1 , 1);

    --  usuario padrão
    INSERT INTO usuario VALUES (1, null , now(), 'admin', '000.000.000-00', 'admin@instore.com.br', md5(123));

    -- regioes
    insert into regiao values(1, 'Região Norte');
    insert into regiao values(2, 'Região Nordeste');
    insert into regiao values(3, 'Região Centro-Oeste');
    insert into regiao values(4, 'Região Sudeste');
    insert into regiao values(5, 'Região Sul');

    -- estado
    INSERT INTO estado VALUES (null, 1,'Acre', 'AC');
    INSERT INTO estado VALUES (null, 2,'Alagoas' , 'AL');
    INSERT INTO estado VALUES (null, 1,'Amapá' , 'AP');
    INSERT INTO estado VALUES (null, 1,'Amazonas' , 'AM');
    INSERT INTO estado VALUES (null, 2,'Bahia' , 'BA' );
    INSERT INTO estado VALUES (null, 2,'Ceará','CE');
    INSERT INTO estado VALUES (null, 3,'Distrito Federal','DF');
    INSERT INTO estado VALUES (null, 4,'Espírito Santo','ES');
    INSERT INTO estado VALUES (null, 3,'Goiás','GO');
    INSERT INTO estado VALUES (null, 2,'Maranhão','MA');
    INSERT INTO estado VALUES (null, 3,'Mato Grosso','MT');
    INSERT INTO estado VALUES (null, 3,'Mato Grosso do Sul','MS');
    INSERT INTO estado VALUES (null, 4,'Minas Gerais','MG');
    INSERT INTO estado VALUES (null, 1,'Pará','PA');
    INSERT INTO estado VALUES (null, 2,'Paraíba','PB');
    INSERT INTO estado VALUES (null, 5,'Paraná','PR');
    INSERT INTO estado VALUES (null, 2,'Pernambuco','PE');
    INSERT INTO estado VALUES (null, 2,'Piauí','PI');
    INSERT INTO estado VALUES (null, 4,'Rio de Janeiro','RJ');
    INSERT INTO estado VALUES (null, 2,'Rio Grande do Norte','RN');
    INSERT INTO estado VALUES (null, 5,'Rio Grande do Sul','RS');
    INSERT INTO estado VALUES (null, 1,'Rondônia','RO');
    INSERT INTO estado VALUES (null, 1,'Roraima','RR');
    INSERT INTO estado VALUES (null, 5,'Santa Catarina','SC');
    INSERT INTO estado VALUES (null, 4,'São Paulo','SP');
    INSERT INTO estado VALUES (null, 2,'Sergipe','SE');
    INSERT INTO estado VALUES (null, 1,'Tocantins','TO'); 

    -- FUNCIONALIDADES
    delete from perfil_funcionalidade where idperfil > 0;
    delete from perfil_usuario where idperfil > 0;
    delete from funcionalidade where idfuncionalidade > 0;
    delete from perfil where idperfil > 0;

    insert into perfil values(1, 'perfil interno');
    insert into perfil values(2, 'Administrador');

    INSERT INTO funcionalidade VALUES (1, '/clientes', 'Cliente' , 'fa-building' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (2, '/cliente/cadastrar', 'Formulário de cadastro cliente' , 'fa-building'    , 1 , 1 ); 
    INSERT INTO funcionalidade VALUES (3, '/cliente/atualizar/{id}', 'Formulário de atualização do cliente' , 'fa-building' , 1 , 0 ); 
    INSERT INTO funcionalidade VALUES (4, '/cliente/remover/{id}', 'Formulário de remoção do cliente' , 'fa-building'   , 1 , 0 ); 

    INSERT INTO funcionalidade VALUES (5, '/contatos/{id}', 'Contato do cliente' , 'fa-users' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (6, '/contato/cadastrar/{id}', 'Formulário de cadastro contato' , 'fa-users'    , 5 , 1 ); 
    INSERT INTO funcionalidade VALUES (7, '/contato/atualizar/{id}', 'Formulário de atualização do contato' , 'fa-users' , 5 , 0 ); 
    INSERT INTO funcionalidade VALUES (8, '/contato/remover/{id}', 'Formulário de remoção do contato' , 'fa-users'   , 5 , 0 ); 

    INSERT INTO funcionalidade VALUES (9, '/audiostore-categorias', 'Categoria' , 'fa-file-code-o' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (10, '/audiostore-categoria/cadastrar', 'Formulário de cadastro audiostore categoria' , 'fa-file-code-o'    , 9 , 1 ); 
    INSERT INTO funcionalidade VALUES (11, '/audiostore-categoria/atualizar/{id}', 'Formulário de atualização do audiostore categoria' , 'fa-file-code-o' , 9 , 0 ); 
    INSERT INTO funcionalidade VALUES (12, '/audiostore-categoria/remover/{id}', 'Formulário de remoção do audiostore categoria' , 'fa-file-code-o'   , 9 , 0 ); 
    INSERT INTO funcionalidade VALUES (13, '/audiostore-categoria/download-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 9 , 0 ); 
    INSERT INTO funcionalidade VALUES (14, '/audiostore-categoria/upload-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 9 , 0 ); 

    INSERT INTO funcionalidade VALUES (15, '/audiostore-programacao', 'Programação' , 'fa-file-archive-o' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (16, '/audiostore-programacao/cadastrar', 'Formulário de cadastro audiostore programação' , 'fa-file-archive-o'    , 15 , 1 ); 
    INSERT INTO funcionalidade VALUES (17, '/audiostore-programacao/atualizar/{id}', 'Formulário de atualização do audiostore programação' , 'fa-file-archive-o' , 15 , 0 ); 
    INSERT INTO funcionalidade VALUES (18, '/audiostore-programacao/remover/{id}', 'Formulário de remoção do audiostore programação' , 'fa-file-archive-o'   , 15 , 0 ); 
    INSERT INTO funcionalidade VALUES (19, '/audiostore-programacao/download-exp/{id}', 'Download do arquivo exp' , 'fa-file-archive-o'   , 15 , 0 ); 
    INSERT INTO funcionalidade VALUES (20, '/audiostore-programacao/upload-exp/{id}', 'Download do arquivo exp' , 'fa-file-archive-o'   , 15 , 0 ); 

    INSERT INTO funcionalidade VALUES (21, '/voz', 'Voz' , 'fa-bullhorn' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (22, '/voz/cadastrar', 'Formulário de cadastro voz' , 'fa-bullhorn'    , 21 , 1 ); 
    INSERT INTO funcionalidade VALUES (23, '/voz/atualizar/{id}', 'Formulário de atualização da voz' , 'fa-bullhorn' , 21 , 0 ); 
    INSERT INTO funcionalidade VALUES (24, '/voz/remover/{id}', 'Formulário de remoção da voz' , 'fa-bullhorn'   , 21 , 0 ); 

    INSERT INTO funcionalidade VALUES (25, '/audiostore-gravadora', 'Gravadora' , 'fa-youtube-play' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (26, '/audiostore-gravadora/cadastrar', 'Formulário de cadastro gravadora' , 'fa-youtube-play'    , 25 , 1 ); 
    INSERT INTO funcionalidade VALUES (27, '/audiostore-gravadora/atualizar/{id}', 'Formulário de atualização da gravadora' , 'fa-youtube-play' , 25 , 0 ); 
    INSERT INTO funcionalidade VALUES (28, '/audiostore-gravadora/remover/{id}', 'Formulário de remoção da gravadora' , 'fa-youtube-play'   , 25 , 0 ); 
    INSERT INTO funcionalidade VALUES (29, '/audiostore-gravadora/download-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 25 , 0 ); 
    INSERT INTO funcionalidade VALUES (30, '/audiostore-gravadora/upload-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 25 , 0 ); 

    INSERT INTO funcionalidade VALUES (31, '/audiostore-musica', 'Música' , 'fa-volume-up' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (32, '/audiostore-musica/cadastrar', 'Formulário de cadastro música' , 'fa-volume-up'    , 31 , 1 ); 
    INSERT INTO funcionalidade VALUES (33, '/audiostore-musica/atualizar/{id}', 'Formulário de atualização da música' , 'fa-volume-up' , 31 , 0 ); 
    INSERT INTO funcionalidade VALUES (34, '/audiostore-musica/remover/{id}', 'Formulário de remoção da música' , 'fa-volume-up'   , 31 , 0 ); 
    INSERT INTO funcionalidade VALUES (35, '/audiostore-musica/download-exp/{id}', 'Download do arquivo exp' , 'fa-volume-up'   , 31 , 0 ); 
    INSERT INTO funcionalidade VALUES (36, '/audiostore-musica/upload-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 31 , 0 ); 

    INSERT INTO funcionalidade VALUES (37, '/configuracao-interna', 'Configurações' , 'fa-cog' , 0 , 1 ); 

    INSERT INTO funcionalidade VALUES (38, '/audiostore-comercial', 'Comercial' , 'fa-tag' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (39, '/audiostore-comercial/cadastrar', 'Formulário de cadastro comercial' , 'fa-tag'    , 38 , 1 ); 
    INSERT INTO funcionalidade VALUES (40, '/audiostore-comercial/atualizar/{id}', 'Formulário de atualização do comercial' , 'fa-tag' , 38 , 0 ); 
    INSERT INTO funcionalidade VALUES (41, '/audiostore-comercial/remover/{id}', 'Formulário de remoção do comercial' , 'fa-tag'   , 38 , 0 ); 
    INSERT INTO funcionalidade VALUES (42, '/audiostore-comercial/download-exp/{id}', 'Download do arquivo exp' , 'fa-tag'   , 38 , 0 ); 
    INSERT INTO funcionalidade VALUES (43, '/audiostore-comercial/upload-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 38 , 0 ); 

    INSERT INTO funcionalidade VALUES (44, '/perfil', 'Perfil' , 'fa-sitemap' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (45, '/perfil/cadastrar', 'Formulário de cadastro perfil' , 'fa-sitemap'    , 44 , 1 ); 
    INSERT INTO funcionalidade VALUES (46, '/perfil/atualizar/{id}', 'Formulário de atualização do perfil' , 'fa-sitemap' , 4 , 0 ); 
    INSERT INTO funcionalidade VALUES (47, '/perfil/remover/{id}', 'Formulário de remoção do perfil' , 'fa-sitemap'   , 44 , 0 ); 

    INSERT INTO funcionalidade VALUES (48, '/usuario', 'Usuário' , 'fa-user' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (49, '/usuario/cadastrar', 'Formulário de cadastro usuario' , 'fa-user'    , 48 , 1 ); 
    INSERT INTO funcionalidade VALUES (50, '/usuario/atualizar/{id}', 'Formulário de atualização do usuario' , 'fa-user' , 48 , 0 ); 
    INSERT INTO funcionalidade VALUES (51, '/usuario/remover/{id}', 'Formulário de remoção do usuario' , 'fa-user'   , 48 , 0 ); 

    INSERT INTO funcionalidade VALUES (52, '/lancamento-entidade', 'Entidade Financeira' , 'fa-building' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (53, '/lancamento-entidade/cadastrar', 'Formulário de cadastro entidade' , 'fa-building'    , 52 , 1 ); 
    INSERT INTO funcionalidade VALUES (54, '/lancamento-entidade/atualizar/{id}', 'Formulário de atualização do entidade' , 'fa-building' , 52 , 0 ); 
    INSERT INTO funcionalidade VALUES (55, '/lancamento-entidade/remover/{id}', 'Formulário de remoção do entidade' , 'fa-building'   , 52 , 0 ); 
    INSERT INTO funcionalidade VALUES (56, '/lancamento-entidade/relatorio', 'Relatorios de lançamentos' , 'fa-building'   , 52 , 0 ); 

    INSERT INTO funcionalidade VALUES (57, '/lancamento', 'Lançamentos' , 'fa-usd' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (58, '/lancamento/cadastrar', 'Formulário de cadastro lançamento' , 'fa-usd'    , 57 , 1 ); 
    INSERT INTO funcionalidade VALUES (59, '/lancamento/atualizar/{id}', 'Formulário de atualização do lançamento' , 'fa-usd' , 57 , 0 ); 
    INSERT INTO funcionalidade VALUES (60, '/lancamento/remover/{id}', 'Formulário de remoção do lançamento' , 'fa-usd'   , 57 , 0 ); 

    INSERT INTO funcionalidade VALUES (61, '/filial/{id}', 'Filial' , 'fa-cubes' , 0 , 0 ); 
    INSERT INTO funcionalidade VALUES (62, '/filial/cadastrar/{id}', 'Formulário de cadastro filial' , 'fa-cubes'    , 61 , 0 ); 
    INSERT INTO funcionalidade VALUES (63, '/filial/atualizar/{id}', 'Formulário de atualização da filial' , 'fa-cubes' , 61 , 0 ); 
    INSERT INTO funcionalidade VALUES (64, '/filial/remover/{id}', 'Formulário de remoção da filial' , 'fa-cubes'   , 61 , 0 ); 

    insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade;
    insert into perfil_usuario select null, idperfil , idusuario from perfil , usuario;

    -- DELTETE
    delete from contato_cliente where contato_cliente.idcontato_cliente > 0;
    delete from dados_cliente where dados_cliente.iddados_cliente > 0;
    delete from cliente where cliente.idcliente >  1;
    delete from endereco where endereco.idendereco > 100;
    delete from cep where cep.idcep > 100;
    delete from bairro where bairro.idbairro > 100;
    delete from cidade where cidade.idcidade > 100;



    -- INSERTS
    INSERT INTO cidade VALUES(200, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(200 , 200, 'Rio de Janeiro' , 'Avenida Marechal Floriano, 55');
    INSERT INTO cep VALUES(200 , 200 , '20.080-003');
    INSERT INTO endereco VALUES(200 , 200 , 'sn' , 'Avenida Marechal Floriano, 55');
    INSERT INTO cliente VALUES(200 , 200 , 1 , 'A Impecável - A Impecável Roupas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(200 , 200 , '33.044.983/0001-17' , 'A Impecável Roupas Ltda.' , 'A Impecável - A Impecável Roupas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(200 , 200 , '' , 0 , 'nfiscal@impecavel.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(201, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(201 , 201, 'São Paulo' , 'Estrada do Campo Limpo, 4263');
    INSERT INTO cep VALUES(201 , 201 , '05.787-000');
    INSERT INTO endereco VALUES(201 , 201 , 'sn' , 'Estrada do Campo Limpo, 4263');
    INSERT INTO cliente VALUES(201 , 201 , 1 , 'Águia Shoes Campo Limpo - Lj 1 - Aguia Shoes Calc e Confec Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(201 , 201 , '04.909.028/0001-05' , 'Aguia Shoes Calc e Confec Ltda' , 'Águia Shoes Campo Limpo - Lj 1 - Aguia Shoes Calc e Confec Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(201 , 201 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(202, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(202 , 202, 'São Paulo' , 'Estrada do Campo Limpo, 3908-3');
    INSERT INTO cep VALUES(202 , 202 , '05.787-000');
    INSERT INTO endereco VALUES(202 , 202 , 'sn' , 'Estrada do Campo Limpo, 3908-3');
    INSERT INTO cliente VALUES(202 , 202 , 1 , 'Águia Shoes Campo Limpo - Lj 2 - Serena Kay Calç e Confec Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(202 , 202 , '07.154.011/0001-75' , 'Serena Kay Calç e Confec Ltda.' , 'Águia Shoes Campo Limpo - Lj 2 - Serena Kay Calç e Confec Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(202 , 202 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(203, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(203 , 203, 'São Paulo' , 'Estrada do M Boi Mirim, 4542');
    INSERT INTO cep VALUES(203 , 203 , '04.948-030');
    INSERT INTO endereco VALUES(203 , 203 , 'sn' , 'Estrada do M Boi Mirim, 4542');
    INSERT INTO cliente VALUES(203 , 203 , 1 , 'Águia Shoes Jd Angela - Lj 3 - H.M. Calç e Confec. Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(203 , 203 , '07.792.988/0001-18' , 'H.M. Calç e Confec. Ltda' , 'Águia Shoes Jd Angela - Lj 3 - H.M. Calç e Confec. Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(203 , 203 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(204, 25 , 'Mauá');
    INSERT INTO bairro VALUES(204 , 204, 'Mauá' , 'Avenida Barão de Mauá, 125');
    INSERT INTO cep VALUES(204 , 204 , '09.310-000');
    INSERT INTO endereco VALUES(204 , 204 , 'sn' , 'Avenida Barão de Mauá, 125');
    INSERT INTO cliente VALUES(204 , 204 , 1 , 'Águia Shoes Mauá - Lj 8 - Bersha Calç. e Confec. Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(204 , 204 , '08.397.974/0002-43' , 'Bersha Calç. e Confec. Ltda' , 'Águia Shoes Mauá - Lj 8 - Bersha Calç. e Confec. Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(204 , 204 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(205, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(205 , 205, 'São Paulo' , 'Estrada do M Boi Mirim, 1049');
    INSERT INTO cep VALUES(205 , 205 , '04.905-021');
    INSERT INTO endereco VALUES(205 , 205 , 'sn' , 'Estrada do M Boi Mirim, 1049');
    INSERT INTO cliente VALUES(205 , 205 , 1 , 'Águia Shoes Piraporinha - Lj 4 - Bersha Calç. e Confec. Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(205 , 205 , '08.397.974/0001-62' , 'Bersha Calç. e Confec. Ltda' , 'Águia Shoes Piraporinha - Lj 4 - Bersha Calç. e Confec. Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(205 , 205 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(206, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(206 , 206, 'São Paulo' , 'Estrada do M Boi Mirim, 1145');
    INSERT INTO cep VALUES(206 , 206 , '04.905-021');
    INSERT INTO endereco VALUES(206 , 206 , 'sn' , 'Estrada do M Boi Mirim, 1145');
    INSERT INTO cliente VALUES(206 , 206 , 1 , 'Águia Shoes Piraporinha - Lj 6 - Roseli B. Sena Calçados e Confecções' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(206 , 206 , '09.588.433/0001-84' , 'Roseli B. Sena Calçados e Confecções' , 'Águia Shoes Piraporinha - Lj 6 - Roseli B. Sena Calçados e Confecções' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(206 , 206 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(207, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(207 , 207, 'São Paulo' , 'Avenida Inácio Dias da Silva, 226');
    INSERT INTO cep VALUES(207 , 207 , '04.913-180');
    INSERT INTO endereco VALUES(207 , 207 , 'sn' , 'Avenida Inácio Dias da Silva, 226');
    INSERT INTO cliente VALUES(207 , 207 , 1 , 'Águia Shoes Piraporinha - Lj 7 - Roseli B. Sena Calçados e Confecções' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(207 , 207 , '09.588.433/0002-65' , 'Roseli B. Sena Calçados e Confecções' , 'Águia Shoes Piraporinha - Lj 7 - Roseli B. Sena Calçados e Confecções' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(207 , 207 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(208, 25 , 'São José dos Campos');
    INSERT INTO bairro VALUES(208 , 208, 'São José dos Campos' , 'Rua Sete de Setembro, 313');
    INSERT INTO cep VALUES(208 , 208 , '12.210-260');
    INSERT INTO endereco VALUES(208 , 208 , 'sn' , 'Rua Sete de Setembro, 313');
    INSERT INTO cliente VALUES(208 , 208 , 1 , 'Águia Shoes S.J. dos Campos - Lj 11 - Lilian M.R. Pereira Calçados EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(208 , 208 , '14.725.072/0001-00' , 'Lilian M.R. Pereira Calçados EPP' , 'Águia Shoes S.J. dos Campos - Lj 11 - Lilian M.R. Pereira Calçados EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(208 , 208 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(209, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(209 , 209, 'São Paulo' , 'Avenida Mateo Bei, 3181');
    INSERT INTO cep VALUES(209 , 209 , '03.949-013');
    INSERT INTO endereco VALUES(209 , 209 , 'sn' , 'Avenida Mateo Bei, 3181');
    INSERT INTO cliente VALUES(209 , 209 , 1 , 'Águia Shoes São Mateus - Lj 10 - 3A Calçados e Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(209 , 209 , '97.544.825/0001-09' , '3A Calçados e Confecções Ltda.' , 'Águia Shoes São Mateus - Lj 10 - 3A Calçados e Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(209 , 209 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(210, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(210 , 210, 'São Paulo' , 'Avenida Mateo Bei, 3443');
    INSERT INTO cep VALUES(210 , 210 , '03.949-013');
    INSERT INTO endereco VALUES(210 , 210 , 'sn' , 'Avenida Mateo Bei, 3443');
    INSERT INTO cliente VALUES(210 , 210 , 1 , 'Águia Shoes São Mateus - Lj 5 - Monique Calçados e Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(210 , 210 , '09.528.527/0001-68' , 'Monique Calçados e Confecções Ltda.' , 'Águia Shoes São Mateus - Lj 5 - Monique Calçados e Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(210 , 210 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '5833-1658 / 5833-2204' , 'indefinido');
    INSERT INTO cidade VALUES(211, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(211 , 211, 'Rio de Janeiro' , 'Est. Do Pontal, 843 - Casa 845 e 847');
    INSERT INTO cep VALUES(211 , 211 , '');
    INSERT INTO endereco VALUES(211 , 211 , 'sn' , 'Est. Do Pontal, 843 - Casa 845 e 847');
    INSERT INTO cliente VALUES(211 , 211 , 1 , 'Amoedo - Bottino Materiais de Construção Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(211 , 211 , '05.879.152/0007-15' , 'Bottino Materiais de Construção Ltda.' , 'Amoedo - Bottino Materiais de Construção Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(211 , 211 , 'Joice Ibrahim e Renato Guedes' , 0 , 'joiceb@amoedo.com.br,renato.guedes@amoedo.com.br' , '(21) 2199-1249' , 'indefinido');
    INSERT INTO cidade VALUES(212, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(212 , 212, 'São Paulo' , 'Avenida Paulista, 1754, 1754');
    INSERT INTO cep VALUES(212 , 212 , '01.310-920');
    INSERT INTO endereco VALUES(212 , 212 , 'sn' , 'Avenida Paulista, 1754, 1754');
    INSERT INTO cliente VALUES(212 , 212 , 1 , 'Artex - American Sportswear Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(212 , 212 , '03.494.776/0012-56' , 'American Sportswear Ltda' , 'Artex - American Sportswear Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(212 , 212 , 'Luis Henrique' , 0 , 'guilherme.verissimo@ammovarejo.com.br, luis.amstalden@ammovarejo.com.br' , '(19) 2102-2243' , 'indefinido');
    INSERT INTO cidade VALUES(213, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(213 , 213, 'São Paulo' , 'Avenida Angélica, 2163 - 8 andar');
    INSERT INTO cep VALUES(213 , 213 , '01.227-200');
    INSERT INTO endereco VALUES(213 , 213 , 'sn' , 'Avenida Angélica, 2163 - 8 andar');
    INSERT INTO cliente VALUES(213 , 213 , 1 , 'Authentic Feet - Associação AFeet Franquias' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(213 , 213 , '09.652.046/0001-60' , 'Associação AFeet Franquias' , 'Authentic Feet - Associação AFeet Franquias' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(213 , 213 , 'Flavio' , 0 , 'flavio.monaco@grupoafeet.com.br' , '(11) 3150-4452 / 99651-3969' , 'indefinido');
    INSERT INTO cidade VALUES(214, 21 , 'Pelotas');
    INSERT INTO bairro VALUES(214 , 214, 'Pelotas' , 'Rua Quinze de Novembro, 667 - Loja 19');
    INSERT INTO cep VALUES(214 , 214 , '96.015-000');
    INSERT INTO endereco VALUES(214 , 214 , 'sn' , 'Rua Quinze de Novembro, 667 - Loja 19');
    INSERT INTO cliente VALUES(214 , 214 , 1 , 'Authentical Acessórios - APB Comércio de Semi joias Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(214 , 214 , '09.442.990/0001-92' , 'APB Comércio de Semi joias Ltda.' , 'Authentical Acessórios - APB Comércio de Semi joias Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(214 , 214 , 'Bruna' , 0 , 'bruna@authentical.com.br' , '(53) 3307-0945' , 'indefinido');
    INSERT INTO cidade VALUES(215, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(215 , 215, 'São Paulo' , 'Rua Marechal Hastinfilo de Moura, 417');
    INSERT INTO cep VALUES(215 , 215 , '05.641-000');
    INSERT INTO endereco VALUES(215 , 215 , 'sn' , 'Rua Marechal Hastinfilo de Moura, 417');
    INSERT INTO cliente VALUES(215 , 215 , 1 , 'Bananeira Restaurante - Bananeira Restaurante e Serviços de Buffet Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(215 , 215 , '08.359.116/0001-23' , 'Bananeira Restaurante e Serviços de Buffet Ltda' , 'Bananeira Restaurante - Bananeira Restaurante e Serviços de Buffet Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(215 , 215 , '' , 0 , 'mauricio@bananeiramorumbi.com.br' , '(11) 3542-4630' , 'indefinido');
    INSERT INTO cidade VALUES(216, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(216 , 216, 'São Paulo' , 'Rua Itapura, 829');
    INSERT INTO cep VALUES(216 , 216 , '03310-000');
    INSERT INTO endereco VALUES(216 , 216 , 'sn' , 'Rua Itapura, 829');
    INSERT INTO cliente VALUES(216 , 216 , 1 , 'Beleza Urbana Hair - Beleza Urbana Hair Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(216 , 216 , '18.254.633/0001-91' , 'Beleza Urbana Hair Ltda.' , 'Beleza Urbana Hair - Beleza Urbana Hair Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(216 , 216 , 'Adalberto' , 0 , 'dalsw@hotmail.com' , '(11)  2384-8626' , 'indefinido');
    INSERT INTO cidade VALUES(217, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(217 , 217, 'São Paulo' , 'Praça Ramos de Azevedo, 206, 206 - CONJ. 2730');
    INSERT INTO cep VALUES(217 , 217 , '01.037-910');
    INSERT INTO endereco VALUES(217 , 217 , 'sn' , 'Praça Ramos de Azevedo, 206, 206 - CONJ. 2730');
    INSERT INTO cliente VALUES(217 , 217 , 1 , 'Besni - Lojas Belian Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(217 , 217 , '46.469.748/0001-39' , 'Lojas Belian Moda Ltda.' , 'Besni - Lojas Belian Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(217 , 217 , '' , 0 , 'henriquemkt@lojasbesni.com.br,aline.maria@lojasbesni.com.br,thiago.nolasco@lojasbesni.com.br,paula.silva@lojasbesni.com.br' , '(11) 3357-0515' , 'indefinido');
    INSERT INTO cidade VALUES(218, 8 , 'Vitória');
    INSERT INTO bairro VALUES(218 , 218, 'Vitória' , 'Avenida Saturnino de Brito, 1327');
    INSERT INTO cep VALUES(218 , 218 , '29.055-180');
    INSERT INTO endereco VALUES(218 , 218 , 'sn' , 'Avenida Saturnino de Brito, 1327');
    INSERT INTO cliente VALUES(218 , 218 , 1 , 'Bristol Four Towers - Four Towers Hotels Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(218 , 218 , '14.777.686/0001-36' , 'Four Towers Hotels Ltda' , 'Bristol Four Towers - Four Towers Hotels Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(218 , 218 , 'Andressa / Elisangela' , 0 , 'financeiro.bft@redebristol.com.br, financeiro1.bft@redebristol.com.brelaine.oliveira@lojasjerram.com.brloja24@tennisexpress.com.brvivian1110@gmail.comleonidas@redeoba.com.br,marcos.bruno@redeoba.com.br,charles.moreira@redeoba.com.brh6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(27) 3183-2500' , 'indefinido');
    INSERT INTO cidade VALUES(219, 25 , 'Barueri');
    INSERT INTO bairro VALUES(219 , 219, 'Barueri' , 'Alameda Araguaia, 1022');
    INSERT INTO cep VALUES(219 , 219 , '06.455-000');
    INSERT INTO endereco VALUES(219 , 219 , 'sn' , 'Alameda Araguaia, 1022');
    INSERT INTO cliente VALUES(219 , 219 , 1 , 'C&A - C&A Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(219 , 219 , '45.242.914/0001-05' , 'C&A Modas Ltda.' , 'C&A - C&A Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(219 , 219 , '' , 0 , 'priscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(220, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(220 , 220, 'Rio de Janeiro' , 'Campo São Cristóvão, 87');
    INSERT INTO cep VALUES(220 , 220 , '20.921-440');
    INSERT INTO endereco VALUES(220 , 220 , 'sn' , 'Campo São Cristóvão, 87');
    INSERT INTO cliente VALUES(220 , 220 , 1 , 'Caçula - Parco Papelaria Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(220 , 220 , '05.214.053/0001-29' , 'Parco Papelaria Ltda.' , 'Caçula - Parco Papelaria Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(220 , 220 , 'Juliana (R8822)' , 0 , 'vinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(221, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(221 , 221, 'São Paulo' , 'Rua Pirajá, 803 - 815, 817 Terreo Andar 2');
    INSERT INTO cep VALUES(221 , 221 , '03.190-170');
    INSERT INTO endereco VALUES(221 , 221 , 'sn' , 'Rua Pirajá, 803 - 815, 817 Terreo Andar 2');
    INSERT INTO cliente VALUES(221 , 221 , 1 , 'Caedu - Caedu Comercio Varejista de Artigos do Vestuário Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(221 , 221 , '46.377.727/0001-93' , 'Caedu Comercio Varejista de Artigos do Vestuário Ltda' , 'Caedu - Caedu Comercio Varejista de Artigos do Vestuário Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(221 , 221 , 'Nathalia' , 0 , 'nathalia.dirani@caedu.com.br' , '(11) 3469-2300 Ramal:2456' , 'indefinido');
    INSERT INTO cidade VALUES(222, 19 , 'São João de Meriti');
    INSERT INTO bairro VALUES(222 , 222, 'São João de Meriti' , 'Rua Maria Soares Sendas, 111 - Lote A – Unidade G');
    INSERT INTO cep VALUES(222 , 222 , '25.575-825');
    INSERT INTO endereco VALUES(222 , 222 , 'sn' , 'Rua Maria Soares Sendas, 111 - Lote A – Unidade G');
    INSERT INTO cliente VALUES(222 , 222 , 1 , 'Casa Show - Casa Show S.A.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(222 , 222 , '28.200.947/0001-65' , 'Casa Show S.A.' , 'Casa Show - Casa Show S.A.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(222 , 222 , 'Larissa' , 0 , 'hvenancio@brhc.com.br, lrcosta@brhc.com.br, aabdul@brhc.com.br, lartoni@brhc.com.br' , '(62) 4012-5129' , 'indefinido');
    INSERT INTO cidade VALUES(223, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(223 , 223, 'São Paulo' , 'Rua Olimpíadas, 360');
    INSERT INTO cep VALUES(223 , 223 , '04.551-000');
    INSERT INTO endereco VALUES(223 , 223 , 'sn' , 'Rua Olimpíadas, 360');
    INSERT INTO cliente VALUES(223 , 223 , 1 , 'Cats - SKO - Locação de Bens Móveis para Prof. da Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(223 , 223 , '10.901.923/0001-78' , 'SKO - Locação de Bens Móveis para Prof. da Beleza Ltda.' , 'Cats - SKO - Locação de Bens Móveis para Prof. da Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(223 , 223 , 'Vanessa' , 0 , 'vanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 2589-4001' , 'indefinido');
    INSERT INTO cidade VALUES(224, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(224 , 224, 'São Paulo' , 'Rua José Paulino, 333');
    INSERT INTO cep VALUES(224 , 224 , '01.120-001');
    INSERT INTO endereco VALUES(224 , 224 , 'sn' , 'Rua José Paulino, 333');
    INSERT INTO cliente VALUES(224 , 224 , 1 , 'Choucream - Confecçoes Choucream Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(224 , 224 , '10.685.672/0001-31' , 'Confecçoes Choucream Ltda.' , 'Choucream - Confecçoes Choucream Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(224 , 224 , '' , 0 , 'patyss@msn.com,cereja@superig.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(225, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(225 , 225, 'São Paulo' , 'Rua Professor Cesare Lombroso - lado ímpar, 259 - Loja 17');
    INSERT INTO cep VALUES(225 , 225 , '01.122-021');
    INSERT INTO endereco VALUES(225 , 225 , 'sn' , 'Rua Professor Cesare Lombroso - lado ímpar, 259 - Loja 17');
    INSERT INTO cliente VALUES(225 , 225 , 1 , 'Confession - Luzes da Moda Comércio de Roupas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(225 , 225 , '08.642.790/0001-10' , 'Luzes da Moda Comércio de Roupas Ltda.' , 'Confession - Luzes da Moda Comércio de Roupas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(225 , 225 , '' , 0 , 'patyss@msn.com,cereja@superig.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(226, 9 , 'Anápolis');
    INSERT INTO bairro VALUES(226 , 226, 'Anápolis' , 'Rodovia BR 153, 3661 - Km 2 - Sala 1');
    INSERT INTO cep VALUES(226 , 226 , '75132-400');
    INSERT INTO endereco VALUES(226 , 226 , 'sn' , 'Rodovia BR 153, 3661 - Km 2 - Sala 1');
    INSERT INTO cliente VALUES(226 , 226 , 1 , 'Denali Hotel - Care Hotelaria Turismo Hospedagem e Arrendamento Mercantil Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(226 , 226 , '09.280.677/0001-03' , 'Care Hotelaria Turismo Hospedagem e Arrendamento Mercantil Ltda.' , 'Denali Hotel - Care Hotelaria Turismo Hospedagem e Arrendamento Mercantil Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(226 , 226 , 'Daniel Alves' , 0 , 'ger.financeiro@denalihotel.com.br' , '(62) 3099-9506' , 'indefinido');
    INSERT INTO cidade VALUES(227, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(227 , 227, 'São Paulo' , 'Largo do Arouche, 337');
    INSERT INTO cep VALUES(227 , 227 , '01.219-011');
    INSERT INTO endereco VALUES(227 , 227 , 'sn' , 'Largo do Arouche, 337');
    INSERT INTO cliente VALUES(227 , 227 , 1 , 'Dibs - Dibs Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(227 , 227 , '55.386.577/0001-75' , 'Dibs Modas Ltda.' , 'Dibs - Dibs Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(227 , 227 , 'Andrea' , 0 , 'andrea@dibs.com.br,financeiro.dibs@terra.com.br' , '(11)3339-9999' , 'indefinido');
    INSERT INTO cidade VALUES(228, 9 , 'Goiânia');
    INSERT INTO bairro VALUES(228 , 228, 'Goiânia' , 'Avenida Deputado Jamel Cecílio, 3221 - QdB31 - Lt. 17');
    INSERT INTO cep VALUES(228 , 228 , '74.810-100');
    INSERT INTO endereco VALUES(228 , 228 , 'sn' , 'Avenida Deputado Jamel Cecílio, 3221 - QdB31 - Lt. 17');
    INSERT INTO cliente VALUES(228 , 228 , 1 , 'Empório Saccaria - R2 Comércio de Alimentos e Bebidas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(228 , 228 , '11.169.421/0002-48' , 'R2 Comércio de Alimentos e Bebidas Ltda.' , 'Empório Saccaria - R2 Comércio de Alimentos e Bebidas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(228 , 228 , 'Kelly' , 0 , 'kelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(62)3921-9000' , 'indefinido');
    INSERT INTO cidade VALUES(229, 9 , 'Goiânia');
    INSERT INTO bairro VALUES(229 , 229, 'Goiânia' , 'Avenida 24 de Outubro, 1383');
    INSERT INTO cep VALUES(229 , 229 , '74.505-011');
    INSERT INTO endereco VALUES(229 , 229 , 'sn' , 'Avenida 24 de Outubro, 1383');
    INSERT INTO cliente VALUES(229 , 229 , 1 , 'Flávios Calçados - Flávios Calçados Esporte Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(229 , 229 , '02.138.006/0001-55' , 'Flávios Calçados Esporte Ltda.' , 'Flávios Calçados - Flávios Calçados Esporte Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(229 , 229 , 'Maicon' , 0 , 'maiconsantos@flavios.com.br, malbaleticia@flavios.com.br' , '(62) 3235-4646' , 'indefinido');
    INSERT INTO cidade VALUES(230, 24 , 'Palhoça');
    INSERT INTO bairro VALUES(230 , 230, 'Palhoça' , 'Rua Roney Henrique Heidershidt, sn');
    INSERT INTO cep VALUES(230 , 230 , '88.130-000');
    INSERT INTO endereco VALUES(230 , 230 , 'sn' , 'Rua Roney Henrique Heidershidt, sn');
    INSERT INTO cliente VALUES(230 , 230 , 1 , 'Gabriela Calçados / Studio Z - Calcenter Calçados Centro Oeste Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(230 , 230 , '15.048.754/0075-25' , 'Calcenter Calçados Centro Oeste Ltda.' , 'Gabriela Calçados / Studio Z - Calcenter Calçados Centro Oeste Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(230 , 230 , 'Maiara' , 0 , 'maiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(48) 3298-6939' , 'indefinido');
    INSERT INTO cidade VALUES(231, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(231 , 231, 'São Paulo' , 'Rua Sena Madureira, 1355 - Bloco I');
    INSERT INTO cep VALUES(231 , 231 , '04.021-051');
    INSERT INTO endereco VALUES(231 , 231 , 'sn' , 'Rua Sena Madureira, 1355 - Bloco I');
    INSERT INTO cliente VALUES(231 , 231 , 1 , 'Grand Mercure Ibirapuera - Ibirapuera Park Hotel Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(231 , 231 , '53.355.004/0003-10' , 'Ibirapuera Park Hotel Ltda.' , 'Grand Mercure Ibirapuera - Ibirapuera Park Hotel Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(231 , 231 , '' , 0 , 'h0578-gl2@accor.com.br, sofitel.saopaulo@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(232, 24 , 'Brusque');
    INSERT INTO bairro VALUES(232 , 232, 'Brusque' , 'Via Rodovia Antônio Heil - do km 28,000 ao fim, 200');
    INSERT INTO cep VALUES(232 , 232 , '88.353-100');
    INSERT INTO endereco VALUES(232 , 232 , 'sn' , 'Via Rodovia Antônio Heil - do km 28,000 ao fim, 200');
    INSERT INTO cliente VALUES(232 , 232 , 1 , 'Havan - Havan Lojas de Departamento Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(232 , 232 , '79.379.491/0001-83' , 'Havan Lojas de Departamento Ltda.' , 'Havan - Havan Lojas de Departamento Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(232 , 232 , '' , 0 , '' , '' , 'indefinido');
    INSERT INTO cidade VALUES(233, 25 , 'Andradina');
    INSERT INTO bairro VALUES(233 , 233, 'Andradina' , 'Rua Elétrico Bracale, 2996');
    INSERT INTO cep VALUES(233 , 233 , '16901-235');
    INSERT INTO endereco VALUES(233 , 233 , 'sn' , 'Rua Elétrico Bracale, 2996');
    INSERT INTO cliente VALUES(233 , 233 , 1 , 'Ibis Andradina - LIVIA CORREA LOPES - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(233 , 233 , '17.055.398/0001-66' , 'LIVIA CORREA LOPES - EPP' , 'Ibis Andradina - LIVIA CORREA LOPES - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(233 , 233 , 'Andreia' , 0 , 'h7128-gl@accor.com.br,h7128-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(234, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(234 , 234, 'Rio de Janeiro' , 'Avenida Gilberto Amado, 41');
    INSERT INTO cep VALUES(234 , 234 , '22.620-061');
    INSERT INTO endereco VALUES(234 , 234 , 'sn' , 'Avenida Gilberto Amado, 41');
    INSERT INTO cliente VALUES(234 , 234 , 1 , 'Ibis Barra da Tijuca - Up Asset Pepê Hotel Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(234 , 234 , '18.638.713/0002-21' , 'Up Asset Pepê Hotel Ltda.' , 'Ibis Barra da Tijuca - Up Asset Pepê Hotel Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(234 , 234 , '' , 0 , 'H8182-GL@accor.com.br' , '(11) 3818-6204' , 'indefinido');
    INSERT INTO cidade VALUES(235, 16 , 'Cascavel');
    INSERT INTO bairro VALUES(235 , 235, 'Cascavel' , 'Rua Paraná, 4522');
    INSERT INTO cep VALUES(235 , 235 , '85813-010');
    INSERT INTO endereco VALUES(235 , 235 , 'sn' , 'Rua Paraná, 4522');
    INSERT INTO cliente VALUES(235 , 235 , 1 , 'Ibis Cascavel - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(235 , 235 , '80.732.928/0019-29' , 'Atrio Hotéis S/A' , 'Ibis Cascavel - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(235 , 235 , 'Anelise Rhoden Dalferth' , 0 , 'h7826-gl@accor.com.br,h7826-gm@accor.com.br' , '(45) 2101-9800' , 'indefinido');
    INSERT INTO cidade VALUES(236, 16 , 'Foz do Iguaçu');
    INSERT INTO bairro VALUES(236 , 236, 'Foz do Iguaçu' , 'Rua Almirante Barroso, 866');
    INSERT INTO cep VALUES(236 , 236 , '85851-010');
    INSERT INTO endereco VALUES(236 , 236 , 'sn' , 'Rua Almirante Barroso, 866');
    INSERT INTO cliente VALUES(236 , 236 , 1 , 'Ibis Foz do Iguaçu - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(236 , 236 , '09.967.852/0170-11' , 'Hotelaria Accor Brasil S/A' , 'Ibis Foz do Iguaçu - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(236 , 236 , 'Juliana' , 0 , 'h7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(45) 3422-3300' , 'indefinido');
    INSERT INTO cidade VALUES(237, 25 , 'Mogi das Cruzes');
    INSERT INTO bairro VALUES(237 , 237, 'Mogi das Cruzes' , 'Av. Vereador Narciso Yague Guimarães, 372');
    INSERT INTO cep VALUES(237 , 237 , '08780-000');
    INSERT INTO endereco VALUES(237 , 237 , 'sn' , 'Av. Vereador Narciso Yague Guimarães, 372');
    INSERT INTO cliente VALUES(237 , 237 , 1 , 'Ibis Mogi das Cruzes - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(237 , 237 , '80.732.928/0018-48' , 'Atrio Hotéis S/A' , 'Ibis Mogi das Cruzes - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(237 , 237 , 'Miler Bairros' , 0 , 'h7823-gl@accor.com.br' , '(11) 2813-3800' , 'indefinido');
    INSERT INTO cidade VALUES(238, 21 , 'Montenegro');
    INSERT INTO bairro VALUES(238 , 238, 'Montenegro' , 'Rua Capitão Porfírio, 1615');
    INSERT INTO cep VALUES(238 , 238 , '95780-000');
    INSERT INTO endereco VALUES(238 , 238 , 'sn' , 'Rua Capitão Porfírio, 1615');
    INSERT INTO cliente VALUES(238 , 238 , 1 , 'Ibis Montenegro - Montenegrina Administradora de Hotéis Sociedade de Propósito Específico Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(238 , 238 , '11.948.936/0001-65' , 'Montenegrina Administradora de Hotéis Sociedade de Propósito Específico Ltda.' , 'Ibis Montenegro - Montenegrina Administradora de Hotéis Sociedade de Propósito Específico Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(238 , 238 , '' , 0 , 'h8140-gl@accor.com.br' , '(51) 3883-2800' , 'indefinido');
    INSERT INTO cidade VALUES(239, 24 , 'Joinville');
    INSERT INTO bairro VALUES(239 , 239, 'Joinville' , 'Rua Comandante Frederico Stoll, 47');
    INSERT INTO cep VALUES(239 , 239 , '89201-340');
    INSERT INTO endereco VALUES(239 , 239 , 'sn' , 'Rua Comandante Frederico Stoll, 47');
    INSERT INTO cliente VALUES(239 , 239 , 1 , 'Ibis Styles Joinville - Átrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(239 , 239 , '80.732.928/0009-57' , 'Átrio Hotéis S/A' , 'Ibis Styles Joinville - Átrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(239 , 239 , 'Tânia Regina Rosa' , 0 , 'h3138-gm@accor.com.br' , '(47) 3481-3322' , 'indefinido');
    INSERT INTO cidade VALUES(240, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(240 , 240, 'Belo Horizonte' , 'Rua dos Guajajaras, 849');
    INSERT INTO cep VALUES(240 , 240 , '30180-100');
    INSERT INTO endereco VALUES(240 , 240 , 'sn' , 'Rua dos Guajajaras, 849');
    INSERT INTO cliente VALUES(240 , 240 , 1 , 'Ibis Styles Minas Centro - EBH Estacionamento Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(240 , 240 , '12.908.368/0002-12' , 'EBH Estacionamento Ltda.' , 'Ibis Styles Minas Centro - EBH Estacionamento Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(240 , 240 , 'Rafael' , 0 , 'H8952-GM@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(241, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(241 , 241, 'Belo Horizonte' , 'Avenida Professor Magalhães Penido, 378');
    INSERT INTO cep VALUES(241 , 241 , '31270-700');
    INSERT INTO endereco VALUES(241 , 241 , 'sn' , 'Avenida Professor Magalhães Penido, 378');
    INSERT INTO cliente VALUES(241 , 241 , 1 , 'Ibis Styles Pampulha - Hotelaria Accor PDB Pampulha Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(241 , 241 , '19.756.396/0001-20' , 'Hotelaria Accor PDB Pampulha Ltda.' , 'Ibis Styles Pampulha - Hotelaria Accor PDB Pampulha Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(241 , 241 , 'Poliana' , 0 , 'h8931-gl@accor.com.br' , '(31) 3888-6100' , 'indefinido');
    INSERT INTO cidade VALUES(242, 13 , 'Uberaba');
    INSERT INTO bairro VALUES(242 , 242, 'Uberaba' , 'Avenida Barão do Rio Branco, 1340');
    INSERT INTO cep VALUES(242 , 242 , '38020-300');
    INSERT INTO endereco VALUES(242 , 242 , 'sn' , 'Avenida Barão do Rio Branco, 1340');
    INSERT INTO cliente VALUES(242 , 242 , 1 , 'Ibis Uberaba - Hiu Administradora de Hotéis e Condomínios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(242 , 242 , '16.584.805/0001-60' , 'Hiu Administradora de Hotéis e Condomínios Ltda.' , 'Ibis Uberaba - Hiu Administradora de Hotéis e Condomínios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(242 , 242 , 'Gustavo' , 0 , 'h8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(34) 3521-9900' , 'indefinido');
    INSERT INTO cidade VALUES(243, 5 , 'Vitória da Conquista');
    INSERT INTO bairro VALUES(243 , 243, 'Vitória da Conquista' , 'Avenida Juracy Magalhães, s/n');
    INSERT INTO cep VALUES(243 , 243 , '45026-090');
    INSERT INTO endereco VALUES(243 , 243 , 'sn' , 'Avenida Juracy Magalhães, s/n');
    INSERT INTO cliente VALUES(243 , 243 , 1 , 'Ibis Vitória da Conquista - União Empreendimentos Turísticos da Bahia Ltda - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(243 , 243 , '09.537.292/0001-70' , 'União Empreendimentos Turísticos da Bahia Ltda - ME' , 'Ibis Vitória da Conquista - União Empreendimentos Turísticos da Bahia Ltda - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(243 , 243 , 'Cris' , 0 , 'H7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(244, 26 , 'Aracaju');
    INSERT INTO bairro VALUES(244 , 244, 'Aracaju' , 'Avenida Adelia Franco, 2719');
    INSERT INTO cep VALUES(244 , 244 , '49.027-010');
    INSERT INTO endereco VALUES(244 , 244 , 'sn' , 'Avenida Adelia Franco, 2719');
    INSERT INTO cliente VALUES(244 , 244 , 1 , 'Ibis Aracaju - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(244 , 244 , '09.967.852/0117-57' , 'Hotelaria Accor Brasil S/A' , 'Ibis Aracaju - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(244 , 244 , 'Flavio' , 0 , 'h5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(79) 2106-2000' , 'indefinido');
    INSERT INTO cidade VALUES(245, 25 , 'Araçatuba');
    INSERT INTO bairro VALUES(245 , 245, 'Araçatuba' , 'Avenida Brasilia, 2500');
    INSERT INTO cep VALUES(245 , 245 , '16.018-000');
    INSERT INTO endereco VALUES(245 , 245 , 'sn' , 'Avenida Brasilia, 2500');
    INSERT INTO cliente VALUES(245 , 245 , 1 , 'Ibis Araçatuba - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(245 , 245 , '09.967.852/0150-78' , 'Hotelaria Accor Brasil S/A' , 'Ibis Araçatuba - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(245 , 245 , 'Daniela/ Anne' , 0 , 'h5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(18) 2103-5300' , 'indefinido');
    INSERT INTO cidade VALUES(246, 25 , 'Barretos');
    INSERT INTO bairro VALUES(246 , 246, 'Barretos' , 'Avenida dos Maçons, 405');
    INSERT INTO cep VALUES(246 , 246 , '14.783-167');
    INSERT INTO endereco VALUES(246 , 246 , 'sn' , 'Avenida dos Maçons, 405');
    INSERT INTO cliente VALUES(246 , 246 , 1 , 'Ibis Barretos - HIB Hotéis e Condomínios Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(246 , 246 , '15.490.520/0001-05' , 'HIB Hotéis e Condomínios Ltda' , 'Ibis Barretos - HIB Hotéis e Condomínios Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(246 , 246 , 'Roberta' , 0 , 'h8135-gm@accor.com.br' , '(17) 3312-8282' , 'indefinido');
    INSERT INTO cidade VALUES(247, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(247 , 247, 'Belo Horizonte' , 'Avenida Joao Pinheiro, 602');
    INSERT INTO cep VALUES(247 , 247 , '30.130-180');
    INSERT INTO endereco VALUES(247 , 247 , 'sn' , 'Avenida Joao Pinheiro, 602');
    INSERT INTO cliente VALUES(247 , 247 , 1 , 'Ibis Belo Horizonte Liberdade - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(247 , 247 , '09.967.852/0103-51' , 'Hotelaria Accor Brasil S/A' , 'Ibis Belo Horizonte Liberdade - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(247 , 247 , '' , 0 , 'h5298-gl@accor.com.br,h5298-gm@accor.com.br' , '(31) 2111 1500' , 'indefinido');
    INSERT INTO cidade VALUES(248, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(248 , 248, 'Belo Horizonte' , 'Avenida do Contorno, 6180');
    INSERT INTO cep VALUES(248 , 248 , '30.110-042');
    INSERT INTO endereco VALUES(248 , 248 , 'sn' , 'Avenida do Contorno, 6180');
    INSERT INTO cliente VALUES(248 , 248 , 1 , 'Ibis Belo Horizonte Savassi - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(248 , 248 , '09.967.852/0163-92' , 'Hotelaria Accor Brasil S/A' , 'Ibis Belo Horizonte Savassi - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(248 , 248 , '' , 0 , 'h7021-gl@accor.com.br' , '(31) 3888 4300' , 'indefinido');
    INSERT INTO cidade VALUES(249, 13 , 'Betim');
    INSERT INTO bairro VALUES(249 , 249, 'Betim' , 'Rodovia BR 381 Fernao Dias Km 482, s/nº ');
    INSERT INTO cep VALUES(249 , 249 , '32.689-898');
    INSERT INTO endereco VALUES(249 , 249 , 'sn' , 'Rodovia BR 381 Fernao Dias Km 482, s/nº ');
    INSERT INTO cliente VALUES(249 , 249 , 1 , 'Ibis Betim - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(249 , 249 , '09.967.852/0106-02' , 'Hotelaria Accor Brasil S/A' , 'Ibis Betim - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(249 , 249 , '' , 0 , 'h5467-gl@accor.com.br' , '(31) 2111-1600/2111-1601' , 'indefinido');
    INSERT INTO cidade VALUES(250, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(250 , 250, 'Belo Horizonte' , 'Rua Goncalves Dias, 720');
    INSERT INTO cep VALUES(250 , 250 , '30.140-091');
    INSERT INTO endereco VALUES(250 , 250 , 'sn' , 'Rua Goncalves Dias, 720');
    INSERT INTO cliente VALUES(250 , 250 , 1 , 'Ibis BH Afonso Pena - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(250 , 250 , '09.967.852/0169-88' , 'Hotelaria Accor Brasil S/A' , 'Ibis BH Afonso Pena - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(250 , 250 , 'Socorro' , 0 , 'H8498-GM@accor.com.br,h8498-gl@accor.com.br, h8498-gl1@accor.com.br' , '(31) 2108-2950' , 'indefinido');
    INSERT INTO cidade VALUES(251, 24 , 'Blumenau');
    INSERT INTO bairro VALUES(251 , 251, 'Blumenau' , 'Rua Paul Hering, 67');
    INSERT INTO cep VALUES(251 , 251 , '89.010-050');
    INSERT INTO endereco VALUES(251 , 251 , 'sn' , 'Rua Paul Hering, 67');
    INSERT INTO cliente VALUES(251 , 251 , 1 , 'Ibis Blumenau - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(251 , 251 , '80.732.928/0003-61' , 'Atrio Hotéis S/A' , 'Ibis Blumenau - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(251 , 251 , 'Everson' , 0 , 'h5468-gl@accor.com.br' , '(47) 3221 4700 / 3221 4701' , 'indefinido');
    INSERT INTO cidade VALUES(252, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(252 , 252, 'Rio de Janeiro' , 'Rua Paulino Fernandes, 39');
    INSERT INTO cep VALUES(252 , 252 , '22.270-050');
    INSERT INTO endereco VALUES(252 , 252 , 'sn' , 'Rua Paulino Fernandes, 39');
    INSERT INTO cliente VALUES(252 , 252 , 1 , 'Ibis Botafogo - Up Asset Botafogo Hotel Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(252 , 252 , '17.065.907/0001-31' , 'Up Asset Botafogo Hotel Ltda.' , 'Ibis Botafogo - Up Asset Botafogo Hotel Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(252 , 252 , 'Leny / Rafael' , 0 , 'h7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(21) 3515-2974 / 3515-2999' , 'indefinido');
    INSERT INTO cidade VALUES(253, 25 , 'Campinas');
    INSERT INTO bairro VALUES(253 , 253, 'Campinas' , 'Avenida Aquidaban, 440');
    INSERT INTO cep VALUES(253 , 253 , '13.026-510');
    INSERT INTO endereco VALUES(253 , 253 , 'sn' , 'Avenida Aquidaban, 440');
    INSERT INTO cliente VALUES(253 , 253 , 1 , 'Ibis Campinas - P1 Administração em Complexos Imobiliários Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(253 , 253 , '00.205.375/0004-30' , 'P1 Administração em Complexos Imobiliários Ltda' , 'Ibis Campinas - P1 Administração em Complexos Imobiliários Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(253 , 253 , '' , 0 , 'h5469-gl@accor.com.br' , '(19) 3731 2300 / 3731 2310' , 'indefinido');
    INSERT INTO cidade VALUES(254, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(254 , 254, 'Campo Grande' , 'Avenida Mato Grosso, 5513');
    INSERT INTO cep VALUES(254 , 254 , '79.104-300');
    INSERT INTO endereco VALUES(254 , 254 , 'sn' , 'Avenida Mato Grosso, 5513');
    INSERT INTO cliente VALUES(254 , 254 , 1 , 'Ibis Campo Grande - Seven - Administração e Participação Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(254 , 254 , '02.139.652/0003-07' , 'Seven - Administração e Participação Ltda' , 'Ibis Campo Grande - Seven - Administração e Participação Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(254 , 254 , 'Carol' , 0 , 'h6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(67) 2106-1953' , 'indefinido');
    INSERT INTO cidade VALUES(255, 21 , 'Canoas');
    INSERT INTO bairro VALUES(255 , 255, 'Canoas' , 'Rua Mathias Velho, 235');
    INSERT INTO cep VALUES(255 , 255 , '92.310-300');
    INSERT INTO endereco VALUES(255 , 255 , 'sn' , 'Rua Mathias Velho, 235');
    INSERT INTO cliente VALUES(255 , 255 , 1 , 'Ibis Canoas Shopping - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(255 , 255 , '80.732.928/0015-03' , 'Atrio Hotéis S/A' , 'Ibis Canoas Shopping - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(255 , 255 , '' , 0 , 'h8273-gm@accor.com.br,h8273-dm@accor.com.br' , '(51) 3507 2177' , 'indefinido');
    INSERT INTO cidade VALUES(256, 21 , 'Caxias do Sul');
    INSERT INTO bairro VALUES(256 , 256, 'Caxias do Sul' , 'Rua Joao Nichelle, 2335');
    INSERT INTO cep VALUES(256 , 256 , '95.012-631');
    INSERT INTO endereco VALUES(256 , 256 , 'sn' , 'Rua Joao Nichelle, 2335');
    INSERT INTO cliente VALUES(256 , 256 , 1 , 'Ibis Caxias do Sul - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(256 , 256 , '80.732.928/0010-90' , 'Atrio Hotéis S/A' , 'Ibis Caxias do Sul - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(256 , 256 , 'Cristiane' , 0 , 'h5470-gm@accor.com.br,h5470-gl@accor.com.br,h5470-dm@accor.com.br' , '(54) 3209 5555/3209-5580' , 'indefinido');
    INSERT INTO cidade VALUES(257, 8 , 'Colatina');
    INSERT INTO bairro VALUES(257 , 257, 'Colatina' , 'Rua Pedro Epichim, 1524');
    INSERT INTO cep VALUES(257 , 257 , '29.712-412');
    INSERT INTO endereco VALUES(257 , 257 , 'sn' , 'Rua Pedro Epichim, 1524');
    INSERT INTO cliente VALUES(257 , 257 , 1 , 'Ibis Colatina - Ajax Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(257 , 257 , '09.643.387/0001-79' , 'Ajax Hotéis S/A' , 'Ibis Colatina - Ajax Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(257 , 257 , '' , 0 , 'h8073-gm@accor.com.br,' , '' , 'indefinido');
    INSERT INTO cidade VALUES(258, 13 , 'Contagem');
    INSERT INTO bairro VALUES(258 , 258, 'Contagem' , 'Rua Um, 165');
    INSERT INTO cep VALUES(258 , 258 , '32.152-002');
    INSERT INTO endereco VALUES(258 , 258 , 'sn' , 'Rua Um, 165');
    INSERT INTO cliente VALUES(258 , 258 , 1 , 'Ibis Contagem Ceasa - Sucesso Administração e Participação Hoteleira AS' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(258 , 258 , '11.824.567/0003-60' , 'Sucesso Administração e Participação Hoteleira AS' , 'Ibis Contagem Ceasa - Sucesso Administração e Participação Hoteleira AS' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(258 , 258 , '' , 0 , 'h7948-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(259, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(259 , 259, 'Rio de Janeiro' , 'Rua Ministro Viveiro de Castro, 134');
    INSERT INTO cep VALUES(259 , 259 , '22.021-010');
    INSERT INTO endereco VALUES(259 , 259 , 'sn' , 'Rua Ministro Viveiro de Castro, 134');
    INSERT INTO cliente VALUES(259 , 259 , 1 , 'Ibis Copacabana - UP Asset Copacabana Hotel Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(259 , 259 , '15.486.691/0001-52' , 'UP Asset Copacabana Hotel Ltda' , 'Ibis Copacabana - UP Asset Copacabana Hotel Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(259 , 259 , 'Joyce' , 0 , 'h6497-gl@accor.com.br, h6497-gl1@accor.com.br, h6497-gm@accor.com.br,h6497-dm@accor.com.br' , '(21) 3218-1179' , 'indefinido');
    INSERT INTO cidade VALUES(260, 24 , 'Criciúma');
    INSERT INTO bairro VALUES(260 , 260, 'Criciúma' , 'Avenida Gabriel Zanette, 1090');
    INSERT INTO cep VALUES(260 , 260 , '88.815-060');
    INSERT INTO endereco VALUES(260 , 260 , 'sn' , 'Avenida Gabriel Zanette, 1090');
    INSERT INTO cliente VALUES(260 , 260 , 1 , 'Ibis Criciúma - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(260 , 260 , '80.732.928/0007-95' , 'Atrio Hotéis S/A' , 'Ibis Criciúma - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(260 , 260 , '' , 0 , 'h6315-gl@accor.com.br' , '(48) 2102-9000/2102-9001' , 'indefinido');
    INSERT INTO cidade VALUES(261, 16 , 'São José dos Pinhais');
    INSERT INTO bairro VALUES(261 , 261, 'São José dos Pinhais' , 'Rodovia BR 376, 1633');
    INSERT INTO cep VALUES(261 , 261 , '83.015-000');
    INSERT INTO endereco VALUES(261 , 261 , 'sn' , 'Rodovia BR 376, 1633');
    INSERT INTO cliente VALUES(261 , 261 , 1 , 'Ibis Curitiba Aeroporto - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(261 , 261 , '80.732.928/0006-04' , 'Atrio Hotéis S/A' , 'Ibis Curitiba Aeroporto - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(261 , 261 , '' , 0 , 'h3736-gl@accor.com.br' , '(41) 2109 6650 / 2109 6651' , 'indefinido');
    INSERT INTO cidade VALUES(262, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(262 , 262, 'Curitiba' , 'Rua Comendador Araujo, 730');
    INSERT INTO cep VALUES(262 , 262 , '80.420-000');
    INSERT INTO endereco VALUES(262 , 262 , 'sn' , 'Rua Comendador Araujo, 730');
    INSERT INTO cliente VALUES(262 , 262 , 1 , 'Ibis Curitiba Batel - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(262 , 262 , '09.967.852/0115-95' , 'Hotelaria Accor Brasil S/A' , 'Ibis Curitiba Batel - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(262 , 262 , 'Elisangela' , 0 , 'h5461-gm@accor.com.br,h5461-dm@accor.com.br,h5461-gl@accor.com.br' , '(41) 2102 2004/ (11) 2089-6427 Ana Carolina' , 'indefinido');
    INSERT INTO cidade VALUES(263, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(263 , 263, 'Curitiba' , 'Rua Mateus Leme, 358');
    INSERT INTO cep VALUES(263 , 263 , '80.510-190');
    INSERT INTO endereco VALUES(263 , 263 , 'sn' , 'Rua Mateus Leme, 358');
    INSERT INTO cliente VALUES(263 , 263 , 1 , 'Ibis Curitiba Centro Cívico - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(263 , 263 , '09.967.852/0036-57' , 'Hotelaria Accor Brasil S/A' , 'Ibis Curitiba Centro Cívico - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(263 , 263 , '' , 0 , 'h3205-gm@accor.com.br,h3205-dm@accor.com.br,h3205-gl@accor.com.br' , '(41)3324-0469 / 3323-3404' , 'indefinido');
    INSERT INTO cidade VALUES(264, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(264 , 264, 'Curitiba' , 'Rua Brigadeiro Franco, 2154');
    INSERT INTO cep VALUES(264 , 264 , '80.250-030');
    INSERT INTO endereco VALUES(264 , 264 , 'sn' , 'Rua Brigadeiro Franco, 2154');
    INSERT INTO cliente VALUES(264 , 264 , 1 , 'Ibis Curitiba Shopping - GFA Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(264 , 264 , '13.762.215/0001-91' , 'GFA Hotelaria Ltda' , 'Ibis Curitiba Shopping - GFA Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(264 , 264 , 'Olacyr' , 0 , 'h7827-gm@accor.com.br' , '(41) 3595 2450' , 'indefinido');
    INSERT INTO cidade VALUES(265, 13 , 'Abadia dos Dourados');
    INSERT INTO bairro VALUES(265 , 265, 'Abadia dos Dourados' , 'Av Joaquim Teixeira Alves, 3365');
    INSERT INTO cep VALUES(265 , 265 , '79.830-010');
    INSERT INTO endereco VALUES(265 , 265 , 'sn' , 'Av Joaquim Teixeira Alves, 3365');
    INSERT INTO cliente VALUES(265 , 265 , 1 , 'Ibis Dourados - Bertt Hotelaria Ltda ' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(265 , 265 , '11.229.562/0001-28' , 'Bertt Hotelaria Ltda ' , 'Ibis Dourados - Bertt Hotelaria Ltda ' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(265 , 265 , '' , 0 , 'h6666-gm@accor.com.br' , '(67) 2108-1000' , 'indefinido');
    INSERT INTO cidade VALUES(266, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(266 , 266, 'São Paulo' , 'Rua Eduardo Viana, 163');
    INSERT INTO cep VALUES(266 , 266 , '01.133-040');
    INSERT INTO endereco VALUES(266 , 266 , 'sn' , 'Rua Eduardo Viana, 163');
    INSERT INTO cliente VALUES(266 , 266 , 1 , 'Ibis Expo Barra Funda - Asset Atividades  Hoteleiras Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(266 , 266 , '12.910.328/0003-96' , 'Asset Atividades  Hoteleiras Ltda' , 'Ibis Expo Barra Funda - Asset Atividades  Hoteleiras Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(266 , 266 , '' , 0 , 'h2211-gl1@accor.com.br,h2211-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(267, 5 , 'Feira de Santana');
    INSERT INTO bairro VALUES(267 , 267, 'Feira de Santana' , 'Rua Cel Jose Pinto dos Santos, 700');
    INSERT INTO cep VALUES(267 , 267 , '44.051-400');
    INSERT INTO endereco VALUES(267 , 267 , 'sn' , 'Rua Cel Jose Pinto dos Santos, 700');
    INSERT INTO cliente VALUES(267 , 267 , 1 , 'Ibis Feira de Santana - Braga Empreendimentos Participação LTDA' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(267 , 267 , '11.093.203/0001-96' , 'Braga Empreendimentos Participação LTDA' , 'Ibis Feira de Santana - Braga Empreendimentos Participação LTDA' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(267 , 267 , '' , 0 , 'h7825-gm@accor.com.br' , '(75) 3301-4282 / 3301-4295' , 'indefinido');
    INSERT INTO cidade VALUES(268, 24 , 'Florianópolis');
    INSERT INTO bairro VALUES(268 , 268, 'Florianópolis' , 'Avenida Rio Branco, 37');
    INSERT INTO cep VALUES(268 , 268 , '88.015-200');
    INSERT INTO endereco VALUES(268 , 268 , 'sn' , 'Avenida Rio Branco, 37');
    INSERT INTO cliente VALUES(268 , 268 , 1 , 'Ibis Florianópolis - Flex Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(268 , 268 , '08.928.877/0001-59' , 'Flex Hotelaria Ltda' , 'Ibis Florianópolis - Flex Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(268 , 268 , 'Solange' , 0 , 'h5224-gl@accor.com.br' , '(48) 3216 0005' , 'indefinido');
    INSERT INTO cidade VALUES(269, 13 , 'Cruzeiro da Fortaleza');
    INSERT INTO bairro VALUES(269 , 269, 'Cruzeiro da Fortaleza' , 'Rua Dr Atualpa Barbosa Lima, 660');
    INSERT INTO cep VALUES(269 , 269 , '60.060-370');
    INSERT INTO endereco VALUES(269 , 269 , 'sn' , 'Rua Dr Atualpa Barbosa Lima, 660');
    INSERT INTO cliente VALUES(269 , 269 , 1 , 'Ibis Fortaleza - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(269 , 269 , '09.967.852/0041-14' , 'Hotelaria Accor Brasil S/A' , 'Ibis Fortaleza - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(269 , 269 , '' , 0 , 'h1142-gl@accor.com.br,h1142-gm@accor.com.br' , '(85) 3052 2450 / 3052 2471' , 'indefinido');
    INSERT INTO cidade VALUES(270, 9 , 'Ap. de Goiânia');
    INSERT INTO bairro VALUES(270 , 270, 'Ap. de Goiânia' , 'Rua 21, 154 - Quadra D 11  Lote 03');
    INSERT INTO cep VALUES(270 , 270 , '74.120-120');
    INSERT INTO endereco VALUES(270 , 270 , 'sn' , 'Rua 21, 154 - Quadra D 11  Lote 03');
    INSERT INTO cliente VALUES(270 , 270 , 1 , 'Ibis Goiânia - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(270 , 270 , '09.967.852/0138-81' , 'Hotelaria Accor Brasil S/A' , 'Ibis Goiânia - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(270 , 270 , 'Roberta' , 0 , 'h3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(62) 2765-6053' , 'indefinido');
    INSERT INTO cidade VALUES(271, 25 , 'Guarulhos');
    INSERT INTO bairro VALUES(271 , 271, 'Guarulhos' , 'Rua General Ozorio, 19');
    INSERT INTO cep VALUES(271 , 271 , '07.024-000');
    INSERT INTO endereco VALUES(271 , 271 , 'sn' , 'Rua General Ozorio, 19');
    INSERT INTO cliente VALUES(271 , 271 , 1 , 'Ibis Guarulhos - P1 Administração em Complexos Imobiliários Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(271 , 271 , '00.205.375/0007-83' , 'P1 Administração em Complexos Imobiliários Ltda' , 'Ibis Guarulhos - P1 Administração em Complexos Imobiliários Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(271 , 271 , 'Joseane' , 0 , 'h5021-gl1@accor.com.br, h5021-gl@accor.com.br' , '(11) 2159 5950 / 2159 5951' , 'indefinido');
    INSERT INTO cidade VALUES(272, 19 , 'Itaboraí');
    INSERT INTO bairro VALUES(272 , 272, 'Itaboraí' , 'Av 22 de Maio, 3126');
    INSERT INTO cep VALUES(272 , 272 , '24.812-516');
    INSERT INTO endereco VALUES(272 , 272 , 'sn' , 'Av 22 de Maio, 3126');
    INSERT INTO cliente VALUES(272 , 272 , 1 , 'Ibis Itaboraí - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(272 , 272 , '09.967.852/0167-16' , 'Hotelaria Accor Brasil S/A' , 'Ibis Itaboraí - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(272 , 272 , '' , 0 , 'h8229-gl@accor.com.br,h8229gl1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(273, 10 , 'Bacurituba');
    INSERT INTO bairro VALUES(273 , 273, 'Bacurituba' , 'Av Wolko Orni Yedlin, 1251');
    INSERT INTO cep VALUES(273 , 273 , '13.304-360');
    INSERT INTO endereco VALUES(273 , 273 , 'sn' , 'Av Wolko Orni Yedlin, 1251');
    INSERT INTO cliente VALUES(273 , 273 , 1 , 'Ibis Itu - IPS Empreemdimentos S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(273 , 273 , '03.140.367/0002-80' , 'IPS Empreemdimentos S/A' , 'Ibis Itu - IPS Empreemdimentos S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(273 , 273 , '' , 0 , 'h8138-gl@accor.com.br' , '(11) 3414-3454 / 3414-3461 / 3414-3469' , 'indefinido');
    INSERT INTO cidade VALUES(274, 25 , 'Jaboticabal');
    INSERT INTO bairro VALUES(274 , 274, 'Jaboticabal' , 'Avenida Major Novaes, 70');
    INSERT INTO cep VALUES(274 , 274 , '14.870-115');
    INSERT INTO endereco VALUES(274 , 274 , 'sn' , 'Avenida Major Novaes, 70');
    INSERT INTO cliente VALUES(274 , 274 , 1 , 'Ibis Jaboticabal - HIJ Administradora de Hotéis e Condominios Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(274 , 274 , '14.763.421/0001-89' , 'HIJ Administradora de Hotéis e Condominios Ltda' , 'Ibis Jaboticabal - HIJ Administradora de Hotéis e Condominios Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(274 , 274 , '' , 0 , 'h7828-gm@accor.com.br' , '(16) 2141-0099 /  2141-0076' , 'indefinido');
    INSERT INTO cidade VALUES(275, 20 , 'Coronel João Pessoa');
    INSERT INTO bairro VALUES(275 , 275, 'Coronel João Pessoa' , 'Avenida Cabo Branco, 4.350');
    INSERT INTO cep VALUES(275 , 275 , '58.045-906');
    INSERT INTO endereco VALUES(275 , 275 , 'sn' , 'Avenida Cabo Branco, 4.350');
    INSERT INTO cliente VALUES(275 , 275 , 1 , 'Ibis João Pessoa - Vitrine Empreendimentos Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(275 , 275 , '06.033.835/0002-05' , 'Vitrine Empreendimentos Ltda' , 'Ibis João Pessoa - Vitrine Empreendimentos Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(275 , 275 , 'Niedja' , 0 , 'h6355-gl@accor.com.br' , '(83) 2108 9206' , 'indefinido');
    INSERT INTO cidade VALUES(276, 24 , 'Joinville');
    INSERT INTO bairro VALUES(276 , 276, 'Joinville' , 'Rua 9 de Marco, 806');
    INSERT INTO cep VALUES(276 , 276 , '89.201-400');
    INSERT INTO endereco VALUES(276 , 276 , 'sn' , 'Rua 9 de Marco, 806');
    INSERT INTO cliente VALUES(276 , 276 , 1 , 'Ibis Joinville - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(276 , 276 , '80.732.928/0005-23' , 'Atrio Hotéis S/A' , 'Ibis Joinville - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(276 , 276 , '' , 0 , 'h5633-gl@accor.com.br' , '(47) 3489 9000 / 3489 9001' , 'indefinido');
    INSERT INTO cidade VALUES(277, 19 , 'Macaé');
    INSERT INTO bairro VALUES(277 , 277, 'Macaé' , 'Rua Dolores Carvalho de Vasconcelos, 136');
    INSERT INTO cep VALUES(277 , 277 , '27.937-600');
    INSERT INTO endereco VALUES(277 , 277 , 'sn' , 'Rua Dolores Carvalho de Vasconcelos, 136');
    INSERT INTO cliente VALUES(277 , 277 , 1 , 'Ibis Macaé - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(277 , 277 , '09.967.852/0124-86' , 'Hotelaria Accor Brasil S/A' , 'Ibis Macaé - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(277 , 277 , '' , 0 , 'h3733-gl@accor.com.br' , '(22) 2105-6000' , 'indefinido');
    INSERT INTO cidade VALUES(278, 3 , 'Macapá');
    INSERT INTO bairro VALUES(278 , 278, 'Macapá' , 'Rua Tiradentes, 303');
    INSERT INTO cep VALUES(278 , 278 , '69.800-098');
    INSERT INTO endereco VALUES(278 , 278 , 'sn' , 'Rua Tiradentes, 303');
    INSERT INTO cliente VALUES(278 , 278 , 1 , 'Ibis Macapá - BDH Hotelaria e Turismo Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(278 , 278 , '12.993.139/0001-62' , 'BDH Hotelaria e Turismo Ltda' , 'Ibis Macapá - BDH Hotelaria e Turismo Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(278 , 278 , '' , 0 , 'h6349-gm@accor.com.br' , '(96) 2101 9050 / 2101 9051' , 'indefinido');
    INSERT INTO cidade VALUES(279, 4 , 'Manaus');
    INSERT INTO bairro VALUES(279 , 279, 'Manaus' , 'Avenida Mandi, 04-B');
    INSERT INTO cep VALUES(279 , 279 , '69.075-140');
    INSERT INTO endereco VALUES(279 , 279 , 'sn' , 'Avenida Mandi, 04-B');
    INSERT INTO cliente VALUES(279 , 279 , 1 , 'Ibis Manaus - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(279 , 279 , '09.967.852/0146-91' , 'Hotelaria Accor Brasil S/A' , 'Ibis Manaus - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(279 , 279 , 'Alexandre' , 0 , 'thiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(92) 2123-6152' , 'indefinido');
    INSERT INTO cidade VALUES(280, 16 , 'Maringá');
    INSERT INTO bairro VALUES(280 , 280, 'Maringá' , 'Avenida XV de Novembro, 129');
    INSERT INTO cep VALUES(280 , 280 , '87.013-230');
    INSERT INTO endereco VALUES(280 , 280 , 'sn' , 'Avenida XV de Novembro, 129');
    INSERT INTO cliente VALUES(280 , 280 , 1 , 'Ibis Maringá - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(280 , 280 , '09.967.852/0116-76' , 'Hotelaria Accor Brasil S/A' , 'Ibis Maringá - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(280 , 280 , 'Francisca' , 0 , 'h3732-gl@accor.com.br' , '(44) 3027 9200' , 'indefinido');
    INSERT INTO cidade VALUES(281, 13 , 'Montes Claros');
    INSERT INTO bairro VALUES(281 , 281, 'Montes Claros' , 'Avenida Donato Quintino, 130');
    INSERT INTO cep VALUES(281 , 281 , '39.400-546');
    INSERT INTO endereco VALUES(281 , 281 , 'sn' , 'Avenida Donato Quintino, 130');
    INSERT INTO cliente VALUES(281 , 281 , 1 , 'Ibis Montes Claros - Sucesso Administração e Participação Hoteleira S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(281 , 281 , '11.824.567/0002-80' , 'Sucesso Administração e Participação Hoteleira S/A' , 'Ibis Montes Claros - Sucesso Administração e Participação Hoteleira S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(281 , 281 , '' , 0 , 'h7840-gm@accor.com.br,h7840-gl@accor.com.br' , '(38) 2101-9050 / 9062' , 'indefinido');
    INSERT INTO cidade VALUES(282, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(282 , 282, 'São Paulo' , 'Avenida Roque Petroni Junior, 800 - Torre I');
    INSERT INTO cep VALUES(282 , 282 , '04.707-000');
    INSERT INTO endereco VALUES(282 , 282 , 'sn' , 'Avenida Roque Petroni Junior, 800 - Torre I');
    INSERT INTO cliente VALUES(282 , 282 , 1 , 'Ibis Morumbi - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(282 , 282 , '09.967.852/0152-30' , 'Hotelaria Accor Brasil S/A' , 'Ibis Morumbi - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(282 , 282 , '' , 0 , 'h5532-gl3@accor.com.br,h5532-gm@accor.com.br,h5532-dm@accor.com.br,h5532-dm1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(283, 20 , 'Mossoró');
    INSERT INTO bairro VALUES(283 , 283, 'Mossoró' , 'Rua Manoel Hemeterio, 10');
    INSERT INTO cep VALUES(283 , 283 , '59.631-020');
    INSERT INTO endereco VALUES(283 , 283 , 'sn' , 'Rua Manoel Hemeterio, 10');
    INSERT INTO cliente VALUES(283 , 283 , 1 , 'Ibis Mossoró - Larego Empreendimentos Hoteleiros Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(283 , 283 , '07.602.960/0002-51' , 'Larego Empreendimentos Hoteleiros Ltda' , 'Ibis Mossoró - Larego Empreendimentos Hoteleiros Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(283 , 283 , '' , 0 , 'h6517-gl@accor.com.br,h6517-gl1@accor.com.br' , '(84) 3422-6422 / 3317-3879' , 'indefinido');
    INSERT INTO cidade VALUES(284, 24 , 'Itajaí');
    INSERT INTO bairro VALUES(284 , 284, 'Itajaí' , 'Rua Vereador  Abrahao Joao Francisco, 567');
    INSERT INTO cep VALUES(284 , 284 , '88.302-101');
    INSERT INTO endereco VALUES(284 , 284 , 'sn' , 'Rua Vereador  Abrahao Joao Francisco, 567');
    INSERT INTO cliente VALUES(284 , 284 , 1 , 'Ibis Navegantes Itajaí - ADH Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(284 , 284 , '06.015.748/0003-06' , 'ADH Hotelaria Ltda' , 'Ibis Navegantes Itajaí - ADH Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(284 , 284 , 'Nathani' , 0 , 'h6361-gl@accor.com.br' , '(47) 3249 6800' , 'indefinido');
    INSERT INTO cidade VALUES(285, 21 , 'Novo Hamburgo');
    INSERT INTO bairro VALUES(285 , 285, 'Novo Hamburgo' , 'Rua Jose do Patrocinio, 303');
    INSERT INTO cep VALUES(285 , 285 , '93.310-240');
    INSERT INTO endereco VALUES(285 , 285 , 'sn' , 'Rua Jose do Patrocinio, 303');
    INSERT INTO cliente VALUES(285 , 285 , 1 , 'Ibis Novo Hamburgo - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(285 , 285 , '80.732.928/0016-86' , 'Atrio Hotéis S/A' , 'Ibis Novo Hamburgo - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(285 , 285 , '' , 0 , 'h8175-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(286, 25 , 'Ourinhos');
    INSERT INTO bairro VALUES(286 , 286, 'Ourinhos' , 'Av Luiz Saldanha Rodrigues, 1800');
    INSERT INTO cep VALUES(286 , 286 , '19.907-510');
    INSERT INTO endereco VALUES(286 , 286 , 'sn' , 'Av Luiz Saldanha Rodrigues, 1800');
    INSERT INTO cliente VALUES(286 , 286 , 1 , 'Ibis Ourinhos - Castor Administração de Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(286 , 286 , '01.061.991/0002-66' , 'Castor Administração de Hotelaria Ltda' , 'Ibis Ourinhos - Castor Administração de Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(286 , 286 , '' , 0 , 'h7946-gl@accor.com.br,h7946-gm@accor.com.br,h7946-dm@accor.com.br' , '(14) 3512-2715 / 3512-2712 / 3512-2713' , 'indefinido');
    INSERT INTO cidade VALUES(287, 21 , 'Passo Fundo');
    INSERT INTO bairro VALUES(287 , 287, 'Passo Fundo' , 'Avenida Brasil, 610');
    INSERT INTO cep VALUES(287 , 287 , '99.010-001');
    INSERT INTO endereco VALUES(287 , 287 , 'sn' , 'Avenida Brasil, 610');
    INSERT INTO cliente VALUES(287 , 287 , 1 , 'Ibis Passo Fundo - Leto Administração de Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(287 , 287 , '15.930.180/0001-88' , 'Leto Administração de Hotelaria Ltda' , 'Ibis Passo Fundo - Leto Administração de Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(287 , 287 , '' , 0 , 'h7131-gl@accor.com.br' , '(54) 2104-4488 / 2104-4470' , 'indefinido');
    INSERT INTO cidade VALUES(288, 25 , 'Paulínia');
    INSERT INTO bairro VALUES(288 , 288, 'Paulínia' , 'Rua 31 de marco, 290');
    INSERT INTO cep VALUES(288 , 288 , '13.140-000');
    INSERT INTO endereco VALUES(288 , 288 , 'sn' , 'Rua 31 de marco, 290');
    INSERT INTO cliente VALUES(288 , 288 , 1 , 'Ibis Paulínia - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(288 , 288 , '09.967.852/0015-22' , 'Hotelaria Accor Brasil S/A' , 'Ibis Paulínia - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(288 , 288 , 'Suzemar' , 0 , 'h3054-gl@accor.com.br' , '(19) 3833-7161' , 'indefinido');
    INSERT INTO cidade VALUES(289, 17 , 'Petrolina');
    INSERT INTO bairro VALUES(289 , 289, 'Petrolina' , 'Avenida Tancredo Neves, 1049');
    INSERT INTO cep VALUES(289 , 289 , '56.304-190');
    INSERT INTO endereco VALUES(289 , 289 , 'sn' , 'Avenida Tancredo Neves, 1049');
    INSERT INTO cliente VALUES(289 , 289 , 1 , 'Ibis Petrolina - Condominio Hotel de Petrolina' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(289 , 289 , '13.367.555/0001-18' , 'Condominio Hotel de Petrolina' , 'Ibis Petrolina - Condominio Hotel de Petrolina' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(289 , 289 , 'Italla Raquel' , 0 , 'h6520-gl@accor.com.br' , '(87) 3202-2200' , 'indefinido');
    INSERT INTO cidade VALUES(290, 25 , 'Piracicaba');
    INSERT INTO bairro VALUES(290 , 290, 'Piracicaba' , 'Rua Armando Dedini, 125');
    INSERT INTO cep VALUES(290 , 290 , '13.414-018');
    INSERT INTO endereco VALUES(290 , 290 , 'sn' , 'Rua Armando Dedini, 125');
    INSERT INTO cliente VALUES(290 , 290 , 1 , 'Ibis Piracicaba - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(290 , 290 , '09.967.852/0139-62' , 'Hotelaria Accor Brasil S/A' , 'Ibis Piracicaba - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(290 , 290 , '' , 0 , 'h3263-gl@accor.com.br,h3263-gm@accor.com.br,h3263-dm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(291, 13 , 'Poços de Caldas');
    INSERT INTO bairro VALUES(291 , 291, 'Poços de Caldas' , 'Rua Junqueiras, 520');
    INSERT INTO cep VALUES(291 , 291 , '37.701-033');
    INSERT INTO endereco VALUES(291 , 291 , 'sn' , 'Rua Junqueiras, 520');
    INSERT INTO cliente VALUES(291 , 291 , 1 , 'Ibis Poços de Caldas - LOB Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(291 , 291 , '10.201.371/0001-95' , 'LOB Hotelaria Ltda' , 'Ibis Poços de Caldas - LOB Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(291 , 291 , 'Andressa' , 0 , 'h6969-gl@accor.com.br' , '(35) 3066-6650' , 'indefinido');
    INSERT INTO cidade VALUES(292, 21 , 'Porto Alegre');
    INSERT INTO bairro VALUES(292 , 292, 'Porto Alegre' , 'Avenida das Industrias, 1342');
    INSERT INTO cep VALUES(292 , 292 , '90.200-290');
    INSERT INTO endereco VALUES(292 , 292 , 'sn' , 'Avenida das Industrias, 1342');
    INSERT INTO cliente VALUES(292 , 292 , 1 , 'Ibis Porto Alegre Aeroporto - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(292 , 292 , '80.732.928/0004-42' , 'Atrio Hotéis S/A' , 'Ibis Porto Alegre Aeroporto - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(292 , 292 , '' , 0 , 'h5670-gl@accor.com.br' , '(51) 3018 1800 / 3018 1801' , 'indefinido');
    INSERT INTO cidade VALUES(293, 21 , 'Porto Alegre');
    INSERT INTO bairro VALUES(293 , 293, 'Porto Alegre' , 'Rua Marques do Herval, 540');
    INSERT INTO cep VALUES(293 , 293 , '90.570-140');
    INSERT INTO endereco VALUES(293 , 293 , 'sn' , 'Rua Marques do Herval, 540');
    INSERT INTO cliente VALUES(293 , 293 , 1 , 'Ibis Porto Alegre Moinhos de Vento - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(293 , 293 , '80.732.928/0012-52' , 'Atrio Hotéis S/A' , 'Ibis Porto Alegre Moinhos de Vento - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(293 , 293 , '' , 0 , 'h6664-gl@accor.com.br,h6664-gm@accor.com.br' , '(51) 2112 2772 / 2112 2773' , 'indefinido');
    INSERT INTO cidade VALUES(294, 25 , 'Presidente Prudente');
    INSERT INTO bairro VALUES(294 , 294, 'Presidente Prudente' , 'Avenida Manoel Goulart, 2070');
    INSERT INTO cep VALUES(294 , 294 , '19.015-241');
    INSERT INTO endereco VALUES(294 , 294 , 'sn' , 'Avenida Manoel Goulart, 2070');
    INSERT INTO cliente VALUES(294 , 294 , 1 , 'Ibis Presidente Prudente - Hotel Prudentão Ltda ME ' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(294 , 294 , '15.541.789/0001-65' , 'Hotel Prudentão Ltda ME ' , 'Ibis Presidente Prudente - Hotel Prudentão Ltda ME ' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(294 , 294 , 'Michele' , 0 , 'h7135-gl@accor.com.br' , '(18) 3355 6363 / 3355 6364' , 'indefinido');
    INSERT INTO cidade VALUES(295, 17 , 'Recife');
    INSERT INTO bairro VALUES(295 , 295, 'Recife' , 'Av Engenheiro Domingos Ferreira, 683');
    INSERT INTO cep VALUES(295 , 295 , '51.011-051');
    INSERT INTO endereco VALUES(295 , 295 , 'sn' , 'Av Engenheiro Domingos Ferreira, 683');
    INSERT INTO cliente VALUES(295 , 295 , 1 , 'Ibis Recife - SVC Hoteis Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(295 , 295 , '17.217.599/0001-12' , 'SVC Hoteis Ltda' , 'Ibis Recife - SVC Hoteis Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(295 , 295 , 'Flavio' , 0 , 'h6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(81) 3334-3434' , 'indefinido');
    INSERT INTO cidade VALUES(296, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(296 , 296, 'Ribeirão Preto' , 'Avenida Braz Olaia Acosta, 691 - Torre A');
    INSERT INTO cep VALUES(296 , 296 , '14.026-040');
    INSERT INTO endereco VALUES(296 , 296 , 'sn' , 'Avenida Braz Olaia Acosta, 691 - Torre A');
    INSERT INTO cliente VALUES(296 , 296 , 1 , 'Ibis Ribeirão Preto - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(296 , 296 , '09.967.852/0100-09' , 'Hotelaria Accor Brasil S/A' , 'Ibis Ribeirão Preto - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(296 , 296 , 'Juliana' , 0 , 'h3261-gl@accor.com.br,h3261-gm@accor.com.br' , '(16) 2101-2950' , 'indefinido');
    INSERT INTO cidade VALUES(297, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(297 , 297, 'Rio de Janeiro' , 'Rua Silva Jardim, 32 - Torre I');
    INSERT INTO cep VALUES(297 , 297 , '20.050-060');
    INSERT INTO endereco VALUES(297 , 297 , 'sn' , 'Rua Silva Jardim, 32 - Torre I');
    INSERT INTO cliente VALUES(297 , 297 , 1 , 'Ibis Rio de Janeiro Centro - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(297 , 297 , '09.967.852/0143-49' , 'Hotelaria Accor Brasil S/A' , 'Ibis Rio de Janeiro Centro - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(297 , 297 , 'Claudio' , 0 , 'h5534-gl2@accor.com.br' , '(21) 3511 8228' , 'indefinido');
    INSERT INTO cidade VALUES(298, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(298 , 298, 'Rio de Janeiro' , 'Avenida Marechal Camara, 280');
    INSERT INTO cep VALUES(298 , 298 , '20.020-080');
    INSERT INTO endereco VALUES(298 , 298 , 'sn' , 'Avenida Marechal Camara, 280');
    INSERT INTO cliente VALUES(298 , 298 , 1 , 'Ibis Rio de Janeiro Santos Dumont - Santos Dumont Investimentos Imobiliarios S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(298 , 298 , '08.881.090/0002-60' , 'Santos Dumont Investimentos Imobiliarios S/A' , 'Ibis Rio de Janeiro Santos Dumont - Santos Dumont Investimentos Imobiliarios S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(298 , 298 , '' , 0 , 'h5691-dm@accor.com.br,h5691-gl@accor.com.br,H5691-gl2@accor.com.br' , '(21) 3506-4500' , 'indefinido');
    INSERT INTO cidade VALUES(299, 5 , 'Salvador');
    INSERT INTO bairro VALUES(299 , 299, 'Salvador' , 'Avenida Luís Viana, 13145 - Torre I');
    INSERT INTO cep VALUES(299 , 299 , '41.500-300');
    INSERT INTO endereco VALUES(299 , 299 , 'sn' , 'Avenida Luís Viana, 13145 - Torre I');
    INSERT INTO cliente VALUES(299 , 299 , 1 , 'Ibis Salvador Aeroporto Hangar - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(299 , 299 , '09.967.852/0172-83' , 'Hotelaria Accor Brasil S/A' , 'Ibis Salvador Aeroporto Hangar - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(299 , 299 , '' , 0 , 'h8181-dm@accor.com.br, h8181-gl@accor.com.br,h8181-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(300, 5 , 'Salvador');
    INSERT INTO bairro VALUES(300 , 300, 'Salvador' , 'Rua Fonte do Boi, 215');
    INSERT INTO cep VALUES(300 , 300 , '41.940-360');
    INSERT INTO endereco VALUES(300 , 300 , 'sn' , 'Rua Fonte do Boi, 215');
    INSERT INTO cliente VALUES(300 , 300 , 1 , 'Ibis Salvador Rio Vermelho - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(300 , 300 , '09.967.852/0111-61' , 'Hotelaria Accor Brasil S/A' , 'Ibis Salvador Rio Vermelho - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(300 , 300 , 'Rebeca' , 0 , 'h5173-gm@accor.com.br,h5173-gl1@accor.com.br' , '(71) 3172-4121' , 'indefinido');
    INSERT INTO cidade VALUES(301, 25 , 'Santo André');
    INSERT INTO bairro VALUES(301 , 301, 'Santo André' , 'Avenida Industrial, 885');
    INSERT INTO cep VALUES(301 , 301 , '09.080-510');
    INSERT INTO endereco VALUES(301 , 301 , 'sn' , 'Avenida Industrial, 885');
    INSERT INTO cliente VALUES(301 , 301 , 1 , 'Ibis Santo André - P1 Administração em Complexos Imobiliários Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(301 , 301 , '00.205.375/0005-11' , 'P1 Administração em Complexos Imobiliários Ltda' , 'Ibis Santo André - P1 Administração em Complexos Imobiliários Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(301 , 301 , '' , 0 , 'h5672-gl@accor.com.br' , '(11) 4979 7800 / 4979 7801' , 'indefinido');
    INSERT INTO cidade VALUES(302, 15 , 'Brejo dos Santos');
    INSERT INTO bairro VALUES(302 , 302, 'Brejo dos Santos' , 'Avenida Vicente de Carvalho, 50 - Torre II');
    INSERT INTO cep VALUES(302 , 302 , '11.045-500');
    INSERT INTO endereco VALUES(302 , 302 , 'sn' , 'Avenida Vicente de Carvalho, 50 - Torre II');
    INSERT INTO cliente VALUES(302 , 302 , 1 , 'Ibis Santos - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(302 , 302 , '09.967.852/0122-14' , 'Hotelaria Accor Brasil S/A' , 'Ibis Santos - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(302 , 302 , '' , 0 , 'h5530-gl@accor.com.br' , '(13) 2127 1676 / 2127 1661' , 'indefinido');
    INSERT INTO cidade VALUES(303, 24 , 'São Carlos');
    INSERT INTO bairro VALUES(303 , 303, 'São Carlos' , 'Avenida Passeio dos Ipes, 140');
    INSERT INTO cep VALUES(303 , 303 , '13.561-385');
    INSERT INTO endereco VALUES(303 , 303 , 'sn' , 'Avenida Passeio dos Ipes, 140');
    INSERT INTO cliente VALUES(303 , 303 , 1 , 'Ibis São Carlos - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(303 , 303 , '09.967.852/0140-04' , 'Hotelaria Accor Brasil S/A' , 'Ibis São Carlos - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(303 , 303 , '' , 0 , 'h3264-gl@accor.com.br,h3264-dm@accor.com.br,h3264-gm@accor.com.br' , '(16) 2106 6500 / 2106 6505' , 'indefinido');
    INSERT INTO cidade VALUES(304, 24 , 'São José');
    INSERT INTO bairro VALUES(304 , 304, 'São José' , 'Rua Domingos Andre Zanini, 333');
    INSERT INTO cep VALUES(304 , 304 , '88.117-200');
    INSERT INTO endereco VALUES(304 , 304 , 'sn' , 'Rua Domingos Andre Zanini, 333');
    INSERT INTO cliente VALUES(304 , 304 , 1 , 'Ibis São José - ADH Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(304 , 304 , '06.015.748/0004-97' , 'ADH Hotelaria Ltda' , 'Ibis São José - ADH Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(304 , 304 , '' , 0 , 'h6667-gl@accor.com.br' , '(48) 3211 1200 / 3211 1201' , 'indefinido');
    INSERT INTO cidade VALUES(305, 25 , 'São José do Rio Preto');
    INSERT INTO bairro VALUES(305 , 305, 'São José do Rio Preto' , 'Avenida Arthur Nonato, 4193');
    INSERT INTO cep VALUES(305 , 305 , '15.090-040');
    INSERT INTO endereco VALUES(305 , 305 , 'sn' , 'Avenida Arthur Nonato, 4193');
    INSERT INTO cliente VALUES(305 , 305 , 1 , 'Ibis São José do Rio Preto - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(305 , 305 , '09.967.852/0144-20' , 'Hotelaria Accor Brasil S/A' , 'Ibis São José do Rio Preto - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(305 , 305 , 'Daniela' , 0 , 'h3265-gl@accor.com.br' , '(17) 3216-9407' , 'indefinido');
    INSERT INTO cidade VALUES(306, 25 , 'São José dos Campos');
    INSERT INTO bairro VALUES(306 , 306, 'São José dos Campos' , 'Avenida Dr Jorge Zarur, 81 - Torre I');
    INSERT INTO cep VALUES(306 , 306 , '12.243-081');
    INSERT INTO endereco VALUES(306 , 306 , 'sn' , 'Avenida Dr Jorge Zarur, 81 - Torre I');
    INSERT INTO cliente VALUES(306 , 306 , 1 , 'Ibis São José dos Campos Colinas - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(306 , 306 , '09.967.852/0133-77' , 'Hotelaria Accor Brasil S/A' , 'Ibis São José dos Campos Colinas - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(306 , 306 , 'Bertilia' , 0 , 'h6035-gl@accor.com.br,h6035-gm@accor.com.br' , '(12) 3904 2400' , 'indefinido');
    INSERT INTO cidade VALUES(307, 25 , 'São José dos Campos');
    INSERT INTO bairro VALUES(307 , 307, 'São José dos Campos' , 'Avenida Cidade Jardim, 101');
    INSERT INTO cep VALUES(307 , 307 , '12.231-675');
    INSERT INTO endereco VALUES(307 , 307 , 'sn' , 'Avenida Cidade Jardim, 101');
    INSERT INTO cliente VALUES(307 , 307 , 1 , 'Ibis São José dos Campos Dutra - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(307 , 307 , '09.967.852/0018-75' , 'Hotelaria Accor Brasil S/A' , 'Ibis São José dos Campos Dutra - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(307 , 307 , '' , 0 , 'h3118-gl@accor.com.br' , '(12) 2139 5950 / 2139 5955' , 'indefinido');
    INSERT INTO cidade VALUES(308, 10 , 'São Luís');
    INSERT INTO bairro VALUES(308 , 308, 'São Luís' , 'Avenida dos Holandeses, 13 - Loteamento Sao Marcos');
    INSERT INTO cep VALUES(308 , 308 , '65.075-650');
    INSERT INTO endereco VALUES(308 , 308 , 'sn' , 'Avenida dos Holandeses, 13 - Loteamento Sao Marcos');
    INSERT INTO cliente VALUES(308 , 308 , 1 , 'Ibis São Luis - Windows Hotéis e Turismo Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(308 , 308 , '09.456.657/0002-13' , 'Windows Hotéis e Turismo Ltda' , 'Ibis São Luis - Windows Hotéis e Turismo Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(308 , 308 , '' , 0 , 'h7200-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(309, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(309 , 309, 'São Paulo' , 'Avenida Interlagos, 2215');
    INSERT INTO cep VALUES(309 , 309 , '04.661-200');
    INSERT INTO endereco VALUES(309 , 309 , 'sn' , 'Avenida Interlagos, 2215');
    INSERT INTO cliente VALUES(309 , 309 , 1 , 'Ibis São Paulo Interlagos - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(309 , 309 , '09.967.852/0119-19' , 'Hotelaria Accor Brasil S/A' , 'Ibis São Paulo Interlagos - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(309 , 309 , '' , 0 , 'h5471-gl@accor.com.br,h5471-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(310, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(310 , 310, 'São Paulo' , 'Avenida Paulista, 236');
    INSERT INTO cep VALUES(310 , 310 , '01.311-300');
    INSERT INTO endereco VALUES(310 , 310 , 'sn' , 'Avenida Paulista, 236');
    INSERT INTO cliente VALUES(310 , 310 , 1 , 'Ibis São Paulo Paulista Bela Vista - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(310 , 310 , '09.967.852/0108-66' , 'Hotelaria Accor Brasil S/A' , 'Ibis São Paulo Paulista Bela Vista - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(310 , 310 , 'Alessandra' , 0 , 'h3735-gl1@accor.com.br,h3735-dm@accor.com.br' , '(11) 3523-3013' , 'indefinido');
    INSERT INTO cidade VALUES(311, 25 , 'Sertãozinho');
    INSERT INTO bairro VALUES(311 , 311, 'Sertãozinho' , 'Rua Fioravante Sicchieri, 45');
    INSERT INTO cep VALUES(311 , 311 , '14.170-560');
    INSERT INTO endereco VALUES(311 , 311 , 'sn' , 'Rua Fioravante Sicchieri, 45');
    INSERT INTO cliente VALUES(311 , 311 , 1 , 'Ibis Sertãozinho - His Hotéis e Condomínios Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(311 , 311 , '15.487.471/0001-43' , 'His Hotéis e Condomínios Ltda' , 'Ibis Sertãozinho - His Hotéis e Condomínios Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(311 , 311 , 'Giuliano' , 0 , 'h7436-gm@accor.com.br' , '(16) 2105-9191' , 'indefinido');
    INSERT INTO cidade VALUES(312, 25 , 'Sorocaba');
    INSERT INTO bairro VALUES(312 , 312, 'Sorocaba' , 'Rua Maria Aparecida Pessotti Milego, 290');
    INSERT INTO cep VALUES(312 , 312 , '18.048-140');
    INSERT INTO endereco VALUES(312 , 312 , 'sn' , 'Rua Maria Aparecida Pessotti Milego, 290');
    INSERT INTO cliente VALUES(312 , 312 , 1 , 'Ibis Sorocaba - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(312 , 312 , '09.967.852/0011-07' , 'Hotelaria Accor Brasil S/A' , 'Ibis Sorocaba - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(312 , 312 , '' , 0 , 'h2907-gl@accor.com.br,h2907-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(313, 25 , 'Barueri');
    INSERT INTO bairro VALUES(313 , 313, 'Barueri' , 'Avenida Marcos Penteado de Ulhoa Rodrigues, 1111');
    INSERT INTO cep VALUES(313 , 313 , '06.460-040');
    INSERT INTO endereco VALUES(313 , 313 , 'sn' , 'Avenida Marcos Penteado de Ulhoa Rodrigues, 1111');
    INSERT INTO cliente VALUES(313 , 313 , 1 , 'Ibis Tamboré - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(313 , 313 , '09.967.852/0131-05' , 'Hotelaria Accor Brasil S/A' , 'Ibis Tamboré - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(313 , 313 , '' , 0 , 'h5520-te@accor.com.br,h3255-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(314, 25 , 'Taubaté');
    INSERT INTO bairro VALUES(314 , 314, 'Taubaté' , 'Avenida Independencia, 18');
    INSERT INTO cep VALUES(314 , 314 , '12.031-000');
    INSERT INTO endereco VALUES(314 , 314 , 'sn' , 'Avenida Independencia, 18');
    INSERT INTO cliente VALUES(314 , 314 , 1 , 'Ibis Taubaté - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(314 , 314 , '09.967.852/0126-48' , 'Hotelaria Accor Brasil S/A' , 'Ibis Taubaté - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(314 , 314 , '' , 0 , 'h3262-gl@accor.com.br' , 'Tel: (11)4208-9707' , 'indefinido');
    INSERT INTO cidade VALUES(315, 18 , 'Teresina');
    INSERT INTO bairro VALUES(315 , 315, 'Teresina' , 'Rua 1º de Maio, 450');
    INSERT INTO cep VALUES(315 , 315 , '64.001-430');
    INSERT INTO endereco VALUES(315 , 315 , 'sn' , 'Rua 1º de Maio, 450');
    INSERT INTO cliente VALUES(315 , 315 , 1 , 'Ibis Teresina - Boa Vista Hotel Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(315 , 315 , '01.687.173/0001-92' , 'Boa Vista Hotel Ltda' , 'Ibis Teresina - Boa Vista Hotel Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(315 , 315 , '' , 0 , 'h5031-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(316, 13 , 'Uberlândia');
    INSERT INTO bairro VALUES(316 , 316, 'Uberlândia' , 'Rua Joao Naves de Avila, 1590A');
    INSERT INTO cep VALUES(316 , 316 , '38.408-100');
    INSERT INTO endereco VALUES(316 , 316 , 'sn' , 'Rua Joao Naves de Avila, 1590A');
    INSERT INTO cliente VALUES(316 , 316 , 1 , 'Ibis Uberlândia - Hotel Apollo Ltda EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(316 , 316 , '38.648.135/0002-11' , 'Hotel Apollo Ltda EPP' , 'Ibis Uberlândia - Hotel Apollo Ltda EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(316 , 316 , 'Adriana' , 0 , 'h6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(34) 3253-7700' , 'indefinido');
    INSERT INTO cidade VALUES(317, 16 , 'Porto Vitória');
    INSERT INTO bairro VALUES(317 , 317, 'Porto Vitória' , 'Av Dante Michelini, 791');
    INSERT INTO cep VALUES(317 , 317 , '29.060-235');
    INSERT INTO endereco VALUES(317 , 317 , 'sn' , 'Av Dante Michelini, 791');
    INSERT INTO cliente VALUES(317 , 317 , 1 , 'Ibis Vitória Praia de Camburi - UP Asset adminsitração Hoteleira Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(317 , 317 , '16.993.309/0001-60' , 'UP Asset adminsitração Hoteleira Ltda' , 'Ibis Vitória Praia de Camburi - UP Asset adminsitração Hoteleira Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(317 , 317 , '' , 0 , 'h7437-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(318, 16 , 'Porto Vitória');
    INSERT INTO bairro VALUES(318 , 318, 'Porto Vitória' , 'Rua Joao da Cruz, 385');
    INSERT INTO cep VALUES(318 , 318 , '29.055-620');
    INSERT INTO endereco VALUES(318 , 318 , 'sn' , 'Rua Joao da Cruz, 385');
    INSERT INTO cliente VALUES(318 , 318 , 1 , 'Ibis Vitória Praia do Canto - Ilha Vitória Adminstração Hoteleira Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(318 , 318 , '04.837.505/0001-66' , 'Ilha Vitória Adminstração Hoteleira Ltda' , 'Ibis Vitória Praia do Canto - Ilha Vitória Adminstração Hoteleira Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(318 , 318 , '' , 0 , 'h5223-gl1@accor.com.br,h5223-dm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(319, 16 , 'Porto Vitória');
    INSERT INTO bairro VALUES(319 , 319, 'Porto Vitória' , 'Rodovia BR 101 Norte Km 2, s/nº');
    INSERT INTO cep VALUES(319 , 319 , '29.161-793');
    INSERT INTO endereco VALUES(319 , 319 , 'sn' , 'Rodovia BR 101 Norte Km 2, s/nº');
    INSERT INTO cliente VALUES(319 , 319 , 1 , 'Ibis Vitória Serra Aeroporto - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(319 , 319 , '09.967.852/0151-59' , 'Hotelaria Accor Brasil S/A' , 'Ibis Vitória Serra Aeroporto - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(319 , 319 , '' , 0 , 'h5528-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(320, 25 , 'Bragança Paulista');
    INSERT INTO bairro VALUES(320 , 320, 'Bragança Paulista' , 'Rua Coronel Teófilo Leme, 1360');
    INSERT INTO cep VALUES(320 , 320 , '12.900-002');
    INSERT INTO endereco VALUES(320 , 320 , 'sn' , 'Rua Coronel Teófilo Leme, 1360');
    INSERT INTO cliente VALUES(320 , 320 , 1 , 'Jerram Bragança - Jula Comércio de Roupas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(320 , 320 , '02.198.485/0001-03' , 'Jula Comércio de Roupas Ltda.' , 'Jerram Bragança - Jula Comércio de Roupas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(320 , 320 , 'Elaine' , 0 , 'elaine.oliveira@lojasjerram.com.brloja24@tennisexpress.com.brvivian1110@gmail.comleonidas@redeoba.com.br,marcos.bruno@redeoba.com.br,charles.moreira@redeoba.com.brh6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 2473-3336' , 'indefinido');
    INSERT INTO cidade VALUES(321, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(321 , 321, 'São Paulo' , '(11) 3222-5922');
    INSERT INTO cep VALUES(321 , 321 , '01122-011');
    INSERT INTO endereco VALUES(321 , 321 , 'sn' , '(11) 3222-5922');
    INSERT INTO cliente VALUES(321 , 321 , 1 , 'Jo Fashion - Jo Fashion Eireli EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(321 , 321 , '11.851.943/0001-44' , 'Jo Fashion Eireli EPP' , 'Jo Fashion - Jo Fashion Eireli EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(321 , 321 , 'Deise' , 0 , 'lucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 3222-5922' , 'indefinido');
    INSERT INTO cidade VALUES(322, 21 , 'Igrejinha');
    INSERT INTO bairro VALUES(322 , 322, 'Igrejinha' , 'Rua 7 de Julho, 416');
    INSERT INTO cep VALUES(322 , 322 , '95.650-000');
    INSERT INTO endereco VALUES(322 , 322 , 'sn' , 'Rua 7 de Julho, 416');
    INSERT INTO cliente VALUES(322 , 322 , 1 , 'Jorge Bischoff - Natalia Luisa Bischoff' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(322 , 322 , '08.960.572/0001-24' , 'Natalia Luisa Bischoff' , 'Jorge Bischoff - Natalia Luisa Bischoff' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(322 , 322 , 'Camila' , 0 , 'camila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(51) 3549-9300' , 'indefinido');
    INSERT INTO cidade VALUES(323, 25 , 'Santos');
    INSERT INTO bairro VALUES(323 , 323, 'Santos' , 'Rua João Pessoa, 40');
    INSERT INTO cep VALUES(323 , 323 , '11.013-000');
    INSERT INTO endereco VALUES(323 , 323 , 'sn' , 'Rua João Pessoa, 40');
    INSERT INTO cliente VALUES(323 , 323 , 1 , 'Kallan 01 - FAJ Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(323 , 323 , '08.390.027/0003-01' , 'FAJ Comercial de Calçados Ltda.' , 'Kallan 01 - FAJ Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(323 , 323 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(324, 25 , 'Mauá');
    INSERT INTO bairro VALUES(324 , 324, 'Mauá' , 'Avenida Barão de Mauá, 275');
    INSERT INTO cep VALUES(324 , 324 , '09.310-000');
    INSERT INTO endereco VALUES(324 , 324 , 'sn' , 'Avenida Barão de Mauá, 275');
    INSERT INTO cliente VALUES(324 , 324 , 1 , 'Kallan 02 - RJF Comércio de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(324 , 324 , '08.382.561/0003-76' , 'RJF Comércio de Calçados Ltda.' , 'Kallan 02 - RJF Comércio de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(324 , 324 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(325, 25 , 'Santos');
    INSERT INTO bairro VALUES(325 , 325, 'Santos' , 'Rua Alexandre Martins, 80 - LJ 246 E 247');
    INSERT INTO cep VALUES(325 , 325 , '11.025-200');
    INSERT INTO endereco VALUES(325 , 325 , 'sn' , 'Rua Alexandre Martins, 80 - LJ 246 E 247');
    INSERT INTO cliente VALUES(325 , 325 , 1 , 'Kallan 03 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(325 , 325 , '08.385.154/0003-12' , 'JCR Comércio de Calçados e Acessórios Ltda.' , 'Kallan 03 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(325 , 325 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(326, 25 , 'São Bernardo do Campo');
    INSERT INTO bairro VALUES(326 , 326, 'São Bernardo do Campo' , 'Rua Marechal Deodoro, 1419');
    INSERT INTO cep VALUES(326 , 326 , '09.710-012');
    INSERT INTO endereco VALUES(326 , 326 , 'sn' , 'Rua Marechal Deodoro, 1419');
    INSERT INTO cliente VALUES(326 , 326 , 1 , 'Kallan 05 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(326 , 326 , '08.385.154/0002-31' , 'JCR Comércio de Calçados e Acessórios Ltda.' , 'Kallan 05 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(326 , 326 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(327, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(327 , 327, 'São Paulo' , 'Praça Ramos de Azevedo, 219');
    INSERT INTO cep VALUES(327 , 327 , '01.037-010');
    INSERT INTO endereco VALUES(327 , 327 , 'sn' , 'Praça Ramos de Azevedo, 219');
    INSERT INTO cliente VALUES(327 , 327 , 1 , 'Kallan 06 - Kallan Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(327 , 327 , '51.540.219/0001-14' , 'Kallan Modas Ltda.' , 'Kallan 06 - Kallan Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(327 , 327 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(328, 25 , 'São Vicente');
    INSERT INTO bairro VALUES(328 , 328, 'São Vicente' , 'Rua Martim Afonso, 426');
    INSERT INTO cep VALUES(328 , 328 , '11.310-010');
    INSERT INTO endereco VALUES(328 , 328 , 'sn' , 'Rua Martim Afonso, 426');
    INSERT INTO cliente VALUES(328 , 328 , 1 , 'Kallan 09 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(328 , 328 , '08.382.542/0003-40' , 'RAJ Comércio de Calçados e Acessórios Ltda.' , 'Kallan 09 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(328 , 328 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(329, 25 , 'São Bernardo do Campo');
    INSERT INTO bairro VALUES(329 , 329, 'São Bernardo do Campo' , 'Rua Marechal Deodoro, 1144');
    INSERT INTO cep VALUES(329 , 329 , '09.710-002');
    INSERT INTO endereco VALUES(329 , 329 , 'sn' , 'Rua Marechal Deodoro, 1144');
    INSERT INTO cliente VALUES(329 , 329 , 1 , 'Kallan 11 - RJF Comércio de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(329 , 329 , '08.382.561/0001-04' , 'RJF Comércio de Calçados Ltda.' , 'Kallan 11 - RJF Comércio de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(329 , 329 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(330, 25 , 'Santos');
    INSERT INTO bairro VALUES(330 , 330, 'Santos' , 'Avenida Marechal Floriano Peixoto, 17 - 19');
    INSERT INTO cep VALUES(330 , 330 , '11.060-300');
    INSERT INTO endereco VALUES(330 , 330 , 'sn' , 'Avenida Marechal Floriano Peixoto, 17 - 19');
    INSERT INTO cliente VALUES(330 , 330 , 1 , 'Kallan 12 - CJA Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(330 , 330 , '08.389.167/0001-06' , 'CJA Calçados Ltda.' , 'Kallan 12 - CJA Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(330 , 330 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(331, 25 , 'Santo André');
    INSERT INTO bairro VALUES(331 , 331, 'Santo André' , 'Rua Senador Fláquer, 312 - 316');
    INSERT INTO cep VALUES(331 , 331 , '09.010-160');
    INSERT INTO endereco VALUES(331 , 331 , 'sn' , 'Rua Senador Fláquer, 312 - 316');
    INSERT INTO cliente VALUES(331 , 331 , 1 , 'Kallan 13 - Kallan Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(331 , 331 , '51.540.219/0016-09' , 'Kallan Modas Ltda.' , 'Kallan 13 - Kallan Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(331 , 331 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(332, 25 , 'Guarujá');
    INSERT INTO bairro VALUES(332 , 332, 'Guarujá' , 'Avenida Thiago Ferreira, 366');
    INSERT INTO cep VALUES(332 , 332 , '11.450-001');
    INSERT INTO endereco VALUES(332 , 332 , 'sn' , 'Avenida Thiago Ferreira, 366');
    INSERT INTO cliente VALUES(332 , 332 , 1 , 'Kallan 14 - FAJ Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(332 , 332 , '08.390.027/0002-20' , 'FAJ Comercial de Calçados Ltda.' , 'Kallan 14 - FAJ Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(332 , 332 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(333, 24 , 'Praia Grande');
    INSERT INTO bairro VALUES(333 , 333, 'Praia Grande' , 'Avenida Ayrton Senna da Silva, 1511 - LJ 80 a 83');
    INSERT INTO cep VALUES(333 , 333 , '11.726-000');
    INSERT INTO endereco VALUES(333 , 333 , 'sn' , 'Avenida Ayrton Senna da Silva, 1511 - LJ 80 a 83');
    INSERT INTO cliente VALUES(333 , 333 , 1 , 'Kallan 15 - AFK Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(333 , 333 , '07.589.772/0001-50' , 'AFK Calçados Ltda.' , 'Kallan 15 - AFK Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(333 , 333 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(334, 25 , 'Santo André');
    INSERT INTO bairro VALUES(334 , 334, 'Santo André' , 'Avenida Industrial, 600');
    INSERT INTO cep VALUES(334 , 334 , '09.080-500');
    INSERT INTO endereco VALUES(334 , 334 , 'sn' , 'Avenida Industrial, 600');
    INSERT INTO cliente VALUES(334 , 334 , 1 , 'Kallan 16 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(334 , 334 , '08.382.542/0001-88' , 'RAJ Comércio de Calçados e Acessórios Ltda.' , 'Kallan 16 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(334 , 334 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(335, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(335 , 335, 'São Paulo' , 'Avenida Mateo Bei, 3437');
    INSERT INTO cep VALUES(335 , 335 , '03.949-013');
    INSERT INTO endereco VALUES(335 , 335 , 'sn' , 'Avenida Mateo Bei, 3437');
    INSERT INTO cliente VALUES(335 , 335 , 1 , 'Kallan 17 - AFK Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(335 , 335 , '07.589.772/0002-30' , 'AFK Calçados Ltda.' , 'Kallan 17 - AFK Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(335 , 335 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(336, 25 , 'Cubatão');
    INSERT INTO bairro VALUES(336 , 336, 'Cubatão' , 'Avenida Nove de Abril, 2060');
    INSERT INTO cep VALUES(336 , 336 , '11.520-000');
    INSERT INTO endereco VALUES(336 , 336 , 'sn' , 'Avenida Nove de Abril, 2060');
    INSERT INTO cliente VALUES(336 , 336 , 1 , 'Kallan 18 - RJF Comércio de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(336 , 336 , '08.382.561/0002-95' , 'RJF Comércio de Calçados Ltda.' , 'Kallan 18 - RJF Comércio de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(336 , 336 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(337, 25 , 'Diadema');
    INSERT INTO bairro VALUES(337 , 337, 'Diadema' , 'Avenida Antônio Piranga, 50');
    INSERT INTO cep VALUES(337 , 337 , '09.911-160');
    INSERT INTO endereco VALUES(337 , 337 , 'sn' , 'Avenida Antônio Piranga, 50');
    INSERT INTO cliente VALUES(337 , 337 , 1 , 'Kallan 19 - Kallan Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(337 , 337 , '51.540.219/0026-72' , 'Kallan Modas Ltda.' , 'Kallan 19 - Kallan Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(337 , 337 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(338, 25 , 'Registro');
    INSERT INTO bairro VALUES(338 , 338, 'Registro' , 'Av. Pref. Jonas Banks Leite, 699');
    INSERT INTO cep VALUES(338 , 338 , '11.900-000');
    INSERT INTO endereco VALUES(338 , 338 , 'sn' , 'Av. Pref. Jonas Banks Leite, 699');
    INSERT INTO cliente VALUES(338 , 338 , 1 , 'Kallan 22 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(338 , 338 , '08.382.542/0002-69' , 'RAJ Comércio de Calçados e Acessórios Ltda.' , 'Kallan 22 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(338 , 338 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(339, 25 , 'São José dos Campos');
    INSERT INTO bairro VALUES(339 , 339, 'São José dos Campos' , 'Rua Sete de Setembro, 215 - 223');
    INSERT INTO cep VALUES(339 , 339 , '12.210-260');
    INSERT INTO endereco VALUES(339 , 339 , 'sn' , 'Rua Sete de Setembro, 215 - 223');
    INSERT INTO cliente VALUES(339 , 339 , 1 , 'Kallan 23 - FAJ Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(339 , 339 , '08.390.027/0001-40' , 'FAJ Comercial de Calçados Ltda.' , 'Kallan 23 - FAJ Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(339 , 339 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(340, 25 , 'Jacareí');
    INSERT INTO bairro VALUES(340 , 340, 'Jacareí' , 'Rua Sargento Acrísio Santana, 61');
    INSERT INTO cep VALUES(340 , 340 , '12.327-320');
    INSERT INTO endereco VALUES(340 , 340 , 'sn' , 'Rua Sargento Acrísio Santana, 61');
    INSERT INTO cliente VALUES(340 , 340 , 1 , 'Kallan 24 - Kallan Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(340 , 340 , '51.540.219/0032-10' , 'Kallan Modas Ltda.' , 'Kallan 24 - Kallan Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(340 , 340 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(341, 25 , 'São Vicente');
    INSERT INTO bairro VALUES(341 , 341, 'São Vicente' , 'Rua Frei Gaspar, 365');
    INSERT INTO cep VALUES(341 , 341 , '11.310-060');
    INSERT INTO endereco VALUES(341 , 341 , 'sn' , 'Rua Frei Gaspar, 365');
    INSERT INTO cliente VALUES(341 , 341 , 1 , 'Kallan 25 - Kallan Modas Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(341 , 341 , '51.540.219/0033-00' , 'Kallan Modas Ltda.' , 'Kallan 25 - Kallan Modas Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(341 , 341 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(342, 24 , 'Praia Grande');
    INSERT INTO bairro VALUES(342 , 342, 'Praia Grande' , 'Avenida Presidente Costa e Silva, 374');
    INSERT INTO cep VALUES(342 , 342 , '11.700-005');
    INSERT INTO endereco VALUES(342 , 342 , 'sn' , 'Avenida Presidente Costa e Silva, 374');
    INSERT INTO cliente VALUES(342 , 342 , 1 , 'Kallan 27 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(342 , 342 , '08.385.154/0004-01' , 'JCR Comércio de Calçados e Acessórios Ltda.' , 'Kallan 27 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(342 , 342 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(343, 25 , 'Peruíbe');
    INSERT INTO bairro VALUES(343 , 343, 'Peruíbe' , 'Avenida Padre Anchieta, 1246');
    INSERT INTO cep VALUES(343 , 343 , '11.750-000');
    INSERT INTO endereco VALUES(343 , 343 , 'sn' , 'Avenida Padre Anchieta, 1246');
    INSERT INTO cliente VALUES(343 , 343 , 1 , 'Kallan 28 - CJA Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(343 , 343 , '08.389.167/0004-40' , 'CJA Calçados Ltda.' , 'Kallan 28 - CJA Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(343 , 343 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(344, 25 , 'Guarujá');
    INSERT INTO bairro VALUES(344 , 344, 'Guarujá' , 'Avenida Puglisi, 260 - Loja 02');
    INSERT INTO cep VALUES(344 , 344 , '11.410-000');
    INSERT INTO endereco VALUES(344 , 344 , 'sn' , 'Avenida Puglisi, 260 - Loja 02');
    INSERT INTO cliente VALUES(344 , 344 , 1 , 'Kallan 29 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(344 , 344 , '08.382.542/0005-01' , 'RAJ Comércio de Calçados e Acessórios Ltda.' , 'Kallan 29 - RAJ Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(344 , 344 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(345, 25 , 'Diadema');
    INSERT INTO bairro VALUES(345 , 345, 'Diadema' , 'Rua Manoel da Nóbrega (Prq S Setembro), 712 - Piso Araucária');
    INSERT INTO cep VALUES(345 , 345 , '09.910-720');
    INSERT INTO endereco VALUES(345 , 345 , 'sn' , 'Rua Manoel da Nóbrega (Prq S Setembro), 712 - Piso Araucária');
    INSERT INTO cliente VALUES(345 , 345 , 1 , 'Kallan 30 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(345 , 345 , '08.385.154/0005-84' , 'JCR Comércio de Calçados e Acessórios Ltda.' , 'Kallan 30 - JCR Comércio de Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(345 , 345 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(346, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(346 , 346, 'São Paulo' , 'Praça do Patriarca, 09');
    INSERT INTO cep VALUES(346 , 346 , '01.002-010');
    INSERT INTO endereco VALUES(346 , 346 , 'sn' , 'Praça do Patriarca, 09');
    INSERT INTO cliente VALUES(346 , 346 , 1 , 'Kallan 31 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(346 , 346 , '11.693.598/0001-68' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 31 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(346 , 346 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(347, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(347 , 347, 'São Paulo' , 'Estrada do Campo Limpo, 459 - Piso Itapecerica');
    INSERT INTO cep VALUES(347 , 347 , '05.777-001');
    INSERT INTO endereco VALUES(347 , 347 , 'sn' , 'Estrada do Campo Limpo, 459 - Piso Itapecerica');
    INSERT INTO cliente VALUES(347 , 347 , 1 , 'Kallan 32 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(347 , 347 , '11.693.598/0002-49' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 32 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(347 , 347 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(348, 25 , 'Barueri');
    INSERT INTO bairro VALUES(348 , 348, 'Barueri' , 'Rua General de Divisão de Pedro Rodrigues da Silva, 400 - PISO 2 - LOJAS 2021/2022');
    INSERT INTO cep VALUES(348 , 348 , '06.440-180');
    INSERT INTO endereco VALUES(348 , 348 , 'sn' , 'Rua General de Divisão de Pedro Rodrigues da Silva, 400 - PISO 2 - LOJAS 2021/2022');
    INSERT INTO cliente VALUES(348 , 348 , 1 , 'Kallan 33 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(348 , 348 , '11.693.598/0003-20' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 33 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(348 , 348 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(349, 25 , 'São Bernardo do Campo');
    INSERT INTO bairro VALUES(349 , 349, 'São Bernardo do Campo' , 'Avenida Albert Schweitzer, 256 - LCC - PISO L1');
    INSERT INTO cep VALUES(349 , 349 , '09.790-000');
    INSERT INTO endereco VALUES(349 , 349 , 'sn' , 'Avenida Albert Schweitzer, 256 - LCC - PISO L1');
    INSERT INTO cliente VALUES(349 , 349 , 1 , 'Kallan 34 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(349 , 349 , '11.693.598/0004-00' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 34 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(349 , 349 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(350, 24 , 'Praia Grande');
    INSERT INTO bairro VALUES(350 , 350, 'Praia Grande' , 'Avenida Presidente Kennedy, 7254 - LJ 2, LOTE 1 E 2, QDA 12 LOTEAM JD ANHANGUERA');
    INSERT INTO cep VALUES(350 , 350 , '11.704-100');
    INSERT INTO endereco VALUES(350 , 350 , 'sn' , 'Avenida Presidente Kennedy, 7254 - LJ 2, LOTE 1 E 2, QDA 12 LOTEAM JD ANHANGUERA');
    INSERT INTO cliente VALUES(350 , 350 , 1 , 'Kallan 35 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(350 , 350 , '11.693.598/0006-72' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 35 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(350 , 350 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(351, 25 , 'Guarulhos');
    INSERT INTO bairro VALUES(351 , 351, 'Guarulhos' , 'Rua Dom Pedro II, 272 - ESQUINA COM A PC. CONS.CRISPINIANO 266');
    INSERT INTO cep VALUES(351 , 351 , '07.011-003');
    INSERT INTO endereco VALUES(351 , 351 , 'sn' , 'Rua Dom Pedro II, 272 - ESQUINA COM A PC. CONS.CRISPINIANO 266');
    INSERT INTO cliente VALUES(351 , 351 , 1 , 'Kallan 36 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(351 , 351 , '11.693.598/0008-34' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 36 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(351 , 351 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(352, 25 , 'Mongaguá');
    INSERT INTO bairro VALUES(352 , 352, 'Mongaguá' , 'Avenida Marina, 555');
    INSERT INTO cep VALUES(352 , 352 , '11.730-000');
    INSERT INTO endereco VALUES(352 , 352 , 'sn' , 'Avenida Marina, 555');
    INSERT INTO cliente VALUES(352 , 352 , 1 , 'Kallan 38 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(352 , 352 , '11.693.598/0007-53' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 38 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(352 , 352 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(353, 25 , 'Ribeirão Pires');
    INSERT INTO bairro VALUES(353 , 353, 'Ribeirão Pires' , 'Rua Padre Marcos Simoni, 141');
    INSERT INTO cep VALUES(353 , 353 , '09.400-010');
    INSERT INTO endereco VALUES(353 , 353 , 'sn' , 'Rua Padre Marcos Simoni, 141');
    INSERT INTO cliente VALUES(353 , 353 , 1 , 'Kallan 39 - Rede Comercial de Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(353 , 353 , '11.693.598/0009-15' , 'Rede Comercial de Calçados Ltda.' , 'Kallan 39 - Rede Comercial de Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(353 , 353 , 'Jessica' , 0 , 'jessica.monteiro@kallan.com.br' , '(11) 3352-0600 R: 621' , 'indefinido');
    INSERT INTO cidade VALUES(354, 9 , 'Goiânia');
    INSERT INTO bairro VALUES(354 , 354, 'Goiânia' , 'Avenida Deputado Jamel Cecílio, 3300 - Shopping Flamboyant');
    INSERT INTO cep VALUES(354 , 354 , '74810-100');
    INSERT INTO endereco VALUES(354 , 354 , 'sn' , 'Avenida Deputado Jamel Cecílio, 3300 - Shopping Flamboyant');
    INSERT INTO cliente VALUES(354 , 354 , 1 , 'Kanpai Blue - Kanpai Restaurantes ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(354 , 354 , '17.061.838/0001-98' , 'Kanpai Restaurantes ltda.' , 'Kanpai Blue - Kanpai Restaurantes ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(354 , 354 , 'Vivian' , 0 , 'vivian1110@gmail.comleonidas@redeoba.com.br,marcos.bruno@redeoba.com.br,charles.moreira@redeoba.com.brh6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(62) 9971-6658' , 'indefinido');
    INSERT INTO cidade VALUES(355, 19 , 'Niterói');
    INSERT INTO bairro VALUES(355 , 355, 'Niterói' , 'Avenida Visconde do Rio Branco, 511');
    INSERT INTO cep VALUES(355 , 355 , '24.020-004');
    INSERT INTO endereco VALUES(355 , 355 , 'sn' , 'Avenida Visconde do Rio Branco, 511');
    INSERT INTO cliente VALUES(355 , 355 , 1 , 'Leader - União de Lojas Leader S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(355 , 355 , '30.094.114/0001-09' , 'União de Lojas Leader S/A' , 'Leader - União de Lojas Leader S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(355 , 355 , '' , 0 , 'lslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(356, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(356 , 356, 'São Paulo' , 'Rua Oscar Freire, 2379');
    INSERT INTO cep VALUES(356 , 356 , '05409-012');
    INSERT INTO endereco VALUES(356 , 356 , 'sn' , 'Rua Oscar Freire, 2379');
    INSERT INTO cliente VALUES(356 , 356 , 1 , 'Levis (9 lojas) - Levis Strauss do Brasil Ind. E Com. Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(356 , 356 , '43.351.097/0013-23' , 'Levis Strauss do Brasil Ind. E Com. Ltda.' , 'Levis (9 lojas) - Levis Strauss do Brasil Ind. E Com. Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(356 , 356 , 'Paulo Forster' , 0 , 'rfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 3066-3758' , 'indefinido');
    INSERT INTO cidade VALUES(357, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(357 , 357, 'São Paulo' , 'Rua Antônio Raposo, 186 - Cj 103');
    INSERT INTO cep VALUES(357 , 357 , '05.074-020');
    INSERT INTO endereco VALUES(357 , 357 , 'sn' , 'Rua Antônio Raposo, 186 - Cj 103');
    INSERT INTO cliente VALUES(357 , 357 , 1 , 'Levis (5 Lojas - Vide Obs) - New Castle Comercial Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(357 , 357 , '05.069.343/0001-26' , 'New Castle Comercial Eireli' , 'Levis (5 Lojas - Vide Obs) - New Castle Comercial Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(357 , 357 , '' , 0 , 'luiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(358, 7 , 'Brasília');
    INSERT INTO bairro VALUES(358 , 358, 'Brasília' , 'Setor SDN ( de Diversões Norte), T136');
    INSERT INTO cep VALUES(358 , 358 , '70.077-000');
    INSERT INTO endereco VALUES(358 , 358 , 'sn' , 'Setor SDN ( de Diversões Norte), T136');
    INSERT INTO cliente VALUES(358 , 358 , 1 , 'Levis Brasília - Nex Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(358 , 358 , '04.482.821/0001-62' , 'Nex Comercial Ltda.' , 'Levis Brasília - Nex Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(358 , 358 , 'Lais' , 0 , 'levis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(359, 7 , 'Brasília');
    INSERT INTO bairro VALUES(359 , 359, 'Brasília' , 'SMAS Área 6580, 6580 - Loja 149');
    INSERT INTO cep VALUES(359 , 359 , '71.219-900');
    INSERT INTO endereco VALUES(359 , 359 , 'sn' , 'SMAS Área 6580, 6580 - Loja 149');
    INSERT INTO cliente VALUES(359 , 359 , 1 , 'Levis Brasilia Park - Alta Comércio de Vestuário Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(359 , 359 , '06.351.400/0001-28' , 'Alta Comércio de Vestuário Ltda.' , 'Levis Brasilia Park - Alta Comércio de Vestuário Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(359 , 359 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(360, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(360 , 360, 'Campo Grande' , 'Avenida Afonso Pena, 4909');
    INSERT INTO cep VALUES(360 , 360 , '79.031-900');
    INSERT INTO endereco VALUES(360 , 360 , 'sn' , 'Avenida Afonso Pena, 4909');
    INSERT INTO cliente VALUES(360 , 360 , 1 , 'Levis Campo Grande - Deanna Wirmola Barbosa' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(360 , 360 , '05.527.497/0001-14' , 'Deanna Wirmola Barbosa' , 'Levis Campo Grande - Deanna Wirmola Barbosa' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(360 , 360 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(361, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(361 , 361, 'Cuiabá' , 'Avenida Historiador Rubens de Mendonça, 3300 - Loja 2012-2013');
    INSERT INTO cep VALUES(361 , 361 , '78.050-250');
    INSERT INTO endereco VALUES(361 , 361 , 'sn' , 'Avenida Historiador Rubens de Mendonça, 3300 - Loja 2012-2013');
    INSERT INTO cliente VALUES(361 , 361 , 1 , 'Levis Cuiabá - Pazzotti Comércio de Vestuário Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(361 , 361 , '10.386.694/0001-09' , 'Pazzotti Comércio de Vestuário Ltda.' , 'Levis Cuiabá - Pazzotti Comércio de Vestuário Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(361 , 361 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(362, 25 , 'Campinas');
    INSERT INTO bairro VALUES(362 , 362, 'Campinas' , 'Avenida Iguatemi, 777 - Loja 16-2 1o piso');
    INSERT INTO cep VALUES(362 , 362 , '13.092-902');
    INSERT INTO endereco VALUES(362 , 362 , 'sn' , 'Avenida Iguatemi, 777 - Loja 16-2 1o piso');
    INSERT INTO cliente VALUES(362 , 362 , 1 , 'Levis Iguatemi Campinas - Demi Vendas Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(362 , 362 , '03.382.088/0001-41' , 'Demi Vendas Comercial Ltda.' , 'Levis Iguatemi Campinas - Demi Vendas Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(362 , 362 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(363, 25 , 'Santos');
    INSERT INTO bairro VALUES(363 , 363, 'Santos' , 'Avenida Marechal Floriano Peixoto, 42 - Lj. 83/84');
    INSERT INTO cep VALUES(363 , 363 , '11.060-300');
    INSERT INTO endereco VALUES(363 , 363 , 'sn' , 'Avenida Marechal Floriano Peixoto, 42 - Lj. 83/84');
    INSERT INTO cliente VALUES(363 , 363 , 1 , 'Levis Santos - Miramar Straus Ltda EPP.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(363 , 363 , '04.837.155/0001-38' , 'Miramar Straus Ltda EPP.' , 'Levis Santos - Miramar Straus Ltda EPP.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(363 , 363 , '' , 0 , 'anara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(364, 25 , 'São José do Rio Preto');
    INSERT INTO bairro VALUES(364 , 364, 'São José do Rio Preto' , 'Avenida Brigadeiro Faria Lim, 6363 - Loja 214-215');
    INSERT INTO cep VALUES(364 , 364 , '15.090-900');
    INSERT INTO endereco VALUES(364 , 364 , 'sn' , 'Avenida Brigadeiro Faria Lim, 6363 - Loja 214-215');
    INSERT INTO cliente VALUES(364 , 364 , 1 , 'Levis São José do Rio Preto - No Rio Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(364 , 364 , '03.991.480/0001-98' , 'No Rio Comercial Ltda.' , 'Levis São José do Rio Preto - No Rio Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(364 , 364 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(365, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(365 , 365, 'Ribeirão Preto' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 162/163');
    INSERT INTO cep VALUES(365 , 365 , '14.026-900');
    INSERT INTO endereco VALUES(365 , 365 , 'sn' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 162/163');
    INSERT INTO cliente VALUES(365 , 365 , 1 , 'Levis Shopping Ribeirão - Black Creek Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(365 , 365 , '02.484.995/0001-39' , 'Black Creek Comercial Ltda.' , 'Levis Shopping Ribeirão - Black Creek Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(365 , 365 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(366, 13 , 'Uberlândia');
    INSERT INTO bairro VALUES(366 , 366, 'Uberlândia' , 'Vila Avenida João Naves de Ávila, 1331 - Loja 278');
    INSERT INTO cep VALUES(366 , 366 , '38.408-100');
    INSERT INTO endereco VALUES(366 , 366 , 'sn' , 'Vila Avenida João Naves de Ávila, 1331 - Loja 278');
    INSERT INTO cliente VALUES(366 , 366 , 1 , 'Levis Uberlândia - Uma Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(366 , 366 , '04.958.122/0001-46' , 'Uma Comercial Ltda.' , 'Levis Uberlândia - Uma Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(366 , 366 , 'Lais' , 0 , 'levis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(16) 3636 2401' , 'indefinido');
    INSERT INTO cidade VALUES(367, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(367 , 367, 'São Paulo' , 'Rua Mateus Grou - lado par, 412');
    INSERT INTO cep VALUES(367 , 367 , '05.415-040');
    INSERT INTO endereco VALUES(367 , 367 , 'sn' , 'Rua Mateus Grou - lado par, 412');
    INSERT INTO cliente VALUES(367 , 367 , 1 , 'Lita Mortari - Trem Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(367 , 367 , '52.067.212/0001-90' , 'Trem Confecções Ltda.' , 'Lita Mortari - Trem Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(367 , 367 , 'Marly' , 0 , 'heloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11)2713-5425' , 'indefinido');
    INSERT INTO cidade VALUES(368, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(368 , 368, 'Cuiabá' , 'Avenida Senador Metelo, 556');
    INSERT INTO cep VALUES(368 , 368 , '78.020-600');
    INSERT INTO endereco VALUES(368 , 368 , 'sn' , 'Avenida Senador Metelo, 556');
    INSERT INTO cliente VALUES(368 , 368 , 1 , 'Lojas Avenida / Giovanna - Lojas Avenida Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(368 , 368 , '00.819.201/0001-15' , 'Lojas Avenida Ltda.' , 'Lojas Avenida / Giovanna - Lojas Avenida Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(368 , 368 , 'Marcos/Paula' , 0 , 'mkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(65) 3316-8876' , 'indefinido');
    INSERT INTO cidade VALUES(369, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(369 , 369, 'São Paulo' , 'Rua Teodoro Sampaio, 2559');
    INSERT INTO cep VALUES(369 , 369 , '05.405-250');
    INSERT INTO endereco VALUES(369 , 369 , 'sn' , 'Rua Teodoro Sampaio, 2559');
    INSERT INTO cliente VALUES(369 , 369 , 1 , 'Lojas Eskala - Lojas Eskala Comércio de Tecidos e Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(369 , 369 , '45.067.147/0001-37' , 'Lojas Eskala Comércio de Tecidos e Confecções Ltda.' , 'Lojas Eskala - Lojas Eskala Comércio de Tecidos e Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(369 , 369 , '' , 0 , 'andre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(370, 19 , 'Magé');
    INSERT INTO bairro VALUES(370 , 370, 'Magé' , 'Avenida Santos Dumont, 18');
    INSERT INTO cep VALUES(370 , 370 , '25.915-000');
    INSERT INTO endereco VALUES(370 , 370 , 'sn' , 'Avenida Santos Dumont, 18');
    INSERT INTO cliente VALUES(370 , 370 , 1 , 'Lojas Nalin - LNG 10 Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(370 , 370 , '08.381.155/0002-08' , 'LNG 10 Confecções Ltda.' , 'Lojas Nalin - LNG 10 Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(370 , 370 , 'Larissa' , 0 , 'lalves@lojasnalin.com.br,kpires@lojasnalin.com.br' , '(21) 2633-9003' , 'indefinido');
    INSERT INTO cidade VALUES(371, 25 , 'Lins');
    INSERT INTO bairro VALUES(371 , 371, 'Lins' , 'Rua Floriano Peixoto, 1777');
    INSERT INTO cep VALUES(371 , 371 , '16.400-101');
    INSERT INTO endereco VALUES(371 , 371 , 'sn' , 'Rua Floriano Peixoto, 1777');
    INSERT INTO cliente VALUES(371 , 371 , 1 , 'Lojas Tanger - Lojas Tanger Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(371 , 371 , '51.663.763/0010-44' , 'Lojas Tanger Ltda.' , 'Lojas Tanger - Lojas Tanger Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(371 , 371 , 'Marilaine' , 0 , 'nfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(372, 21 , 'Igrejinha');
    INSERT INTO bairro VALUES(372 , 372, 'Igrejinha' , 'Rua 7 de Julho, 416');
    INSERT INTO cep VALUES(372 , 372 , '95650-000');
    INSERT INTO endereco VALUES(372 , 372 , 'sn' , 'Rua 7 de Julho, 416');
    INSERT INTO cliente VALUES(372 , 372 , 1 , 'Loucos & Santos - Bischoff Creative Group Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(372 , 372 , '08.960.572/0001-24' , 'Bischoff Creative Group Eireli' , 'Loucos & Santos - Bischoff Creative Group Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(372 , 372 , 'Susimara' , 0 , 'susimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(51) 3549-9300' , 'indefinido');
    INSERT INTO cidade VALUES(373, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(373 , 373, 'São Paulo' , 'Rua Xavantes, 715/719, 6º andar, sala 623');
    INSERT INTO cep VALUES(373 , 373 , '03027-000');
    INSERT INTO endereco VALUES(373 , 373 , 'sn' , 'Rua Xavantes, 715/719, 6º andar, sala 623');
    INSERT INTO cliente VALUES(373 , 373 , 1 , 'Magazine Torra Torra - Torra Torra Administração de Negócios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(373 , 373 , '14.874.300/0001-04' , 'Torra Torra Administração de Negócios Ltda.' , 'Magazine Torra Torra - Torra Torra Administração de Negócios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(373 , 373 , 'Luciana Galvão' , 0 , 'lucianagalvao@torratorra.com.br' , '(11) 2192-9999' , 'indefinido');
    INSERT INTO cidade VALUES(374, 7 , 'Brasília');
    INSERT INTO bairro VALUES(374 , 374, 'Brasília' , 'Av das Araucárias, 1525, loja 34/36');
    INSERT INTO cep VALUES(374 , 374 , '71936-250');
    INSERT INTO endereco VALUES(374 , 374 , 'sn' , 'Av das Araucárias, 1525, loja 34/36');
    INSERT INTO cliente VALUES(374 , 374 , 1 , 'Max Sushi Águas Claras - Restaurante Sushi Oriental Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(374 , 374 , '17.299.773/0001-13' , 'Restaurante Sushi Oriental Ltda.' , 'Max Sushi Águas Claras - Restaurante Sushi Oriental Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(374 , 374 , 'Bruno Borges' , 0 , 'maxsushiaguasclaras@gmail.com' , '(61) 8154-9873' , 'indefinido');
    INSERT INTO cidade VALUES(375, 9 , 'Goiânia');
    INSERT INTO bairro VALUES(375 , 375, 'Goiânia' , 'Avenida T 4, 1478 - Qd. 169-A Lt. 01E loja 4a');
    INSERT INTO cep VALUES(375 , 375 , '74.230-030');
    INSERT INTO endereco VALUES(375 , 375 , 'sn' , 'Avenida T 4, 1478 - Qd. 169-A Lt. 01E loja 4a');
    INSERT INTO cliente VALUES(375 , 375 , 1 , 'Max Sushi (T4) - Sushi Food Service Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(375 , 375 , '12.288.871/0001-31' , 'Sushi Food Service Ltda.' , 'Max Sushi (T4) - Sushi Food Service Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(375 , 375 , 'Renan' , 0 , 'absolut_t4@maxsushi.com.br' , '(62) 9616-0767/ 3932-2941' , 'indefinido');
    INSERT INTO cidade VALUES(376, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(376 , 376, 'São Paulo' , 'Av Roque Petroni Junior, n° 1087 – loja 209/210 – Shopping Morumbi');
    INSERT INTO cep VALUES(376 , 376 , '');
    INSERT INTO endereco VALUES(376 , 376 , 'sn' , 'Av Roque Petroni Junior, n° 1087 – loja 209/210 – Shopping Morumbi');
    INSERT INTO cliente VALUES(376 , 376 , 1 , 'Maxior Jóias - Orange Rock Artigos para Presentes Ltda. EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(376 , 376 , '18.837.055/0001-16' , 'Orange Rock Artigos para Presentes Ltda. EPP' , 'Maxior Jóias - Orange Rock Artigos para Presentes Ltda. EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(376 , 376 , 'Priscilla Tieko' , 0 , 'priscilla@americajoias.com.br,fernando@americajoias.com.br' , '3242-3524' , 'indefinido');
    INSERT INTO cidade VALUES(377, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(377 , 377, 'Campo Grande' , 'Rua Quatorze de Julho, 2285');
    INSERT INTO cep VALUES(377 , 377 , '79.002-331');
    INSERT INTO endereco VALUES(377 , 377 , 'sn' , 'Rua Quatorze de Julho, 2285');
    INSERT INTO cliente VALUES(377 , 377 , 1 , 'Mega Jeans - Zona Franca comércio de confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(377 , 377 , '01.313.250/0001-44' , 'Zona Franca comércio de confecções Ltda.' , 'Mega Jeans - Zona Franca comércio de confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(377 , 377 , '' , 0 , 'sac@megajeans.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(378, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(378 , 378, 'Campo Grande' , 'Rua Quatorze de Julho, 2132');
    INSERT INTO cep VALUES(378 , 378 , '79.002-331');
    INSERT INTO endereco VALUES(378 , 378 , 'sn' , 'Rua Quatorze de Julho, 2132');
    INSERT INTO cliente VALUES(378 , 378 , 1 , 'Mega Jeans - Formigheri e Cia Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(378 , 378 , '73.360.315/0001-13' , 'Formigheri e Cia Ltda.' , 'Mega Jeans - Formigheri e Cia Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(378 , 378 , '' , 0 , 'sac@megajeans.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(379, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(379 , 379, 'Campo Grande' , 'Rua Quatorze de Julho, 2137');
    INSERT INTO cep VALUES(379 , 379 , '79.002-331');
    INSERT INTO endereco VALUES(379 , 379 , 'sn' , 'Rua Quatorze de Julho, 2137');
    INSERT INTO cliente VALUES(379 , 379 , 1 , 'Mega Jeans (Atitude) - Atitude Comércio de confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(379 , 379 , '05.231.398/0001-90' , 'Atitude Comércio de confecções Ltda.' , 'Mega Jeans (Atitude) - Atitude Comércio de confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(379 , 379 , '' , 0 , 'sac@megajeans.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(380, 24 , 'Balneário Camboriú');
    INSERT INTO bairro VALUES(380 , 380, 'Balneário Camboriú' , 'Avenida Atlântica, 2010');
    INSERT INTO cep VALUES(380 , 380 , '88330-012');
    INSERT INTO endereco VALUES(380 , 380 , 'sn' , 'Avenida Atlântica, 2010');
    INSERT INTO cliente VALUES(380 , 380 , 1 , 'Mercure Balneário Camboriú - Pires Hotéis e Turismo Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(380 , 380 , '80.451.941/0002-61' , 'Pires Hotéis e Turismo Ltda.' , 'Mercure Balneário Camboriú - Pires Hotéis e Turismo Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(380 , 380 , 'Ana paula' , 0 , 'h6661-gm@accor.com.br,anapaula@hoteispires.com.br' , '(47) 3056-9500' , 'indefinido');
    INSERT INTO cidade VALUES(381, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(381 , 381, 'Rio de Janeiro' , 'Avenida do Pepê, 56');
    INSERT INTO cep VALUES(381 , 381 , '22.620-170');
    INSERT INTO endereco VALUES(381 , 381 , 'sn' , 'Avenida do Pepê, 56');
    INSERT INTO cliente VALUES(381 , 381 , 1 , 'Mercure Barra da Tijuca - Up Asset Pepê Hotel Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(381 , 381 , '18.638.738/0001-40' , 'Up Asset Pepê Hotel Ltda.' , 'Mercure Barra da Tijuca - Up Asset Pepê Hotel Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(381 , 381 , 'Karin Krug' , 0 , 'h8180-gl@accor.com.br,h8180-gm@accor.com.br' , '(11) 3818-6288' , 'indefinido');
    INSERT INTO cidade VALUES(382, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(382 , 382, 'Curitiba' , 'Rua Alferes Angelo Sampaio, 1177');
    INSERT INTO cep VALUES(382 , 382 , '80.250-120');
    INSERT INTO endereco VALUES(382 , 382 , 'sn' , 'Rua Alferes Angelo Sampaio, 1177');
    INSERT INTO cliente VALUES(382 , 382 , 1 , 'Mercure Batel - Tramandai Hotelaria Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(382 , 382 , '13.816.617/0001-21' , 'Tramandai Hotelaria Ltda' , 'Mercure Batel - Tramandai Hotelaria Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(382 , 382 , 'Daniel Kowara' , 0 , 'h2127-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(383, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(383 , 383, 'São Paulo' , 'Alameda Itu, 1151');
    INSERT INTO cep VALUES(383 , 383 , '01421-001');
    INSERT INTO endereco VALUES(383 , 383 , 'sn' , 'Alameda Itu, 1151');
    INSERT INTO cliente VALUES(383 , 383 , 1 , 'Mercure Jardins - Castor & Leão Administração Hoteleira S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(383 , 383 , '02.238.702/0002-14' , 'Castor & Leão Administração Hoteleira S/A' , 'Mercure Jardins - Castor & Leão Administração Hoteleira S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(383 , 383 , 'Alessander Souza' , 0 , 'h3467-gl@accor.com.br,h3467-gl1@accor.com.br,h3467-gl2@accor.com.br' , '(11) 3089-7555' , 'indefinido');
    INSERT INTO cidade VALUES(384, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(384 , 384, 'São Paulo' , 'Rua Funchal, 111');
    INSERT INTO cep VALUES(384 , 384 , '04.551-060');
    INSERT INTO endereco VALUES(384 , 384 , 'sn' , 'Rua Funchal, 111');
    INSERT INTO cliente VALUES(384 , 384 , 1 , 'Mercure SP Funchal - Hotelaria Accor Brasil S/A SCP Mercure SP Funchal' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(384 , 384 , '09.967.852/0094-26' , 'Hotelaria Accor Brasil S/A SCP Mercure SP Funchal' , 'Mercure SP Funchal - Hotelaria Accor Brasil S/A SCP Mercure SP Funchal' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(384 , 384 , 'Karina Veroneses' , 0 , 'h2128-gl@accor.com.br, h2128-gl1@accor.com.br' , '(11) 3046 3800' , 'indefinido');
    INSERT INTO cidade VALUES(385, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(385 , 385, 'São Paulo' , 'Rua Capote Valente, 500');
    INSERT INTO cep VALUES(385 , 385 , '05409-000');
    INSERT INTO endereco VALUES(385 , 385 , 'sn' , 'Rua Capote Valente, 500');
    INSERT INTO cliente VALUES(385 , 385 , 1 , 'Mercure SP Pinheiros - Hotelaria Accor Brasil S/A - SCP The Excellence Flat' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(385 , 385 , '09.967.852/0091-83' , 'Hotelaria Accor Brasil S/A - SCP The Excellence Flat' , 'Mercure SP Pinheiros - Hotelaria Accor Brasil S/A - SCP The Excellence Flat' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(385 , 385 , 'Luis' , 0 , 'h3147-gl3@accor.com.br' , '3069-4050' , 'indefinido');
    INSERT INTO cidade VALUES(386, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(386 , 386, 'São Paulo' , 'Av. Jamaris, 100 - Torre Mercure');
    INSERT INTO cep VALUES(386 , 386 , '04078-000');
    INSERT INTO endereco VALUES(386 , 386 , 'sn' , 'Av. Jamaris, 100 - Torre Mercure');
    INSERT INTO cliente VALUES(386 , 386 , 1 , 'Mercure SP Times Square - Hotelaria Accor Brasil S/A SCP Times Square' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(386 , 386 , '09.967.852/0075-63' , 'Hotelaria Accor Brasil S/A SCP Times Square' , 'Mercure SP Times Square - Hotelaria Accor Brasil S/A SCP Times Square' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(386 , 386 , 'Mariângela ou Claudio' , 0 , 'H3454-GL@accor.com.br,H3454-GL1@accor.com.br' , '(11) 5053-2566' , 'indefinido');
    INSERT INTO cidade VALUES(387, 26 , 'Aracaju');
    INSERT INTO bairro VALUES(387 , 387, 'Aracaju' , 'Avenida Santos Dumont, 1500');
    INSERT INTO cep VALUES(387 , 387 , '49.035-785');
    INSERT INTO endereco VALUES(387 , 387 , 'sn' , 'Avenida Santos Dumont, 1500');
    INSERT INTO cliente VALUES(387 , 387 , 1 , 'Mercure Aracaju - Cosil Hotéis e Turismo S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(387 , 387 , '13.355.060/0001-79' , 'Cosil Hotéis e Turismo S/A' , 'Mercure Aracaju - Cosil Hotéis e Turismo S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(387 , 387 , '' , 0 , 'h7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(388, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(388 , 388, 'Rio de Janeiro' , 'Rua Francisco Otaviano, 61');
    INSERT INTO cep VALUES(388 , 388 , '22.080-040');
    INSERT INTO endereco VALUES(388 , 388 , 'sn' , 'Rua Francisco Otaviano, 61');
    INSERT INTO cliente VALUES(388 , 388 , 1 , 'Mercure Arpoador - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(388 , 388 , '09.967.852/0113-23' , 'Hotelaria Accor Brasil S/A' , 'Mercure Arpoador - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(388 , 388 , '' , 0 , 'h5215-gl@accor.com.br, h5215-GL1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(389, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(389 , 389, 'São Paulo' , 'Rua Sansão Alves dos Santos, 373');
    INSERT INTO cep VALUES(389 , 389 , '04.571-090');
    INSERT INTO endereco VALUES(389 , 389 , 'sn' , 'Rua Sansão Alves dos Santos, 373');
    INSERT INTO cliente VALUES(389 , 389 , 1 , 'Mercure Berrini - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(389 , 389 , '09.967.852/0071-30' , 'Hotelaria Accor Brasil S/A' , 'Mercure Berrini - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(389 , 389 , '' , 0 , 'h3114-gl@accor.com.br, h3114-gl1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(390, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(390 , 390, 'Belo Horizonte' , 'Rua Cícero Ferreira, 10');
    INSERT INTO cep VALUES(390 , 390 , '30.220-040');
    INSERT INTO endereco VALUES(390 , 390 , 'sn' , 'Rua Cícero Ferreira, 10');
    INSERT INTO cliente VALUES(390 , 390 , 1 , 'Mercure BH Lifecenter - Hotelaria Accor Brasil S/A – SCP Lifecenter' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(390 , 390 , '09.967.852/0031-42' , 'Hotelaria Accor Brasil S/A – SCP Lifecenter' , 'Mercure BH Lifecenter - Hotelaria Accor Brasil S/A – SCP Lifecenter' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(390 , 390 , '' , 0 , 'h3050-gl@accor.com.br, h3050-gm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(391, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(391 , 391, 'Belo Horizonte' , 'Avenida do Contorno, 7315');
    INSERT INTO cep VALUES(391 , 391 , '30.110-047');
    INSERT INTO endereco VALUES(391 , 391 , 'sn' , 'Avenida do Contorno, 7315');
    INSERT INTO cliente VALUES(391 , 391 , 1 , 'Mercure BH Lourdes - Condomínio Edifício Líder Top Flat Service' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(391 , 391 , '04.347.624/0001-30' , 'Condomínio Edifício Líder Top Flat Service' , 'Mercure BH Lourdes - Condomínio Edifício Líder Top Flat Service' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(391 , 391 , '' , 0 , 'h3575-it@accor.com.br,h3575-gl5@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(392, 13 , 'Nova Lima');
    INSERT INTO bairro VALUES(392 , 392, 'Nova Lima' , 'Alameda da Serra, 405');
    INSERT INTO cep VALUES(392 , 392 , '34.000-000');
    INSERT INTO endereco VALUES(392 , 392 , 'sn' , 'Alameda da Serra, 405');
    INSERT INTO cliente VALUES(392 , 392 , 1 , 'Mercure BH Vila da Serra - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(392 , 392 , '09.967.852/0050-05' , 'Hotelaria Accor Brasil S/A' , 'Mercure BH Vila da Serra - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(392 , 392 , 'Erica' , 0 , 'h3625-gl1@accor.com.br, h3625-gl@accor.com.br' , '(31) 3079-4106' , 'indefinido');
    INSERT INTO cidade VALUES(393, 7 , 'Brasília');
    INSERT INTO bairro VALUES(393 , 393, 'Brasília' , 'Quadra SHN  5 Bloco I, sn');
    INSERT INTO cep VALUES(393 , 393 , '70.705-912');
    INSERT INTO endereco VALUES(393 , 393 , 'sn' , 'Quadra SHN  5 Bloco I, sn');
    INSERT INTO cliente VALUES(393 , 393 , 1 , 'Mercure Brasília Lider - Hotelaria Accor Brasil S/A SCP Líder Flat' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(393 , 393 , '09.967.852/0052-77' , 'Hotelaria Accor Brasil S/A SCP Líder Flat' , 'Mercure Brasília Lider - Hotelaria Accor Brasil S/A SCP Líder Flat' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(393 , 393 , '' , 0 , 'H3627-gl@accor.com.br, h3627-gl1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(394, 25 , 'Campinas');
    INSERT INTO bairro VALUES(394 , 394, 'Campinas' , 'Avenida Aquidaban, 400');
    INSERT INTO cep VALUES(394 , 394 , '13.026-510');
    INSERT INTO endereco VALUES(394 , 394 , 'sn' , 'Avenida Aquidaban, 400');
    INSERT INTO cliente VALUES(394 , 394 , 1 , 'Mercure Campinas - P1 Administração em Complexos Imobiliários Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(394 , 394 , '00.205.375/0003-50' , 'P1 Administração em Complexos Imobiliários Ltda' , 'Mercure Campinas - P1 Administração em Complexos Imobiliários Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(394 , 394 , '' , 0 , 'h5181-gl@accor.com.br,h5181-gl4@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(395, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(395 , 395, 'Belo Horizonte' , 'Avenida Luíz Paulo Franco, 421');
    INSERT INTO cep VALUES(395 , 395 , '30.320-570');
    INSERT INTO endereco VALUES(395 , 395 , 'sn' , 'Avenida Luíz Paulo Franco, 421');
    INSERT INTO cliente VALUES(395 , 395 , 1 , 'Mercure CB Belvedere - Hotelaria Accor Brasil PDB' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(395 , 395 , '02.419.765/0005-10' , 'Hotelaria Accor Brasil PDB' , 'Mercure CB Belvedere - Hotelaria Accor Brasil PDB' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(395 , 395 , 'Fabiola' , 0 , 'h8944-gl@accor.com.br, h8944-gl1@accor.com.br, h8944-gl3@accor.com.br' , '(31) 2123-9839' , 'indefinido');
    INSERT INTO cidade VALUES(396, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(396 , 396, 'São Paulo' , 'Rua Olimpíadas, 205');
    INSERT INTO cep VALUES(396 , 396 , '04.551-000');
    INSERT INTO endereco VALUES(396 , 396 , 'sn' , 'Rua Olimpíadas, 205');
    INSERT INTO cliente VALUES(396 , 396 , 1 , 'Mercure CB Faria Lima - CBB Faria Lima Administração Hoteleira e Comercial Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(396 , 396 , '06.172.269/0001-31' , 'CBB Faria Lima Administração Hoteleira e Comercial Ltda' , 'Mercure CB Faria Lima - CBB Faria Lima Administração Hoteleira e Comercial Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(396 , 396 , '' , 0 , 'H8938-gl6@accor.com.br, H8938-gl1@accor.com.br, H8938-dm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(397, 5 , 'Salvador');
    INSERT INTO bairro VALUES(397 , 397, 'Salvador' , 'Rua Des Alvaro Clemente de Oliveira, 296');
    INSERT INTO cep VALUES(397 , 397 , '41.810-720');
    INSERT INTO endereco VALUES(397 , 397 , 'sn' , 'Rua Des Alvaro Clemente de Oliveira, 296');
    INSERT INTO cliente VALUES(397 , 397 , 1 , 'Mercure CB Salvador Pituba - CBB Salvador Administração Hoteleira e Comercial Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(397 , 397 , '13.325.053/0001-24' , 'CBB Salvador Administração Hoteleira e Comercial Ltda.' , 'Mercure CB Salvador Pituba - CBB Salvador Administração Hoteleira e Comercial Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(397 , 397 , 'Merivania' , 0 , 'h8930-gl3@accor.com.br' , '(71) 3021-8105' , 'indefinido');
    INSERT INTO cidade VALUES(398, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(398 , 398, 'Curitiba' , 'Rua Emiliano Perneta, 747');
    INSERT INTO cep VALUES(398 , 398 , '80.420-080');
    INSERT INTO endereco VALUES(398 , 398 , 'sn' , 'Rua Emiliano Perneta, 747');
    INSERT INTO cliente VALUES(398 , 398 , 1 , 'Mercure Curitiba Centro - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(398 , 398 , '09.967.852/0141-87' , 'Hotelaria Accor Brasil S/A' , 'Mercure Curitiba Centro - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(398 , 398 , '' , 0 , 'admmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(399, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(399 , 399, 'Curitiba' , 'Rua Desembargador Motta, 2044');
    INSERT INTO cep VALUES(399 , 399 , '80.420-190');
    INSERT INTO endereco VALUES(399 , 399 , 'sn' , 'Rua Desembargador Motta, 2044');
    INSERT INTO cliente VALUES(399 , 399 , 1 , 'Mercure Curitiba Golden - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(399 , 399 , '09.967.852/0035-76' , 'Hotelaria Accor Brasil S/A' , 'Mercure Curitiba Golden - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(399 , 399 , '' , 0 , 'h0653-gl@accor.com.br' , '(41) 3322-7666' , 'indefinido');
    INSERT INTO cidade VALUES(400, 24 , 'Florianópolis');
    INSERT INTO bairro VALUES(400 , 400, 'Florianópolis' , 'R Admar Gonzaga, 600');
    INSERT INTO cep VALUES(400 , 400 , '88.034-000');
    INSERT INTO endereco VALUES(400 , 400 , 'sn' , 'R Admar Gonzaga, 600');
    INSERT INTO cliente VALUES(400 , 400 , 1 , 'Mercure Florianópolis Convention - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(400 , 400 , '09.967.852/0001-27' , 'Hotelaria Accor Brasil S/A' , 'Mercure Florianópolis Convention - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(400 , 400 , '' , 0 , 'h5693-gl@accor.com.br' , '(48) 3231-1700' , 'indefinido');
    INSERT INTO cidade VALUES(401, 6 , 'Fortaleza');
    INSERT INTO bairro VALUES(401 , 401, 'Fortaleza' , 'Rua Joaquim Nabuco, 166');
    INSERT INTO cep VALUES(401 , 401 , '60.125-120');
    INSERT INTO endereco VALUES(401 , 401 , 'sn' , 'Rua Joaquim Nabuco, 166');
    INSERT INTO cliente VALUES(401 , 401 , 1 , 'Mercure Fortaleza Meireles - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(401 , 401 , '09.967.852/0042-03' , 'Hotelaria Accor Brasil S/A' , 'Mercure Fortaleza Meireles - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(401 , 401 , '' , 0 , 'H3473-GL@accor.com.br, H3473-GL1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(402, 9 , 'Ap. de Goiânia');
    INSERT INTO bairro VALUES(402 , 402, 'Ap. de Goiânia' , 'Av Republica do Libano, 1613 - LT 1527');
    INSERT INTO cep VALUES(402 , 402 , '74.125-125');
    INSERT INTO endereco VALUES(402 , 402 , 'sn' , 'Av Republica do Libano, 1613 - LT 1527');
    INSERT INTO cliente VALUES(402 , 402 , 1 , 'Mercure Goiânia - Atrium Hotéis e Turismo Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(402 , 402 , '04.494.841/0002-34' , 'Atrium Hotéis e Turismo Ltda' , 'Mercure Goiânia - Atrium Hotéis e Turismo Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(402 , 402 , 'Fábio' , 0 , 'h7129-te@accor.com.br,h7129-gl@accor.com.br, h7129-gl6@accor.com.br' , '(62) 3605-7577' , 'indefinido');
    INSERT INTO cidade VALUES(403, 25 , 'Guarulhos');
    INSERT INTO bairro VALUES(403 , 403, 'Guarulhos' , 'Rua Barao de Maua, 450');
    INSERT INTO cep VALUES(403 , 403 , '07.012-040');
    INSERT INTO endereco VALUES(403 , 403 , 'sn' , 'Rua Barao de Maua, 450');
    INSERT INTO cliente VALUES(403 , 403 , 1 , 'Mercure Guarulhos Aeroporto - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(403 , 403 , '09.967.852/0098-50' , 'Hotelaria Accor Brasil S/A' , 'Mercure Guarulhos Aeroporto - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(403 , 403 , 'Bianca' , 0 , 'h3637-gl2@accor.com.br' , '(11) 2475-9983' , 'indefinido');
    INSERT INTO cidade VALUES(404, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(404 , 404, 'São Paulo' , 'Rua Sena Madureira, 1355 - Bloco II');
    INSERT INTO cep VALUES(404 , 404 , '04.021-051');
    INSERT INTO endereco VALUES(404 , 404 , 'sn' , 'Rua Sena Madureira, 1355 - Bloco II');
    INSERT INTO cliente VALUES(404 , 404 , 1 , 'Mercure Ibirapuera - Ibirapuera Park Hotel Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(404 , 404 , '53.355.004/0002-30' , 'Ibirapuera Park Hotel Ltda.' , 'Mercure Ibirapuera - Ibirapuera Park Hotel Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(404 , 404 , '' , 0 , 'h0578-gl2@accor.com.br, financeiro.mercuregrandibirapuera@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(405, 24 , 'Jaraguá do Sul');
    INSERT INTO bairro VALUES(405 , 405, 'Jaraguá do Sul' , 'Rua Pres. Epitácio Pessoa, 239');
    INSERT INTO cep VALUES(405 , 405 , '89.251-100');
    INSERT INTO endereco VALUES(405 , 405 , 'sn' , 'Rua Pres. Epitácio Pessoa, 239');
    INSERT INTO cliente VALUES(405 , 405 , 1 , 'Mercure Jaraguá do Sul - Atrio Hotéis S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(405 , 405 , '80.732.928/0002-80' , 'Atrio Hotéis S/A' , 'Mercure Jaraguá do Sul - Atrio Hotéis S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(405 , 405 , 'Bianca' , 0 , 'h3624-gl@accor.com.br' , '(47) 3372-5811' , 'indefinido');
    INSERT INTO cidade VALUES(406, 19 , 'Macaé');
    INSERT INTO bairro VALUES(406 , 406, 'Macaé' , 'Av Atlantica, 126');
    INSERT INTO cep VALUES(406 , 406 , '27.920-390');
    INSERT INTO endereco VALUES(406 , 406 , 'sn' , 'Av Atlantica, 126');
    INSERT INTO cliente VALUES(406 , 406 , 1 , 'Mercure Macaé - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(406 , 406 , '09.967.852/0147-72' , 'Hotelaria Accor Brasil S/A' , 'Mercure Macaé - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(406 , 406 , '' , 0 , 'h5647-gl@accor.com.br' , '(22) 2123-2400' , 'indefinido');
    INSERT INTO cidade VALUES(407, 2 , 'Maceió');
    INSERT INTO bairro VALUES(407 , 407, 'Maceió' , 'Avenida Doutor Antônio Gouveia, 627');
    INSERT INTO cep VALUES(407 , 407 , '57.030-170');
    INSERT INTO endereco VALUES(407 , 407 , 'sn' , 'Avenida Doutor Antônio Gouveia, 627');
    INSERT INTO cliente VALUES(407 , 407 , 1 , 'Mercure Maceió - Nova Empreendimentos Hoteleiros Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(407 , 407 , '08.364.485/0002-95' , 'Nova Empreendimentos Hoteleiros Ltda.' , 'Mercure Maceió - Nova Empreendimentos Hoteleiros Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(407 , 407 , '' , 0 , 'h6663-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(408, 4 , 'Manaus');
    INSERT INTO bairro VALUES(408 , 408, 'Manaus' , 'Avenida Mário Ypiranga, 1000');
    INSERT INTO cep VALUES(408 , 408 , '69.057-000');
    INSERT INTO endereco VALUES(408 , 408 , 'sn' , 'Avenida Mário Ypiranga, 1000');
    INSERT INTO cliente VALUES(408 , 408 , 1 , 'Mercure Manaus - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(408 , 408 , '09.967.852/0112-42' , 'Hotelaria Accor Brasil S/A' , 'Mercure Manaus - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(408 , 408 , 'Valdenora' , 0 , 'h5671-gl@accor.com.br' , '(92) 2101-1100' , 'indefinido');
    INSERT INTO cidade VALUES(409, 25 , 'Mogi das Cruzes');
    INSERT INTO bairro VALUES(409 , 409, 'Mogi das Cruzes' , 'Rua Duarte de Freitas, 35');
    INSERT INTO cep VALUES(409 , 409 , '08.780-240');
    INSERT INTO endereco VALUES(409 , 409 , 'sn' , 'Rua Duarte de Freitas, 35');
    INSERT INTO cliente VALUES(409 , 409 , 1 , 'Mercure Mogi das Cruzes - Hotelaria Accor Brasil S/A SCP Antares' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(409 , 409 , '09.967.852/0013-60' , 'Hotelaria Accor Brasil S/A SCP Antares' , 'Mercure Mogi das Cruzes - Hotelaria Accor Brasil S/A SCP Antares' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(409 , 409 , '' , 0 , 'h3441-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(410, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(410 , 410, 'São Paulo' , 'Rua Professor Manoelito de Ornellas, 104');
    INSERT INTO cep VALUES(410 , 410 , '04.719-040');
    INSERT INTO endereco VALUES(410 , 410 , 'sn' , 'Rua Professor Manoelito de Ornellas, 104');
    INSERT INTO cliente VALUES(410 , 410 , 1 , 'Mercure Nações Unidas - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(410 , 410 , '09.967.852/0068-34' , 'Hotelaria Accor Brasil S/A' , 'Mercure Nações Unidas - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(410 , 410 , 'Sandra' , 0 , 'h3135-gl@accor.com.br' , '(11) 5188-3856' , 'indefinido');
    INSERT INTO cidade VALUES(411, 17 , 'Recife');
    INSERT INTO bairro VALUES(411 , 411, 'Recife' , 'Rua dos Navegantes, 1706');
    INSERT INTO cep VALUES(411 , 411 , '51.020-010');
    INSERT INTO endereco VALUES(411 , 411 , 'sn' , 'Rua dos Navegantes, 1706');
    INSERT INTO cliente VALUES(411 , 411 , 1 , 'Mercure Navegantes - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(411 , 411 , '09.967.852/0053-58' , 'Hotelaria Accor Brasil S/A' , 'Mercure Navegantes - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(411 , 411 , 'Gustavo' , 0 , 'h2171-fo@accor.com.br, h2171-hr@accor.com.br' , '(81) 4009-1141' , 'indefinido');
    INSERT INTO cidade VALUES(412, 19 , 'Niterói');
    INSERT INTO bairro VALUES(412 , 412, 'Niterói' , 'Rua Engenheiro Roberto Velasco Cardoso, 321');
    INSERT INTO cep VALUES(412 , 412 , '24.210-375');
    INSERT INTO endereco VALUES(412 , 412 , 'sn' , 'Rua Engenheiro Roberto Velasco Cardoso, 321');
    INSERT INTO cliente VALUES(412 , 412 , 1 , 'Mercure Niterói Orizzonte - Hotelaria Accor Br. S/A – SCP Mercure Niteroi Orizzonte' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(412 , 412 , '09.967.852/0153-10' , 'Hotelaria Accor Br. S/A – SCP Mercure Niteroi Orizzonte' , 'Mercure Niterói Orizzonte - Hotelaria Accor Br. S/A – SCP Mercure Niteroi Orizzonte' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(412 , 412 , 'Sousa' , 0 , 'H6934-GL@accor.com.br, H6934-GL2@accor.com.br, h6934-re@accor.com.br' , '(21) 2707-5879' , 'indefinido');
    INSERT INTO cidade VALUES(413, 19 , 'Nova Iguaçu');
    INSERT INTO bairro VALUES(413 , 413, 'Nova Iguaçu' , 'Avenida Doutor Mário Guimarães, 520');
    INSERT INTO cep VALUES(413 , 413 , '26.255-230');
    INSERT INTO endereco VALUES(413 , 413 , 'sn' , 'Avenida Doutor Mário Guimarães, 520');
    INSERT INTO cliente VALUES(413 , 413 , 1 , 'Mercure Nova Iguaçu - Hotelaria Accor Brasil S/A - SCP Nova Iguaçu' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(413 , 413 , '09.967.852/0164-73' , 'Hotelaria Accor Brasil S/A - SCP Nova Iguaçu' , 'Mercure Nova Iguaçu - Hotelaria Accor Brasil S/A - SCP Nova Iguaçu' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(413 , 413 , 'Daniela' , 0 , 'h7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(21) 3257-8500' , 'indefinido');
    INSERT INTO cidade VALUES(414, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(414 , 414, 'São Paulo' , 'Rua Pamplona, 1315');
    INSERT INTO cep VALUES(414 , 414 , '01.405-002');
    INSERT INTO endereco VALUES(414 , 414 , 'sn' , 'Rua Pamplona, 1315');
    INSERT INTO cliente VALUES(414 , 414 , 1 , 'Mercure Pamplona - Castor Administração de Hotelaria S/C Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(414 , 414 , '01.061.991/0001-85' , 'Castor Administração de Hotelaria S/C Ltda' , 'Mercure Pamplona - Castor Administração de Hotelaria S/C Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(414 , 414 , '' , 0 , 'h6284-gl@accor.com.br,h6284-gl1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(415, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(415 , 415, 'São Paulo' , 'Rua Vergueiro, 1661');
    INSERT INTO cep VALUES(415 , 415 , '04.101-000');
    INSERT INTO endereco VALUES(415 , 415 , 'sn' , 'Rua Vergueiro, 1661');
    INSERT INTO cliente VALUES(415 , 415 , 1 , 'Mercure Paraíso - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(415 , 415 , '09.967.852/0072-10' , 'Hotelaria Accor Brasil S/A' , 'Mercure Paraíso - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(415 , 415 , '' , 0 , 'h3146-gl@accor.com.br, h3146-gl1@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(416, 21 , 'Porto Alegre');
    INSERT INTO bairro VALUES(416 , 416, 'Porto Alegre' , 'Rua Miguel Tostes, 30');
    INSERT INTO cep VALUES(416 , 416 , '90.430-060');
    INSERT INTO endereco VALUES(416 , 416 , 'sn' , 'Rua Miguel Tostes, 30');
    INSERT INTO cliente VALUES(416 , 416 , 1 , 'Mercure Porto Alegre Manhattan - Hotelaria Accor Brasil S/A SCP Manhattan' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(416 , 416 , '09.967.852/0055-10' , 'Hotelaria Accor Brasil S/A SCP Manhattan' , 'Mercure Porto Alegre Manhattan - Hotelaria Accor Brasil S/A SCP Manhattan' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(416 , 416 , '' , 0 , 'h3623-gm@accor.com.br,h3623-gl@accor.com.br,h3623-dm@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(417, 24 , 'Joinville');
    INSERT INTO bairro VALUES(417 , 417, 'Joinville' , 'Rua Otto Boehm, 525');
    INSERT INTO cep VALUES(417 , 417 , '89.201-700');
    INSERT INTO endereco VALUES(417 , 417 , 'sn' , 'Rua Otto Boehm, 525');
    INSERT INTO cliente VALUES(417 , 417 , 1 , 'Mercure Prinz Joinville - Condomínio do Edifício Prinz Suite Hotel' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(417 , 417 , '72.407.489/0001-21' , 'Condomínio do Edifício Prinz Suite Hotel' , 'Mercure Prinz Joinville - Condomínio do Edifício Prinz Suite Hotel' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(417 , 417 , '' , 0 , 'h0768-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(418, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(418 , 418, 'São Paulo' , 'Avenida Macuco, 579');
    INSERT INTO cep VALUES(418 , 418 , '04.523-001');
    INSERT INTO endereco VALUES(418 , 418 , 'sn' , 'Avenida Macuco, 579');
    INSERT INTO cliente VALUES(418 , 418 , 1 , 'Mercure Privilege - Hotelaria Accor Brasil S/A - SCP The Privilege' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(418 , 418 , '09.967.852/0087-05' , 'Hotelaria Accor Brasil S/A - SCP The Privilege' , 'Mercure Privilege - Hotelaria Accor Brasil S/A - SCP The Privilege' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(418 , 418 , '' , 0 , 'h3124-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(419, 17 , 'Recife');
    INSERT INTO bairro VALUES(419 , 419, 'Recife' , 'Rua Estado de Israel, 203');
    INSERT INTO cep VALUES(419 , 419 , '50.070-420');
    INSERT INTO endereco VALUES(419 , 419 , 'sn' , 'Rua Estado de Israel, 203');
    INSERT INTO cliente VALUES(419 , 419 , 1 , 'Mercure Recife Metrópolis - Hotelaria Accor Brasil S/A SCP Metrópolis' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(419 , 419 , '09.967.852/0096-98' , 'Hotelaria Accor Brasil S/A SCP Metrópolis' , 'Mercure Recife Metrópolis - Hotelaria Accor Brasil S/A SCP Metrópolis' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(419 , 419 , 'Sara' , 0 , 'h5019-gl@accor.com.br' , '(81) 3087-3700' , 'indefinido');
    INSERT INTO cidade VALUES(420, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(420 , 420, 'Rio de Janeiro' , 'Rua Sorocaba, 305');
    INSERT INTO cep VALUES(420 , 420 , '22.271-110');
    INSERT INTO endereco VALUES(420 , 420 , 'sn' , 'Rua Sorocaba, 305');
    INSERT INTO cliente VALUES(420 , 420 , 1 , 'Mercure RJ Botafogo - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(420 , 420 , '09.967.852/0125-67' , 'Hotelaria Accor Brasil S/A' , 'Mercure RJ Botafogo - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(420 , 420 , '' , 0 , 'h5629-gl@accor.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(421, 5 , 'Salvador');
    INSERT INTO bairro VALUES(421 , 421, 'Salvador' , 'Rua Ewerton Visco, 160');
    INSERT INTO cep VALUES(421 , 421 , '41.820-022');
    INSERT INTO endereco VALUES(421 , 421 , 'sn' , 'Rua Ewerton Visco, 160');
    INSERT INTO cliente VALUES(421 , 421 , 1 , 'Mercure Salvador Boulevard - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(421 , 421 , '09.967.852/0166-35' , 'Hotelaria Accor Brasil S/A' , 'Mercure Salvador Boulevard - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(421 , 421 , 'Marcela' , 0 , 'h7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(71) 2201-2989' , 'indefinido');
    INSERT INTO cidade VALUES(422, 5 , 'Salvador');
    INSERT INTO bairro VALUES(422 , 422, 'Salvador' , 'Rua Fonte do Boi, 215');
    INSERT INTO cep VALUES(422 , 422 , '41.940-360');
    INSERT INTO endereco VALUES(422 , 422 , 'sn' , 'Rua Fonte do Boi, 215');
    INSERT INTO cliente VALUES(422 , 422 , 1 , 'Mercure Salvador Rio Vermelho - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(422 , 422 , '09.967.852/0110-80' , 'Hotelaria Accor Brasil S/A' , 'Mercure Salvador Rio Vermelho - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(422 , 422 , '' , 0 , 'h5182-gl@accor.com.br' , '(71) 3172-9200' , 'indefinido');
    INSERT INTO cidade VALUES(423, 25 , 'Santo André');
    INSERT INTO bairro VALUES(423 , 423, 'Santo André' , 'Av Industrial, 885 - Terreo');
    INSERT INTO cep VALUES(423 , 423 , '09.080-510');
    INSERT INTO endereco VALUES(423 , 423 , 'sn' , 'Av Industrial, 885 - Terreo');
    INSERT INTO cliente VALUES(423 , 423 , 1 , 'Mercure Santo André - P1 Administração em Complexos Imobiliários Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(423 , 423 , '00.205.375/0006-00' , 'P1 Administração em Complexos Imobiliários Ltda' , 'Mercure Santo André - P1 Administração em Complexos Imobiliários Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(423 , 423 , 'Viviane' , 0 , 'h5169-gl1@accor.com.br' , '(11) 4979-7917' , 'indefinido');
    INSERT INTO cidade VALUES(424, 25 , 'Santos');
    INSERT INTO bairro VALUES(424 , 424, 'Santos' , 'Rua Vicente de Carvalho, 50');
    INSERT INTO cep VALUES(424 , 424 , '11.045-000');
    INSERT INTO endereco VALUES(424 , 424 , 'sn' , 'Rua Vicente de Carvalho, 50');
    INSERT INTO cliente VALUES(424 , 424 , 1 , 'Mercure Santos - Hotelaria Accor Brasil S/A – SCP Mercure Santos' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(424 , 424 , '09.967.852/0127-29' , 'Hotelaria Accor Brasil S/A – SCP Mercure Santos' , 'Mercure Santos - Hotelaria Accor Brasil S/A – SCP Mercure Santos' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(424 , 424 , '' , 0 , 'h6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(13) 3036 1013' , 'indefinido');
    INSERT INTO cidade VALUES(425, 25 , 'São Caetano do Sul');
    INSERT INTO bairro VALUES(425 , 425, 'São Caetano do Sul' , 'Rua Alegre, 440');
    INSERT INTO cep VALUES(425 , 425 , '09.050-250');
    INSERT INTO endereco VALUES(425 , 425 , 'sn' , 'Rua Alegre, 440');
    INSERT INTO cliente VALUES(425 , 425 , 1 , 'Mercure São Caetano - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(425 , 425 , '09.967.852/0114-04' , 'Hotelaria Accor Brasil S/A' , 'Mercure São Caetano - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(425 , 425 , '' , 0 , 'h5628-sb@accor.com.br' , '(11) 4228-9000' , 'indefinido');
    INSERT INTO cidade VALUES(426, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(426 , 426, 'São Paulo' , 'R Sao Carlos do Pinhal, 87');
    INSERT INTO cep VALUES(426 , 426 , '01.333-001');
    INSERT INTO endereco VALUES(426 , 426 , 'sn' , 'R Sao Carlos do Pinhal, 87');
    INSERT INTO cliente VALUES(426 , 426 , 1 , 'Mercure São Paulo Paulista - Amaral e Nicolau – ABN – Hotelaria e Consultoria e Administração Ltda' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(426 , 426 , '05.759.021/0001-09' , 'Amaral e Nicolau – ABN – Hotelaria e Consultoria e Administração Ltda' , 'Mercure São Paulo Paulista - Amaral e Nicolau – ABN – Hotelaria e Consultoria e Administração Ltda' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(426 , 426 , '' , 0 , 'h5176-gl1@accor.com.br' , '(11) 3372-6800' , 'indefinido');
    INSERT INTO cidade VALUES(427, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(427 , 427, 'São Paulo' , 'Rua Maestro Cardim, 407');
    INSERT INTO cep VALUES(427 , 427 , '01.323-000');
    INSERT INTO endereco VALUES(427 , 427 , 'sn' , 'Rua Maestro Cardim, 407');
    INSERT INTO cliente VALUES(427 , 427 , 1 , 'Mercure SP Central Tower - Hotelaria Accor Brasil S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(427 , 427 , '09.967.852/0065-91' , 'Hotelaria Accor Brasil S/A' , 'Mercure SP Central Tower - Hotelaria Accor Brasil S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(427 , 427 , '' , 0 , 'h3626-gl@accor.com.br, h3626-gl1@accor.com.br' , '(11) 2853-7091' , 'indefinido');
    INSERT INTO cidade VALUES(428, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(428 , 428, 'São Paulo' , 'Rua Salto, 70');
    INSERT INTO cep VALUES(428 , 428 , '04.001-130');
    INSERT INTO endereco VALUES(428 , 428 , 'sn' , 'Rua Salto, 70');
    INSERT INTO cliente VALUES(428 , 428 , 1 , 'Mercure Stella Vega - Hotelaria Accor Brasil S/a – SCP Stella Vega' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(428 , 428 , '09.967.852/0081-01' , 'Hotelaria Accor Brasil S/a – SCP Stella Vega' , 'Mercure Stella Vega - Hotelaria Accor Brasil S/a – SCP Stella Vega' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(428 , 428 , 'Anderson' , 0 , 'h3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 3055-2521' , 'indefinido');
    INSERT INTO cidade VALUES(429, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(429 , 429, 'São Paulo' , 'Rua Santa Justina, 210');
    INSERT INTO cep VALUES(429 , 429 , '04.545-041');
    INSERT INTO endereco VALUES(429 , 429 , 'sn' , 'Rua Santa Justina, 210');
    INSERT INTO cliente VALUES(429 , 429 , 1 , 'Mercure Vila Olimpia - Hotelaria Accor Brasil S/A – SCP Executive Flat One' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(429 , 429 , '09.967.852/0077-25' , 'Hotelaria Accor Brasil S/A – SCP Executive Flat One' , 'Mercure Vila Olimpia - Hotelaria Accor Brasil S/A – SCP Executive Flat One' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(429 , 429 , '' , 0 , 'H3206-gl@accor.com.br,h3206-gl1@accor.com.br' , '(11) 3089-6222' , 'indefinido');
    INSERT INTO cidade VALUES(430, 8 , 'Vitória');
    INSERT INTO bairro VALUES(430 , 430, 'Vitória' , 'Rua Aleixo Netto, 1385');
    INSERT INTO cep VALUES(430 , 430 , '29.055-260');
    INSERT INTO endereco VALUES(430 , 430 , 'sn' , 'Rua Aleixo Netto, 1385');
    INSERT INTO cliente VALUES(430 , 430 , 1 , 'Mercure Vitória - Hotelaria Accor Brasil SCP Bermudas' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(430 , 430 , '09.967.852/0104-32' , 'Hotelaria Accor Brasil SCP Bermudas' , 'Mercure Vitória - Hotelaria Accor Brasil SCP Bermudas' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(430 , 430 , '' , 0 , 'h5472-gl@accor.com.br,h5472-gl2@accor.com.br' , '(27) 3183-6000' , 'indefinido');
    INSERT INTO cidade VALUES(431, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(431 , 431, 'São Paulo' , 'Rua Leão XIII, 580');
    INSERT INTO cep VALUES(431 , 431 , '02.526-000');
    INSERT INTO endereco VALUES(431 , 431 , 'sn' , 'Rua Leão XIII, 580');
    INSERT INTO cliente VALUES(431 , 431 , 1 , 'Midway - Midway S.A. - Crédito, Financiamento e Investimento' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(431 , 431 , '09.464.032/0001-12' , 'Midway S.A. - Crédito, Financiamento e Investimento' , 'Midway - Midway S.A. - Crédito, Financiamento e Investimento' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(431 , 431 , '' , 0 , 'fabicb@midwayfinanceira.com.br,vivian@midwayfinanceira.com.br,patricc@midwayfinanceira.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(432, 25 , 'Barueri');
    INSERT INTO bairro VALUES(432 , 432, 'Barueri' , 'Avenida Piracema, 669 - Lojas 44/45 – Shopping Tamboré');
    INSERT INTO cep VALUES(432 , 432 , '06.460-030');
    INSERT INTO endereco VALUES(432 , 432 , 'sn' , 'Avenida Piracema, 669 - Lojas 44/45 – Shopping Tamboré');
    INSERT INTO cliente VALUES(432 , 432 , 1 , 'Miranville - Miranville Calçados e Acessórios Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(432 , 432 , '01.727.945/0001-72' , 'Miranville Calçados e Acessórios Ltda.' , 'Miranville - Miranville Calçados e Acessórios Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(432 , 432 , '' , 0 , 'felipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(433, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(433 , 433, 'Belo Horizonte' , 'Rua Rio de Janeiro, 2553');
    INSERT INTO cep VALUES(433 , 433 , '30.160-042');
    INSERT INTO endereco VALUES(433 , 433 , 'sn' , 'Rua Rio de Janeiro, 2553');
    INSERT INTO cliente VALUES(433 , 433 , 1 , 'Mixed (BH) 2 Lojas - AMT Comercio Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(433 , 433 , '00.237.757/0001-01' , 'AMT Comercio Ltda.' , 'Mixed (BH) 2 Lojas - AMT Comercio Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(433 , 433 , '' , 0 , 'mixedbh@yahoo.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(434, 7 , 'Brasília');
    INSERT INTO bairro VALUES(434 , 434, 'Brasília' , 'SHIS QI 11 Bloco A, 11');
    INSERT INTO cep VALUES(434 , 434 , '71.625-500');
    INSERT INTO endereco VALUES(434 , 434 , 'sn' , 'SHIS QI 11 Bloco A, 11');
    INSERT INTO cliente VALUES(434 , 434 , 1 , 'Mixed (DF) 1 Loja - Patibela Comercio de Vestuario Ltda EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(434 , 434 , '07.825.655/0001-48' , 'Patibela Comercio de Vestuario Ltda EPP' , 'Mixed (DF) 1 Loja - Patibela Comercio de Vestuario Ltda EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(434 , 434 , 'Maria' , 0 , 'patibelamixed@uol.com.br' , '(61) 3248-5394' , 'indefinido');
    INSERT INTO cidade VALUES(435, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(435 , 435, 'Curitiba' , 'Rua Comendador Araújo, 731 - L4 LJ 428');
    INSERT INTO cep VALUES(435 , 435 , '80.420-000');
    INSERT INTO endereco VALUES(435 , 435 , 'sn' , 'Rua Comendador Araújo, 731 - L4 LJ 428');
    INSERT INTO cliente VALUES(435 , 435 , 1 , 'Mixed (PR) 1 Loja - Três Diamantes Comércio de Moda Feminina Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(435 , 435 , '15.459.026/0001-70' , 'Três Diamantes Comércio de Moda Feminina Ltda.' , 'Mixed (PR) 1 Loja - Três Diamantes Comércio de Moda Feminina Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(435 , 435 , '' , 0 , 'ketheleen.mixed@hotmail.com,joice.mixed@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(436, 19 , 'Rio de Janeiro');
    INSERT INTO bairro VALUES(436 , 436, 'Rio de Janeiro' , 'Estrada da Gávea, 899 - LJ 118 A B');
    INSERT INTO cep VALUES(436 , 436 , '22.610-001');
    INSERT INTO endereco VALUES(436 , 436 , 'sn' , 'Estrada da Gávea, 899 - LJ 118 A B');
    INSERT INTO cliente VALUES(436 , 436 , 1 , 'Mixed (RJ) 2 Lojas - Canto Direito Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(436 , 436 , '07.060.447/0001-03' , 'Canto Direito Confecções Ltda.' , 'Mixed (RJ) 2 Lojas - Canto Direito Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(436 , 436 , '' , 0 , 'mixedrj@uol.com.br,michele.curvelo@mixed.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(437, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(437 , 437, 'São Paulo' , 'Rua Santa Justina, 496');
    INSERT INTO cep VALUES(437 , 437 , '04.545-042');
    INSERT INTO endereco VALUES(437 , 437 , 'sn' , 'Rua Santa Justina, 496');
    INSERT INTO cliente VALUES(437 , 437 , 1 , 'Mixed (SP) 4 Lojas - On The Table Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(437 , 437 , '58.277.872/0001-81' , 'On The Table Confecções Ltda.' , 'Mixed (SP) 4 Lojas - On The Table Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(437 , 437 , '' , 0 , 'roque@mixed.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(438, 25 , 'Campinas');
    INSERT INTO bairro VALUES(438 , 438, 'Campinas' , 'Rua Maria Monteiro, 1539');
    INSERT INTO cep VALUES(438 , 438 , '13.025-152');
    INSERT INTO endereco VALUES(438 , 438 , 'sn' , 'Rua Maria Monteiro, 1539');
    INSERT INTO cliente VALUES(438 , 438 , 1 , 'Mixed Campinas - JW Comércio de Vestuários e Acessórios LTDA - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(438 , 438 , '18.785.694/0001-85' , 'JW Comércio de Vestuários e Acessórios LTDA - ME' , 'Mixed Campinas - JW Comércio de Vestuários e Acessórios LTDA - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(438 , 438 , '' , 0 , 'campinas@mixed.com.br, lucia.walker@me.com, mmjlopes@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(439, 19 , 'Iguaba Grande');
    INSERT INTO bairro VALUES(439 , 439, 'Iguaba Grande' , 'Rua Doutor João Vasconcellos, 205');
    INSERT INTO cep VALUES(439 , 439 , '28960-000');
    INSERT INTO endereco VALUES(439 , 439 , 'sn' , 'Rua Doutor João Vasconcellos, 205');
    INSERT INTO cliente VALUES(439 , 439 , 1 , 'Nalin Shopping Iguaba - ABM Vestuários Ltda. (Filial 4)' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(439 , 439 , '13.872.378/0004-70' , 'ABM Vestuários Ltda. (Filial 4)' , 'Nalin Shopping Iguaba - ABM Vestuários Ltda. (Filial 4)' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(439 , 439 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(440, 19 , 'Saquarema');
    INSERT INTO bairro VALUES(440 , 440, 'Saquarema' , 'Rua Amaral Peixoto, 51 - Sobrelojas 15 a 19');
    INSERT INTO cep VALUES(440 , 440 , '28.993-000');
    INSERT INTO endereco VALUES(440 , 440 , 'sn' , 'Rua Amaral Peixoto, 51 - Sobrelojas 15 a 19');
    INSERT INTO cliente VALUES(440 , 440 , 1 , 'Nalin Shopping Bacaxá - AJN - Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(440 , 440 , '13.459.933/0003-55' , 'AJN - Confecções Ltda.' , 'Nalin Shopping Bacaxá - AJN - Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(440 , 440 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(441, 19 , 'Cabo Frio');
    INSERT INTO bairro VALUES(441 , 441, 'Cabo Frio' , 'Avenida Joaqium Nogueira, 541');
    INSERT INTO cep VALUES(441 , 441 , '28.909-490');
    INSERT INTO endereco VALUES(441 , 441 , 'sn' , 'Avenida Joaqium Nogueira, 541');
    INSERT INTO cliente VALUES(441 , 441 , 1 , 'Nalin Shopping Cabo Frio - ABM Vestuários Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(441 , 441 , '13.872.378/0003-99' , 'ABM Vestuários Ltda.' , 'Nalin Shopping Cabo Frio - ABM Vestuários Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(441 , 441 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(442, 19 , 'Guapimirim');
    INSERT INTO bairro VALUES(442 , 442, 'Guapimirim' , 'Rua Professor Rocha Farias, 05');
    INSERT INTO cep VALUES(442 , 442 , '25.940-000');
    INSERT INTO endereco VALUES(442 , 442 , 'sn' , 'Rua Professor Rocha Farias, 05');
    INSERT INTO cliente VALUES(442 , 442 , 1 , 'Nalin Shopping Guapimirim - N.N.G – Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(442 , 442 , '02.821.176/0001-30' , 'N.N.G – Confecções Ltda.' , 'Nalin Shopping Guapimirim - N.N.G – Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(442 , 442 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(443, 19 , 'Itaboraí');
    INSERT INTO bairro VALUES(443 , 443, 'Itaboraí' , 'Praça Doutor Celso Nogueira, s/n');
    INSERT INTO cep VALUES(443 , 443 , '24.800-000');
    INSERT INTO endereco VALUES(443 , 443 , 'sn' , 'Praça Doutor Celso Nogueira, s/n');
    INSERT INTO cliente VALUES(443 , 443 , 1 , 'Nalin Shopping Itaboraí - AJN - Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(443 , 443 , '13.459.933/0001-93' , 'AJN - Confecções Ltda.' , 'Nalin Shopping Itaboraí - AJN - Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(443 , 443 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(444, 19 , 'Magé');
    INSERT INTO bairro VALUES(444 , 444, 'Magé' , 'Rua Dr. Siqueira, 137');
    INSERT INTO cep VALUES(444 , 444 , '25.900-000');
    INSERT INTO endereco VALUES(444 , 444 , 'sn' , 'Rua Dr. Siqueira, 137');
    INSERT INTO cliente VALUES(444 , 444 , 1 , 'Nalin Shopping Magé - NNG Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(444 , 444 , '02.821.176/0002-10' , 'NNG Confecções Ltda.' , 'Nalin Shopping Magé - NNG Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(444 , 444 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(445, 19 , 'Itaboraí');
    INSERT INTO bairro VALUES(445 , 445, 'Itaboraí' , 'Rua Milton Rodrigues da Rocha, 162 - lojas 01 a 04');
    INSERT INTO cep VALUES(445 , 445 , '24.800-000');
    INSERT INTO endereco VALUES(445 , 445 , 'sn' , 'Rua Milton Rodrigues da Rocha, 162 - lojas 01 a 04');
    INSERT INTO cliente VALUES(445 , 445 , 1 , 'Nalin Shopping Manilha - N.N.G – Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(445 , 445 , '02.821.176/0003-00' , 'N.N.G – Confecções Ltda.' , 'Nalin Shopping Manilha - N.N.G – Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(445 , 445 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(446, 19 , 'Rio Bonito');
    INSERT INTO bairro VALUES(446 , 446, 'Rio Bonito' , 'Rua XV de Novembro, 49 - Loja 09 a 18');
    INSERT INTO cep VALUES(446 , 446 , '28.800-000');
    INSERT INTO endereco VALUES(446 , 446 , 'sn' , 'Rua XV de Novembro, 49 - Loja 09 a 18');
    INSERT INTO cliente VALUES(446 , 446 , 1 , 'Nalin Shopping Rio Bonito - AJN - Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(446 , 446 , '13.459.933/0002-74' , 'AJN - Confecções Ltda.' , 'Nalin Shopping Rio Bonito - AJN - Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(446 , 446 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(447, 19 , 'Rio das Ostras');
    INSERT INTO bairro VALUES(447 , 447, 'Rio das Ostras' , 'Rodovia Amaral Peixoto, 4971 - Loja A');
    INSERT INTO cep VALUES(447 , 447 , '28.893-076');
    INSERT INTO endereco VALUES(447 , 447 , 'sn' , 'Rodovia Amaral Peixoto, 4971 - Loja A');
    INSERT INTO cliente VALUES(447 , 447 , 1 , 'Nalin Shopping Rio das Ostras - A.B.M – Vestuários Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(447 , 447 , '13.872.378/0001-27' , 'A.B.M – Vestuários Ltda.' , 'Nalin Shopping Rio das Ostras - A.B.M – Vestuários Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(447 , 447 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(448, 19 , 'São Pedro da Aldeia');
    INSERT INTO bairro VALUES(448 , 448, 'São Pedro da Aldeia' , 'Rodovia RJ 140 - km 02, 100 - Sobreloja e Cobertura');
    INSERT INTO cep VALUES(448 , 448 , '28.940-000');
    INSERT INTO endereco VALUES(448 , 448 , 'sn' , 'Rodovia RJ 140 - km 02, 100 - Sobreloja e Cobertura');
    INSERT INTO cliente VALUES(448 , 448 , 1 , 'Nalin Shopping S. Pedro da Aldeia - A.B.M – Vestuários Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(448 , 448 , '13.872.378/0002-08' , 'A.B.M – Vestuários Ltda.' , 'Nalin Shopping S. Pedro da Aldeia - A.B.M – Vestuários Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(448 , 448 , 'Rachel Toledo' , 0 , 'rachel.toledo@nalinshopping.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(449, 25 , 'Barueri');
    INSERT INTO bairro VALUES(449 , 449, 'Barueri' , 'Rua Avenida Aruanã, 700');
    INSERT INTO cep VALUES(449 , 449 , '06.460-908');
    INSERT INTO endereco VALUES(449 , 449 , 'sn' , 'Rua Avenida Aruanã, 700');
    INSERT INTO cliente VALUES(449 , 449 , 1 , 'Netshoes - NS2.Com Internet S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(449 , 449 , '09.339.936/0002-05' , 'NS2.Com Internet S/A' , 'Netshoes - NS2.Com Internet S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(449 , 449 , 'Paola' , 0 , 'paola.parrini@netshoes.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(450, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(450 , 450, 'Campo Grande' , 'Av Mato Grosso, 5555');
    INSERT INTO cep VALUES(450 , 450 , '');
    INSERT INTO endereco VALUES(450 , 450 , 'sn' , 'Av Mato Grosso, 5555');
    INSERT INTO cliente VALUES(450 , 450 , 1 , 'Novotel Campo Grande - Seven Administração e Participação Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(450 , 450 , '02.139.652/0002-18' , 'Seven Administração e Participação Ltda.' , 'Novotel Campo Grande - Seven Administração e Participação Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(450 , 450 , 'Willy' , 0 , 'h2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(67) 2106-5907' , 'indefinido');
    INSERT INTO cidade VALUES(451, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(451 , 451, 'São Paulo' , 'Av Zaki Narchi, 500');
    INSERT INTO cep VALUES(451 , 451 , '02.029-000');
    INSERT INTO endereco VALUES(451 , 451 , 'sn' , 'Av Zaki Narchi, 500');
    INSERT INTO cliente VALUES(451 , 451 , 1 , 'Novotel Center Norte - Center Norte S/A Constr. Empree. Adm. e Participação' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(451 , 451 , '45.246.402/0007-02' , 'Center Norte S/A Constr. Empree. Adm. e Participação' , 'Novotel Center Norte - Center Norte S/A Constr. Empree. Adm. e Participação' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(451 , 451 , 'Peterson' , 0 , 'h2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 2224-4000' , 'indefinido');
    INSERT INTO cidade VALUES(452, 1 , 'Cusco');
    INSERT INTO bairro VALUES(452 , 452, 'Cusco' , 'Calle San Agustin, 239');
    INSERT INTO cep VALUES(452 , 452 , '');
    INSERT INTO endereco VALUES(452 , 452 , 'sn' , 'Calle San Agustin, 239');
    INSERT INTO cliente VALUES(452 , 452 , 1 , 'Novotel Cusco - Corporación Hotelera del Cuzco S.A.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(452 , 452 , '204.228.416-53' , 'Corporación Hotelera del Cuzco S.A.' , 'Novotel Cusco - Corporación Hotelera del Cuzco S.A.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(452 , 452 , '' , 0 , '' , '' , 'indefinido');
    INSERT INTO cidade VALUES(453, 17 , 'Abreu e Lima');
    INSERT INTO bairro VALUES(453 , 453, 'Abreu e Lima' , 'Av Victor Andres Belaunde, 198');
    INSERT INTO cep VALUES(453 , 453 , '');
    INSERT INTO endereco VALUES(453 , 453 , 'sn' , 'Av Victor Andres Belaunde, 198');
    INSERT INTO cliente VALUES(453 , 453 , 1 , 'Novotel Lima - Sociedad de Desarrollo de Hoteles Peruanos' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(453 , 453 , '205.132.158-87' , 'Sociedad de Desarrollo de Hoteles Peruanos' , 'Novotel Lima - Sociedad de Desarrollo de Hoteles Peruanos' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(453 , 453 , '' , 0 , '' , '' , 'indefinido');
    INSERT INTO cidade VALUES(454, 25 , 'Campinas');
    INSERT INTO bairro VALUES(454 , 454, 'Campinas' , 'Via Rodovia Dom Pedro I - KM, 140,5');
    INSERT INTO cep VALUES(454 , 454 , '13.082-120');
    INSERT INTO endereco VALUES(454 , 454 , 'sn' , 'Via Rodovia Dom Pedro I - KM, 140,5');
    INSERT INTO cliente VALUES(454 , 454 , 1 , 'Oba Hortifruti - Grupo Fartura de Hortifrut Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(454 , 454 , '04.972.092/0001-22' , 'Grupo Fartura de Hortifrut Ltda.' , 'Oba Hortifruti - Grupo Fartura de Hortifrut Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(454 , 454 , '' , 0 , 'leonidas@redeoba.com.br,marcos.bruno@redeoba.com.br,charles.moreira@redeoba.com.brh6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(455, 8 , 'Serra');
    INSERT INTO bairro VALUES(455 , 455, 'Serra' , 'Avenida Eudes Scherrer de Souza, n° 2001 - Galpão 09');
    INSERT INTO cep VALUES(455 , 455 , '29165-680');
    INSERT INTO endereco VALUES(455 , 455 , 'sn' , 'Avenida Eudes Scherrer de Souza, n° 2001 - Galpão 09');
    INSERT INTO cliente VALUES(455 , 455 , 1 , 'OK Superatacado - Serrano Distribuidora Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(455 , 455 , '09.397.586/0001-44' , 'Serrano Distribuidora Ltda.' , 'OK Superatacado - Serrano Distribuidora Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(455 , 455 , 'Maisa' , 0 , 'financeiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(27) 3298-8129' , 'indefinido');
    INSERT INTO cidade VALUES(456, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(456 , 456, 'São Paulo' , 'Alameda Gabriel Monteiro da Silva, 1914');
    INSERT INTO cep VALUES(456 , 456 , '01.442-001');
    INSERT INTO endereco VALUES(456 , 456 , 'sn' , 'Alameda Gabriel Monteiro da Silva, 1914');
    INSERT INTO cliente VALUES(456 , 456 , 1 , 'Orlean - Revestimentos e Pisos S3 Orlean' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(456 , 456 , '01.212.194/0001-51' , 'Revestimentos e Pisos S3 Orlean' , 'Orlean - Revestimentos e Pisos S3 Orlean' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(456 , 456 , '' , 0 , 'mariane.freitas@orlean.com.br, janaina@orlean.com.br,alexandra@orlean.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(457, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(457 , 457, 'Cuiabá' , 'Avenida Haiti, 344');
    INSERT INTO cep VALUES(457 , 457 , '78.060-634');
    INSERT INTO endereco VALUES(457 , 457 , 'sn' , 'Avenida Haiti, 344');
    INSERT INTO cliente VALUES(457 , 457 , 1 , 'Padaria América - Padaria América' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(457 , 457 , '07.256.473/0001-01' , 'Padaria América' , 'Padaria América - Padaria América' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(457 , 457 , '' , 0 , 'padariaamericacba@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(458, 25 , 'Sorocaba');
    INSERT INTO bairro VALUES(458 , 458, 'Sorocaba' , 'Rua Aparecida, 322');
    INSERT INTO cep VALUES(458 , 458 , '18.095-000');
    INSERT INTO endereco VALUES(458 , 458 , 'sn' , 'Rua Aparecida, 322');
    INSERT INTO cliente VALUES(458 , 458 , 1 , 'Padaria Santa Rosália - Panificadora Pivetta Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(458 , 458 , '71.458.210/0001-76' , 'Panificadora Pivetta Ltda.' , 'Padaria Santa Rosália - Panificadora Pivetta Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(458 , 458 , '' , 0 , 'paulo@santarosalia.com.br,faturamento@santarosalia.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(459, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(459 , 459, 'Cuiabá' , 'Travessa Paiaguás, 116');
    INSERT INTO cep VALUES(459 , 459 , '78.020-280');
    INSERT INTO endereco VALUES(459 , 459 , 'sn' , 'Travessa Paiaguás, 116');
    INSERT INTO cliente VALUES(459 , 459 , 1 , 'Paiol - Paiol Comercial Produtos Alimentos Naturais Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(459 , 459 , '07.747.254/0001-17' , 'Paiol Comercial Produtos Alimentos Naturais Ltda.' , 'Paiol - Paiol Comercial Produtos Alimentos Naturais Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(459 , 459 , '' , 0 , 'paiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(460, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(460 , 460, 'Campo Grande' , 'Rua Quatorze de Julho, 2228');
    INSERT INTO cep VALUES(460 , 460 , '79.002-332');
    INSERT INTO endereco VALUES(460 , 460 , 'sn' , 'Rua Quatorze de Julho, 2228');
    INSERT INTO cliente VALUES(460 , 460 , 1 , 'Passarela Calçados - Centro Oeste Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(460 , 460 , '01.509.013/0001-53' , 'Centro Oeste Calçados Ltda.' , 'Passarela Calçados - Centro Oeste Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(460 , 460 , '' , 0 , 'passarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(461, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(461 , 461, 'Campo Grande' , 'Rua Quatorze de Julho, 1943');
    INSERT INTO cep VALUES(461 , 461 , '79.002-334');
    INSERT INTO endereco VALUES(461 , 461 , 'sn' , 'Rua Quatorze de Julho, 1943');
    INSERT INTO cliente VALUES(461 , 461 , 1 , 'Passarela Calçados - Souza e Galetti Ltda - Matriz' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(461 , 461 , '04.531.254/0001-97' , 'Souza e Galetti Ltda - Matriz' , 'Passarela Calçados - Souza e Galetti Ltda - Matriz' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(461 , 461 , '' , 0 , 'passarelacg@gmail.com,passarelamodas@terra.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(462, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(462 , 462, 'Campo Grande' , 'Rua Dom Aquino, 1354, 1354');
    INSERT INTO cep VALUES(462 , 462 , '79.002-904');
    INSERT INTO endereco VALUES(462 , 462 , 'sn' , 'Rua Dom Aquino, 1354, 1354');
    INSERT INTO cliente VALUES(462 , 462 , 1 , 'Passarela Calçados - Souza e Galetti Ltda - Filial' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(462 , 462 , '04.531.254/0002-78' , 'Souza e Galetti Ltda - Filial' , 'Passarela Calçados - Souza e Galetti Ltda - Filial' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(462 , 462 , '' , 0 , 'passarelacg@gmail.com,passarelamodas@terra.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(463, 12 , 'Campo Grande');
    INSERT INTO bairro VALUES(463 , 463, 'Campo Grande' , 'Rua Quatorze de Julho, 2164');
    INSERT INTO cep VALUES(463 , 463 , '79.002-336');
    INSERT INTO endereco VALUES(463 , 463 , 'sn' , 'Rua Quatorze de Julho, 2164');
    INSERT INTO cliente VALUES(463 , 463 , 1 , 'Passarela Calçados - Passarela Modas Calçados e Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(463 , 463 , '06.894.586/0001-61' , 'Passarela Modas Calçados e Confecções Ltda.' , 'Passarela Calçados - Passarela Modas Calçados e Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(463 , 463 , '' , 0 , 'passarelacg@gmail.com,passarelamodas@terra.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(464, 13 , 'Uberlândia');
    INSERT INTO bairro VALUES(464 , 464, 'Uberlândia' , 'Avenida Afonso Pena, 119 - Subsolo 1');
    INSERT INTO cep VALUES(464 , 464 , '38400-128');
    INSERT INTO endereco VALUES(464 , 464 , 'sn' , 'Avenida Afonso Pena, 119 - Subsolo 1');
    INSERT INTO cliente VALUES(464 , 464 , 1 , 'Pat Bo (Patricia Bonaldi) - Pat Bo Industria de Moda – ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(464 , 464 , '14.112.375/0001-58' , 'Pat Bo Industria de Moda – ME' , 'Pat Bo (Patricia Bonaldi) - Pat Bo Industria de Moda – ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(464 , 464 , 'José Carlos' , 0 , 'rogerio@patriciabonaldi.com.br, josecarlos@patriciabonaldi.com.br' , '(34) 3291-4402' , 'indefinido');
    INSERT INTO cidade VALUES(465, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(465 , 465, 'São Paulo' , 'Via Rua Coronel Otaviano da Silveira, 97');
    INSERT INTO cep VALUES(465 , 465 , '05.522-010');
    INSERT INTO endereco VALUES(465 , 465 , 'sn' , 'Via Rua Coronel Otaviano da Silveira, 97');
    INSERT INTO cliente VALUES(465 , 465 , 1 , 'Pepper - Pepper Comércio de Presentes Ltda - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(465 , 465 , '04.432.462/0001-39' , 'Pepper Comércio de Presentes Ltda - EPP' , 'Pepper - Pepper Comércio de Presentes Ltda - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(465 , 465 , '' , 0 , 'administrativo2@pepper.com.br, financeiro@pepper.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(466, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(466 , 466, 'São Paulo' , 'Rua da Consolação - de 1101 a 2459 - lado ímpar, 2387 - 2411');
    INSERT INTO cep VALUES(466 , 466 , '01.301-100');
    INSERT INTO endereco VALUES(466 , 466 , 'sn' , 'Rua da Consolação - de 1101 a 2459 - lado ímpar, 2387 - 2411');
    INSERT INTO cliente VALUES(466 , 466 , 1 , 'Pernambucanas - Arthur Lundgren Tecidos S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(466 , 466 , '61.099.834/0001-90' , 'Arthur Lundgren Tecidos S/A' , 'Pernambucanas - Arthur Lundgren Tecidos S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(466 , 466 , 'Kamila' , 0 , 'anapaula.tocci@pernambucanas.com.br,ulisses.souza@pernambucanas.com.br,mariane.arnoni@pernambucanas.com.br,kamila.dias@pernambucanas.com.br, juan.garcia@pernambucanas.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(467, 21 , 'Porto Alegre');
    INSERT INTO bairro VALUES(467 , 467, 'Porto Alegre' , 'Avenida Ipiranga, 5570');
    INSERT INTO cep VALUES(467 , 467 , '90.610-000');
    INSERT INTO endereco VALUES(467 , 467 , 'sn' , 'Avenida Ipiranga, 5570');
    INSERT INTO cliente VALUES(467 , 467 , 1 , 'Peugeot Lyon Azenha - Dijon Comércio de Veículos Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(467 , 467 , '15.108.924/0005-07' , 'Dijon Comércio de Veículos Ltda.' , 'Peugeot Lyon Azenha - Dijon Comércio de Veículos Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(467 , 467 , '' , 0 , 'gercomercial@lyonveiculos.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(468, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(468 , 468, 'São Paulo' , 'Avenida das Nações Unidas, 12555 - LOJA 325 PISO L 3');
    INSERT INTO cep VALUES(468 , 468 , '04.578-000');
    INSERT INTO endereco VALUES(468 , 468 , 'sn' , 'Avenida das Nações Unidas, 12555 - LOJA 325 PISO L 3');
    INSERT INTO cliente VALUES(468 , 468 , 1 , 'Phenicia (D&D) - Phenicia Comercial Exportadora e Importadora Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(468 , 468 , '59.501.825/0001-32' , 'Phenicia Comercial Exportadora e Importadora Ltda.' , 'Phenicia (D&D) - Phenicia Comercial Exportadora e Importadora Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(468 , 468 , '' , 0 , 'phenicia@phenicia.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(469, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(469 , 469, 'São Paulo' , 'Alameda Gabriel Monteiro da Silva - de 1358 a 2298 - lado par, 1950 E');
    INSERT INTO cep VALUES(469 , 469 , '01.442-001');
    INSERT INTO endereco VALUES(469 , 469 , 'sn' , 'Alameda Gabriel Monteiro da Silva - de 1358 a 2298 - lado par, 1950 E');
    INSERT INTO cliente VALUES(469 , 469 , 1 , 'Phenicia (Gabriel) - Phenicia Comercial Exportadora e Importadora Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(469 , 469 , '59.501.825/0003-02' , 'Phenicia Comercial Exportadora e Importadora Ltda.' , 'Phenicia (Gabriel) - Phenicia Comercial Exportadora e Importadora Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(469 , 469 , '' , 0 , 'phenicia@phenicia.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(470, 7 , 'Brasília');
    INSERT INTO bairro VALUES(470 , 470, 'Brasília' , 'Quadra SHS  5, 5 - QD 05 Bloco H');
    INSERT INTO cep VALUES(470 , 470 , '70.315-000');
    INSERT INTO endereco VALUES(470 , 470 , 'sn' , 'Quadra SHS  5, 5 - QD 05 Bloco H');
    INSERT INTO cliente VALUES(470 , 470 , 1 , 'Places - Places Bar e Restaurante Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(470 , 470 , '13.251.752/0001-77' , 'Places Bar e Restaurante Ltda.' , 'Places - Places Bar e Restaurante Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(470 , 470 , 'Gustavo' , 0 , 'financeiro@placesrestaurante.com.br' , '(61) 3223-1526' , 'indefinido');
    INSERT INTO cidade VALUES(471, 16 , 'Palmas');
    INSERT INTO bairro VALUES(471 , 471, 'Palmas' , 'Avenida 806 Sul  NS 10, 10 - lt pac 24A');
    INSERT INTO cep VALUES(471 , 471 , '77.023-056');
    INSERT INTO endereco VALUES(471 , 471 , 'sn' , 'Avenida 806 Sul  NS 10, 10 - lt pac 24A');
    INSERT INTO cliente VALUES(471 , 471 , 1 , 'Posto San Marino - Santana e Castro Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(471 , 471 , '04.797.330/0001-00' , 'Santana e Castro Ltda.' , 'Posto San Marino - Santana e Castro Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(471 , 471 , 'Brasilia' , 0 , 'contato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(63) 3216-6600' , 'indefinido');
    INSERT INTO cidade VALUES(472, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(472 , 472, 'São Paulo' , 'Rua Abílio Soares, 876');
    INSERT INTO cep VALUES(472 , 472 , '04.005-003');
    INSERT INTO endereco VALUES(472 , 472 , 'sn' , 'Rua Abílio Soares, 876');
    INSERT INTO cliente VALUES(472 , 472 , 1 , 'Pusco - Rita Maria Alexandr Modas' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(472 , 472 , '05.357.634/0003-81' , 'Rita Maria Alexandr Modas' , 'Pusco - Rita Maria Alexandr Modas' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(472 , 472 , '' , 0 , 'persio@pusco.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(473, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(473 , 473, 'São Paulo' , 'Rua Leão XIII, 500');
    INSERT INTO cep VALUES(473 , 473 , '02.526-000');
    INSERT INTO endereco VALUES(473 , 473 , 'sn' , 'Rua Leão XIII, 500');
    INSERT INTO cliente VALUES(473 , 473 , 1 , 'Riachuelo - Lojas Riachuelo S/A' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(473 , 473 , '33.200.056/0001-49' , 'Lojas Riachuelo S/A' , 'Riachuelo - Lojas Riachuelo S/A' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(473 , 473 , '' , 0 , 'beatrizp@riachuelo.com.br,arletef@riachuelo.com.br,tatianaf@riachuelo.com.br,nfmarketing@riachuelo.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(474, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(474 , 474, 'São Paulo' , 'Rua Pascoal Vita, 329');
    INSERT INTO cep VALUES(474 , 474 , '05.445-000');
    INSERT INTO endereco VALUES(474 , 474 , 'sn' , 'Rua Pascoal Vita, 329');
    INSERT INTO cliente VALUES(474 , 474 , 1 , 'Rodó Restaurante - Álvaro Freire Cury ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(474 , 474 , '17.939.327/0001-26' , 'Álvaro Freire Cury ME' , 'Rodó Restaurante - Álvaro Freire Cury ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(474 , 474 , '' , 0 , 'jc.cury@uol.com.br' , '11 3032-7517' , 'indefinido');
    INSERT INTO cidade VALUES(475, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(475 , 475, 'São Paulo' , 'Avenida Regente Feijó, 1739');
    INSERT INTO cep VALUES(475 , 475 , '03.342-000');
    INSERT INTO endereco VALUES(475 , 475 , 'sn' , 'Avenida Regente Feijó, 1739');
    INSERT INTO cliente VALUES(475 , 475 , 1 , 'Sergio K Anália Franco - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(475 , 475 , '09.028.217/0014-07' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Anália Franco - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(475 , 475 , '' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(476, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(476 , 476, 'Belo Horizonte' , 'Via Rodovia BR-356, 3049 - Loja MA 81');
    INSERT INTO cep VALUES(476 , 476 , '30.320-900');
    INSERT INTO endereco VALUES(476 , 476 , 'sn' , 'Via Rodovia BR-356, 3049 - Loja MA 81');
    INSERT INTO cliente VALUES(476 , 476 , 1 , 'Sergio K BH Shopping - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(476 , 476 , '09.028.217/0012-37' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K BH Shopping - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(476 , 476 , '' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(477, 25 , 'Barueri');
    INSERT INTO bairro VALUES(477 , 477, 'Barueri' , 'Alameda Xingu, 200 - Loja 208');
    INSERT INTO cep VALUES(477 , 477 , '06.455-030');
    INSERT INTO endereco VALUES(477 , 477 , 'sn' , 'Alameda Xingu, 200 - Loja 208');
    INSERT INTO cliente VALUES(477 , 477 , 1 , 'Sergio K Iguatemi Alphaville - ESX Comércio de Calçados e Confecções Ltda EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(477 , 477 , '13.617.856/0001-52' , 'ESX Comércio de Calçados e Confecções Ltda EPP' , 'Sergio K Iguatemi Alphaville - ESX Comércio de Calçados e Confecções Ltda EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(477 , 477 , 'Daiana' , 0 , 'seferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '(11) 4193-6342' , 'indefinido');
    INSERT INTO cidade VALUES(478, 7 , 'Brasília');
    INSERT INTO bairro VALUES(478 , 478, 'Brasília' , 'Setor Habitacional ST SHI Norte, 77 - Quadra CA-04 Bloco A lj 64-65');
    INSERT INTO cep VALUES(478 , 478 , '71.503-504');
    INSERT INTO endereco VALUES(478 , 478 , 'sn' , 'Setor Habitacional ST SHI Norte, 77 - Quadra CA-04 Bloco A lj 64-65');
    INSERT INTO cliente VALUES(478 , 478 , 1 , 'Sergio K Iguatemi Brasília - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(478 , 478 , '09.028.217/0005-08' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Iguatemi Brasília - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(478 , 478 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(479, 25 , 'Campinas');
    INSERT INTO bairro VALUES(479 , 479, 'Campinas' , 'Avenida Iguatemi, 777 - Loja SUC 10-01 - 2o piso');
    INSERT INTO cep VALUES(479 , 479 , '13.092-902');
    INSERT INTO endereco VALUES(479 , 479 , 'sn' , 'Avenida Iguatemi, 777 - Loja SUC 10-01 - 2o piso');
    INSERT INTO cliente VALUES(479 , 479 , 1 , 'Sergio K Iguatemi Campinas - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(479 , 479 , '09.028.217/0006-99' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Iguatemi Campinas - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(479 , 479 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(480, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(480 , 480, 'Ribeirão Preto' , 'Avenida Luiz Eduardo Toledo Prado, 900 - Loja 2001 - Piso Superior');
    INSERT INTO cep VALUES(480 , 480 , '14.027-250');
    INSERT INTO endereco VALUES(480 , 480 , 'sn' , 'Avenida Luiz Eduardo Toledo Prado, 900 - Loja 2001 - Piso Superior');
    INSERT INTO cliente VALUES(480 , 480 , 1 , 'Sergio K Iguatemi Ribeirão Preto - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(480 , 480 , '09.028.217/0009-31' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Iguatemi Ribeirão Preto - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(480 , 480 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(481, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(481 , 481, 'São Paulo' , 'Avenida Brigadeiro Faria Lima, 2232 - 2o Piso, Loja S-01');
    INSERT INTO cep VALUES(481 , 481 , '01.489-900');
    INSERT INTO endereco VALUES(481 , 481 , 'sn' , 'Avenida Brigadeiro Faria Lima, 2232 - 2o Piso, Loja S-01');
    INSERT INTO cliente VALUES(481 , 481 , 1 , 'Sergio K Iguatemi São Paulo - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(481 , 481 , '09.028.217/0001-84' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Iguatemi São Paulo - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(481 , 481 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(482, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(482 , 482, 'São Paulo' , 'Av. Dr. Chucri Zaidan, 902 - Loja 129A - Piso Térreo');
    INSERT INTO cep VALUES(482 , 482 , '04.794-000');
    INSERT INTO endereco VALUES(482 , 482 , 'sn' , 'Av. Dr. Chucri Zaidan, 902 - Loja 129A - Piso Térreo');
    INSERT INTO cliente VALUES(482 , 482 , 1 , 'Sergio K Market Place - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(482 , 482 , '09.028.217/0003-46' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Market Place - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(482 , 482 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(483, 21 , 'Novo Hamburgo');
    INSERT INTO bairro VALUES(483 , 483, 'Novo Hamburgo' , 'Rua Rincão, 505 - Loja 114');
    INSERT INTO cep VALUES(483 , 483 , '93.310-460');
    INSERT INTO endereco VALUES(483 , 483 , 'sn' , 'Rua Rincão, 505 - Loja 114');
    INSERT INTO cliente VALUES(483 , 483 , 1 , 'Sergio K Novo Hamburgo - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(483 , 483 , '09.028.217/0007-70' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Novo Hamburgo - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(483 , 483 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(484, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(484 , 484, 'São Paulo' , 'Rua Oscar Freire, 1143');
    INSERT INTO cep VALUES(484 , 484 , '01.426-001');
    INSERT INTO endereco VALUES(484 , 484 , 'sn' , 'Rua Oscar Freire, 1143');
    INSERT INTO cliente VALUES(484 , 484 , 1 , 'Sergio K Oscar Freire - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(484 , 484 , '09.028.217/0002-65' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Oscar Freire - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(484 , 484 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(485, 9 , 'Alexânia');
    INSERT INTO bairro VALUES(485 , 485, 'Alexânia' , 'ROD. BR 060 km 22, s/n - LOJA 1019');
    INSERT INTO cep VALUES(485 , 485 , '72.930-000');
    INSERT INTO endereco VALUES(485 , 485 , 'sn' , 'ROD. BR 060 km 22, s/n - LOJA 1019');
    INSERT INTO cliente VALUES(485 , 485 , 1 , 'Sergio K Outlet Brasília - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(485 , 485 , '09.028.217/0015-80' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Outlet Brasília - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(485 , 485 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(486, 25 , 'Itupeva');
    INSERT INTO bairro VALUES(486 , 486, 'Itupeva' , 'Estrada Joaquim Bueno Neto, 9999 - Loja 13');
    INSERT INTO cep VALUES(486 , 486 , '29971-500');
    INSERT INTO endereco VALUES(486 , 486 , 'sn' , 'Estrada Joaquim Bueno Neto, 9999 - Loja 13');
    INSERT INTO cliente VALUES(486 , 486 , 1 , 'Sergio K Outlet Premium São Paulo - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(486 , 486 , '09.028.217/0011-56' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Outlet Premium São Paulo - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(486 , 486 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(487, 5 , 'Camaçari');
    INSERT INTO bairro VALUES(487 , 487, 'Camaçari' , 'Estrada do Côco Km 13, s/n');
    INSERT INTO cep VALUES(487 , 487 , '42.840-971');
    INSERT INTO endereco VALUES(487 , 487 , 'sn' , 'Estrada do Côco Km 13, s/n');
    INSERT INTO cliente VALUES(487 , 487 , 1 , 'Sergio K Outlet Salvador - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(487 , 487 , '09.028.217/0008-50' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Outlet Salvador - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(487 , 487 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(488, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(488 , 488, 'São Paulo' , 'Avenida Presidente Juscelino Kubitschek, 2041');
    INSERT INTO cep VALUES(488 , 488 , '04.543-011');
    INSERT INTO endereco VALUES(488 , 488 , 'sn' , 'Avenida Presidente Juscelino Kubitschek, 2041');
    INSERT INTO cliente VALUES(488 , 488 , 1 , 'Sergio K Shopping Iguatemi JK - SLKS Comércio de Artigos de Moda Eireli' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(488 , 488 , '09.028.217/0010-75' , 'SLKS Comércio de Artigos de Moda Eireli' , 'Sergio K Shopping Iguatemi JK - SLKS Comércio de Artigos de Moda Eireli' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(488 , 488 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(489, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(489 , 489, 'Ribeirão Preto' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 147');
    INSERT INTO cep VALUES(489 , 489 , '14.026-900');
    INSERT INTO endereco VALUES(489 , 489 , 'sn' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 147');
    INSERT INTO cliente VALUES(489 , 489 , 1 , 'Sergio K Shopping Ribeirão - SLKS Comércio de Artigos de Moda Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(489 , 489 , '09.028.217/0013-18' , 'SLKS Comércio de Artigos de Moda Ltda.' , 'Sergio K Shopping Ribeirão - SLKS Comércio de Artigos de Moda Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(489 , 489 , 'Luciene' , 0 , 'glauce@sergiok.com.br,luciene@sergiok.com.br' , '(11) 3085-8900' , 'indefinido');
    INSERT INTO cidade VALUES(490, 13 , 'Montes Claros');
    INSERT INTO bairro VALUES(490 , 490, 'Montes Claros' , 'Avenida Donato Quintino, 90');
    INSERT INTO cep VALUES(490 , 490 , '39.400-546');
    INSERT INTO endereco VALUES(490 , 490 , 'sn' , 'Avenida Donato Quintino, 90');
    INSERT INTO cliente VALUES(490 , 490 , 1 , 'Shopping Montes Claros - Associação dos Lojistas do Montes Claros Shopping Center' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(490 , 490 , '02.539.535/0001-60' , 'Associação dos Lojistas do Montes Claros Shopping Center' , 'Shopping Montes Claros - Associação dos Lojistas do Montes Claros Shopping Center' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(490 , 490 , 'Karla' , 0 , 'karla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(491, 9 , 'Aparecida de Goiânia');
    INSERT INTO bairro VALUES(491 , 491, 'Aparecida de Goiânia' , 'Rua Tapauá, sn - Lote 06 a 15, Quadra 02, Sala 01');
    INSERT INTO cep VALUES(491 , 491 , '74.911-815');
    INSERT INTO endereco VALUES(491 , 491 , 'sn' , 'Rua Tapauá, sn - Lote 06 a 15, Quadra 02, Sala 01');
    INSERT INTO cliente VALUES(491 , 491 , 1 , 'TendTudo - Home Center Nordeste Comércio de Materiais Para Construção S.A.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(491 , 491 , '08.197.731/0001-80' , 'Home Center Nordeste Comércio de Materiais Para Construção S.A.' , 'TendTudo - Home Center Nordeste Comércio de Materiais Para Construção S.A.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(491 , 491 , 'Larissa' , 0 , 'hvenancio@brhc.com.br, lrcosta@brhc.com.br, aabdul@brhc.com.br, lartoni@brhc.com.br' , '(62) 4012-5660' , 'indefinido');
    INSERT INTO cidade VALUES(492, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(492 , 492, 'São Paulo' , 'Rua Silva Bueno, 2253');
    INSERT INTO cep VALUES(492 , 492 , '04208-053');
    INSERT INTO endereco VALUES(492 , 492 , 'sn' , 'Rua Silva Bueno, 2253');
    INSERT INTO cliente VALUES(492 , 492 , 1 , 'Tennis Express 19 - Ipiranga - Gilmar Pereira Calçados - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(492 , 492 , '18.871.794/0001-24' , 'Gilmar Pereira Calçados - EPP' , 'Tennis Express 19 - Ipiranga - Gilmar Pereira Calçados - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(492 , 492 , 'Fernando' , 0 , 'fernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(493, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(493 , 493, 'Ribeirão Preto' , 'Rua Tibiriçá, 539');
    INSERT INTO cep VALUES(493 , 493 , '14010-090');
    INSERT INTO endereco VALUES(493 , 493 , 'sn' , 'Rua Tibiriçá, 539');
    INSERT INTO cliente VALUES(493 , 493 , 1 , 'Tennis Express 22 - Ribeirão Preto - Heloisa Toller de Souza - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(493 , 493 , '19.139.803/0001-50' , 'Heloisa Toller de Souza - EPP' , 'Tennis Express 22 - Ribeirão Preto - Heloisa Toller de Souza - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(493 , 493 , 'Heloisa' , 0 , 'heloisa.souza@tennisexpress.com.br' , '(16) 3236-3870' , 'indefinido');
    INSERT INTO cidade VALUES(494, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(494 , 494, 'São Paulo' , 'Rua Voluntários da Pátria, 2023');
    INSERT INTO cep VALUES(494 , 494 , '02.011-400');
    INSERT INTO endereco VALUES(494 , 494 , 'sn' , 'Rua Voluntários da Pátria, 2023');
    INSERT INTO cliente VALUES(494 , 494 , 1 , 'Tennis Express 01 - Santana - ARG Comércio de Roupas, Calçados e Acessórios Ltda. - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(494 , 494 , '04.688.607/0001-67' , 'ARG Comércio de Roupas, Calçados e Acessórios Ltda. - ME' , 'Tennis Express 01 - Santana - ARG Comércio de Roupas, Calçados e Acessórios Ltda. - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(494 , 494 , '' , 0 , 'guilherme.almeida@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(495, 25 , 'Guarulhos');
    INSERT INTO bairro VALUES(495 , 495, 'Guarulhos' , 'Rua Felício Marcondes, 74');
    INSERT INTO cep VALUES(495 , 495 , '07.010-030');
    INSERT INTO endereco VALUES(495 , 495 , 'sn' , 'Rua Felício Marcondes, 74');
    INSERT INTO cliente VALUES(495 , 495 , 1 , 'Tennis Express 02 - Guarulhos - V.A. Xambre Junior Artigos Esportivos - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(495 , 495 , '11.104.764/0002-24' , 'V.A. Xambre Junior Artigos Esportivos - EPP' , 'Tennis Express 02 - Guarulhos - V.A. Xambre Junior Artigos Esportivos - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(495 , 495 , 'Junior' , 0 , 'adm.awk@terra.com.br, junior.xambre@artwalk.com.br' , '(11) 2972-6222' , 'indefinido');
    INSERT INTO cidade VALUES(496, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(496 , 496, 'São Paulo' , 'Rua da Mooca, 2536');
    INSERT INTO cep VALUES(496 , 496 , '03.104-002');
    INSERT INTO endereco VALUES(496 , 496 , 'sn' , 'Rua da Mooca, 2536');
    INSERT INTO cliente VALUES(496 , 496 , 1 , 'Tennis Express 03 - Móoca - Marceli Ciarelli Calçados - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(496 , 496 , '10.461.177/0002-20' , 'Marceli Ciarelli Calçados - EPP' , 'Tennis Express 03 - Móoca - Marceli Ciarelli Calçados - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(496 , 496 , 'Marcia' , 0 , 'e.lojas@hotmail.com' , '(19) 3201-5633 / (19) 3722-5633' , 'indefinido');
    INSERT INTO cidade VALUES(497, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(497 , 497, 'São Paulo' , 'Rua Serra Dourada, 213');
    INSERT INTO cep VALUES(497 , 497 , '08.010-000');
    INSERT INTO endereco VALUES(497 , 497 , 'sn' , 'Rua Serra Dourada, 213');
    INSERT INTO cliente VALUES(497 , 497 , 1 , 'Tennis Express 04 - São Miguel - Patricia dos Reis Artigos Esportivos - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(497 , 497 , '13.404.738/0002-47' , 'Patricia dos Reis Artigos Esportivos - EPP' , 'Tennis Express 04 - São Miguel - Patricia dos Reis Artigos Esportivos - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(497 , 497 , 'Junior' , 0 , 'adm.awk@terra.com.br, junior.xambre@artwalk.com.br' , '(11) 2972-6222' , 'indefinido');
    INSERT INTO cidade VALUES(498, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(498 , 498, 'São Paulo' , 'Avenida Penha de França, 395');
    INSERT INTO cep VALUES(498 , 498 , '03.606-010');
    INSERT INTO endereco VALUES(498 , 498 , 'sn' , 'Avenida Penha de França, 395');
    INSERT INTO cliente VALUES(498 , 498 , 1 , 'Tennis Express 05 - Penha - Luiz Felipe de Souza Jorge - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(498 , 498 , '14.584.597/0001-73' , 'Luiz Felipe de Souza Jorge - ME' , 'Tennis Express 05 - Penha - Luiz Felipe de Souza Jorge - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(498 , 498 , '' , 0 , 'luiz.souza@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(499, 25 , 'Mogi Guaçu');
    INSERT INTO bairro VALUES(499 , 499, 'Mogi Guaçu' , 'Rua Apolinário, 58');
    INSERT INTO cep VALUES(499 , 499 , '13.840-035');
    INSERT INTO endereco VALUES(499 , 499 , 'sn' , 'Rua Apolinário, 58');
    INSERT INTO cliente VALUES(499 , 499 , 1 , 'Tennis Express 06 - Mogi Guaçu - V & M Artigos Esportivos - Ltda. - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(499 , 499 , '14.994.020/0001-30' , 'V & M Artigos Esportivos - Ltda. - ME' , 'Tennis Express 06 - Mogi Guaçu - V & M Artigos Esportivos - Ltda. - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(499 , 499 , '' , 0 , 'loja06@tennisexpress.com.br, waldir.martins@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(500, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(500 , 500, 'São Paulo' , 'Rua Teodoro Sampaio, 2109');
    INSERT INTO cep VALUES(500 , 500 , '05.405-200');
    INSERT INTO endereco VALUES(500 , 500 , 'sn' , 'Rua Teodoro Sampaio, 2109');
    INSERT INTO cliente VALUES(500 , 500 , 1 , 'Tennis Express 07 - Pinheiros - LGA Comércio de Calçados EIRELI - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(500 , 500 , '16.720.645/0001-39' , 'LGA Comércio de Calçados EIRELI - EPP' , 'Tennis Express 07 - Pinheiros - LGA Comércio de Calçados EIRELI - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(500 , 500 , 'Adriane' , 0 , 'adriane.alves@tennisexpress.com.br' , '(11) 2925-4060' , 'indefinido');
    INSERT INTO cidade VALUES(501, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(501 , 501, 'São Paulo' , 'Avenida Mateo Bei, 3376');
    INSERT INTO cep VALUES(501 , 501 , '03.949-013');
    INSERT INTO endereco VALUES(501 , 501 , 'sn' , 'Avenida Mateo Bei, 3376');
    INSERT INTO cliente VALUES(501 , 501 , 1 , 'Tennis Express 08 - São Matheus - 2FS Comércio de Calçados Ltda. - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(501 , 501 , '16.863.534/0001-81' , '2FS Comércio de Calçados Ltda. - ME' , 'Tennis Express 08 - São Matheus - 2FS Comércio de Calçados Ltda. - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(501 , 501 , '' , 0 , 'fernando_fumagalli@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(502, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(502 , 502, 'São Paulo' , 'Avenida Milton da Rocha, 82');
    INSERT INTO cep VALUES(502 , 502 , '02.138-010');
    INSERT INTO endereco VALUES(502 , 502 , 'sn' , 'Avenida Milton da Rocha, 82');
    INSERT INTO cliente VALUES(502 , 502 , 1 , 'Tennis Express 09 - Vila Sabrina - Jofan Confecções e Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(502 , 502 , '43.569.185/0001-62' , 'Jofan Confecções e Calçados Ltda.' , 'Tennis Express 09 - Vila Sabrina - Jofan Confecções e Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(502 , 502 , '' , 0 , 'guilherme.almeida@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(503, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(503 , 503, 'São Paulo' , 'Rua Augusta, 2496');
    INSERT INTO cep VALUES(503 , 503 , '01.412-100');
    INSERT INTO endereco VALUES(503 , 503 , 'sn' , 'Rua Augusta, 2496');
    INSERT INTO cliente VALUES(503 , 503 , 1 , 'Tennis Express 10 - Augusta - M C de Pinho Calçados - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(503 , 503 , '17.292.297/0001-09' , 'M C de Pinho Calçados - EPP' , 'Tennis Express 10 - Augusta - M C de Pinho Calçados - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(503 , 503 , '' , 0 , 'loja10@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(504, 25 , 'Osasco');
    INSERT INTO bairro VALUES(504 , 504, 'Osasco' , 'Via Rua Dona Primitiva Vianco, 100 - Loj 32');
    INSERT INTO cep VALUES(504 , 504 , '06.016-000');
    INSERT INTO endereco VALUES(504 , 504 , 'sn' , 'Via Rua Dona Primitiva Vianco, 100 - Loj 32');
    INSERT INTO cliente VALUES(504 , 504 , 1 , 'Tennis Express 11 - Galeria Osasco - Foot Run Comércio de Calçados Ltda. - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(504 , 504 , '17.494.993/0001-06' , 'Foot Run Comércio de Calçados Ltda. - EPP' , 'Tennis Express 11 - Galeria Osasco - Foot Run Comércio de Calçados Ltda. - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(504 , 504 , '' , 0 , 'carlos.oliveira@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(505, 24 , 'São Carlos');
    INSERT INTO bairro VALUES(505 , 505, 'São Carlos' , 'Rua General Osório, 821');
    INSERT INTO cep VALUES(505 , 505 , '13.560-640');
    INSERT INTO endereco VALUES(505 , 505 , 'sn' , 'Rua General Osório, 821');
    INSERT INTO cliente VALUES(505 , 505 , 1 , 'Tennis Express 12 - São Carlos - CKMIYA Sports Ltda. - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(505 , 505 , '17.750.897/0001-73' , 'CKMIYA Sports Ltda. - ME' , 'Tennis Express 12 - São Carlos - CKMIYA Sports Ltda. - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(505 , 505 , '' , 0 , 'celso.miyazaki@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(506, 16 , 'Cascavel');
    INSERT INTO bairro VALUES(506 , 506, 'Cascavel' , 'Rua Sete de Setembro, 2958 - Sala 3');
    INSERT INTO cep VALUES(506 , 506 , '85.801-140');
    INSERT INTO endereco VALUES(506 , 506 , 'sn' , 'Rua Sete de Setembro, 2958 - Sala 3');
    INSERT INTO cliente VALUES(506 , 506 , 1 , 'Tennis Express 13 - Cascavel - Cortani Comércio de Tênis Ltda. - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(506 , 506 , '17.846.794/0001-01' , 'Cortani Comércio de Tênis Ltda. - ME' , 'Tennis Express 13 - Cascavel - Cortani Comércio de Tênis Ltda. - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(506 , 506 , '' , 0 , 'sergio.corso@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(507, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(507 , 507, 'São Paulo' , 'Rua Tuiuti, 1941');
    INSERT INTO cep VALUES(507 , 507 , '03.307-005');
    INSERT INTO endereco VALUES(507 , 507 , 'sn' , 'Rua Tuiuti, 1941');
    INSERT INTO cliente VALUES(507 , 507 , 1 , 'Tennis Express 14 - Tatuapé - R3 Calçados Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(507 , 507 , '17.879.692/0001-92' , 'R3 Calçados Ltda.' , 'Tennis Express 14 - Tatuapé - R3 Calçados Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(507 , 507 , '' , 0 , 'loja14@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(508, 25 , 'Itaquaquecetuba');
    INSERT INTO bairro VALUES(508 , 508, 'Itaquaquecetuba' , 'Rua Capitão José Leite, 37');
    INSERT INTO cep VALUES(508 , 508 , '08.570-030');
    INSERT INTO endereco VALUES(508 , 508 , 'sn' , 'Rua Capitão José Leite, 37');
    INSERT INTO cliente VALUES(508 , 508 , 1 , 'Tennis Express 15 - Itaquaquecetuba - Cinthya Sakaguchi Artigos Esportivos - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(508 , 508 , '17.881.883/0001-99' , 'Cinthya Sakaguchi Artigos Esportivos - EPP' , 'Tennis Express 15 - Itaquaquecetuba - Cinthya Sakaguchi Artigos Esportivos - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(508 , 508 , 'Junior' , 0 , 'adm.awk@terra.com.br, junior.xambre@artwalk.com.br' , '(11) 2972-6222' , 'indefinido');
    INSERT INTO cidade VALUES(509, 25 , 'Itatiba');
    INSERT INTO bairro VALUES(509 , 509, 'Itatiba' , 'Rua Rui Barbosa, 251');
    INSERT INTO cep VALUES(509 , 509 , '13.250-280');
    INSERT INTO endereco VALUES(509 , 509 , 'sn' , 'Rua Rui Barbosa, 251');
    INSERT INTO cliente VALUES(509 , 509 , 1 , 'Tennis Express 16 - Itatiba - Experts Shoes Comércio de Calçados Ltda. - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(509 , 509 , '18.058.746/0001-11' , 'Experts Shoes Comércio de Calçados Ltda. - EPP' , 'Tennis Express 16 - Itatiba - Experts Shoes Comércio de Calçados Ltda. - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(509 , 509 , '' , 0 , 'marcia.pupo@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(510, 25 , 'Campinas');
    INSERT INTO bairro VALUES(510 , 510, 'Campinas' , 'Rua Treze de Maio, 284');
    INSERT INTO cep VALUES(510 , 510 , '13.010-070');
    INSERT INTO endereco VALUES(510 , 510 , 'sn' , 'Rua Treze de Maio, 284');
    INSERT INTO cliente VALUES(510 , 510 , 1 , 'Tennis Express 17 - Campinas - P. de Castro Ciarelli Calçados e Acessórios - EIRELLI' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(510 , 510 , '13.304.759/0002-90' , 'P. de Castro Ciarelli Calçados e Acessórios - EIRELLI' , 'Tennis Express 17 - Campinas - P. de Castro Ciarelli Calçados e Acessórios - EIRELLI' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(510 , 510 , 'Marcia' , 0 , 'e.lojas@hotmail.com' , '(19) 3201-5633 / (19) 3722-5633' , 'indefinido');
    INSERT INTO cidade VALUES(511, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(511 , 511, 'São Paulo' , 'Avenida Marechal Tito, 4490');
    INSERT INTO cep VALUES(511 , 511 , '08.115-000');
    INSERT INTO endereco VALUES(511 , 511 , 'sn' , 'Avenida Marechal Tito, 4490');
    INSERT INTO cliente VALUES(511 , 511 , 1 , 'Tennis Express 18 - Marechal Tito - Luiz Felipe de Souza Jorge - ME' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(511 , 511 , '14.584.597/0002-54' , 'Luiz Felipe de Souza Jorge - ME' , 'Tennis Express 18 - Marechal Tito - Luiz Felipe de Souza Jorge - ME' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(511 , 511 , '' , 0 , 'luiz.souza@tennisexpress.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(512, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(512 , 512, 'São Paulo' , 'Avenida Sapopemba, 8061');
    INSERT INTO cep VALUES(512 , 512 , '03.988-010');
    INSERT INTO endereco VALUES(512 , 512 , 'sn' , 'Avenida Sapopemba, 8061');
    INSERT INTO cliente VALUES(512 , 512 , 1 , 'Tennis Express 20 - Sapopemba - Rita de Cassia Silva Pereira - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(512 , 512 , '18.261.607/0002-71' , 'Rita de Cassia Silva Pereira - EPP' , 'Tennis Express 20 - Sapopemba - Rita de Cassia Silva Pereira - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(512 , 512 , 'Fernando' , 0 , 'fernando_fumagalli@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(513, 25 , 'Mauá');
    INSERT INTO bairro VALUES(513 , 513, 'Mauá' , 'Avenida Barão de Mauá, 359');
    INSERT INTO cep VALUES(513 , 513 , '09.310-000');
    INSERT INTO endereco VALUES(513 , 513 , 'sn' , 'Avenida Barão de Mauá, 359');
    INSERT INTO cliente VALUES(513 , 513 , 1 , 'Tennis Express 21 - Mauá - Cinthya Sakaguchi Artigos Esportivos - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(513 , 513 , '17.881.883/0002-70' , 'Cinthya Sakaguchi Artigos Esportivos - EPP' , 'Tennis Express 21 - Mauá - Cinthya Sakaguchi Artigos Esportivos - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(513 , 513 , 'Junior' , 0 , 'adm.awk@terra.com.br, junior.xambre@artwalk.com.br' , '(11) 2972-6222' , 'indefinido');
    INSERT INTO cidade VALUES(514, 16 , 'Cascavel');
    INSERT INTO bairro VALUES(514 , 514, 'Cascavel' , 'Avenida Brasil, 5924');
    INSERT INTO cep VALUES(514 , 514 , '85801-000');
    INSERT INTO endereco VALUES(514 , 514 , 'sn' , 'Avenida Brasil, 5924');
    INSERT INTO cliente VALUES(514 , 514 , 1 , 'Tennis Express 23 - Cascavel - Cortani Comércio de Tênis Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(514 , 514 , '17.846.794/0002-92' , 'Cortani Comércio de Tênis Ltda.' , 'Tennis Express 23 - Cascavel - Cortani Comércio de Tênis Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(514 , 514 , 'Sérgio Corso' , 0 , 'sergio.corso@tennisexpress.com.br' , '(45) 3039-5924' , 'indefinido');
    INSERT INTO cidade VALUES(515, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(515 , 515, 'São Paulo' , 'Rua Salvador Gianetti, 1020');
    INSERT INTO cep VALUES(515 , 515 , '08410-000');
    INSERT INTO endereco VALUES(515 , 515 , 'sn' , 'Rua Salvador Gianetti, 1020');
    INSERT INTO cliente VALUES(515 , 515 , 1 , 'Tennis Express 24 - Guianazes - Duas Meninas Artigos Esportivos Eireli - EPP' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(515 , 515 , '19.804.838/0001-66' , 'Duas Meninas Artigos Esportivos Eireli - EPP' , 'Tennis Express 24 - Guianazes - Duas Meninas Artigos Esportivos Eireli - EPP' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(515 , 515 , 'Sabrina' , 0 , 'loja24@tennisexpress.com.brvivian1110@gmail.comleonidas@redeoba.com.br,marcos.bruno@redeoba.com.br,charles.moreira@redeoba.com.brh6523-gl@accor.com.brh7435-gl@accor.com.br,h7435-gl1@accor.com.brsusimara.borges@loucosesantos.com.brpforster@levi.comlucas@jofashion.com.brh7130-gl2@accor.com.br, h7130-gl@accor.com.brh2992-gl2@accor.com.brh3541-gl1@accor.com.brcintia.bravo@thebeautybox.com.brfernanda.teixeira@thebeautybox.com.brcontato@postosanmarino.com.brlartoni@brhomecenters.com.brpriscila.anjos@cea.com.br, luciana.paula@cea.com.brh7547-gl@accor.com.br, h7547-gl1@accor.com.brh6000-gl@accor.com.br, h6000-gm@accor.com.bradmmercure@terra.com.brh6314-gl@accor.com.brmkt02@caseli.com.br, marcos@lojasavenida.com.br, paula.borges@lojasavenida.com.brfelipe@miranville.com.br,vilma@miranville.com.br,rose@miranville.com.brkarla@montesclarosshopping.com.br,marcel@montesclarosshopping.com.brpassarelacg@gmail.com,passarelamodas@terra.com.br,financeiro@passaletti.com.brmaiara.martins@gabriela.com.brpaiolcer@terra.com.brthiago.guimaraes@accor.com.br,h3221-gl@accor.com.brh3670-gl@accor.com.brh6348-gl@accor.com.brh5541-gl@accor.com, h5541-gm@accor.com.br,h5541-dm@accor.com.brh5460-gl@accor.com.br, h5460-gm@accor.com.brfernando_fumagalli@hotmail.comh7380-gl@accor.com.br,h7380-dm@accor.com.brh8139-dm@accor.comh8139-gl@accor.com.brH7152-GL@accor.com.brH7152-GL@accor.com.brandre.ximenes@eskala.com.brheloisa.coltro@litamortari.com.br,marly.silva@litamortari.com.brrfrancisco@levi.com, pforster@levi.comlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.brlevis-rp@uol.com.branara.pizzo@terra.com.brluiz@gmvarejo.com.brlslima@leader.com.br, pscosta@leader.com.brcamila@jorgebischoff.com.brkelly@saccaria.com.br, financeiro@saccaria.com.br, ronaldo@saccaria.com.brvanessaduarte@societahair.com.brseferian@streetblock.com.br, daiana@streetblock.com.br, daiana.moura@streetblock.com.br, daianamoura90@gmail.comh7361-gl2@accor.com.brh2043-gl1@accor.com.brvinicius.emiliano@cacula.com, juliana.castello@cacula.com, fernando.goncalves@cacula.comnfe@tanger.com.br, michele@tanger.com.br, marilaine@tanger.com.brfinanceiro@oksuperatacado.com.br, marketing@oksuperatacado.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(516, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(516 , 516, 'Belo Horizonte' , 'Av. dos Andradas, n.3.000, Loja 3047, Piso 3');
    INSERT INTO cep VALUES(516 , 516 , '30260-070');
    INSERT INTO endereco VALUES(516 , 516 , 'sn' , 'Av. dos Andradas, n.3.000, Loja 3047, Piso 3');
    INSERT INTO cliente VALUES(516 , 516 , 1 , 'The Beauty Box - Shopping Boulevard BH - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(516 , 516 , '11.137.051/0302-55' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Boulevard BH - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(516 , 516 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(517, 25 , 'São Bernardo do Campo');
    INSERT INTO bairro VALUES(517 , 517, 'São Bernardo do Campo' , 'Av. Keneddy, nº 700, Loja 244/245,');
    INSERT INTO cep VALUES(517 , 517 , '09726-253');
    INSERT INTO endereco VALUES(517 , 517 , 'sn' , 'Av. Keneddy, nº 700, Loja 244/245,');
    INSERT INTO cliente VALUES(517 , 517 , 1 , 'The Beauty Box - Shopping Golden Square - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(517 , 517 , '11.137.051/0309-21' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Golden Square - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(517 , 517 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(518, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(518 , 518, 'Belo Horizonte' , 'Rodovia BR-356, 3049');
    INSERT INTO cep VALUES(518 , 518 , '30.320-900');
    INSERT INTO endereco VALUES(518 , 518 , 'sn' , 'Rodovia BR-356, 3049');
    INSERT INTO cliente VALUES(518 , 518 , 1 , 'The Beauty Box - BH Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(518 , 518 , '11.137.051/0234-70' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - BH Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(518 , 518 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(519, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(519 , 519, 'Curitiba' , 'Avenida do Batel, sn');
    INSERT INTO cep VALUES(519 , 519 , '80.420-090');
    INSERT INTO endereco VALUES(519 , 519 , 'sn' , 'Avenida do Batel, sn');
    INSERT INTO cliente VALUES(519 , 519 , 1 , 'The Beauty Box - Curitiba Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(519 , 519 , '11.137.051/0268-19' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Curitiba Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(519 , 519 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(520, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(520 , 520, 'Belo Horizonte' , 'Avenida Olegário Maciel, 1600');
    INSERT INTO cep VALUES(520 , 520 , '30.180-915');
    INSERT INTO endereco VALUES(520 , 520 , 'sn' , 'Avenida Olegário Maciel, 1600');
    INSERT INTO cliente VALUES(520 , 520 , 1 , 'The Beauty Box - Diamond Mall - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(520 , 520 , '11.137.051/0235-50' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Diamond Mall - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(520 , 520 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(521, 25 , 'Cotia');
    INSERT INTO bairro VALUES(521 , 521, 'Cotia' , 'Via Rodovia Raposo Tavares, Km, 23');
    INSERT INTO cep VALUES(521 , 521 , '06.709-015');
    INSERT INTO endereco VALUES(521 , 521 , 'sn' , 'Via Rodovia Raposo Tavares, Km, 23');
    INSERT INTO cliente VALUES(521 , 521 , 1 , 'The Beauty Box - Granja Viana - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(521 , 521 , '11.137.051/0224-06' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Granja Viana - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(521 , 521 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(522, 25 , 'Ribeirão Preto');
    INSERT INTO bairro VALUES(522 , 522, 'Ribeirão Preto' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 110');
    INSERT INTO cep VALUES(522 , 522 , '14.026-900');
    INSERT INTO endereco VALUES(522 , 522 , 'sn' , 'Avenida Coronel Fernando Ferreira Leite, 1540 - Loja 110');
    INSERT INTO cliente VALUES(522 , 522 , 1 , 'The Beauty Box - Ribeirão Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(522 , 522 , '11.137.051/0181-23' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Ribeirão Shopping - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(522 , 522 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(523, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(523 , 523, 'São Paulo' , 'Avenida Regente Feijó, 1739');
    INSERT INTO cep VALUES(523 , 523 , '03.342-000');
    INSERT INTO endereco VALUES(523 , 523 , 'sn' , 'Avenida Regente Feijó, 1739');
    INSERT INTO cliente VALUES(523 , 523 , 1 , 'The Beauty Box - Shopping Anália Franco - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(523 , 523 , '11.137.051/0221-55' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Anália Franco - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(523 , 523 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(524, 25 , 'São José dos Campos');
    INSERT INTO bairro VALUES(524 , 524, 'São José dos Campos' , 'Avenida Deputado Benedito Matarazzo, 9403, 9403 - Loja M123');
    INSERT INTO cep VALUES(524 , 524 , '12.215-900');
    INSERT INTO endereco VALUES(524 , 524 , 'sn' , 'Avenida Deputado Benedito Matarazzo, 9403, 9403 - Loja M123');
    INSERT INTO cliente VALUES(524 , 524 , 1 , 'The Beauty Box - Shopping Center Vale - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(524 , 524 , '11.137.051/0178-28' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Center Vale - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(524 , 524 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(525, 25 , 'Campinas');
    INSERT INTO bairro VALUES(525 , 525, 'Campinas' , 'Campo Avenida Guilherme s, 500, 500');
    INSERT INTO cep VALUES(525 , 525 , '13.087-901');
    INSERT INTO endereco VALUES(525 , 525 , 'sn' , 'Campo Avenida Guilherme s, 500, 500');
    INSERT INTO cliente VALUES(525 , 525 , 1 , 'The Beauty Box - Shopping Dom Pedro - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(525 , 525 , '11.137.051/0192-86' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Dom Pedro - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(525 , 525 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(526, 25 , 'Votorantim');
    INSERT INTO bairro VALUES(526 , 526, 'Votorantim' , 'Avenida Gisele Constantino, 1800 - Loja 261-262 - Piso Sorocaba');
    INSERT INTO cep VALUES(526 , 526 , '18.110-650');
    INSERT INTO endereco VALUES(526 , 526 , 'sn' , 'Avenida Gisele Constantino, 1800 - Loja 261-262 - Piso Sorocaba');
    INSERT INTO cliente VALUES(526 , 526 , 1 , 'The Beauty Box - Shopping Iguatemi Esplanada - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(526 , 526 , '11.137.051/0270-33' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Iguatemi Esplanada - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(526 , 526 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(527, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(527 , 527, 'São Paulo' , 'Avenida Interlagos, 2255');
    INSERT INTO cep VALUES(527 , 527 , '04.661-200');
    INSERT INTO endereco VALUES(527 , 527 , 'sn' , 'Avenida Interlagos, 2255');
    INSERT INTO cliente VALUES(527 , 527 , 1 , 'The Beauty Box - Shopping Interlagos - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(527 , 527 , '11.137.051/0200-20' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Interlagos - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(527 , 527 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(528, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(528 , 528, 'São Paulo' , 'Rua Capitão Pacheco e Chaves, 313');
    INSERT INTO cep VALUES(528 , 528 , '03.126-000');
    INSERT INTO endereco VALUES(528 , 528 , 'sn' , 'Rua Capitão Pacheco e Chaves, 313');
    INSERT INTO cliente VALUES(528 , 528 , 1 , 'The Beauty Box - Shopping Mooca - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(528 , 528 , '11.137.051/0191-03' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Mooca - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(528 , 528 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(529, 16 , 'Curitiba');
    INSERT INTO bairro VALUES(529 , 529, 'Curitiba' , 'Avenida do Batel, 1868');
    INSERT INTO cep VALUES(529 , 529 , '80.420-090');
    INSERT INTO endereco VALUES(529 , 529 , 'sn' , 'Avenida do Batel, 1868');
    INSERT INTO cliente VALUES(529 , 529 , 1 , 'The Beauty Box - Shopping Pátio Batel - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(529 , 529 , '11.137.051/0260-61' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Pátio Batel - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(529 , 529 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(530, 25 , 'Barueri');
    INSERT INTO bairro VALUES(530 , 530, 'Barueri' , 'Avenida Piracema, 669');
    INSERT INTO cep VALUES(530 , 530 , '06.460-030');
    INSERT INTO endereco VALUES(530 , 530 , 'sn' , 'Avenida Piracema, 669');
    INSERT INTO cliente VALUES(530 , 530 , 1 , 'The Beauty Box - Shopping Tamboré - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(530 , 530 , '11.137.051/0194-48' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Tamboré - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(530 , 530 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(531, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(531 , 531, 'São Paulo' , 'Avenida das Nações Unidas, 4777 - Lj 245/246B');
    INSERT INTO cep VALUES(531 , 531 , '05.477-000');
    INSERT INTO endereco VALUES(531 , 531 , 'sn' , 'Avenida das Nações Unidas, 4777 - Lj 245/246B');
    INSERT INTO cliente VALUES(531 , 531 , 1 , 'The Beauty Box - Shopping Vila Lobos - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(531 , 531 , '11.137.051/0222-36' , 'Interbelle Com. de Produtos de Beleza Ltda.' , 'The Beauty Box - Shopping Vila Lobos - Interbelle Com. de Produtos de Beleza Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(531 , 531 , 'Carolina' , 0 , 'leandros@grupoboticario.com.br,carolina.marques@thebeautybox.com.br' , '(11) 3809-5668' , 'indefinido');
    INSERT INTO cidade VALUES(532, 25 , 'São Paulo');
    INSERT INTO bairro VALUES(532 , 532, 'São Paulo' , 'Rua Tenente Negrão, 200');
    INSERT INTO cep VALUES(532 , 532 , '04.530-030');
    INSERT INTO endereco VALUES(532 , 532 , 'sn' , 'Rua Tenente Negrão, 200');
    INSERT INTO cliente VALUES(532 , 532 , 1 , 'The Capital Flat - Edifício The Capital Flta' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(532 , 532 , '02.725.151/0001-32' , 'Edifício The Capital Flta' , 'The Capital Flat - Edifício The Capital Flta' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(532 , 532 , '' , 0 , 'contasapagar@thecapital.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(533, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(533 , 533, 'Cuiabá' , 'Avenida Fernando Correa da Costa, 1100');
    INSERT INTO cep VALUES(533 , 533 , '78.065-000');
    INSERT INTO endereco VALUES(533 , 533 , 'sn' , 'Avenida Fernando Correa da Costa, 1100');
    INSERT INTO cliente VALUES(533 , 533 , 1 , 'Todeschini Fernando Correa - ACL Comércio de Móveis' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(533 , 533 , '02.961.567/0001-50' , 'ACL Comércio de Móveis' , 'Todeschini Fernando Correa - ACL Comércio de Móveis' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(533 , 533 , 'Alex' , 0 , 'alex.linhares@todeschinifernandocorrea.com.br' , '(65) 3925-9003 / 8119-8567' , 'indefinido');
    INSERT INTO cidade VALUES(534, 11 , 'Cuiabá');
    INSERT INTO bairro VALUES(534 , 534, 'Cuiabá' , 'Avenida Isaac Póvoas, 1039');
    INSERT INTO cep VALUES(534 , 534 , '78.032-015');
    INSERT INTO endereco VALUES(534 , 534 , 'sn' , 'Avenida Isaac Póvoas, 1039');
    INSERT INTO cliente VALUES(534 , 534 , 1 , 'Todeschini Goiabeiras - West Comércio de Móveis Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(534 , 534 , '73.570.004/0001-89' , 'West Comércio de Móveis Ltda.' , 'Todeschini Goiabeiras - West Comércio de Móveis Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(534 , 534 , '' , 0 , 'marketing@todeschinigoiabeiras.com.br,financeiro@todeschinigoiabeiras.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(535, 9 , 'Jataí');
    INSERT INTO bairro VALUES(535 , 535, 'Jataí' , 'Avenida Goiás, 843');
    INSERT INTO cep VALUES(535 , 535 , '75.800-012');
    INSERT INTO endereco VALUES(535 , 535 , 'sn' , 'Avenida Goiás, 843');
    INSERT INTO cliente VALUES(535 , 535 , 1 , 'Transatom - E. S. Guimarães' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(535 , 535 , '13.385.402/0001-01' , 'E. S. Guimarães' , 'Transatom - E. S. Guimarães' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(535 , 535 , '' , 0 , 'financeiro@transatom.com.br,nfe@transatom.com.br' , '' , 'indefinido');
    INSERT INTO cidade VALUES(536, 13 , 'Belo Horizonte');
    INSERT INTO bairro VALUES(536 , 536, 'Belo Horizonte' , 'Rua Grão Mogol, 1045');
    INSERT INTO cep VALUES(536 , 536 , '30.315-600');
    INSERT INTO endereco VALUES(536 , 536 , 'sn' , 'Rua Grão Mogol, 1045');
    INSERT INTO cliente VALUES(536 , 536 , 1 , 'Yukai - Empreendimento Nutricional Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(536 , 536 , '03.353.890/0001-03' , 'Empreendimento Nutricional Ltda.' , 'Yukai - Empreendimento Nutricional Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(536 , 536 , '' , 0 , 'dani.123.santos@hotmail.com, elizabetimonteiro@hotmail.com' , '' , 'indefinido');
    INSERT INTO cidade VALUES(537, 25 , 'Ferraz de Vasconcelos');
    INSERT INTO bairro VALUES(537 , 537, 'Ferraz de Vasconcelos' , 'Av. Brasil, 1374');
    INSERT INTO cep VALUES(537 , 537 , '08.500-020');
    INSERT INTO endereco VALUES(537 , 537 , 'sn' , 'Av. Brasil, 1374');
    INSERT INTO cliente VALUES(537 , 537 , 1 , 'Águia Shoes Vila Romanopolis Lj 12 - H.P. Calçados e Confecções Ltda.' , 0 , 0 , 1);
    INSERT INTO dados_cliente VALUES(537 , 537 , '20.185.626/0001-27' , 'H.P. Calçados e Confecções Ltda.' , 'Águia Shoes Vila Romanopolis Lj 12 - H.P. Calçados e Confecções Ltda.' , 0 , now() , now() , 1);
    INSERT INTO contato_cliente VALUES(537 , 537 , 'Rodrigo' , 0 , 'rodrigo_aguia@terra.com.br,rocha.roberta@terra.com.br,antonio@aguiashoes.com.br,lucicleide@aguiashoes.com.br' , '' , 'indefinido');

-- adiciona valor do contrato
alter table dados_cliente add column valor_contrato decimal(10,2) not null default '0.0';

-- adiciona tipo de faturamento
alter table cliente add column faturameno_matriz tinyint(1) not null default '1';

-- helpdesk
CREATE TABLE IF NOT EXISTS  ocorrencia_prioridade (
        id integer(11) not null auto_increment,
        descricao varchar(255) not null ,
        nivel integer(11) not null ,
        primary key(id)
);

CREATE TABLE IF NOT EXISTS  ocorrencia_origem (
        id integer(11) not null auto_increment,
        descricao varchar(255) not null ,
        primary key(id)
);

CREATE TABLE IF NOT EXISTS  ocorrencia_status (
        id integer(11) not null auto_increment,
        descricao varchar(255) not null ,
        cor varchar(10) not null ,
        primary key(id)
);

CREATE TABLE IF NOT EXISTS  ocorrencia_problema (
        id integer(11) not null auto_increment,
        descricao text not null,
        primary key(id)
);

CREATE TABLE IF NOT EXISTS  ocorrencia_solucao (
        id integer(11) not null auto_increment,
        descricao text not null,
        prazo_resolucao datetime,
        primary key(id)
);


CREATE TABLE IF NOT EXISTS  ocorrencia_problema_solucao (
        id integer(11) not null auto_increment,
        ocorrencia_problema integer(11) not null,
        ocorrencia_solucao integer(11) not null,
        primary key(id),
        foreign key(ocorrencia_problema) references ocorrencia_problema(id),
        foreign key(ocorrencia_solucao) references ocorrencia_solucao(id)
);

CREATE TABLE IF NOT EXISTS  ocorrencia (
        id integer(11) not null auto_increment,
        descricao text not null,
        data_cadastro date not null,
        ocorrencia_problema integer(11),
        ocorrencia_solucao integer(11),
        ocorrencia_origem integer(11),
        data_resolucao date,
        usuario_criacao integer(11),
        ocorrencia_prioridade integer(11) not null,
        cliente integer(11) not null,
        primary key(id),
        foreign key(ocorrencia_origem) references ocorrencia_origem(id),
        foreign key(usuario_criacao) references usuario(idusuario),
        foreign key(ocorrencia_prioridade) references ocorrencia_prioridade(id),
        foreign key(cliente) references cliente(idcliente)
);

CREATE TABLE IF NOT EXISTS  ocorrencia_usuario (
        id integer(11) not null auto_increment,
        ocorrencia integer(11),
        usuario integer(11),
        prazo_resolucao datetime,
        ocorrencia_status integer(11),
        primary key(id),
        foreign key(ocorrencia) references ocorrencia(id),
        foreign key(usuario) references usuario(idusuario)
);


-- permições
INSERT INTO funcionalidade VALUES (70, '/ocorrencia-origem', 'Origem da ocorrencia' , 'fa-exchange' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (71, '/ocorrencia-origem/cadastrar', 'Formulário de cadastro da origem da ocorrencia' , 'fa-exchange'    , 70 , 0 ); 
INSERT INTO funcionalidade VALUES (72, '/ocorrencia-origem/atualizar/{id}', 'Formulário de atualização da origem da ocorrencia' , 'fa-exchange' , 70 , 0 ); 
INSERT INTO funcionalidade VALUES (73, '/ocorrencia-origem/remover/{id}', 'Formulário de remoção da origem da ocorrencia' , 'fa-exchange'   , 70 , 0 ); 

INSERT INTO funcionalidade VALUES (80, '/ocorrencia-status', 'Situação da ocorrencia' , 'fa-star' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (81, '/ocorrencia-status/cadastrar', 'Formulário de cadastro da situação da ocorrencia' , 'fa-star'    , 80 , 0 ); 
INSERT INTO funcionalidade VALUES (82, '/ocorrencia-status/atualizar/{id}', 'Formulário de atualização da situação da ocorrencia' , 'fa-star' , 80 , 0 ); 
INSERT INTO funcionalidade VALUES (83, '/ocorrencia-status/remover/{id}', 'Formulário de remoção da situação da ocorrencia' , 'fa-star'   , 80 , 0 ); 

INSERT INTO funcionalidade VALUES (90, '/ocorrencia-prioridade', 'Prioridade da ocorrencia' , 'fa-sliders' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (91, '/ocorrencia-prioridade/cadastrar', 'Formulário de cadastro da prioridade da ocorrencia' , 'fa-sliders'    , 90 , 0 ); 
INSERT INTO funcionalidade VALUES (92, '/ocorrencia-prioridade/atualizar/{id}', 'Formulário de atualização da prioridade da ocorrencia' , 'fa-sliders' , 90 , 0 ); 
INSERT INTO funcionalidade VALUES (93, '/ocorrencia-prioridade/remover/{id}', 'Formulário de remoção da prioridade da ocorrencia' , 'fa-sliders'   , 90 , 0 ); 

INSERT INTO funcionalidade VALUES (100, '/ocorrencia-problema', 'Problema padrões' , 'fa-recycle' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (101, '/ocorrencia-problema/cadastrar', 'Formulário de cadastro da problema da ocorrencia' , 'fa-recycle'    , 100 , 0 ); 
INSERT INTO funcionalidade VALUES (102, '/ocorrencia-problema/atualizar/{id}', 'Formulário de atualização da problema da ocorrencia' , 'fa-recycle' , 100 , 0 ); 
INSERT INTO funcionalidade VALUES (103, '/ocorrencia-problema/remover/{id}', 'Formulário de remoção da problema da ocorrencia' , 'fa-recycle'   , 100 , 0 ); 

INSERT INTO funcionalidade VALUES (110, '/ocorrencia-solucao', 'Soluçoes padrões' , 'fa-bolt' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (111, '/ocorrencia-solucao/cadastrar', 'Formulário de cadastro da solução da ocorrencia' , 'fa-bolt'    , 110 , 0 ); 
INSERT INTO funcionalidade VALUES (112, '/ocorrencia-solucao/atualizar/{id}', 'Formulário de atualização da solução da ocorrencia' , 'fa-bolt' , 110 , 0 ); 
INSERT INTO funcionalidade VALUES (113, '/ocorrencia-solucao/remover/{id}', 'Formulário de remoção da solução da ocorrencia' , 'fa-bolt'   , 110 , 0 ); 

INSERT INTO funcionalidade VALUES (120, '/ocorrencia', 'Ocorrencia' , 'fa-bug' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (121, '/ocorrencia/cadastrar', 'Formulário de cadastro da  ocorrencia' , 'fa-bug'    , 120 , 0 ); 
INSERT INTO funcionalidade VALUES (122, '/ocorrencia/atualizar/{id}', 'Formulário de atualização da ocorrencia' , 'fa-bug' , 120 , 0 ); 
INSERT INTO funcionalidade VALUES (123, '/ocorrencia/remover/{id}', 'Formulário de remoção da ocorrencia' , 'fa-bug'   , 120 , 0 ); 

insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 70;

-- configuraçoes dos arquivos por cliente
alter table config_app drop audiostore_musica_dir_origem;
alter table config_app drop audiostore_musica_dir_destino;

alter table dados_cliente add column local_origem_musica  varchar(255) not null default '';
alter table dados_cliente add column local_destino_musica varchar(255) not null default '';
alter table dados_cliente add column local_origem_spot    varchar(255) not null default '';
alter table dados_cliente add column local_destino_spot   varchar(255) not null default '';
alter table dados_cliente add column local_destino_exp    varchar(255) not null default '';

INSERT INTO funcionalidade VALUES (130, '/cliente-configuracao/{id}', 'Configuração do cliente' , 'fa-cog' , 0 , 1 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 70;

-- relaciona musica com o cliente
alter table audiostore_musica add column cliente integer(11) not null default 1;
alter table audiostore_musica add foreign key (cliente) references cliente(idcliente);

alter table audiostore_comercial add column cliente integer(11) not null default 1;
alter table audiostore_comercial add foreign key (cliente) references cliente(idcliente);

alter table ocorrencia_usuario drop column prazo_resolucao;
CREATE TABLE IF NOT EXISTS  ocorrencia_usuario_info (
	id integer(11) not null auto_increment,
	ocorrencia_usuario integer(11),
	comentario text,
	tempo time,
	primary key(id),
	foreign key(ocorrencia_usuario) references ocorrencia_usuario(id)
);

ALTER TABLE auditoria CHANGE COLUMN entidade entidade TEXT NOT NULL ;


alter table cliente add column codigo_interno varchar(255) default '';
alter table cliente add column codigo_externo varchar(255) default '';
alter table bairro add column tipo varchar(255) default '';
CREATE TABLE IF NOT EXISTS indice_reajuste (
	id integer(11) not null auto_increment,
	tipo varchar(10) not null,
	descricao varchar(255) not null,
	percentual decimal(10,0) not null,
	primary key(id)
);

CREATE TABLE IF NOT EXISTS indice_reajuste_historico (
	id integer(11) not null auto_increment,
	indice_reajuste integer(11) not null,
	usuario integer(11) not null,
	texto varchar(255) not null,
	data datetime not null,
	primary key(id),
	foreign key(indice_reajuste) references indice_reajuste(id),
	foreign key(usuario) references usuario(idusuario)
);

alter table dados_cliente add column indice_reajuste integer(11);
alter table dados_cliente add foreign key(indice_reajuste) references indice_reajuste(id);
alter table indice_reajuste modify column percentual varchar(10) not null;

INSERT INTO funcionalidade VALUES (140, '/indice-reajuste', 'Indice de reajuste' , 'fa-sort-numeric-desc ' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (141, '/indice-reajuste/cadastrar', 'Formulário de cadastro de indice' , 'fa-sort-numeric-desc '    , 140 , 0 ); 
INSERT INTO funcionalidade VALUES (142, '/indice-reajuste/atualizar/{id}', 'Formulário de atualização de indice' , 'fa-sort-numeric-desc ' , 140 , 0 ); 
INSERT INTO funcionalidade VALUES (143, '/indice-reajuste/remover/{id}', 'Formulário de remoção de indice' , 'fa-sort-numeric-desc '   , 140 , 0 ); 

insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 140;

INSERT INTO funcionalidade VALUES (145, '/minha-ocorrencia', 'Ocorrencias tratadas por min' , 'fa-bug '   , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (146, '/minha-ocorrencia/cadastrar', 'Formulário de cadastro da  ocorrencia' , 'fa-bug'    , 145 , 0 ); 
INSERT INTO funcionalidade VALUES (147, '/minha-ocorrencia/atualizar/{id}', 'Formulário de atualização da ocorrencia' , 'fa-bug' , 145 , 0 ); 
INSERT INTO funcionalidade VALUES (148, '/minha-ocorrencia/remover/{id}', 'Formulário de remoção da ocorrencia' , 'fa-bug'   , 145 , 0 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 145;

INSERT INTO funcionalidade VALUES (180, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 

where idperfil = 1 and funcionalidade.idfuncionalidade = 180;
ALTER TABLE audiostore_comercial add column interromper_musica_tocada tinyint(1) not null default '0';
ALTER TABLE audiostore_comercial_sh add column interromper_musica_tocada tinyint(1) not null default '0';

create table IF NOT EXISTS ajuda (
id int (11) NOT NULL AUTO_INCREMENT ,
titulo varchar (255) NOT NULL,
texto text NOT NULL,
idfuncionalidade int(11) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (idfuncionalidade) REFERENCES funcionalidade (idfuncionalidade)
);

insert into funcionalidade  values ( 200, "/ajuda", "Ajuda Do Sistema" , "fa fa-life-ring" , 0, 1 );
insert into funcionalidade values ( 201, "/ajuda/cadastrar", "Cadastrar Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into funcionalidade values (202, "/ajuda/atualizar/{id}", "Atualizar Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into funcionalidade  values (203, "/ajuda/remover/{id}", "Remover Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into perfil_funcionalidade values (null, 200,1);
insert into perfil_funcionalidade values (null, 201,1);
insert into perfil_funcionalidade values (null, 202,1);
insert into perfil_funcionalidade values (null, 203,1);


create table if not exists cliente_suspenso (
	id integer(11) not null auto_increment,
	cliente integer(11),
	usuario integer(11),
	suspenso tinyint(1),
	motivo text ,
	data datetime,
	data_inicio date,
	data_fim date,
	primary key(id),
	foreign key(cliente) references cliente(idcliente),
	foreign key(usuario) references usuario(idusuario)
);

INSERT INTO funcionalidade VALUES (150, '/cliente-ou-filial/suspender/{id}', 'Suspender cliente/filial' , 'fa-times'   , 1 , 0 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 150;

CREATE TABLE IF NOT EXISTS categoria_geral (
	id integer(11) not null auto_increment,
	usuario integer(11) not null,
	nome text not null,
	primary key(id)
) ENGINE = MyISAM ;


CREATE TABLE musica_geral (
	id integer(11) NOT NULL AUTO_INCREMENT,
	categoria_geral integer(11) not null,
	usuario integer(11) not null,
	gravadora int(11) NOT NULL,
	titulo varchar(255) NOT NULL,
	interprete varchar(255) NOT NULL,
	tipo_interprete smallint(6) NOT NULL,
	letra text NOT NULL,
	bpm smallint(6) NOT NULL,
	tempo_total varchar(30) NOT NULL,
	ano_gravacao int(11) NOT NULL,
	afinidade1 varchar(255) NOT NULL,
	afinidade2 varchar(255) NOT NULL,
	afinidade3 varchar(255) NOT NULL,
	afinidade4 varchar(255) NOT NULL,
	arquivo varchar(255) NOT NULL,
	PRIMARY KEY (id)
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS categoria_musica_geral (
	id integer(11) not null auto_increment,
	categoria integer(11) not null,
	musica integer(11) not null,
	primary key(id)
) ENGINE = MyISAM ;


INSERT INTO funcionalidade VALUES (152, '/musica', 'Arquivos de Músicas' , 'fa-music'   , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (153, '/musica/cadastrar', 'Cadastrar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (154, '/musica/atualizar/{id}', 'Atualizar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (155, '/musica/remover/{id}', 'Atualizar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 152;


drop table audiostore_musica;

CREATE TABLE audiostore_musica (
  id int(11) NOT NULL AUTO_INCREMENT,
  musica_geral int(11) NOT NULL,
  categoria1 smallint(6) NOT NULL,
  categoria2 smallint(6) DEFAULT NULL,
  categoria3 smallint(6) DEFAULT NULL,
  cut tinyint(1) NOT NULL,
  crossover tinyint(1) NOT NULL,
  data_vencimento_crossover date NOT NULL,
  dias_execucao1 int(11) NOT NULL,
  dias_execucao2 int(11) NOT NULL,
  data date NOT NULL,
  ultima_execucao datetime NOT NULL,
  ultima_execucao_data date NOT NULL,
  random int(11) NOT NULL,
  qtde_player int(11) NOT NULL,
  qtde int(11) NOT NULL,
  data_vencimento date NOT NULL,
  frame_inicio int(11) NOT NULL,
  frame_final int(11) NOT NULL,
  msg varchar(40) NOT NULL,
  sem_som tinyint(1) NOT NULL,
  super_crossover tinyint(1) NOT NULL,
  cliente int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (id),
  KEY fk_audiostore_musica_audiostore_categoria1_idx (categoria1),
  KEY fk_audiostore_musica_audiostore_categoria2_idx (categoria2),
  KEY fk_audiostore_musica_audiostore_categoria3_idx (categoria3),
  KEY cliente (cliente),
  CONSTRAINT audiostore_musica_ibfk_1 FOREIGN KEY (cliente) REFERENCES cliente (idcliente),
  CONSTRAINT fk_audiostore_musica_audiostore_categoria1 FOREIGN KEY (categoria1) REFERENCES audiostore_categoria (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_audiostore_musica_audiostore_categoria2 FOREIGN KEY (categoria2) REFERENCES audiostore_categoria (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_audiostore_musica_audiostore_categoria3 FOREIGN KEY (categoria3) REFERENCES audiostore_categoria (codigo) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

delete from perfil_funcionalidade where idfuncionalidade in(31,32,33,34,35,36,160);
delete from funcionalidade where idfuncionalidade in(31,32,33,34,35,36,160);

INSERT INTO funcionalidade VALUES (160, '/musica/programacao-audiostore/{idmusicaGeral}', 'Programação de Música do AudioServer' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (161, '/musica/programacao-audiostore/cadastrar/{idmusicaGeral}', 'Programação de Música do AudioServer' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (162, '/musica/programacao-audiostore/atualizar/{idmusicaGeral}/{id}', 'Programação de Música do AudioServer' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (163, '/musica/programacao-audiostore/remover/{idmusicaGeral}/{id}', 'Programação de Música do AudioServer' , 'fa-music'   , 152 , 0 ); 
INSERT INTO perfil_funcionalidade select null, idfuncionalidade , idperfil  from perfil , funcionalidade where idfuncionalidade >= 160;

INSERT INTO funcionalidade VALUES (180, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 

where idperfil = 1 and funcionalidade.idfuncionalidade = 180;
ALTER TABLE audiostore_comercial add column interromper_musica_tocada tinyint(1) not null default '0';
ALTER TABLE audiostore_comercial_sh add column interromper_musica_tocada tinyint(1) not null default '0';

create table IF NOT EXISTS ajuda (
id int (11) NOT NULL AUTO_INCREMENT ,
titulo varchar (255) NOT NULL,
texto text NOT NULL,
idfuncionalidade int(11) NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (idfuncionalidade) REFERENCES funcionalidade (idfuncionalidade)
);

insert into funcionalidade  values ( 200, "/ajuda", "Ajuda Do Sistema" , "fa fa-life-ring" , 0, 1 );
insert into funcionalidade values ( 201, "/ajuda/cadastrar", "Cadastrar Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into funcionalidade values (202, "/ajuda/atualizar/{id}", "Atualizar Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into funcionalidade  values (203, "/ajuda/remover/{id}", "Remover Ajuda" , "fa fa-life-ring" , 200, 0 );
insert into perfil_funcionalidade values (null, 200,1);
insert into perfil_funcionalidade values (null, 201,1);
insert into perfil_funcionalidade values (null, 202,1);
insert into perfil_funcionalidade values (null, 203,1);

alter table audiostore_comercial add column texto longtext not null default '';

UPDATE funcionalidade SET mapping_id='/musica/programacao-audiostore', visivel='1', parente = 0 WHERE idfuncionalidade='160';
UPDATE funcionalidade SET mapping_id='/musica/programacao-audiostore/atualizar/{id}' WHERE idfuncionalidade='162';
UPDATE funcionalidade SET mapping_id='/musica/programacao-audiostore/remover/{id}' WHERE idfuncionalidade='163';
UPDATE funcionalidade SET parente='0' WHERE idfuncionalidade='160';
UPDATE funcionalidade SET nome='Música do AudioServer ' WHERE idfuncionalidade='160';
UPDATE funcionalidade SET nome='Música do AudioServer ' WHERE idfuncionalidade='161';
UPDATE funcionalidade SET nome='Música do AudioServer ' WHERE idfuncionalidade='162';
UPDATE funcionalidade SET nome='Música do AudioServer ' WHERE idfuncionalidade='163';
UPDATE funcionalidade SET icone='fa-file-audio-o' WHERE idfuncionalidade >= 160 and idfuncionalidade <= 163;
