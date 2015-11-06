
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.FuncionalidadeBean;
import br.com.instore.core.orm.bean.ProjetoBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.util.Date;
import java.util.List;

public class Main {

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        rv.setUsuario(new UsuarioBean(22));
        ProjetoBean p = new ProjetoBean();
        p.setDataCriacao(new Date());
        p.setDescricao("aaa");
        p.setIdUsuario(Integer.MIN_VALUE);    
        p.setLinkDocumentacao("aaaa");
        p.setNome("aaaaatyuytusssdsdss");
        System.out.println(rv.save(p));
        rv.finalize();
        
    }

}
