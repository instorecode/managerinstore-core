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
INSERT INTO funcionalidade VALUES (70, '/ocorrencia-origem', 'Origem da ocorrencia' , 'fa-bug' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (71, '/ocorrencia-origem/cadastrar', 'Formulário de cadastro da origem da ocorrencia' , 'fa-bug'    , 70 , 0 ); 
INSERT INTO funcionalidade VALUES (72, '/ocorrencia-origem/atualizar/{id}', 'Formulário de atualização da origem da ocorrencia' , 'fa-bug' , 70 , 0 ); 
INSERT INTO funcionalidade VALUES (73, '/ocorrencia-origem/remover/{id}', 'Formulário de remoção da origem da ocorrencia' , 'fa-bug'   , 70 , 0 ); 

INSERT INTO funcionalidade VALUES (80, '/ocorrencia-status', 'Situação da ocorrencia' , 'fa-bug' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (81, '/ocorrencia-status/cadastrar', 'Formulário de cadastro da situação da ocorrencia' , 'fa-bug'    , 80 , 0 ); 
INSERT INTO funcionalidade VALUES (82, '/ocorrencia-status/atualizar/{id}', 'Formulário de atualização da situação da ocorrencia' , 'fa-bug' , 80 , 0 ); 
INSERT INTO funcionalidade VALUES (83, '/ocorrencia-status/remover/{id}', 'Formulário de remoção da situação da ocorrencia' , 'fa-bug'   , 80 , 0 ); 

INSERT INTO funcionalidade VALUES (90, '/ocorrencia-prioridade', 'Prioridade da ocorrencia' , 'fa-bug' , 0 , 1 ); 
INSERT INTO funcionalidade VALUES (91, '/ocorrencia-prioridade/cadastrar', 'Formulário de cadastro da prioridade da ocorrencia' , 'fa-bug'    , 90 , 0 ); 
INSERT INTO funcionalidade VALUES (92, '/ocorrencia-prioridade/atualizar/{id}', 'Formulário de atualização da prioridade da ocorrencia' , 'fa-bug' , 90 , 0 ); 
INSERT INTO funcionalidade VALUES (93, '/ocorrencia-prioridade/remover/{id}', 'Formulário de remoção da prioridade da ocorrencia' , 'fa-bug'   , 90 , 0 ); 

insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade in(70,71,72,73,80,81,82,83,90,91,92,93);