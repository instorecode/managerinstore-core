package br.com.instore.dump;

import br.com.instore.core.orm.DataValidatorException;
import br.com.instore.core.orm.Each;
import br.com.instore.core.orm.RepositoryViewer;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.math.BigInteger;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import jcifs.smb.NtlmPasswordAuthentication;
import jcifs.smb.SmbException;
import jcifs.smb.SmbFile;
import org.apache.commons.lang.StringUtils;

public class DumpGeral {

    public final static Integer idclienteFinal = 1063;

    public static void main(String[] args) {
        String urlparadox = "jdbc:paradox:/c:/Users/TI-Caio/Desktop/bancos/San Marino/paradox/";
        String urlexp = "C:\\Users\\TI-Caio\\Desktop\\bancos\\San Marino\\EXP\\musica.exp";
       
        lerProgramacaoDoBanco(urlparadox);
        lerComercialDoBanco(urlparadox);
        lerMusicasDoExp(urlexp);
    }

    public static void lerComercialDoBanco(String url) {
        RepositoryViewer rv = new RepositoryViewer();

        final List<Integer> countList = new ArrayList<Integer>();
        rv.query("select count(codigo) as count, '' as param from audiostore_categoria where idcliente = " + idclienteFinal + " and categoria = 'NENHUM'").executeSQL(new Each() {
            public BigInteger count;
            public String param;

            public void each() {
                countList.add(count.intValue());
            }
        });

        if (null != countList && !countList.isEmpty()) {
            if (countList.get(0) <= 0) {
                try {
                    rv.query("INSERT INTO audiostore_categoria VALUES (null, '" + idclienteFinal + "', 'NENHUM', '2001-01-01', '2050-12-31', '1', '00:00:00', '001');").executeSQLCommand2();
                } catch (DataValidatorException e) {
                    e.printStackTrace();
                }
            }
        } else {
            try {
                rv.query("INSERT INTO audiostore_categoria VALUES (null, '" + idclienteFinal + "', 'NENHUM', '2001-01-01', '2050-12-31', '1', '00:00:00', '001');").executeSQLCommand2();
            } catch (DataValidatorException e) {
                e.printStackTrace();
            }
        }

        try {
            Class.forName("com.hxtt.sql.paradox.ParadoxDriver").newInstance();

            Connection con = DriverManager.getConnection(url, "", "");

            String sql = "select * from comercial";

            Statement stmt = con.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            ResultSetMetaData resultSetMetaData = rs.getMetaData();
            int iNumCols = resultSetMetaData.getColumnCount();

            for (int i = 1; i <= iNumCols; i++) {
                // System.out.println(resultSetMetaData.getColumnLabel(i) + "  " + resultSetMetaData.getColumnTypeName(i));
            }

            String inserts = "";
            while (rs.next()) {
                inserts = "\nINSERT INTO audiostore_comercial VALUES(null , [categoria] , [arquivo], [titulo] , [tipo_interprete] , [periodo_inicial] , [periodo_final] , [tipo_horario] , [dias_semana] , [dias_alternados] , [data] , [ultima_execucao] , [tempo_total] , [random] , [qtde_player] , [qtde] , [data_vencimento], [dependencia1] , [dependencia2] , [dependencia3] , [frame_inicio] , [frame_final] , [msg] , [sem_som] , " + idclienteFinal + " , 0  , '' )";

                for (int i = 1; i <= iNumCols; i++) {

                    if ("Random".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (rs.getInt(i));
                        inserts = inserts.replace("[random]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Categoria".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (rs.getShort(i) + idclienteFinal);
                        if (0 == rs.getShort(i)) {
                            inserts = inserts.replace("[categoria]", "(select codigo from audiostore_categoria where idcliente = "+idclienteFinal+" order by codigo desc limit 1)");
                        } else {
                            inserts = inserts.replace("[categoria]", "'" + value.replace("'", "\"") + "'");
                        }

                    }

                    if ("Arquivo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[arquivo]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Titulo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[titulo]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("TipoInterprete".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getShort(i);
                        inserts = inserts.replace("[tipo_interprete]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("PeriodoInicial".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[periodo_inicial]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("PeriodoFinal".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[periodo_final]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("TipoHorario".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getShort(i);
                        inserts = inserts.replace("[tipo_horario]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("DiaSemana".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[dias_semana]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("DiasAlternados".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (rs.getBoolean(i) ? "1" : "0");
                        inserts = inserts.replace("[dias_alternados]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Data".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[data]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("UltimaExecucao".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[ultima_execucao]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("TempoTotal".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[tempo_total]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("QtdePlayer".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getInt(i);
                        inserts = inserts.replace("[qtde_player]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Qtde".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getInt(i);
                        inserts = inserts.replace("[qtde]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("DataVencto".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[data_vencimento]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Dependencia1".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[dependencia1]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Dependencia2".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[dependencia2]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Dependencia3".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[dependencia3]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("FrameInicio".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getInt(i);
                        inserts = inserts.replace("[frame_inicio]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("FrameFinal".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getInt(i);
                        inserts = inserts.replace("[frame_final]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("Msg".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (null == rs.getString(i) ? "" : rs.getString(i));
                        inserts = inserts.replace("[msg]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("SemSom".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (rs.getBoolean(i) ? "1" : "0");
                        inserts = inserts.replace("[sem_som]", "'" + value.replace("'", "\"") + "'");
                    }
                }
                inserts += ";";

                for (int i = 8; i < 56; i = i + 2) {
                    String sm1 = (null == rs.getString(8) ? "0" : rs.getString(i + 1));
                    Date hr1d = rs.getDate(i + 2);
//                    System.out.println(resultSetMetaData.getColumnLabel(1).trim() +" -> " + rs.getString(1) + "  -> " + resultSetMetaData.getColumnLabel(i+1).trim() + " : " + sm1);
                    String hr1 = "" + new SimpleDateFormat("HH:mm:ss").format(null == hr1d ? new Date() : hr1d);
                    
                    if (null != sm1 && !sm1.trim().equals("0")) {
                        
                        boolean segunda = (!sm1.substring(0, 1).equals(" ") ? true : false);
                        boolean segundaNX = (!sm1.substring(0, 1).equals("N") ? true : false);

                        boolean terca = (!sm1.substring(1, 2).equals(" ") ? true : false);
                        boolean tercaNX = (!sm1.substring(1, 2).equals("N") ? true : false);

                        boolean quarta = (!sm1.substring(2, 3).equals(" ") ? true : false);
                        boolean quartaNX = (!sm1.substring(2, 3).equals("N") ? true : false);

                        boolean quinta = (!sm1.substring(3, 4).equals(" ") ? true : false);
                        boolean quintaNX = (!sm1.substring(3, 4).equals("N") ? true : false);

                        boolean sexta = (!sm1.substring(4, 5).equals(" ") ? true : false);
                        boolean sextaNX = (!sm1.substring(4, 5).equals("N") ? true : false);

                        boolean sabado = (!sm1.substring(5, 6).equals(" ") ? true : false);
                        boolean sabadoNX = (!sm1.substring(5, 6).equals("N") ? true : false);

                        boolean domingo = (!sm1.substring(6, 7).equals(" ") ? true : false);
                        boolean domingoNX = (!sm1.substring(6, 7).equals("N") ? true : false);


                        if (segunda) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'segunda' , '" + hr1 + "' , '" + (segundaNX ? 1 : 0) + "' );";
                        }

                        if (terca) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'terca' , '" + hr1 + "' , '" + (tercaNX ? 1 : 0) + "' );";
                        }

                        if (quarta) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'quarta' , '" + hr1 + "' , '" + (quartaNX ? 1 : 0) + "' );";
                        }

                        if (quinta) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'quinta' , '" + hr1 + "' , '" + (quintaNX ? 1 : 0) + "' );";
                        }

                        if (sexta) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'sexta' , '" + hr1 + "' , '" + (sextaNX ? 1 : 0) + "' );";
                        }

                        if (sabado) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'sabado' , '" + hr1 + "' , '" + (sabadoNX ? 1 : 0) + "' );";
                        }

                        if (domingo) {
                            inserts += "\nINSERT INTO audiostore_comercial_sh VALUES(null , (select id from audiostore_comercial order by id desc limit 1) , 'domingo' , '" + hr1 + "' , '" + (domingoNX ? 1 : 0) + "' );";
                        }
                    }
                }
                System.out.println(inserts);
            }
            rs.close();

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public static void lerMusicasDoExp(String url) {
        List<String> nomes = new ArrayList<String>();
        try {
            RepositoryViewer rv = new RepositoryViewer();
            String readLine;
            List<String> lines = new ArrayList<String>();
            BufferedReader br = new BufferedReader(new FileReader(new File(url)));
            while (null != (readLine = br.readLine())) {
                lines.add(readLine);
            }

            String inserts = "";
            for (String line : lines) {
                inserts += "\nINSERT INTO audiostore_musica VALUES(null,  ( select ( if ( (select count(id) as id from musica_geral where titulo = [tt]) > 0 , (select id as id from musica_geral where titulo = [tt] limit 1) , (select mg.id from musica_geral as mg inner join categoria_musica_geral on categoria_musica_geral.musica = mg.id and categoria_musica_geral.categoria = [cc]  limit 1) ) ) ) , [categoria1], [categoria2],  [categoria3], [cut], [crossover], [data_vencimento_crossover], [dias_execucao1], [dias_execucao2], [data], [ultima_execucao], [ultima_execucao_data], 0, [qtde_player], [qtde], [data_vencimento], [frame_inicio], [frame_final], [msg], [sem_som],  [super_crossover], " + idclienteFinal + ");";

                String Arquivo = line.substring(0, 30).trim().replace("'", "\"");
                String Interprete = line.substring(30, 60).trim().replace("'", "\"");
                String tipo_Interprete = line.substring(60, 61).trim().replace("'", "\"");
                String Titulo = line.substring(61, 91).trim().replace("'", "\"");
                String Cut = line.substring(91, 94).trim().replace("'", "\"");
                String Categoria1 = (line.substring(94, 97).trim().replace("'", "\"").startsWith("0") ? line.substring(94, 97).trim().replace("'", "\"").substring(1, line.substring(94, 97).trim().replace("'", "\"").length()) : line.substring(94, 97).trim().replace("'", "\""));
                String Categoria2 = ("00".equals((line.substring(97, 100).trim().replace("'", "\"").startsWith("0") ? line.substring(97, 100).trim().replace("'", "\"").substring(1, line.substring(97, 100).trim().replace("'", "\"").length()) : line.substring(97, 100).trim().replace("'", "\""))) ? "null" : (line.substring(97, 100).trim().replace("'", "\"").startsWith("0") ? line.substring(97, 100).trim().replace("'", "\"").substring(1, line.substring(97, 100).trim().replace("'", "\"").length()) : line.substring(97, 100).trim().replace("'", "\"")));
                String Categoria3 = ("00".equals((line.substring(100, 103).trim().replace("'", "\"").startsWith("0") ? line.substring(100, 103).trim().replace("'", "\"").substring(1, line.substring(100, 103).trim().replace("'", "\"").length()) : line.substring(100, 103).trim().replace("'", "\""))) ? "null" : (line.substring(100, 103).trim().replace("'", "\"").startsWith("0") ? line.substring(100, 103).trim().replace("'", "\"").substring(1, line.substring(100, 103).trim().replace("'", "\"").length()) : line.substring(100, 103).trim().replace("'", "\"")));
                String crossover = line.substring(103, 106).trim().replace("'", "\"");
                String dias_de_execucao = line.substring(106, 110).trim().replace("'", "\"");
                String dias_de_execucao2 = line.substring(110, 114).trim().replace("'", "\"");
                String afinidade1 = line.substring(114, 144).trim().replace("'", "\"");
                String afinidade2 = line.substring(144, 174).trim().replace("'", "\"");
                String afinidade3 = line.substring(174, 204).trim().replace("'", "\"");
                String afinidade4 = line.substring(204, 234).trim().replace("'", "\"");
                String gravadora = line.substring(234, 237).trim().replace("'", "\"");
                String ano_de_gravacao = line.substring(237, 241).trim().replace("'", "\"");
                String velocidade = line.substring(241, 242).trim().replace("'", "\"");
                String data = line.substring(242, 250).trim().replace("'", "\"");
                String data_da_ultima_execucao = (line.substring(250, 269).trim().length() == 19 ? line.substring(250, 269).trim() : line.substring(250, 269).trim() + " 00:01:01").replace("'", "\"");
                String tempo_total_da_música = line.substring(269, 277).trim().replace("'", "\"");
                String qtde_de_player_total = line.substring(277, 280).trim().replace("'", "\"");
                String data_vencimento = line.substring(280, 286).trim().replace("'", "\"")+"20"+line.substring(286, 288);
                String data_vencimento_crossover = line.substring(288, 297).trim().replace("'", "\"");
                String frame_inicial = line.substring(297, 305).trim().replace("'", "\"");
                String frame_final = line.substring(305, 313).trim().replace("'", "\"");
                String msg = line.substring(313, 353).trim().replace("'", "\"");
                String sem_som = line.substring(353, 353).trim().replace("'", "\"");

                final List<Integer> countList = new ArrayList<Integer>();
                rv.query("select count(id) as count , '' as param from musica_geral where titulo = '" + Titulo + "'").executeSQL(new Each() {
                    public BigInteger count;
                    public String param;

                    public void each() {
                        countList.add(count.intValue());
                    }
                });

                if (null != countList && !countList.isEmpty() && countList.get(0) > 0) {
                    //idclienteFinal
                    inserts = inserts.replace("[tt]", "'" + Titulo + "'");
                    inserts = inserts.replace("[categoria1]", "'" + (Integer.parseInt(Categoria1.replace("'", "\"")) + idclienteFinal) + "'");
                    inserts = inserts.replace("[cc]", "'" + (Integer.parseInt(Categoria1.replace("'", "\"")) + idclienteFinal) + "'");
                    if (null != Categoria2 && !Categoria2.trim().isEmpty() && !Categoria2.trim().equals("0") && !Categoria2.trim().equals("null")) {
                        inserts = inserts.replace("[categoria2]", "'" + (Integer.parseInt(Categoria2.replace("'", "\"")) + idclienteFinal) + "'");
                    } else {
                        inserts = inserts.replace("[categoria2]", "null");
                    }
                    if (null != Categoria3 && !Categoria3.trim().isEmpty() && !Categoria3.trim().equals("0") && !Categoria3.trim().equals("null")) {
                        inserts = inserts.replace("[categoria3]", "'" + (Integer.parseInt(Categoria3.replace("'", "\"")) + idclienteFinal) + "'");
                    } else {
                        inserts = inserts.replace("[categoria3]", "null");
                    }
                    
                    inserts = inserts.replace("[cut]", "'" + Cut + "'");
                    inserts = inserts.replace("[crossover]", "'" + crossover.replace("'", "\"") + "'");
                    inserts = inserts.replace("[data_vencimento_crossover]", "'" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd/MM/yy").parse(data_vencimento_crossover)) + "'");
                    inserts = inserts.replace("[dias_execucao1]", "'" + dias_de_execucao.replace("'", "\"") + "'");
                    inserts = inserts.replace("[dias_execucao2]", "'" + dias_de_execucao2.replace("'", "\"") + "'");
                    inserts = inserts.replace("[data]", "'" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd/MM/yy").parse(data)) + "'");
                    inserts = inserts.replace("[ultima_execucao]", "'" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd/MM/yyyy hh:mm:ss").parse(data_da_ultima_execucao)) + "'");
                    inserts = inserts.replace("[ultima_execucao_data]", "'" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new SimpleDateFormat("dd/MM/yyyy hh:mm:ss").parse(data_da_ultima_execucao)) + "'");
                    inserts = inserts.replace("[qtde_player]", "'" + qtde_de_player_total.replace("'", "\"") + "'");
                    inserts = inserts.replace("[qtde]", "'" + qtde_de_player_total.replace("'", "\"") + "'");
                    inserts = inserts.replace("[data_vencimento]", "'" + new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd/MM/yyyy").parse(data_vencimento)) + "'");
                    inserts = inserts.replace("[frame_inicio]", "'" + frame_inicial.replace("'", "\"") + "'");
                    inserts = inserts.replace("[frame_final]", "'" + frame_final.replace("'", "\"") + "'");
                    inserts = inserts.replace("[msg]", "'" + msg.replace("'", "\"") + "'");
                    inserts = inserts.replace("[sem_som]", "'" + sem_som.replace("'", "\"") + "'");
                    inserts = inserts.replace("[super_crossover]", "'0'");

//                System.out.println("select count(id) as total , '"+Titulo+"' from musica_geral where titulo = '"+Titulo+"' \n union");
                } else {
                    nomes.add(msg);
                }
            }

            System.out.println("MUSICAS");
            System.out.println("");
            System.out.println("");

            System.out.println(inserts);

            System.out.println("");
            System.out.println("");
            System.out.println("");
            System.out.println("MUSICA QUE NAO EXISTE");

            for (String str : nomes) {
                System.out.println(str);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void lerProgramacaoDoBanco(String url) {
        try {
            Class.forName("com.hxtt.sql.paradox.ParadoxDriver").newInstance();

            Connection con = DriverManager.getConnection(url, "", "");

            String sql = "select * from programacao";

            Statement stmt = con.createStatement();
            stmt.setFetchSize(10);

            ResultSet rs = stmt.executeQuery(sql);

            ResultSetMetaData resultSetMetaData = rs.getMetaData();
            int iNumCols = resultSetMetaData.getColumnCount();

            for (int i = 1; i <= iNumCols; i++) {
//                System.out.println(resultSetMetaData.getColumnLabel(i) + "  "+ resultSetMetaData.getColumnTypeName(i));
            }

            String inserts = "";
            while (rs.next()) {
                Short dia = null, mes = null, ano = null, diaf = null, mesf = null, anof = null;
                inserts = "INSERT INTO audiostore_programacao VALUES(null, [descricao], " + idclienteFinal + ", [data_inicio], [data_final], [hora_inicio] , [hora_final] , [segunda_feira], [terca_feira] , [quarta_feira], [quinta_feira], [sexta_feira] , [sabado] , [domingo] , [conteudo], [loopback]);";
                // [id], [descricao], [idcliente], [data_inicio], [data_final], [hora_inicio] , [hora_final] , [segunda_feira], [terca_feira] , [quarta_feira], [quinta_feira], [sexta_feira] , [sabado] , [domingo] , [conteudo], [loopback]
                for (int i = 1; i <= iNumCols; i++) {

                    if ("Descricao".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        inserts = inserts.replace("[descricao]", "'" + value.replace("'", "\"") + "'");
                    }


                    if ("Dia".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        dia = rs.getShort(i);
                    }

                    if ("Mes".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        mes = rs.getShort(i);
                    }

                    if ("Ano".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        ano = rs.getShort(i);
                    }

                    if ("Diaf".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        diaf = rs.getShort(i);
                    }

                    if ("Mesf".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        mesf = rs.getShort(i);
                    }

                    if ("Anof".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        anof = rs.getShort(i);
                    }

                    if (null != dia && null != mes && null != ano) {
                        String di = "" + ano + "-" + mes + "-" + dia;
                        inserts = inserts.replace("[data_inicio]", "'" + di + "'");
                    }

                    if (null != diaf && null != mesf && null != anof) {
                        String df = "" + anof + "-" + mesf + "-" + diaf;
                        inserts = inserts.replace("[data_final]", "'" + df + "'");
                    }

                    if ("HoraInicio".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[hora_inicio]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("HoraFinal".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + new SimpleDateFormat("HH:mm:ss").format(rs.getDate(i));
                        inserts = inserts.replace("[hora_final]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("DiaSemana".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + rs.getString(i);
                        try {
                            if ("X".equals(value.substring(0, 1))) {
                                inserts = inserts.replace("[segunda_feira]", "'1'");
                            } else {
                                inserts = inserts.replace("[segunda_feira]", "'0'");
                            }

                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[segunda_feira]", "'0'");
                        }

                        try {
                            if ("X".equals(value.substring(1, 2))) {
                                inserts = inserts.replace("[terca_feira]", "'1'");
                            } else {
                                inserts = inserts.replace("[terca_feira]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[terca_feira]", "'0'");
                        }


                        try {
                            if ("X".equals(value.substring(2, 3))) {
                                inserts = inserts.replace("[quarta_feira]", "'1'");
                            } else {
                                inserts = inserts.replace("[quarta_feira]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[quarta_feira]", "'0'");
                        }


                        try {
                            if ("X".equals(value.substring(3, 4))) {
                                inserts = inserts.replace("[quinta_feira]", "'1'");
                            } else {
                                inserts = inserts.replace("[quinta_feira]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[quinta_feira]", "'0'");
                        }


                        try {
                            if ("X".equals(value.substring(4, 5))) {
                                inserts = inserts.replace("[sexta_feira]", "'1'");
                            } else {
                                inserts = inserts.replace("[sexta_feira]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[sexta_feira]", "'0'");
                        }

                        try {
                            if ("X".equals(value.substring(5, 6))) {
                                inserts = inserts.replace("[sabado]", "'1'");
                            } else {
                                inserts = inserts.replace("[sabado]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[sabado]", "'0'");
                        }

                        try {
                            if ("X".equals(value.substring(6, 7))) {
                                inserts = inserts.replace("[domingo]", "'1'");
                            } else {
                                inserts = inserts.replace("[domingo]", "'0'");
                            }
                        } catch (StringIndexOutOfBoundsException e) {
                            inserts = inserts.replace("[domingo]", "'0'");
                        }
                    }

                    if ("Conteudo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (null == rs.getString(i) ? "" : rs.getString(i));
                        inserts = inserts.replace("[conteudo]", "'" + value.replace("'", "\"") + "'");
                    }

                    if ("LoopBack".equals(resultSetMetaData.getColumnLabel(i).trim())) {
                        String value = "" + (rs.getBoolean(i) ? "1" : "0");
                        inserts = inserts.replace("[loopback]", "'" + value.replace("'", "\"") + "'");
                    }

                    if (resultSetMetaData.getColumnLabel(i).trim().contains("Categoria")) {
                        String value = "" + (0 == rs.getShort(i) ? "" : "" + (rs.getShort(i) + idclienteFinal));

                        if (null != value && !value.trim().isEmpty()) {
                            inserts += "\nINSERT INTO audiostore_programacao_categoria VALUES(null, [ccc], (select id from audiostore_programacao order by id desc limit 1));";
                            inserts = inserts.replace("[ccc]", "'" + value.replace("'", "\"") + "'");
                        }
                    }
                }


                System.out.println(inserts);
            }


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
