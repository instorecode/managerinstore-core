
import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.BugBean;
import br.com.instore.core.orm.bean.SolucaoBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import br.com.instore.core.orm.bean.VersaoBugBean;
import java.util.List;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Id;
import javax.persistence.Column;

public class TestadorDeBanco {

    public static void main(String[] args) {
        try {
            Bean bean = testeDeIsercao(new VersaoBugBean());
            System.out.println(bean);
            
            RepositoryViewer rv = new RepositoryViewer();          
            rv.setUsuario(new UsuarioBean(22));
            rv.save(bean);
            rv.finalize();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private static Bean testeDeIsercao(Bean bean) throws Exception {
        try {
            List<Field> listaCampos = Arrays.asList(bean.getClass().getDeclaredFields());
            String classToBelongField = listaCampos.get(0).getDeclaringClass().toString().split("bean.")[1];

            for (Field field : listaCampos) {
                try {
                    field.setAccessible(true);
                    Class<?> klass = field.getType();

                    if (klass.getName().contains("bean")) {
                        Object obj = klass.newInstance();
                        List<Field> fieldsListInside = Arrays.asList(klass.getDeclaredFields());

                        for (Field fieldInside : fieldsListInside) {
                            fieldInside.setAccessible(true);

                            if (fieldInside.isAnnotationPresent(Id.class)) {
                                fieldInside.set(obj, 1);
                            }
                        }
                        field.set(bean, obj);
                    }

                    if (klass.equals(String.class)) {
                        // Pega o tamnho do texto caso seja menor que o tamanho maximo 
                        // Pegar somente um fragmento do texto conforme o tamnho maximo                    
                        Integer lengFromString = field.getAnnotation(Column.class).length();
                        classToBelongField = (classToBelongField.length() < lengFromString) ? classToBelongField : classToBelongField.substring(0, lengFromString);
                        field.set(bean, classToBelongField);
                    }

                    if (klass.equals(Boolean.class)) {
                        field.set(bean, false);
                    }

                    if (klass.equals(Integer.class) && field.getName() != "id") {
                        field.set(bean, 1);
                    }

                    if (klass.equals(Date.class)) {
                        field.set(bean, new Date());
                    }
                } catch (IllegalArgumentException e) {
                    e.printStackTrace();
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
                } catch (IllegalAccessException e) {
                    e.printStackTrace();
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
                } catch (SecurityException e) {
                    e.printStackTrace();
                    return null;
                } catch (InstantiationException e) {
                    e.printStackTrace();
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, e);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
        return bean;
    }
}
