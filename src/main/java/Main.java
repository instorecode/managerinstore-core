
import java.net.MalformedURLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;


public class Main {

    public static void main(String[] args) {
        SmbFile sf;
        try {
            sf = new SmbFile("smb://");
            System.out.println(sf.exists());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (SmbException e) {
            e.printStackTrace();
        }
        
    }
}
