use managerinstore2;
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
