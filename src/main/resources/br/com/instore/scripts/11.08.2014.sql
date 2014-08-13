use managerinstore;
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


INSERT INTO funcionalidade VALUES (152, '/musica', 'Arquivos de Músicas' , 'fa-music'   , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (153, '/musica/cadastrar', 'Cadastrar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (154, '/musica/atualizar/{id}', 'Atualizar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
INSERT INTO funcionalidade VALUES (155, '/musica/remover/{id}', 'Atualizar Arquivos de Músicas' , 'fa-music'   , 152 , 0 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade >= 152;
