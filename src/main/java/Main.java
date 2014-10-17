
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.AjudaBean;
import br.com.instore.core.orm.bean.FuncionalidadeBean;

public class Main {

    public static void main(String[] args) {

        RepositoryViewer repository = new RepositoryViewer();

        AjudaBean ajuda = new AjudaBean();
        ajuda.setFuncionalidade(new FuncionalidadeBean(1));
        ajuda.setTexto("Testando a tabela ajuda na coluna texto");
        ajuda.setTitulo("Testando a coluna titulo");

        repository.save(ajuda);

        repository.finalize();
    }
}
