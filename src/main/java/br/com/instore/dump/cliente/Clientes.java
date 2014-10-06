package br.com.instore.dump.cliente;

import com.thoughtworks.xstream.XStream;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang.StringUtils;

public class Clientes {

    public List<Node> nodes = new ArrayList<Node>();

    public static void main(String[] args) {
        Clientes.dumpMatriz();
        Clientes.dumpFilial();
    }

    public static void dumpMatriz() {   
        File file = new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\matriz_lista.xml");
        XStream xstream = new XStream();
        xstream.alias("clientes", Clientes.class);
        xstream.alias("node", Node.class);
        xstream.addImplicitCollection(Clientes.class, "nodes");

        Clientes clientes = (Clientes) xstream.fromXML(file);

        String sql = "";
        List<String> lines = new ArrayList<String>();
        Integer i = 1000;
        Integer j = 1000;
        for (Node node : clientes.nodes) {
            String codInt = node.nomeFantasia;
            String codExt = node.nomeFantasia;
            
            if(null != node.codigoInterno && !node.codigoInterno.trim().isEmpty()) {
                codInt = node.codigoInterno;
            }
            
            if(null != node.codigoExterno && !node.codigoExterno.trim().isEmpty()) {
                codExt = node.codigoExterno;
            }

            // cidade
            sql = "INSERT INTO cidade VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "(select idestado from estado where sigla = '" + node.estado + "')");
            sql = sql.replaceFirst("\\?", "'" + node.cidade + "'");
            lines.add(sql);

            //bairro
            sql = "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'" + node.bairro + "'");
            sql = sql.replaceFirst("\\?", "'" + node.endereco + "'");
            sql = sql.replaceFirst("\\?", "'rua'");
            lines.add(sql);

            //cep
            sql = "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'" + node.cep + "'");
            lines.add(sql);

            //endereco
            sql = "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'s/n'");
            sql = sql.replaceFirst("\\?", "''");
            lines.add(sql);

            //cliente
            sql = "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "0");
            sql = sql.replaceFirst("\\?", "'" + node.nomeFantasia + "'");
            sql = sql.replaceFirst("\\?", "1");
            sql = sql.replaceFirst("\\?", "0");
            sql = sql.replaceFirst("\\?", "1");
            sql = sql.replaceFirst("\\?", "1");
            sql = sql.replaceFirst("\\?", "'" + codInt + "'");
            sql = sql.replaceFirst("\\?", "'" + codExt + "'");
            lines.add(sql);

            //dados cliente
            sql = "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString()); // pk
            sql = sql.replaceFirst("\\?", i.toString());// idcliente
            sql = sql.replaceFirst("\\?", "'" + node.cnpj + "'"); // cnpj
            sql = sql.replaceFirst("\\?", "'" + node.razaoSocial + "'"); // razão social
            sql = sql.replaceFirst("\\?", "'" + node.nomeFantasia + "'"); // nome fantazia
            sql = sql.replaceFirst("\\?", "'0'"); // indice de reajuste do contrato
            sql = sql.replaceFirst("\\?", "curdate()"); // data inicio do contrato
            sql = sql.replaceFirst("\\?", "curdate() + interval 1 year"); // data termino do contrado
            sql = sql.replaceFirst("\\?", "1"); // renovacao automatica
            sql = sql.replaceFirst("\\?", "0"); // valor do contrato
            sql = sql.replaceFirst("\\?", "''"); // indice de reajuste FK
            sql = sql.replaceFirst("\\?", "''"); // local_origem_musica
            sql = sql.replaceFirst("\\?", "''"); // local_destino_musica
            sql = sql.replaceFirst("\\?", "''"); // local_origem_spot
            sql = sql.replaceFirst("\\?", "''"); // local_destino_spot
            sql = sql.replaceFirst("\\?", "'1'"); // local_destino_exp
            lines.add(sql);

            // contato
            if (null != node.contato && !node.contato.trim().isEmpty()
                    && null != node.email && !node.email.trim().isEmpty()) {

                if (node.email.trim().contains(",")) {
                    for (String email : node.email.trim().split(",")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else if (node.email.trim().contains("/")) {
                    for (String email : node.email.trim().split("/")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else {
                    sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                    sql = sql.replaceFirst("\\?", j.toString());
                    sql = sql.replaceFirst("\\?", i.toString());
                    sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                    sql = sql.replaceFirst("\\?", "0");
                    sql = sql.replaceFirst("\\?", "'" + node.email.trim() + "'");
                    sql = sql.replaceFirst("\\?", "''");
                    sql = sql.replaceFirst("\\?", "'Indefinido'");
                    j++;
                }
                lines.add(sql);
            }

            // contato 2
            if (null != node.contato2 && !node.contato2.trim().isEmpty()
                    && null != node.email && !node.email.trim().isEmpty()) {

                if (node.email.trim().contains(",")) {
                    for (String email : node.email.trim().split(",")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else if (node.email.trim().contains("/")) {
                    for (String email : node.email.trim().split("/")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else {
                    sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                    sql = sql.replaceFirst("\\?", j.toString());
                    sql = sql.replaceFirst("\\?", i.toString());
                    sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                    sql = sql.replaceFirst("\\?", "0");
                    sql = sql.replaceFirst("\\?", "'" + node.email.trim() + "'");
                    sql = sql.replaceFirst("\\?", "''");
                    sql = sql.replaceFirst("\\?", "'Indefinido'");
                    j++;
                }
                lines.add(sql);
            }
            i++;
        }

        for (String string : lines) {
            System.out.println(string);
        }
    }

    public static void dumpFilial() {
        File file = new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\filial_lista.xml");
        XStream xstream = new XStream();
        xstream.alias("clientes", Clientes.class);
        xstream.alias("node", Node.class);
        xstream.addImplicitCollection(Clientes.class, "nodes");

        Clientes clientes = (Clientes) xstream.fromXML(file);

        String sql = "";
        List<String> lines = new ArrayList<String>();
        Integer i = 2000;
        Integer j = 2000;
        for (Node node : clientes.nodes) {
            String codInt = node.nomeFantasia;
            String codExt = node.nomeFantasia;
            
            if(null != node.codigoInterno && !node.codigoInterno.trim().isEmpty()) {
                codInt = node.codigoInterno;
            }
            
            if(null != node.codigoExterno && !node.codigoExterno.trim().isEmpty()) {
                codExt = node.codigoExterno;
            }

            // cidade
            sql = "INSERT INTO cidade VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "(select idestado from estado where sigla = " + (null != node.estado ? (node.estado.trim().length() == 2 ? "'" + node.estado.trim() + "'" : "'SP'") : "'SP'") + ")");
            sql = sql.replaceFirst("\\?", "'" + node.cidade + "'");
            lines.add(sql);

            //bairro
            sql = "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'" + node.bairro + "'");
            sql = sql.replaceFirst("\\?", "'" + node.endereco + "'");
            sql = sql.replaceFirst("\\?", "'rua'");
            lines.add(sql);

            //cep
            sql = "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'" + node.cep + "'");
            lines.add(sql);

            //endereco
            sql = "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", "'s/n'");
            sql = sql.replaceFirst("\\?", "''");
            lines.add(sql);

            //cliente
            sql = "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", i.toString());
            sql = sql.replaceFirst("\\?", (null != node.numero ? node.numero : "0"));
            sql = sql.replaceFirst("\\?", "'" + (null != node.cliente ? node.cliente : ((null != node.nomeFantasia ? node.nomeFantasia : "Não identificado"))) + "'");
            sql = sql.replaceFirst("\\?", "0");
            sql = sql.replaceFirst("\\?", "0");
            sql = sql.replaceFirst("\\?", "1");
            sql = sql.replaceFirst("\\?", "1");
            sql = sql.replaceFirst("\\?", "'" + codInt + "'");
            sql = sql.replaceFirst("\\?", "'" + codExt + "'");
            lines.add(sql);

            //dados cliente
            sql = "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", i.toString()); // pk
            sql = sql.replaceFirst("\\?", i.toString());// idcliente
            sql = sql.replaceFirst("\\?", "'" + node.cnpj + "'"); // cnpj
            sql = sql.replaceFirst("\\?", "'" + node.razaoSocial + "'"); // razão social
            sql = sql.replaceFirst("\\?", "'" + (null != node.nomeFantasia ? node.nomeFantasia : ((null != node.cliente ? node.cliente : "Não identificado"))) + "'"); // nome fantazia
            sql = sql.replaceFirst("\\?", "'0'"); // indice de reajuste do contrato
            sql = sql.replaceFirst("\\?", "curdate()"); // data inicio do contrato
            sql = sql.replaceFirst("\\?", "curdate() + interval 1 year"); // data termino do contrado
            sql = sql.replaceFirst("\\?", "1"); // renovacao automatica
            sql = sql.replaceFirst("\\?", "0"); // valor do contrato
            sql = sql.replaceFirst("\\?", "''"); // indice de reajuste FK
            sql = sql.replaceFirst("\\?", "''"); // local_origem_musica
            sql = sql.replaceFirst("\\?", "''"); // local_destino_musica
            sql = sql.replaceFirst("\\?", "''"); // local_origem_spot
            sql = sql.replaceFirst("\\?", "''"); // local_destino_spot
            sql = sql.replaceFirst("\\?", "'1'"); // local_destino_exp
            lines.add(sql);
            
            // contato
            if (null != node.contato && !node.contato.trim().isEmpty()
                    && null != node.email && !node.email.trim().isEmpty()) {

                if (node.email.trim().contains(",")) {
                    for (String email : node.email.trim().split(",")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else if (node.email.trim().contains("/")) {
                    for (String email : node.email.trim().split("/")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else {
                    sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                    sql = sql.replaceFirst("\\?", j.toString());
                    sql = sql.replaceFirst("\\?", i.toString());
                    sql = sql.replaceFirst("\\?", "'" + node.contato + "'");
                    sql = sql.replaceFirst("\\?", "0");
                    sql = sql.replaceFirst("\\?", "'" + node.email.trim() + "'");
                    sql = sql.replaceFirst("\\?", "''");
                    sql = sql.replaceFirst("\\?", "'Indefinido'");
                    j++;
                }
                lines.add(sql);
            }

            // contato 2
            if (null != node.contato2 && !node.contato2.trim().isEmpty()
                    && null != node.email && !node.email.trim().isEmpty()) {

                if (node.email.trim().contains(",")) {
                    for (String email : node.email.trim().split(",")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else if (node.email.trim().contains("/")) {
                    for (String email : node.email.trim().split("/")) {
                        sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                        sql = sql.replaceFirst("\\?", j.toString());
                        sql = sql.replaceFirst("\\?", i.toString());
                        sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                        sql = sql.replaceFirst("\\?", "0");
                        sql = sql.replaceFirst("\\?", "'" + email.trim() + "'");
                        sql = sql.replaceFirst("\\?", "''");
                        sql = sql.replaceFirst("\\?", "'Indefinido'");
                        j++;
                    }
                } else {
                    sql = "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
                    sql = sql.replaceFirst("\\?", j.toString());
                    sql = sql.replaceFirst("\\?", i.toString());
                    sql = sql.replaceFirst("\\?", "'" + node.contato2 + "'");
                    sql = sql.replaceFirst("\\?", "0");
                    sql = sql.replaceFirst("\\?", "'" + node.email.trim() + "'");
                    sql = sql.replaceFirst("\\?", "''");
                    sql = sql.replaceFirst("\\?", "'Indefinido'");
                    j++;
                }
                lines.add(sql);
            }
            i++;


        }

        for (String string : lines) {
            System.out.println(string);
        }
    }
}
