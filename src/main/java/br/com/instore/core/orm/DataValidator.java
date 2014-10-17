package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.UsuarioBean;
import java.lang.reflect.Field;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;

public class DataValidator {

    public static  <T extends Bean>  void beanValidator(T t) throws DataValidatorException {
        try {
            exec(t);
        } catch (DataValidatorException e) {
            throw e;
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    private static <T extends Bean> void exec(T t) throws DataValidatorException, IllegalArgumentException, IllegalAccessException {
        for (Field field : t.getClass().getDeclaredFields()) {
            field.setAccessible(true);

            String message = "Lamento, ocorreu um erro ao preencher os campos do formulário,";
            String nameField = field.getName();

            if (field.isAnnotationPresent(ViewLabel.class)) {
                ViewLabel viewLabel = field.getAnnotation(ViewLabel.class);
                nameField = viewLabel.value();
            }

            if (field.isAnnotationPresent(Column.class)) {
                Column column = field.getAnnotation(Column.class);

                if (!column.nullable() && !field.isAnnotationPresent(GeneratedValue.class)) {
                    if (null == field.get(t)) {
                        message += nameField + " deve ser preenchido.";
                        throw new DataValidatorException(message);
                    }
                }

                if (field.getType() == String.class) {
                    if (field.get(t).toString().length() <= 0) {
                        message += nameField + " deve ser preenchido.";
                        throw new DataValidatorException(message);
                    }
                }
                if (field.getType() == String.class && column.length() > 0) {
                    if (field.get(t).toString().length() > column.length()) {
                        message += nameField + " não deve conter mais de " + column.length() + " caracteres.";
                        throw new DataValidatorException(message);
                    }
                }
            }

            if (field.isAnnotationPresent(JoinColumn.class)) {
                if (field.getType().getSuperclass() == Bean.class) {
                    JoinColumn joinColumn = field.getAnnotation(JoinColumn.class);

                    if (!joinColumn.nullable()) {
                        if (null == field.get(t)) {
                            message += nameField + " deve ser preenchido.";
                            throw new DataValidatorException(message);
                        } else {
                            Bean bean = (Bean) field.get(t);
                            for (Field fieldBean : bean.getClass().getDeclaredFields()) {
                                if (fieldBean.isAnnotationPresent(Id.class)) {
                                    if (null == fieldBean.get(bean)) {
                                        message += nameField + " deve ser preenchido.";
                                        throw new DataValidatorException(message);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
