    -- SET SESSION wait_timeout = 2;
    -- SHOW VARIABLES LIKE 'wait_timeout';

    -- SET GLOBAL connect_timeout=60;
    -- SHOW VARIABLES LIKE 'connect_timeout';

    -- SHOW GLOBAL STATUS like 'Threads_connected';
    -- show processlist;

    -- empresa origem (INSTORE)
    INSERT INTO cliente  VALUES (1, null , 0 , 'Instore', 1 , 1 , 1);

    --  usuario padrão
    INSERT INTO usuario VALUES (1, null , now(), 'admin', '000.000.000-00', 'admin@instore.com.br', md5(123));
    INSERT INTO usuario_cliente VALUES (1,1,1);

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

    INSERT INTO funcionalidade VALUES (5, '/contatos', 'Contato' , 'fa-users' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (6, '/contato/cadastrar', 'Formulário de cadastro contato' , 'fa-users'    , 5 , 1 ); 
    INSERT INTO funcionalidade VALUES (7, '/contato/atualizar/{id}', 'Formulário de atualização do contato' , 'fa-users' , 5 , 0 ); 
    INSERT INTO funcionalidade VALUES (8, '/contato/remover/{id}', 'Formulário de remoção do contato' , 'fa-users'   , 5 , 0 ); 

    insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade;
    insert into perfil_usuario select null, idperfil , idusuario from perfil , usuario;