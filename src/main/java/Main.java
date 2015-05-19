
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.OrdemServicoParte1Bean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Main {

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        rv.setUsuario(new UsuarioBean(2));
        
        OrdemServicoParte1Bean ospb = new OrdemServicoParte1Bean();
        ospb.setCliente(1);
        ospb.setNome("qqq");
        ospb.setQuemSolicitou("qqq");
        ospb.setQuandoSolicitou("qqq");
        ospb.setDataMaxDistribuicao("qqq");
        ospb.setTipo(1);
        ospb.setUsuario(1);
        ospb.setData(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
        
        rv.save(ospb);
        rv.finalize();
    }
}
