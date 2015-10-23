
import br.com.instore.core.orm.Bean;
import java.util.List;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Id;
import javax.persistence.Column;

public class TestadorDeBanco {

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
                } catch (IllegalAccessException e) {
                    e.printStackTrace();                
                } catch (SecurityException e) {
                    e.printStackTrace();
                    return null;
                } catch (InstantiationException e) {
                    e.printStackTrace();                
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage());
        }
        return bean;
    }
}
