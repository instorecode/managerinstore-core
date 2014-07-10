package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.PerfilBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Properties;
import net.sf.corn.cps.CPScanner;
import net.sf.corn.cps.ClassFilter;
import net.sf.corn.cps.PackageNameFilter;
import org.hibernate.Session;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import org.hibernate.service.ServiceRegistryBuilder;

public class SessionFactoryUtils {

    private Session sessionLocal;
    private static SessionFactoryUtils instance;

    private SessionFactoryUtils() {
    }

    public static SessionFactoryUtils getInstance() {
        if (null == instance) {
            instance = new SessionFactoryUtils();
        }
        return instance;
    }

    public Session session() {
        if (null == sessionLocal) {
            Configuration configuration = new Configuration();
            configuration.addProperties(properties());

            for (Class<?> klass : beans()) {
                configuration.addAnnotatedClass(klass);
            }

            ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry();
            sessionLocal = configuration.buildSessionFactory(serviceRegistry).openSession();
        } else {
            if (!sessionLocal.isOpen()) {
                sessionLocal = sessionLocal.getSessionFactory().openSession();
            }
        }
        return sessionLocal;
    }

    private List<Class<?>> beans() {
        return CPScanner.scanClasses(new PackageNameFilter("br.com.instore.core.orm.bean"));
    }

    private Properties properties() {
        FileInputStream fis = null;
        Properties properties = new Properties();
        try {
            String filename = this.getClass().getResource("/br/com/instore/resources").getPath() + "/";
            switch (Environment.env()) {
                case DEVELOPMENT:
                    filename += "DEVELOPMENT.properties";
                    break;
                case PRODUCTION:
                    filename += "PRODUCTION.properties";
                    break;
            }
            fis = new FileInputStream(new File(filename));
            
            properties.load(fis);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (null != fis) {
                    fis.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return properties;
    }
    
    public static void main(String[] args) {
        System.err.println(System.getProperty("user.dir"));
    }
}
