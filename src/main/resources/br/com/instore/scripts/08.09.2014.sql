INSERT INTO funcionalidade VALUES (180, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade = 180;

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