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
