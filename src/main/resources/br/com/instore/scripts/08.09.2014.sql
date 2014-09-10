INSERT INTO funcionalidade VALUES (180, '/gerarexp', 'Gerar Arquivo de Exportação' , 'fa-file-excel-o'   , 0 , 1 ); 
insert into perfil_funcionalidade select null, idfuncionalidade , idperfil from perfil , funcionalidade 
where idperfil = 1 and funcionalidade.idfuncionalidade = 180;