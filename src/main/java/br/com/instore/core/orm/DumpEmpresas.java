package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.EstadoBean;
import br.com.instore.core.orm.bean.property.Estado;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DumpEmpresas {

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        dumpEmpresas(rv);
    }

    public static void dumpEmpresas(RepositoryViewer dao) {
        BufferedReader br = null;
        try {
            File file = new File("C:\\Users\\TI-Caio\\Desktop\\arquivos\\planilha.csv");
            br = new BufferedReader(new FileReader(file));
            String readLine = null;
            List<String> lines = new ArrayList<String>();

            while ((readLine = br.readLine()) != null) {
                lines.add(readLine);
            }
            Integer index = 1;
            List<String> scripts = new ArrayList<String>();
            Integer indiceAlternatico = 200;
            
            String scriptContent = "";
            
            
            scriptContent += "-- DELTETE\n\n\n\n";
            scriptContent += "\ndelete from contato_cliente where contato_cliente.idcontato_cliente > 0;";
            scriptContent += "\ndelete from dados_cliente where dados_cliente.iddados_cliente > 0;";
            scriptContent += "\ndelete from cliente where cliente.idcliente >  1;";
            scriptContent += "\ndelete from endereco where endereco.idendereco > 100;";
            scriptContent += "\ndelete from cep where cep.idcep > 100;";
            scriptContent += "\ndelete from bairro where bairro.idbairro > 100;";
            scriptContent += "\ndelete from cidade where cidade.idcidade > 100;";
            scriptContent += "\n\n\n\n-- INSERTS";
            
            for (String line : lines) {
                List<String> columns = Arrays.asList(line.split(";"));
                String ufSigle = columns.get(columns.size() - 1);
                
                EstadoBean estado = dao.query(EstadoBean.class).eq(Estado.SIGLA, ufSigle.trim()).findOne();
                if(null == estado) {
                    estado = new EstadoBean();
                    estado.setIdestado(1);
                }
                
                String script1 = "INSERT INTO cidade VALUES([idcidade], [idestado] , '[nome]');";
                String script2 = "INSERT INTO bairro VALUES([idbairro] , [idcidade], '[nome]' , '[rua]');";
                String script3 = "INSERT INTO cep VALUES([idcep] , [idbairro] , '[numero]');";
                String script4 = "INSERT INTO endereco VALUES([idendereco] , [idcep] , '[numero]' , '[complemento]');";
                String script5 = "INSERT INTO cliente VALUES([idcliente] , [idendereco] , 0 , '[nome]' , 0 , 0 , 1);";
                String script6 = "INSERT INTO dados_cliente VALUES([iddados_cliente] , [idcliente] , '[cnpj]' , '[razao_social]' , '[nome_fantasia]' , 0 , now() , now() , 1);";
                String script7 = "INSERT INTO contato_cliente VALUES([idcontato_cliente] , [iddados_cliente] , '[nome]' , 0 , '[email]' , '[tel]' , '[setor]');";
                
                // script cidade 
                script1 = script1.replace("[idcidade]", indiceAlternatico.toString());
                script1 = script1.replace("[idestado]", estado.getIdestado().toString());
                script1 = script1.replace("[nome]", columns.get(columns.size() - 2));
                
                // script bairro 
                script2 = script2.replace("[idbairro]", indiceAlternatico.toString());
                script2 = script2.replace("[idcidade]", indiceAlternatico.toString());
                script2 = script2.replace("[nome]", columns.get(columns.size() - 2));
                script2 = script2.replace("[rua]", columns.get(columns.size() - 5));
                
                // script cep 
                script3 = script3.replace("[idcep]", indiceAlternatico.toString());
                script3 = script3.replace("[idbairro]", indiceAlternatico.toString());
                script3 = script3.replace("[numero]", columns.get(columns.size() - 3));
                
                // script endereco 
                script4 = script4.replace("[idendereco]", indiceAlternatico.toString());
                script4 = script4.replace("[idcep]", indiceAlternatico.toString());
                script4 = script4.replace("[numero]", "sn");
                script4 = script4.replace("[complemento]", columns.get(columns.size() - 5));
                
                // script cliente 
                script5 = script5.replace("[idcliente]", indiceAlternatico.toString());
                script5 = script5.replace("[idendereco]", indiceAlternatico.toString());
                script5 = script5.replace("[nome]", columns.get(7) + " - " + columns.get(8));
                
                // script dados_cliente 
                script6 = script6.replace("[iddados_cliente]", indiceAlternatico.toString());
                script6 = script6.replace("[idcliente]", indiceAlternatico.toString());
                script6 = script6.replace("[cnpj]", columns.get(2));
                script6 = script6.replace("[razao_social]", columns.get(8));
                script6 = script6.replace("[nome_fantasia]", columns.get(7) + " - " + columns.get(8));
                
                // script contato_cliente 
                script7 = script7.replace("[idcontato_cliente]", indiceAlternatico.toString());
                script7 = script7.replace("[iddados_cliente]", indiceAlternatico.toString());
                script7 = script7.replace("[nome]", columns.get(5));
                script7 = script7.replace("[email]", columns.get(4));
                script7 = script7.replace("[tel]", columns.get(6));
                script7 = script7.replace("[setor]", "indefinido");

                
                scripts.add(script1);
                scripts.add(script2);
                scripts.add(script3);
                scripts.add(script4);
                scripts.add(script5);
                scripts.add(script6);
                scripts.add(script7);
                
                indiceAlternatico++;
            }
            
            for (String s : scripts) {
                scriptContent += "\n" + s;
            }
            
            FileOutputStream fos = new FileOutputStream( new File("C:\\Users\\TI-Caio\\Desktop\\arquivos\\planilha.sql"));
            fos.write(scriptContent.getBytes());
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                br.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static String resize(String string) {
        if (string == null) {
            string = "";
        }

        if (string.length() > 255) {
            string = string.substring(0, 255);
        }
        return string;
    }

    public static Date calculaDataVencimento(String vencimentoString) {
        if (vencimentoString.isEmpty()) {
            vencimentoString = "0";
        }

        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(new Date().getTime());
        Integer vencimento = Integer.parseInt(vencimentoString.toString());

        Integer diaAtual = calendar.get(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, vencimento);

        if (!(diaAtual < vencimento)) {
            calendar.add(Calendar.MONTH, 1);
        }

        Date data = new Date();
        data.setTime(calendar.getTimeInMillis());
        return data;
    }
}
