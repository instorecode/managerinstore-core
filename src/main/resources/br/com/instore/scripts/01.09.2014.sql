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