package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.PerfilBean;
import br.com.instore.core.orm.bean.UsuarioBean;
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

    public static Session openSession() {
        Configuration configuration = new Configuration();
        configuration.addProperties(properties());
        
        for(Class<?> klass : beans()) {
            configuration.addAnnotatedClass(klass);
        }
        
        ServiceRegistry serviceRegistry = new ServiceRegistryBuilder().applySettings(configuration.getProperties()).buildServiceRegistry(); 
        return configuration.buildSessionFactory(serviceRegistry).openSession();
    }

    protected static List<Class<?>> beans() {
        return CPScanner.scanClasses(new PackageNameFilter("br.com.instore.core.orm.bean"));
    }

    protected static Properties properties() {
        Properties properties = new Properties();
        // padrao
        properties.put("hibernate.connection.driver_class", "com.mysql.jdbc.Driver");
        properties.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
        properties.put("hibernate.connection.url", "jdbc:mysql://localhost:3306/instore?autoReconnectForPools=true");
        properties.put("hibernate.connection.username", "root");
        properties.put("hibernate.connection.password", "");
        
        // pool
        properties.put("hibernate.connection.provider_class", "org.hibernate.service.jdbc.connections.internal.C3P0ConnectionProvider");
        properties.put("hibernate.connection.pool_size", 1);
        properties.put("c3p0.min_size", 5);
        properties.put("c3p0.max_size", 50);
        properties.put("c3p0.max_statements", 0);
        properties.put("c3p0.idle_test_period", 100);
        properties.put("c3p0.timeout", (60*30));
        properties.put("c3p0.autoCommitOnClose", false);
        properties.put("c3p0.acquire_increment", 5);
        
        return properties;
    }
}
