package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.UsuarioBean;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;


public class Test2 {
    public static void main(String[] args) {
//        ItemJson root = new ItemJson();
//        loadmenu(root , 0, 0);
//        System.out.println(root);
        System.out.println(Environment.env());
        RepositoryViewer rv = new RepositoryViewer();
        System.out.println(rv.query(UsuarioBean.class).findAll());
    }
    
    public static class ItemJson extends Bean {
        Integer idfuncionalidade;
        String nome;
        Boolean perfilTem;
        Integer parente;
        List<ItemJson> filhos = new ArrayList<ItemJson>();
    }
    
    public static void loadmenu(final ItemJson root , Integer parente , Integer idperfil) {
        if(parente == null) {
            parente = 0;
        }
        
        RepositoryViewer rv = new RepositoryViewer();
        String query = "select \n" +
                        "    idfuncionalidade , nome , ( select if(count(*) > 0 , 1 , 0) from perfil_funcionalidade where idperfil = "+idperfil+" and idfuncionalidade = funcionalidade.idfuncionalidade) as perfil_tem , \n"+
                        "   parente, " +
                        "   (select count(*) as filhos from funcionalidade as f where f.parente = funcionalidade.idfuncionalidade) as tem_filhos " +
                        "from\n" +
                        "    funcionalidade\n" +
                        "where parente = " + parente;
        
        rv.query(query).executeSQL(new Each() {
            private Integer idfuncionalidade;
            private String nome;
            private BigInteger perfilTem;
            private Integer parente;
            private BigInteger temFilhos;
            
            @Override
            public void each() {
                ItemJson filho = new ItemJson();
                
                filho.idfuncionalidade = idfuncionalidade;
                filho.nome = nome;
                filho.parente = parente;
                filho.perfilTem = (perfilTem.longValue() > 0 ? true : false );
                
                if(temFilhos.longValue() > 0) {
                    loadmenu(filho, filho.idfuncionalidade, parente);
                }
                root.filhos.add(filho);
            }
        });
    }
}
