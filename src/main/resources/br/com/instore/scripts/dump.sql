    -- SET SESSION wait_timeout = 2;
    -- SHOW VARIABLES LIKE 'wait_timeout';

    -- SET GLOBAL connect_timeout=60;
    -- SHOW VARIABLES LIKE 'connect_timeout';

    -- SHOW GLOBAL STATUS like 'Threads_connected';
    -- show processlist;

    -- empresa origem (INSTORE)
    INSERT INTO config_app VALUES (1, '/', '/', '/');
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
    
    INSERT INTO funcionalidade VALUES (9, '/audiostore-categorias', 'Categoria' , 'fa-file-code-o' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (10, '/audiostore-categoria/cadastrar', 'Formulário de cadastro audiostore categoria' , 'fa-file-code-o'    , 9 , 1 ); 
    INSERT INTO funcionalidade VALUES (11, '/audiostore-categoria/atualizar/{id}', 'Formulário de atualização do audiostore categoria' , 'fa-file-code-o' , 9 , 0 ); 
    INSERT INTO funcionalidade VALUES (12, '/audiostore-categoria/remover/{id}', 'Formulário de remoção do audiostore categoria' , 'fa-file-code-o'   , 9 , 0 ); 
    INSERT INTO funcionalidade VALUES (13, '/audiostore-categoria/download-exp/{id}', 'Download do arquivo exp' , 'fa-file-code-o'   , 9 , 0 ); 
    
    INSERT INTO funcionalidade VALUES (14, '/audiostore-programacao', 'Programação' , 'fa-file-archive-o' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (15, '/audiostore-programacao/cadastrar', 'Formulário de cadastro audiostore programação' , 'fa-file-archive-o'    , 14 , 1 ); 
    INSERT INTO funcionalidade VALUES (16, '/audiostore-programacao/atualizar/{id}', 'Formulário de atualização do audiostore programação' , 'fa-file-archive-o' , 14 , 0 ); 
    INSERT INTO funcionalidade VALUES (17, '/audiostore-programacao/remover/{id}', 'Formulário de remoção do audiostore programação' , 'fa-file-archive-o'   , 14 , 0 ); 
    INSERT INTO funcionalidade VALUES (18, '/audiostore-programacao/download-exp/{id}', 'Download do arquivo exp' , 'fa-file-archive-o'   , 14 , 0 ); 
    
    INSERT INTO funcionalidade VALUES (19, '/voz', 'Voz' , 'fa-bullhorn' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (20, '/voz/cadastrar', 'Formulário de cadastro voz' , 'fa-bullhorn'    , 19 , 1 ); 
    INSERT INTO funcionalidade VALUES (21, '/voz/atualizar/{id}', 'Formulário de atualização da voz' , 'fa-bullhorn' , 19 , 0 ); 
    INSERT INTO funcionalidade VALUES (22, '/voz/remover/{id}', 'Formulário de remoção da voz' , 'fa-bullhorn'   , 19 , 0 ); 
    
    INSERT INTO funcionalidade VALUES (23, '/audiostore-gravadora', 'Gravadora' , 'fa-youtube-play' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (24, '/audiostore-gravadora/cadastrar', 'Formulário de cadastro gravadora' , 'fa-youtube-play'    , 23 , 1 ); 
    INSERT INTO funcionalidade VALUES (25, '/audiostore-gravadora/atualizar/{id}', 'Formulário de atualização da gravadora' , 'fa-youtube-play' , 23 , 0 ); 
    INSERT INTO funcionalidade VALUES (26, '/audiostore-gravadora/remover/{id}', 'Formulário de remoção da gravadora' , 'fa-youtube-play'   , 23 , 0 ); 
    
    INSERT INTO funcionalidade VALUES (27, '/audiostore-musica', 'Música' , 'fa-volume-up' , 0 , 1 ); 
    INSERT INTO funcionalidade VALUES (28, '/audiostore-musica/cadastrar', 'Formulário de cadastro música' , 'fa-volume-up'    , 27 , 1 ); 
    INSERT INTO funcionalidade VALUES (29, '/audiostore-musica/atualizar/{id}', 'Formulário de atualização da música' , 'fa-volume-up' , 27 , 0 ); 
    INSERT INTO funcionalidade VALUES (30, '/audiostore-musica/remover/{id}', 'Formulário de remoção da música' , 'fa-volume-up'   , 27 , 0 ); 
    INSERT INTO funcionalidade VALUES (31, '/audiostore-musica/download-exp/{id}', 'Download do arquivo exp' , 'fa-volume-up'   , 27 , 0 ); 

    INSERT INTO funcionalidade VALUES (32, '/configuracao-interna', 'Configurações Internas do Sistema' , 'fa-cog' , 0 , 1 ); 

    insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade;
    insert into perfil_usuario select null, idperfil , idusuario from perfil , usuario;