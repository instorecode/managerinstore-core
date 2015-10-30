
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.FuncionalidadeBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        rv.setUsuario(new UsuarioBean(22));

        List<FuncionalidadeBean> list = rv.query(FuncionalidadeBean.class).findAll();

        //insert into perfil_funcionalidade values (null, 430, 1);
        for (FuncionalidadeBean bean : list) {
            System.out.println("insert into perfil_funcionalidade values (null, " + bean.getIdfuncionalidade() + ",2);");
        }
    }

}
