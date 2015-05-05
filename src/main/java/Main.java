
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.OrdenServicoParte1Bean;
import java.text.ParseException;



public class Main {

    public static void main(String[] args) throws ParseException {
        RepositoryViewer rv = new RepositoryViewer();
        
        OrdenServicoParte1Bean ospb = new OrdenServicoParte1Bean();
        ospb.setCliente(10000);
        ospb.setNome("aaa");
        ospb.setQuemSolicitou("bbb");
        ospb.setQuandoSolicitou("01/01/2015");
        ospb.setDataMaxDistribuicao("01/01/2015");
        ospb.setTipo(3);
        ospb.setUsuario(1);
        rv.save(ospb);
        rv.finalize();
        
    }
}