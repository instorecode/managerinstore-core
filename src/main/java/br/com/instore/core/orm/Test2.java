package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.PerfilBean;
import br.com.instore.core.orm.bean.UsuarioBean;


public class Test2 {
    public static void main(String[] args) {
        RepositoryViewer repository = new RepositoryViewer();
       repository.setUsuario( new UsuarioBean(1));
        
        
        PerfilBean perfil = new PerfilBean();
        perfil.setNome("aaa");
        
        repository.save(perfil);
        repository.finalize();
        
    }
}
