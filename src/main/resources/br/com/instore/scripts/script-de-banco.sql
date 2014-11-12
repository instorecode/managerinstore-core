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


    SET SESSION wait_timeout = 2;
    SHOW VARIABLES LIKE 'wait_timeout';

    SET GLOBAL connect_timeout=60;
    SHOW VARIABLES LIKE 'connect_timeout';

    SHOW GLOBAL STATUS like 'Threads_connected';
    show processlist;


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

    -- DELTETE
    delete from contato_cliente where contato_cliente.idcontato_cliente > 0;
    delete from dados_cliente where dados_cliente.iddados_cliente > 0;
    delete from cliente where cliente.idcliente >  1;
    delete from endereco where endereco.idendereco > 100;
    delete from cep where cep.idcep > 100;
    delete from bairro where bairro.idbairro > 100;
    delete from cidade where cidade.idcidade > 100;

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

-- configuraçoes dos arquivos por cliente

alter table dados_cliente add column local_origem_musica  varchar(255) not null default '';
alter table dados_cliente add column local_destino_musica varchar(255) not null default '';
alter table dados_cliente add column local_origem_spot    varchar(255) not null default '';
alter table dados_cliente add column local_destino_spot   varchar(255) not null default '';
alter table dados_cliente add column local_destino_exp    varchar(255) not null default '';

INSERT INTO funcionalidade VALUES (130, '/cliente-configuracao/{id}', 'Configuração do cliente' , 'fa-cog' , 0 , 1 ); 


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


INSERT INTO funcionalidade VALUES (145, '/minha-ocorrencia', 'Ocorrencias tratadas por min' , 'fa-bug '   , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (146, '/minha-ocorrencia/cadastrar', 'Formulário de cadastro da  ocorrencia' , 'fa-bug'    , 145 , 0 ); 
INSERT INTO funcionalidade VALUES (147, '/minha-ocorrencia/atualizar/{id}', 'Formulário de atualização da ocorrencia' , 'fa-bug' , 145 , 0 ); 
INSERT INTO funcionalidade VALUES (148, '/minha-ocorrencia/remover/{id}', 'Formulário de remoção da ocorrencia' , 'fa-bug'   , 145 , 0 ); 


INSERT INTO funcionalidade VALUES (180, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 


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

INSERT INTO funcionalidade VALUES (390, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 

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


delete from auditoria_dados where idauditoria_dados  > 0;
delete from auditoria where idauditoria  > 0;
delete from historico_usuario where idhistorico_usuario > 0;
delete from usuario where idusuario > 0;
delete from perfil_usuario where idperfil_usuario > 0;
delete from perfil_funcionalidade where idperfil_funcionalidade > 0;
delete from perfil where idperfil > 0;

INSERT INTO perfil VALUES ('1', 'ADM');
INSERT INTO perfil VALUES ('2', 'TI');
INSERT INTO perfil VALUES ('3', 'Video');
INSERT INTO perfil VALUES ('4', 'Produção');
INSERT INTO perfil VALUES ('5', 'Comercial');
INSERT INTO perfil VALUES ('6', 'Suporte');
INSERT INTO perfil VALUES ('7', 'Studio');

INSERT INTO usuario VALUES ('1', null, now() , 'Alex Valentim Gonçalves', '08920068461', 'alex.goncalves@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('2', null, now() , 'Andre Batalha', '00000000001', 'andre.batalha@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('3', null, now() , 'Batalha', '00000000002', 'batalha@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('4', null, now() , 'Diamandi Ferreira', '00000000003', 'diamandi.ferreira@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('5', null, now() , 'Diana Queiroz', '00000000004', 'diana.queiroz@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('6', null, now() , 'Eder Barbosa', '00000000005', 'eder.barbosa@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('7', null, now() , 'Eduardo Marins', '00000000006', 'eduardo.marins@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('8', null, now() , 'Gabriel Lima', '00000000007', 'gabriel.lima@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('9', null, now() , 'Gabriel Oliveira', '00000000008', 'gabriel.oliveira@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('10', null, now() , 'Giovanna Alves', '00000000009', 'giovanna.alves@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('11', null, now() , 'Jadmas Santana', '00000000010', 'jadmas.santana@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('12', null, now() , 'Julio Silva', '00000000011', 'julio.silva@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('13', null, now() , 'Laercio Bozzi', '00000000012', 'laercio.bozzi@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('14', null, now() , 'Marcos Aloisi', '00000000013', 'marcos.aloisi@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('15', null, now() , 'Marina Rodrigues', '00000000014', 'marina.rodrigues@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('16', null, now() , 'Mony Spinola', '00000000015', 'mony.spinola@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('17', null, now() , 'Nilson Lopes', '00000000016', 'nilson.lopes@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('18', null, now() , 'Paulo Morales', '00000000017', 'paulo.morales@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('19', null, now() , 'Paulo Torres', '00000000018', 'paulo.torres@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('20', null, now() , 'Thiago Queiroz', '00000000019', 'thiago.queiroz@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('21', null, now() , 'Vinicius Gomes', '00000000020', 'vinicius.gomes@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('22', null, now() , 'Vinicius Silva', '00000000021', 'vinicius.silva@instore.com.br', md5(123));
INSERT INTO usuario VALUES ('23', null, now() , 'Viviane Moura', '00000000022', 'viviane.moura@instore.com.br', md5(123));

INSERT INTO perfil_usuario VALUES ('1', '1', '17');
INSERT INTO perfil_usuario VALUES ('2', '1', '3');
INSERT INTO perfil_usuario VALUES ('3', '2', '1');
INSERT INTO perfil_usuario VALUES ('4', '2', '1');
INSERT INTO perfil_usuario VALUES ('5', '2', '22');
INSERT INTO perfil_usuario VALUES ('6', '3', '2');
INSERT INTO perfil_usuario VALUES ('7', '3', '18');
INSERT INTO perfil_usuario VALUES ('8', '4', '4');
INSERT INTO perfil_usuario VALUES ('9', '4', '6');
INSERT INTO perfil_usuario VALUES ('10', '4', '8');
INSERT INTO perfil_usuario VALUES ('11', '4', '9');
INSERT INTO perfil_usuario VALUES ('12', '4', '11');
INSERT INTO perfil_usuario VALUES ('13', '4', '14');
INSERT INTO perfil_usuario VALUES ('14', '4', '15');
INSERT INTO perfil_usuario VALUES ('15', '5', '10');
INSERT INTO perfil_usuario VALUES ('16', '5', '7');
INSERT INTO perfil_usuario VALUES ('17', '5', '5');
INSERT INTO perfil_usuario VALUES ('18', '5', '16');
INSERT INTO perfil_usuario VALUES ('19', '6', '12');
INSERT INTO perfil_usuario VALUES ('20', '6', '20');
INSERT INTO perfil_usuario VALUES ('21', '6', '21');
INSERT INTO perfil_usuario VALUES ('22', '6', '23');
INSERT INTO perfil_usuario VALUES ('23', '7', '18');
INSERT INTO perfil_usuario VALUES ('24', '7', '13');

insert into perfil_funcionalidade select null , idfuncionalidade ,idperfil  from perfil , funcionalidade where idperfil in(1,2);

INSERT INTO categoria_geral VALUES('1',1,'AXE');
INSERT INTO categoria_geral VALUES('2',1,'PAGO/ SAMBA');
INSERT INTO categoria_geral VALUES('3',1,'SERT');
INSERT INTO categoria_geral VALUES('4',1,'POP INT LENT');
INSERT INTO categoria_geral VALUES('5',1,'POP INT RAP');
INSERT INTO categoria_geral VALUES('6',1,'POP NAC');
INSERT INTO categoria_geral VALUES('7',1,'FLASH INT LENT');
INSERT INTO categoria_geral VALUES('8',1,'FLASH INT RAP');
INSERT INTO categoria_geral VALUES('9',1,'FLASH NAC LENT');
INSERT INTO categoria_geral VALUES('10',1,'FLASH NAC RAP');
INSERT INTO categoria_geral VALUES('11',1,'DANCE');
INSERT INTO categoria_geral VALUES('12',1,'ROCK INT');
INSERT INTO categoria_geral VALUES('13',1,'M P B');
INSERT INTO categoria_geral VALUES('14',1,'INSTRUM');
INSERT INTO categoria_geral VALUES('15',1,'INSTRUM - Editada');
INSERT INTO categoria_geral VALUES('16',1,'FASHION');
INSERT INTO categoria_geral VALUES('17',1,'CARNAVAL');
INSERT INTO categoria_geral VALUES('18',1,'JUNINA');
INSERT INTO categoria_geral VALUES('19',1,'FORRO');
INSERT INTO categoria_geral VALUES('20',1,'POPULAR');
INSERT INTO categoria_geral VALUES('21',1,'WORLD MUSIC');
INSERT INTO categoria_geral VALUES('22',1,'HAVAN');
INSERT INTO categoria_geral VALUES('23',1,'NATAL INT');
INSERT INTO categoria_geral VALUES('24',1,'MELLOW');
INSERT INTO categoria_geral VALUES('25',1,'COOL JAZZ');
INSERT INTO categoria_geral VALUES('26',1,'NATAL');
INSERT INTO categoria_geral VALUES('27',1,'TECNO');
INSERT INTO categoria_geral VALUES('28',1,'MUSICA INFANTIL');
INSERT INTO categoria_geral VALUES('29',1,'TOP 10 - SARAIVA');
INSERT INTO categoria_geral VALUES('30',1,'TOP 100 - SARAIVA');
INSERT INTO categoria_geral VALUES('31',1,'FLASH NACIONAL');
INSERT INTO categoria_geral VALUES('32',1,'DANIEL PERN');
INSERT INTO categoria_geral VALUES('33',1,'TOP 100 - SARAIVA NACIONAL');
INSERT INTO categoria_geral VALUES('34',1,'MENSAGENS C&A');
INSERT INTO categoria_geral VALUES('35',1,'CLASSICOS');
INSERT INTO categoria_geral VALUES('36',1,'JAZZ');
INSERT INTO categoria_geral VALUES('37',1,'JAZZ CONTEMPORANEO');
INSERT INTO categoria_geral VALUES('38',1,'CONTEMPORANEO');
INSERT INTO categoria_geral VALUES('39',1,'IMPORTADOS');
INSERT INTO categoria_geral VALUES('40',1,'MULHER NAC');
INSERT INTO categoria_geral VALUES('41',1,'MULHER INT');
INSERT INTO categoria_geral VALUES('42',1,'TOP 100');
INSERT INTO categoria_geral VALUES('43',1,'TOP 200');
INSERT INTO categoria_geral VALUES('44',1,'NEW AGE-ERUDITO');
INSERT INTO categoria_geral VALUES('45',1,'TEEN-AGE');
INSERT INTO categoria_geral VALUES('46',1,'MIDI INTERNACIONAL');
INSERT INTO categoria_geral VALUES('47',1,'MIDI NACIONAL');
INSERT INTO categoria_geral VALUES('48',1,'TEMA DE NOVELA');
INSERT INTO categoria_geral VALUES('49',1,'CARNAVAL SAVEGNAGO');
INSERT INTO categoria_geral VALUES('50',1,'MUSICAS NOVAS');
INSERT INTO categoria_geral VALUES('51',1,'SONS DA NATUREZA');
INSERT INTO categoria_geral VALUES('52',1,'BETTAH RAPIDO');
INSERT INTO categoria_geral VALUES('53',1,'DISCO');
INSERT INTO categoria_geral VALUES('54',1,'WAL MART TOP 50 Roma');
INSERT INTO categoria_geral VALUES('55',1,'LOUNGE');
INSERT INTO categoria_geral VALUES('56',1,'MARCHAS');
INSERT INTO categoria_geral VALUES('57',1,'SAMBA ENREDO');
INSERT INTO categoria_geral VALUES('58',1,'NAMORADOS C&A');
INSERT INTO categoria_geral VALUES('60',1,'DESATIVADAS');
INSERT INTO categoria_geral VALUES('61',1,'TRILHA SONORA');
INSERT INTO categoria_geral VALUES('62',1,'70"s RAP');
INSERT INTO categoria_geral VALUES('63',1,'80"s RAP');
INSERT INTO categoria_geral VALUES('64',1,'90"s RAP');
INSERT INTO categoria_geral VALUES('65',1,'FORUM');
INSERT INTO categoria_geral VALUES('66',1,'TOP POP');
INSERT INTO categoria_geral VALUES('67',1,'LOUNGE BEAT');
INSERT INTO categoria_geral VALUES('68',1,'LOUNGE BOSSA');
INSERT INTO categoria_geral VALUES('71',1,'SUMMER');
INSERT INTO categoria_geral VALUES('81',1,'BOI-BUMBÁ');
INSERT INTO categoria_geral VALUES('82',1,'CD SEBASTIAN');
INSERT INTO categoria_geral VALUES('85',1,'XMAS');
INSERT INTO categoria_geral VALUES('90',1,'MUSICAS C & A');
INSERT INTO categoria_geral VALUES('91',1,'MARIA RITA SARAIVA');
INSERT INTO categoria_geral VALUES('92',1,'DESTAQUE SARAIVA');
INSERT INTO categoria_geral VALUES('93',1,'TOP 40 MORNING');
INSERT INTO categoria_geral VALUES('94',1,'ADORNMENT SARAIVA');
INSERT INTO categoria_geral VALUES('95',1,'COMERCIAIS RADIO ONIBUS');
INSERT INTO categoria_geral VALUES('96',1,'NOTICIAS RADIO ONIBUS');
INSERT INTO categoria_geral VALUES('97',1,'PREVISAO DO TEMPO');
INSERT INTO categoria_geral VALUES('98',1,'VH ONIBUS');
INSERT INTO categoria_geral VALUES('99',1,'AB NOTICIAS');
INSERT INTO categoria_geral VALUES('101',1,'VALENTINES');
INSERT INTO categoria_geral VALUES('102',1,'TOP 40 FAST');
INSERT INTO categoria_geral VALUES('103',1,'TOP 40 SLOW');
INSERT INTO categoria_geral VALUES('104',1,'TOP 100 FAST');
INSERT INTO categoria_geral VALUES('105',1,'TOP 100 SLOW');
INSERT INTO categoria_geral VALUES('106',1,'TOP 200 FAST');
INSERT INTO categoria_geral VALUES('107',1,'TOP 200 SLOW');
INSERT INTO categoria_geral VALUES('108',1,'COOL DOWN SLOW');
INSERT INTO categoria_geral VALUES('109',1,'COOL DOWN FAST');
INSERT INTO categoria_geral VALUES('110',1,'NEW LOUNGE');
INSERT INTO categoria_geral VALUES('111',1,'PROMO FAST');
INSERT INTO categoria_geral VALUES('112',1,'RIACHUELO CRIANÇA');
INSERT INTO categoria_geral VALUES('113',1,'LOUNGE BPM');
INSERT INTO categoria_geral VALUES('114',1,'FORRO EDITADO');
INSERT INTO categoria_geral VALUES('115',1,'SAO JOAO');
INSERT INTO categoria_geral VALUES('116',1,'FESTA JUNINA');
INSERT INTO categoria_geral VALUES('117',1,'KIDS 01');
INSERT INTO categoria_geral VALUES('118',1,'KIDS 02');
INSERT INTO categoria_geral VALUES('119',1,'CRIANCA BESNI');
INSERT INTO categoria_geral VALUES('120',1,'PROMO ONNE');
INSERT INTO categoria_geral VALUES('121',1,'VH BREAKFAST');
INSERT INTO categoria_geral VALUES('122',1,'VH TOP 40');
INSERT INTO categoria_geral VALUES('123',1,'VH VOCE E A NOITE');
INSERT INTO categoria_geral VALUES('124',1,'VH AGUIA');
INSERT INTO categoria_geral VALUES('125',1,'COMERCIAL AGUIA');
INSERT INTO categoria_geral VALUES('126',1,'GOSPEL');
INSERT INTO categoria_geral VALUES('127',1,'NEW MPB');
INSERT INTO categoria_geral VALUES('128',1,'NEW SAMBA / PAGODE');
INSERT INTO categoria_geral VALUES('129',1,'NEW FORRO');
INSERT INTO categoria_geral VALUES('130',1,'NEW AXE');
INSERT INTO categoria_geral VALUES('131',1,'SERT ROMANT');
INSERT INTO categoria_geral VALUES('132',1,'SERT ATUAL');
INSERT INTO categoria_geral VALUES('133',1,'SERT CLASSICO');
INSERT INTO categoria_geral VALUES('134',1,'MPB CLASSICO');
INSERT INTO categoria_geral VALUES('135',1,'20+ NACIONAL');
INSERT INTO categoria_geral VALUES('136',1,'20+ INTER');
INSERT INTO categoria_geral VALUES('137',1,'COUNTRY SAVEGNAGO');
INSERT INTO categoria_geral VALUES('138',1,'TOP 40 RIA');
INSERT INTO categoria_geral VALUES('139',1,'MEMOVE INSTRUMENTAL');
INSERT INTO categoria_geral VALUES('140',1,'MEMOVE VOCAL');
INSERT INTO categoria_geral VALUES('141',1,'MEMOVE ROCK');
INSERT INTO categoria_geral VALUES('142',1,'SERTANEJO REMIX');
INSERT INTO categoria_geral VALUES('150',1,'NOVA SARAIVA');
INSERT INTO categoria_geral VALUES('160',1,'ELECTRO');
INSERT INTO categoria_geral VALUES('161',1,'CONTEMPORARY');
INSERT INTO categoria_geral VALUES('162',1,'NEW POP');
INSERT INTO categoria_geral VALUES('198',1,'PROMO IMPECAVEL');
INSERT INTO categoria_geral VALUES('294',1,'INFANTIL');
INSERT INTO categoria_geral VALUES('305',1,'VH NATAL');
INSERT INTO categoria_geral VALUES('306',1,'HIP HOP BESNI');
INSERT INTO categoria_geral VALUES('441',1,'TANIAB EVENTO NACIONAL');
INSERT INTO categoria_geral VALUES('442',1,'TANIAB EVENTO INTERNAC');
INSERT INTO categoria_geral VALUES('500',1,'ONNE LEVEL 1');
INSERT INTO categoria_geral VALUES('501',1,'ONNE LEVEL 2');
INSERT INTO categoria_geral VALUES('502',1,'ONNE LEVEL 3');
INSERT INTO categoria_geral VALUES('555',1,'CAMPANHA C&A');
INSERT INTO categoria_geral VALUES('556',1,'C&A KIDS 01');
INSERT INTO categoria_geral VALUES('557',1,'C&A KIDS 02');
INSERT INTO categoria_geral VALUES('601',1,'SJOAOC&A');
INSERT INTO categoria_geral VALUES('602',1,'VINHETA IBIS-FORMULE 1');
INSERT INTO categoria_geral VALUES('700',1,'PROMO LEADER');
INSERT INTO categoria_geral VALUES('701',1,'CARTAO LEADER');
INSERT INTO categoria_geral VALUES('702',1,'CUPOM LEADER');
INSERT INTO categoria_geral VALUES('703',1,'ETIQUETA LEADER');
INSERT INTO categoria_geral VALUES('704',1,'SITE LEADER');
INSERT INTO categoria_geral VALUES('705',1,'VH RADIO LEADER');
INSERT INTO categoria_geral VALUES('706',1,'SLOGAN LEADER');
INSERT INTO categoria_geral VALUES('800',1,'CARNAVAL RIA');
INSERT INTO categoria_geral VALUES('850',1,'FORRO TV RIACHUELO');
INSERT INTO categoria_geral VALUES('851',1,'ROCK IN RIO LEADER');
INSERT INTO categoria_geral VALUES('900',1,'REPETIDAS');
INSERT INTO categoria_geral VALUES('901',1,'FREVO');
INSERT INTO categoria_geral VALUES('991',1,'ENC NOTICIAS');
INSERT INTO categoria_geral VALUES('992',1,'MIZZBRASIL RADIO');
INSERT INTO categoria_geral VALUES('993',1,'MUSICAS SARAIVA');
INSERT INTO categoria_geral VALUES('994',1,'ONNE BAR SPECIAL');
INSERT INTO categoria_geral VALUES('995',1,'CRIANÇA ESPECIAL');
INSERT INTO categoria_geral VALUES('996',1,'CARNA AXE');
INSERT INTO categoria_geral VALUES('997',1,'BOSSA NOVA');
INSERT INTO categoria_geral VALUES('999',1,'ESPERA TELEFONICA');
