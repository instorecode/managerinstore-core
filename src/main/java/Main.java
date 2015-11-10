
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.FuncionalidadeBean;
import br.com.instore.core.orm.bean.ProjetoBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.util.Date;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        UsuarioBean user =  rv.query(UsuarioBean.class).eq("idusuario", 22).findOne();
        System.out.println(user);
        
    }

}
