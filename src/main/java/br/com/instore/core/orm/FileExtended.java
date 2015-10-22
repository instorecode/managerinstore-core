package br.com.instore.core.orm;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

public class FileExtended {

    public static void write(String dirpath, String filename, String content) throws FileNotFoundException , IOException , Exception {
        try {
            File dir = new File(dirpath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            
            File file = new File(dirpath.concat(filename));
            System.out.println(file.getAbsolutePath());
            FileOutputStream fos = new FileOutputStream(file);
            BufferedOutputStream bos = new  BufferedOutputStream(fos);
            bos.write(content.getBytes());
            bos.flush();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
