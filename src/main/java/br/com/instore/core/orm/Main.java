package br.com.instore.core.orm;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.zip.DataFormatException;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

public class Main {

    public static void main(String[] args) throws UnsupportedEncodingException, DataFormatException, FileNotFoundException, IOException {
//        compressGzipFile("C:\\Users\\TI-Caio\\Desktop\\VideoOne.l-3", "C:\\Users\\TI-Caio\\Desktop\\zip.l-3");
//        decompressGzipFile("C:\\Users\\TI-Caio\\Desktop\\zip.l-3", "C:\\Users\\TI-Caio\\Desktop\\unzip.l-3");
    }

    private static void decompressGzipFile(String gzipFile, String newFile) throws FileNotFoundException, IOException {
        try {
            FileInputStream fis = new FileInputStream(gzipFile);
            GZIPInputStream gis = new GZIPInputStream(fis);
            FileOutputStream fos = new FileOutputStream(newFile);
            byte[] buffer = new byte[1024];
            int len;
            while ((len = gis.read(buffer)) != -1) {
                fos.write(buffer, 0, len);
            }
            //close resources
            fos.close();
            gis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private static void compressGzipFile(String file, String gzipFile) {
        try {
            FileInputStream fis = new FileInputStream(file);
            FileOutputStream fos = new FileOutputStream(gzipFile);
            GZIPOutputStream gzipOS = new GZIPOutputStream(fos);
            byte[] buffer = new byte[1024];
            int len;
            while ((len = fis.read(buffer)) != -1) {
                gzipOS.write(buffer, 0, len);
            }
            //close resources
            gzipOS.close();
            fos.close();
            fis.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
