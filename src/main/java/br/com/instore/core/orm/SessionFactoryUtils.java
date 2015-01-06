package br.com.instore.core.orm;

import java.util.List;
import java.util.Properties;
import net.sf.corn.cps.CPScanner;
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

//    private Properties properties() {
//        FileInputStream fis = null;
//        Properties properties = new Properties();
//        try {
//            String filename = this.getClass().getResource("/br/com/instore/resources").getPath() + "/";
//            switch (Environment.env()) {
//                case DEVELOPMENT:
//                    filename += "DEVELOPMENT.properties";
//                    break;
//                case PRODUCTION:
//                    filename += "PRODUCTION.properties";
//                    break;
//            }
//            fis = new FileInputStream(new File(filename));
//            
//            properties.load(fis);
//        } catch (FileNotFoundException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (null != fis) {
//                    fis.close();
//                }
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//        return properties;
//    }
    private Properties properties() {
        Properties properties = new Properties();
        // padrao
        properties.put("hibernate.connection.driver_class", "com.mysql.jdbc.Driver");
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
//        properties.put("hibernate.connection.url", "jdbc:mysql://192.168.1.56:3306/test?autoReconnectForPools=true");
        properties.put("hibernate.connection.url", "jdbc:mysql://localhost:3306/intranet?autoReconnectForPools=true");
        properties.put("hibernate.show_sql", true);
        properties.put("javax.persistence.validation.mode", "none"); 
        properties.put("hibernate.connection.username", "root");
//        properties.put("hibernate.connection.password", "instore@#");
//        properties.put("hibernate.'.password", "");

//        if (Environment.env() == Environment.Env.DEVELOPMENT) {
//            properties.put("hibernate.connection.username", "root");
//            properties.put("hibernate.connection.password", "");
//        } else {
//            properties.put("hibernate.connection.username", "root");
//            properties.put("hibernate.connection.password", "instore@#");
//        }

        // pool
        properties.put("hibernate.connection.provider_class", "org.hibernate.service.jdbc.connections.internal.C3P0ConnectionProvider");
        properties.put("hibernate.connection.pool_size", 1);
        properties.put("c3p0.min_size", 5);
//        properties.put("c3p0.max_size", 200);
        properties.put("c3p0.max_statements", 50);
        properties.put("c3p0.idle_test_period", 3000);
        properties.put("c3p0.timeout", ((60 * 60) * 24));
        properties.put("c3p0.autoCommitOnClose", false);
        properties.put("c3p0.acquire_increment", 5);
        return properties;
    }
}
