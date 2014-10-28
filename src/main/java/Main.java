
import java.net.MalformedURLException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import net.sf.corn.cps.CPScanner;
import net.sf.corn.cps.PackageNameFilter;


public class Main {

    public static void main(String[] args) {
        List<Class<?>> klassList = CPScanner.scanClasses();
        for (Class<?> klass : klassList) {
            System.out.println(klass.getSimpleName());
        }
    }
}
