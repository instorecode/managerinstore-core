package br.com.instore.dump.categoria;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;

public class Dump {

    public static void main(String[] args) {
        lerCategoriasDoBanco();
    }
    
    public static void lerMusicasDoBanco() {
        try {
            Class.forName("com.hxtt.sql.paradox.ParadoxDriver").newInstance();


            String url = "jdbc:paradox:/c:/Users/TI-Caio/Desktop/bancos/La Semilla/paradox/";

            Connection con = DriverManager.getConnection(url, "", "");

            String sql = "select * from categoria";

            Statement stmt = con.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            ResultSetMetaData resultSetMetaData = rs.getMetaData();
            int iNumCols = resultSetMetaData.getColumnCount();

            for (int i = 1; i <= iNumCols; i++) {
                System.out.println(resultSetMetaData.getColumnLabel(i)
                        + "  "
                        + resultSetMetaData.getColumnTypeName(i));
            }

            String inserts = "";
            while (rs.next()) {
                inserts += "\n";
                inserts += "INSERT INTO categoria_geral VALUES([C],1,[T]);";
                for (int i = 1; i <= iNumCols; i++) {

                    if ("Codigo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getShort(i);
                        inserts = inserts.replace("[C]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Categoria".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = rs.getString(i);
                        inserts = inserts.replace("[T]", "'" + value.replace("'", "\"") + "'");
                    }
                }
            }
            System.out.println(inserts);
            rs.close();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void lerCategoriasDoBanco() {
        try {
            Class.forName("com.hxtt.sql.paradox.ParadoxDriver").newInstance();


            String url = "jdbc:paradox:/c:/Users/TI-Caio/Desktop/bancos/La Semilla/paradox/";

            Connection con = DriverManager.getConnection(url, "", "");

            String sql = "select * from categoria";

            Statement stmt = con.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            ResultSetMetaData resultSetMetaData = rs.getMetaData();
            int iNumCols = resultSetMetaData.getColumnCount();

            for (int i = 1; i <= iNumCols; i++) {
                System.out.println(resultSetMetaData.getColumnLabel(i)
                        + "  "
                        + resultSetMetaData.getColumnTypeName(i));
            }

            String inserts = "";
            while (rs.next()) {
                inserts += "\n";
                inserts += "INSERT INTO categoria_geral VALUES([C],1,[T]);";
                for (int i = 1; i <= iNumCols; i++) {

                    if ("Codigo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getShort(i);
                        inserts = inserts.replace("[C]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Categoria".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = rs.getString(i);
                        inserts = inserts.replace("[T]", "'" + value.replace("'", "\"") + "'");
                    }
                }
            }
            System.out.println(inserts);
            rs.close();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void lerArquivoParadox2() {
        try {
            File file = new File("C:\\Users\\TI-Caio\\Desktop\\banco\\Musica.csv");
            BufferedReader bufferedReader = new BufferedReader(new FileReader(file));

            String readLine;
            List<String> lines = new ArrayList<String>();

            while (null != (readLine = bufferedReader.readLine())) {
                lines.add(readLine);
            }

            String inserts = new String("");
            String inserts2 = new String("");



            for (String line : lines) {
                inserts = "\n";
                inserts += "INSERT INTO musica_geral VALUES(null, [C] , 1 , 0 , [Titulo] , [Interprete] , [TipoInterprete] , '' , 0 , [TempoTotal] , [AnoGravacao] , [Afinidade1] , [Afinidade2] , [Afinidade3] , [Afinidade4] , [Arquivo]);";
                inserts2 = "INSERT INTO categoria_musica_geral VALUES(null, [IC] , (SELECT id FROM musica_geral ORDER BY ID DESC LIMIT 1));";

                List<String> cols = Arrays.asList(line.split(","));

                inserts = inserts.replace("[C]", "'" + cols.get(5).replace("'", "\"") + "'");
                inserts2 = inserts2.replace("[IC]", "'" + cols.get(5).replace("'", "\"") + "'");
                inserts = inserts.replace("[Titulo]", "'" + cols.get(3).replace("'", "\"") + "'");
                inserts = inserts.replace("[Interprete]", "'" + cols.get(1).replace("'", "\"") + "'");
                inserts = inserts.replace("[TipoInterprete]", "'" + cols.get(2).replace("'", "\"") + "'");
                try {
                    inserts = inserts.replace("[TempoTotal]", "'" + new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("HH:mm:ss").parse(cols.get(22).toString())) + "'");
                } catch (Exception e) {
                    try {
                        inserts = inserts.replace("[TempoTotal]", "'" + new SimpleDateFormat("HH:mm:ss").format(new SimpleDateFormat("dd/MM/yyyy").parse(cols.get(22).toString())) + "'");
                    } catch (Exception e2) {
                        inserts = inserts.replace("[TempoTotal]", "'01:01:01'");
                    }
                }
                inserts = inserts.replace("[AnoGravacao]", "'" + cols.get(17).replace("'", "\"") + "'");
                inserts = inserts.replace("[TipoInterprete]", "'" + cols.get(2).replace("'", "\"") + "'");
                inserts = inserts.replace("[Afinidade1]", "'" + cols.get(12).replace("'", "\"") + "'");
                inserts = inserts.replace("[Afinidade2]", "'" + cols.get(13).replace("'", "\"") + "'");
                inserts = inserts.replace("[Afinidade3]", "'" + cols.get(14).replace("'", "\"") + "'");
                inserts = inserts.replace("[Afinidade4]", "'" + cols.get(15).replace("'", "\"") + "'");
                inserts = inserts.replace("[Arquivo]", "'smb://192.168.1.226/Programacao/SERVER/" + cols.get(0).replace("'", "\"") + "'");

                System.out.println(inserts);
                System.out.println(inserts2);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<String> listaMusicaJaCadastradas() {
        List<String> nomes = new ArrayList<String>();
        try {
            File file = new File("C:\\Users\\TI-Caio\\Desktop\\banco\\Musica.csv");
            BufferedReader bufferedReader = new BufferedReader(new FileReader(file));

            String readLine;
            List<String> lines = new ArrayList<String>();

            while (null != (readLine = bufferedReader.readLine())) {
                lines.add(readLine);
            }

            for (String line : lines) {
                List<String> cols = Arrays.asList(line.split(","));
                nomes.add(cols.get(0).trim());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return nomes;
    }

    public static void comparaArquivos() {
        try {
            List<String> nomes = listaMusicaJaCadastradas();
            List<String> nomes2 = new ArrayList<String>();

            SmbFile file = new SmbFile("smb://192.168.1.226/Programacao/SERVER/", new NtlmPasswordAuthentication("", "Intranet", "<nsto>re#*12"));
            for (SmbFile item : file.listFiles()) {
                String nomeArquivoNaoCadastrado = item.getName().trim();
                if (!nomes.contains(nomeArquivoNaoCadastrado)) {
                    nomes2.add(nomeArquivoNaoCadastrado);
                }
            }
            System.out.println("TOTAL: " + nomes2.size());
            for (String n : nomes2) {
                System.out.println(n);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (SmbException e) {
            e.printStackTrace();
        }
    }

    public static void replaceAll(StringBuilder builder, String from, String to) {
        int index = builder.indexOf(from);
        while (index != -1) {
            builder.replace(index, index + from.length(), to);
            index += to.length(); // Move to the end of the replacement
            index = builder.indexOf(from, index);
        }
    }
}
