//package br.com.instore.core.orm;
//
//import static br.com.instore.core.orm.Test.uncompressString;
//import java.io.BufferedInputStream;
//import java.io.BufferedOutputStream;
//import java.io.BufferedReader;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileNotFoundException;
//import java.io.FileOutputStream;
//import java.io.FileReader;
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.Collection;
//import java.util.Collections;
//import java.util.HashMap;
//import java.util.List;
//import java.util.logging.Level;
//import java.util.logging.Logger;
//import java.util.zip.Deflater;
//import java.util.zip.Inflater;
//import org.apache.commons.compress.archivers.ArchiveException;
//import org.apache.commons.compress.compressors.CompressorException;
//import org.apache.commons.compress.compressors.pack200.Pack200CompressorInputStream;
//
//public class Test {
//
//    public static void main(String[] args) {
//         compress("C:\\Users\\TI-Caio\\Desktop\\test\\musica.mp3");
//        // 6450991
//    }
//
//    public static void compress(String pathfile) {
//        try {
//            File file = new File(pathfile);
//            String pathfile2 = pathfile;
//            String pathfile3 = pathfile;
//            pathfile2 = pathfile2.substring(0, pathfile.indexOf(file.getName()));
//
//            String[] nomepart = file.getName().replace(".", "-").split("-");
//
//            for (int i = 0; i < nomepart.length - 1; i++) {
//                pathfile2 += nomepart[i];
//            }
//
//            pathfile3 = pathfile2; 
//            pathfile2 += ".byte";
//            pathfile3 += ".txt";
//            System.out.println(pathfile2);
//
//            byte bytes[] = new byte[(int) file.length()];
//
//            BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
//            bufferedInputStream.read(bytes, 0, bytes.length);
//            bufferedInputStream.close();
//
//            StringBuilder compressedbytes = new StringBuilder();
//            HashMap<Byte, Integer> repeatedValue = new HashMap<Byte, Integer>();
//            for (byte b : bytes) {
//                if (repeatedValue.containsKey(b)) {
//                    int index = repeatedValue.get(b) + 1;
//                    repeatedValue.put(b, index);
//                } else {
//                    repeatedValue.put(b, 1);
//                    compressedbytes.append(getAscii(b));
//                }
//            }
//            
//            
//            System.out.println("BYTES SIZE " + bytes.length);
//            System.out.println("BYTES SIZE " + repeatedValue.size());
//            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(new File(pathfile2)));
//            bufferedOutputStream.write(bytesCompr, 0, bytesCompr.length);
//            bufferedOutputStream.flush();
//            bufferedOutputStream.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static String getAscii(int i) {
//        if (i < 0) {
//            int y = i + (2 * (-1 * i));
//            i = y;
//        }
//        
//        return ""+(char) i;
//    }
//
//    public static void uncompress(String pathfile) {
//        try {
//            File file = new File(pathfile);
//            String pathfile2 = pathfile;
//            pathfile2 = pathfile2.substring(0, pathfile.indexOf(file.getName()));
//
//            String[] nomepart = file.getName().replace(".", "-").split("-");
//
//            for (int i = 0; i < nomepart.length - 1; i++) {
//                pathfile2 += nomepart[i];
//            }
//            pathfile2 += ".mp3";
//            System.out.println(pathfile2);
//
//            BufferedReader bufferedReader = new BufferedReader(new FileReader(file));
//            String readLine = "";
//
//            StringBuilder stringBuilder = new StringBuilder();
//            while ((readLine = bufferedReader.readLine()) != null) {
//                stringBuilder.append(readLine);
//            }
//
//            String stringBytes = uncompressString(stringBuilder.toString());
//            List<String> position = Arrays.asList(stringBytes.split(","));
//
//            byte[] bytesFile = new byte[position.size() - 1];
//
//            for (String p : position) {
//                List<String> indexValue = Arrays.asList(p.split("-"));
//                Integer index = Integer.parseInt(indexValue.get(0));
//                byte value = Byte.parseByte(indexValue.get(1).toString());
//
//                bytesFile[index] = value;
//            }
//
//            BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(new File(pathfile2)));
//            bufferedOutputStream.write(bytesFile, 0, bytesFile.length);
//            bufferedOutputStream.flush();
//            bufferedOutputStream.close();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static String compressString(String expressao) {
//        int tamanho = 1024;
//        byte[] input = expressao.getBytes();
//        byte[] output = new byte[tamanho];
//        Deflater compresser = new Deflater();
//        compresser.setInput(input);
//        compresser.finish();
//        compresser.deflate(output);
//
//        sun.misc.BASE64Encoder enc = new sun.misc.BASE64Encoder();
//        String s = enc.encode(output);
//        return s;
//    }
//
//    public static String uncompressString(String expressao) {
//        int tamanho = 1024;
//        try {
//            sun.misc.BASE64Decoder dec = new sun.misc.BASE64Decoder();
//            byte output[] = dec.decodeBuffer(expressao);
//
//            Inflater decompresser = new Inflater();
//            decompresser.setInput(output);
//            byte[] result = new byte[tamanho];
//            decompresser.inflate(result);
//            decompresser.end();
//            return new String(result);
//        } catch (java.util.zip.DataFormatException ex) {
//            ex.printStackTrace();
//            return "";
//        } catch (IOException e) {
//            e.printStackTrace();
//            return "";
//        }
//    }
//}
