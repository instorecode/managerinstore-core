package br.com.instore.dump.cliente;

import com.thoughtworks.xstream.XStream;
import java.io.File;
import java.net.MalformedURLException;
import java.text.SimpleDateFormat;
import java.util.List;

public class Main {

    static String sql = "";

    public static void carregaXMLClientes() throws MalformedURLException {
        // clientes
        XStream xstream = new XStream();
        xstream.alias("clientes", List.class);
        xstream.alias("cliente", Cliente.class);

        List<Cliente> clientes = (List<Cliente>) xstream.fromXML(new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\cliente\\clientes.xml").toURI().toURL());

        for (Cliente cliente : clientes) {
            // cidade
            sql += "INSERT INTO cidade VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcidade int(11) AI PK 
            sql = sql.replaceFirst("\\?", "(select idestado from estado where sigla = '" + cliente.getEstado() + "')"); //idestado int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getCidade() + "'"); //nome varchar(255)
            sql += "\n";

            // bairro
            sql += "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idbairro int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcidade int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getBairro() + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getRua() + "'"); //rua varchar(255) 
            sql = sql.replaceFirst("\\?", "''"); //tipo varchar(255)
            sql += "\n";

            // cep
            sql += "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcep int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idbairro int(11)
            sql = sql.replaceFirst("\\?", "'" + cliente.getRuaNumero() + "'"); //numero varchar(10)
            sql += "\n";

            // endereco
            sql += "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idendereco int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcep int(11)
            sql = sql.replaceFirst("\\?", "'" + cliente.getRuaNumero() + "'"); //numero varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getComplemento() + "'"); //complemento varchar(255)
            sql += "\n";

            // cliente
            sql += "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idendereco int(11) 
            sql = sql.replaceFirst("\\?", "'0'"); //parente int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getNome() + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'0'"); //instore tinyint(1)
            sql = sql.replaceFirst("\\?", "'1'"); //faturameno_matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getCodigoInterno() + "'"); //codigo_interno varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //codigo_externo varchar(255)
            sql += "\n";

            // dados_cliente
            sql += "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //ddados_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcliente int(11)
            sql = sql.replaceFirst("\\?", "'13.655.492/0001-03'"); //cnpj varchar(18) 
            sql = sql.replaceFirst("\\?", "'NÃO INFORMADO'"); //razao_social text 
            sql = sql.replaceFirst("\\?", "'"+cliente.getNome()+"'"); //nome_fantasia varchar(255) 
            sql = sql.replaceFirst("\\?", "'0.00'"); //indice_reajuste_contrato decimal(10,0) 
            sql = sql.replaceFirst("\\?", "'"+cliente.getDataInicio()+"'"); //data_inicio_contrato date 
            sql = sql.replaceFirst("\\?", "'"+cliente.getDataFim()+"'"); //data_termino_contrato date 
            sql = sql.replaceFirst("\\?", "'1'"); //renovacao_automatica date 
            sql = sql.replaceFirst("\\?", "'0.00'"); //valor_contrato date 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.226/Programacao/SERVER/'"); //local_origem_musica varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+cliente.getCodigoInterno()+"/'"); //local_destino_musica varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.220/Comerciais/"+cliente.getCodigoInterno()+"/'"); //local_origem_spot varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+cliente.getCodigoInterno()+"/'"); //local_destino_spot varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+cliente.getCodigoInterno()+"/'"); //local_destino_exp varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //indice_reajuste varchar(255) 
            sql += "\n";
        }
    }

    public static void carregaXMLUnidades() throws MalformedURLException {
        // clientes
        XStream xstream = new XStream();
        xstream.alias("unidades", List.class);
        xstream.alias("unidade", Unidade.class);

        List<Unidade> unidades = (List<Unidade>) xstream.fromXML(new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\cliente\\unidades.xml").toURI().toURL());
        for (Unidade unidade : unidades) {
            Integer id_integration = Integer.parseInt(unidade.getIdentificadorDaMatriz().trim()) + Integer.parseInt(unidade.getIdentificadorDaUnidade().trim());
            // cidade
            sql += "INSERT INTO cidade VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcidade int(11) AI PK 
            sql = sql.replaceFirst("\\?", "(select idestado from estado where sigla = '" + unidade.getEstado() + "')"); //idestado int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getCidade() + "'"); //nome varchar(255)
            sql += "\n";

            // bairro
            sql += "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idbairro int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcidade int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getBairro() + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getRua() + "'"); //rua varchar(255) 
            sql = sql.replaceFirst("\\?", "''"); //tipo varchar(255)
            sql += "\n";

            // cep
            sql += "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcep int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idbairro int(11)
            sql = sql.replaceFirst("\\?", "'" + unidade.getCep() + "'"); //numero varchar(10)
            sql += "\n";

            // endereco
            sql += "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idendereco int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcep int(11)
            sql = sql.replaceFirst("\\?", "'" + unidade.getRuaNumero() + "'"); //numero varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getComplemento() + "'"); //complemento varchar(255)
            sql += "\n";

            // cliente
            sql += "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", unidade.getIdentificadorDaUnidade()); //idcliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idendereco int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getIdentificadorDaMatriz() + "'"); //parente int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getNome() + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'0'"); //matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'0'"); //instore tinyint(1)
            sql = sql.replaceFirst("\\?", "'1'"); //faturameno_matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getCodigoInterno() + "'"); //codigo_interno varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //codigo_externo varchar(255)
            sql += "\n";
            
            // dados_cliente
            sql += "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", unidade.getIdentificadorDaUnidade()); //ddados_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", unidade.getIdentificadorDaUnidade()); //idcliente int(11)
            sql = sql.replaceFirst("\\?", "'13.655.492/0001-03'"); //cnpj varchar(18) 
            sql = sql.replaceFirst("\\?", "'NÃO INFORMADO'"); //razao_social text 
            sql = sql.replaceFirst("\\?", "'"+unidade.getNome()+"'"); //nome_fantasia varchar(255) 
            sql = sql.replaceFirst("\\?", "'0.00'"); //indice_reajuste_contrato decimal(10,0) 
            sql = sql.replaceFirst("\\?", "'"+unidade.getDataInicio()+"'"); //data_inicio_contrato date 
            sql = sql.replaceFirst("\\?", "'"+unidade.getDataFim()+"'"); //data_termino_contrato date 
            sql = sql.replaceFirst("\\?", "'1'"); //renovacao_automatica date 
            sql = sql.replaceFirst("\\?", "'0.00'"); //valor_contrato date 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.226/Programacao/SERVER/'"); //local_origem_musica varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+unidade.getCodigoInterno()+"/'"); //local_destino_musica varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.220/Comerciais/"+unidade.getCodigoInterno()+"/'"); //local_origem_spot varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+unidade.getCodigoInterno()+"/'"); //local_destino_spot varchar(255) 
            sql = sql.replaceFirst("\\?", "'smb://192.168.1.249/Clientes/"+unidade.getCodigoInterno()+"/'"); //local_destino_exp varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //indice_reajuste varchar(255) 
            sql += "\n";
        }
    }

    public static void carregaXMLContatos() throws MalformedURLException {
        // clientes
        XStream xstream = new XStream();
        xstream.alias("contatos", List.class);
        xstream.alias("contato", Contato.class);

        List<Contato> contatos = (List<Contato>) xstream.fromXML(new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\cliente\\contatos.xml").toURI().toURL());
        for (Contato contato : contatos) {
            Integer id_integration = Integer.parseInt(
                    (null != contato.getIdentificadorDaMatriz() && !contato.getIdentificadorDaMatriz().isEmpty() ? contato.getIdentificadorDaMatriz().trim() : "0")) + Integer.parseInt(
                    (null != contato.getIdentificadorDaUnidade() && !contato.getIdentificadorDaUnidade().isEmpty() ? contato.getIdentificadorDaUnidade().trim() : "0"));

            int iddados_cliente = Integer.parseInt(
                    (null != contato.getIdentificadorDaUnidade() && !contato.getIdentificadorDaUnidade().isEmpty() ? contato.getIdentificadorDaUnidade().trim() : "0"));
            
            if (0 == iddados_cliente) {
                iddados_cliente = Integer.parseInt(
                        (null != contato.getIdentificadorDaMatriz() && !contato.getIdentificadorDaMatriz().isEmpty() ? contato.getIdentificadorDaMatriz().trim() : "0"));
            }

            // cidade
            sql += "INSERT INTO contato VALUES(?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "null"); //idcontato_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + iddados_cliente + "'"); //iddados_cliente int(11)  AI PK 
            sql = sql.replaceFirst("\\?", "'" + contato.getNome() + "'"); //nome varchar(255)
            sql = sql.replaceFirst("\\?", "'1'"); //principal tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getEmail() && !contato.getEmail().isEmpty() ? contato.getEmail() : "Nao informado") + "'"); //email varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getTel() && !contato.getTel().isEmpty() ? contato.getTel() : "Nao informado") + "'"); //tel varchar(20) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getSetor() && !contato.getSetor().isEmpty() ? contato.getSetor() : "Nao informado") + "'"); //setor varchar(255)
            sql += "\n";
        }

    }
    
    public static void carregaXMLAcessoRemoto() throws MalformedURLException {
        // clientes
        XStream xstream = new XStream();
        xstream.alias("acessos_remotos", List.class);
        xstream.alias("acesso_remoto", AcessoRemoto.class);

        List<AcessoRemoto> acessoRemoto = (List<AcessoRemoto>) xstream.fromXML(new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\cliente\\acesso_remoto.xml").toURI().toURL());
        for (AcessoRemoto ar : acessoRemoto) {
            // cidade
            sql += "INSERT INTO contato VALUES(?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "null"); //id int(11) AI PK
            sql = sql.replaceFirst("\\?", "'"+ar.getIdentificadorDoTipoAcesseo()+"'"); //tipo_acesso_remoto int(11) 
            sql = sql.replaceFirst("\\?", "'"+ar.getIdentificadorDaUnidade()+"'"); //cliente int(11) 
            sql = sql.replaceFirst("\\?", "'"+ar.getServidor()+"'"); //servidor varchar(255)  
            sql = sql.replaceFirst("\\?", "'"+ar.getUsuario()+"'"); //usuario varchar(255) 
            sql = sql.replaceFirst("\\?", "'"+ar.getSenha()+"'"); //senha varchar(255) 
            sql = sql.replaceFirst("\\?", "'"+ar.getPorta()+"'"); //porta varchar(255)
            sql += "\n";
        }

    }

    public static void main(String[] args) throws MalformedURLException {
        
        carregaXMLClientes();
        carregaXMLUnidades();
        carregaXMLContatos();
        carregaXMLAcessoRemoto();        
        sql += "\nINSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('1', 'AUDIO');";
        sql += "\nINSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('2', 'VIDEO');";
        sql += "\nINSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('3', 'WEB');";
        sql += "\nINSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('4', 'MOBILE');";
        sql += "\nINSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('1', '1', 'AUDIOSTORE');";
        sql += "\nINSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('2', '2', 'VIDEOONE');";
        sql += "\nINSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('3', '3', 'ELLAFM');";
        sql += "\nINSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('4', '4', 'VIDEOONE-H06C');";        
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('1', 'TEAMVIEWER');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('2', 'LOGMEIN');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('3', 'FTP');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('4', 'SSH');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('5', 'SHOWMYPC');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('6', 'VNC');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('7', 'RDP');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('8', 'AMMY');";
        sql += "\nINSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('9', 'OUTRO');";

        System.out.println(sql);
    }
}
