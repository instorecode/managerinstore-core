package br.com.instore.core.orm.generators;

import br.com.instore.core.orm.FileExtended;
import java.lang.reflect.Field;
import java.util.List;
import javax.persistence.Id;
import net.sf.corn.cps.CPScanner;
import net.sf.corn.cps.PackageNameFilter;

public class PropertyGenerator {
    public static void main(String[] args) {
        List<Class<?>> beanList = CPScanner.scanClasses(new PackageNameFilter("br.com.instore.core.orm.bean"));
        List<Class<?>> propertyList = CPScanner.scanClasses(new PackageNameFilter("br.com.instore.core.orm.bean.property"));
        
        for (Class<?> bean : beanList) {
            String name = bean.getSimpleName().replace("Bean", "");
            boolean contains = false;
            
            for (Class<?> prop : propertyList) {
                if(prop.getSimpleName().equals(name)) {
                    contains = true;
                    break;
                }
            }
            // Parse URL Http
            if(!contains) {
                String code = "";
                code = code.concat("package br.com.instore.core.orm.property;\n");
                code = code.concat("public interface ");
                code = code.concat(name.concat(""));
                code = code.concat(" { \n");
                for(Field f : bean.getDeclaredFields()) {
                    String n = f.getName();
                    String nf = " ";
                    for (int i = 0; i < n.length(); i++) {
                        char chr = n.charAt(i);
                        nf = nf.concat(String.valueOf(chr).toUpperCase());
                        if(Character.isUpperCase( chr )) {
                            nf = nf.substring(0, nf.length()-1).concat("_").concat(String.valueOf(chr).toUpperCase());
                        }
                    }                    
                    code = code.concat("\n\t").concat("String ").concat(nf.trim()).concat(" = ").concat("\"").concat(n).concat(genNameValue(f)).concat("\"").concat(";");
                }
                code = code.concat("\n}\n");               
                
                try {
                    FileExtended.write("C:\\Users\\instore\\Desktop\\prop\\", name.concat(".java"), code);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    public static String genNameValue(Field field) {
        String ret = "";
        if (field.getType().getName().contains("br.com.instore.core.orm.bean.")) {
            for (Field f : field.getType().getDeclaredFields()) {
                if(f.isAnnotationPresent(Id.class)) {
                    f.setAccessible(true);
                    ret = ".".concat(f.getName());
                }
            }
        }
        return ret;
    }
}
