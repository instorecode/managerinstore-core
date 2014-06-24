package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.ContatoClienteBean;
import br.com.instore.core.orm.bean.UsuarioBean;


public class Test2 {
    public static void main(String[] args) {
        RepositoryViewer repository = new RepositoryViewer();
       repository.setUsuario( new UsuarioBean(1));
        
        
        System.out.println(repository.query(ContatoClienteBean.class).findAll());;
    }
}
