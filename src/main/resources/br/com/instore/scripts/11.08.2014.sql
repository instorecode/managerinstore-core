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
