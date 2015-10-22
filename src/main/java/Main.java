
import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.BugBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.util.List;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Random;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Id;

public class Main {

    public static void main(String[] args) {

        BugBean bean = new BugBean();
        List<Field> listaCampos = Arrays.asList(BugBean.class.getDeclaredFields());

//        for (Field field : listaCampos) {
//            try {
//                field.setAccessible(true);
//                Class<?> klass = field.getType();
//
//                if (klass.getName().contains("bean")) {
//                    Object obj = klass.newInstance();
//                    List<Field> fieldsListInside = Arrays.asList(klass.getDeclaredFields());
//
//                    for (Field fieldInside : fieldsListInside) {
//                        fieldInside.setAccessible(true);
//
//                        if (fieldInside.isAnnotationPresent(Id.class)) {
//                            fieldInside.set(obj, 23);
//                        }
//                    }
//                    field.set(bean, obj);
//                }
//
//                if (klass.equals(String.class)) {
//                    field.set(bean, "abc");
//                }
//
//                if (klass.equals(Boolean.class)) {
//                    field.set(bean, false);
//                }
//
//                if (klass.equals(Integer.class) && field.getName() != "id") {
//                    field.set(bean, 23);
//                }
//
//                if (klass.equals(Date.class)) {
//                    field.set(bean, new Date());
//                }
//            } catch (IllegalArgumentException e) {
//                e.printStackTrace();
//                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
//            } catch (IllegalAccessException e) {
//                e.printStackTrace();
//                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
//            } catch (SecurityException e) {
//                e.printStackTrace();
//                return;
//            } catch (InstantiationException e) {
//                e.printStackTrace();
//                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
//            }
//        }
        RepositoryViewer rv = new RepositoryViewer();
        UsuarioBean usuario = rv.query(UsuarioBean.class).eq("idusuario", 22).findOne();

        bean.setArquiteturaProcessador("a");
        bean.setDataAtualizacaoOs(new Date());
        bean.setDataCadastro(new Date());
        bean.setDescricao("a");
        bean.setIsServico(false);
        bean.setNomeProcessador("a");
        bean.setNumeroVersaoOs("a");
        bean.setQuantidadeMemoriaRam(1);
        bean.setServicesPack("não");
        bean.setSistemaOperacional("a");
        bean.setTamanhoDisco(1);
        bean.setTipoSistemaOperacional(1);
        bean.setUsuario(usuario);
        bean.setUsuarioDaMaquina("vinicius");
        bean.setVersaoSistemaOperacional("a");

        rv.setUsuario(usuario);
        System.out.println(bean);
        rv.save(bean);
        rv.finalize();
    }

}
