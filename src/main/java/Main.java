
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import org.apache.commons.compress.utils.IOUtils;

public class Main {

    public static void main(String[] args) {
    }

    public static void main2(String[] args) {
//        RepositoryViewer rv = new RepositoryViewer();
//        rv.setUsuario( new UsuarioBean(1));
//        
//        OcorrenciaBean bean = new OcorrenciaBean();
//        bean.setCliente(new ClienteBean(1));
//        bean.setDataCadastro(new Date());
//        bean.setDataResolucao(new Date());
//        bean.setUsuarioCriacao(new UsuarioBean(1));
//        bean.setOcorrenciaOrigem(new OcorrenciaOrigemBean(2));
//        bean.setOcorrenciaPrioridade(new OcorrenciaPrioridadeBean(1));
//        bean.setDescricao("");
//        
//        rv.save(bean);
//        rv.finalize();
        // \\ftp\Clientes\audiostore\audiostore2

        try {

            File origem = new File("\\\\ftp\\Clientes\\arquivo_exp.csv");
            FileInputStream fis = new FileInputStream(origem);

            File destino = new File("\\\\ftp\\Clientes\\audiostore\\audiostore2\\arquivo_exp.csv");
            FileOutputStream fos = new FileOutputStream(destino);

            IOUtils.copy(fis, fos);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }
}
