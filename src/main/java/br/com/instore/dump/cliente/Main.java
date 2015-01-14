package br.com.instore.dump.cliente;

import com.thoughtworks.xstream.XStream;
import java.io.File;
import java.net.MalformedURLException;
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
            sql = sql.replaceFirst("\\?", "(if((select count(idestado) as c from estado where sigla = '"+cliente.getEstado()+"') > 0 , (select idestado from estado where sigla = '"+cliente.getEstado()+"') , 25 ) )"); //idestado int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getCidade().replace("'", "\"") + "'"); //nome varchar(255)
            sql += "\n";

            // bairro
            sql += "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idbairro int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcidade int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getBairro().replace("'", "\"") + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getRua().replace("'", "\"") + "'"); //rua varchar(255) 
            sql = sql.replaceFirst("\\?", "''"); //tipo varchar(255)
            sql += "\n";

            // cep
            sql += "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcep int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idbairro int(11)
            sql = sql.replaceFirst("\\?", "'" + (null != cliente.getCep()&& !cliente.getCep().isEmpty() ? cliente.getCep().replace("'", "\"") : "00.000-00") + "'"); //numero varchar(10)
            sql += "\n";

            // endereco
            sql += "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idendereco int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcep int(11)
            sql = sql.replaceFirst("\\?", "'" + (null != cliente.getRuaNumero() && !cliente.getRuaNumero().isEmpty() ? cliente.getRuaNumero().replace("'", "\"") : "NÃO INFORMADO") + "'"); //numero varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + (null != cliente.getComplemento() && !cliente.getComplemento().isEmpty() ? cliente.getComplemento().replace("'", "\"") : "NÃO INFORMADO") + "'"); //complemento varchar(255)
            sql += "\n";

            // cliente
            sql += "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idendereco int(11) 
            sql = sql.replaceFirst("\\?", "'0'"); //parente int(11) 
            sql = sql.replaceFirst("\\?", "'" + cliente.getNome().replace("'", "\"") + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'1'"); //SITUACAO tinyint(1) 
            sql = sql.replaceFirst("\\?", "'0'"); //instore tinyint(1)
            sql = sql.replaceFirst("\\?", "'1'"); //faturameno_matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + (null != cliente.getCodigoInterno() && !cliente.getCodigoInterno().isEmpty() ? cliente.getCodigoInterno().replace("'", "\"") : "00.000-00")  + "'"); //codigo_interno varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //codigo_externo varchar(255)
            sql += "\n";

            // dados_cliente
            sql += "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //ddados_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", cliente.getIdentificadorDaMatriz()); //idcliente int(11)
            sql = sql.replaceFirst("\\?", "'13.655.492/0001-03'"); //cnpj varchar(18) 
            sql = sql.replaceFirst("\\?", "'NÃO INFORMADO'"); //razao_social text 
            sql = sql.replaceFirst("\\?", "'"+cliente.getNome().replace("'", "\"") +"'"); //nome_fantasia varchar(255) 
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
            Integer id_integration = (Integer.parseInt(unidade.getIdentificadorDaUnidade().trim()));
            id_integration += 20000;
            id_integration += Integer.parseInt(unidade.getIdentificadorDaMatriz().trim());
            // cidade
            sql += "INSERT INTO cidade VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcidade int(11) AI PK 
            sql = sql.replaceFirst("\\?", "(if((select count(idestado) as c from estado where sigla = '"+unidade.getEstado()+"') > 0 , (select idestado from estado where sigla = '"+unidade.getEstado()+"') , 25 ) )"); //idestado int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getCidade().replace("'", "\"") + "'"); //nome varchar(255)
            sql += "\n";

            // bairro
            sql += "INSERT INTO bairro VALUES(?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idbairro int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcidade int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getBairro().replace("'", "\"") + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getRua().replace("'", "\"") + "'"); //rua varchar(255) 
            sql = sql.replaceFirst("\\?", "''"); //tipo varchar(255)
            sql += "\n";

            // cep
            sql += "INSERT INTO cep VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcep int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idbairro int(11)
            sql = sql.replaceFirst("\\?", "'" + unidade.getCep().replace("'", "\"") + "'"); //numero varchar(10)
            sql += "\n";

            // endereco
            sql += "INSERT INTO endereco VALUES(?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idendereco int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idcep int(11)
            sql = sql.replaceFirst("\\?", "'" + unidade.getRuaNumero().replace("'", "\"") + "'"); //numero varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getComplemento().replace("'", "\"") + "'"); //complemento varchar(255)
            sql += "\n";

            // cliente
            sql += "INSERT INTO cliente VALUES(?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'"+(Integer.parseInt(unidade.getIdentificadorDaUnidade().trim()) + 20000)+"'"); //idcliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + id_integration + "'"); //idendereco int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getIdentificadorDaMatriz() + "'"); //parente int(11) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getNome().replace("'", "\"") + "'"); //nome varchar(255) 
            sql = sql.replaceFirst("\\?", "'0'"); //matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'1'"); //SITUACAO(1) 
            sql = sql.replaceFirst("\\?", "'0'"); //instore tinyint(1)
            sql = sql.replaceFirst("\\?", "'1'"); //faturameno_matriz tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + unidade.getCodigoInterno().replace("'", "\"") + "'"); //codigo_interno varchar(255) 
            sql = sql.replaceFirst("\\?", "'1'"); //codigo_externo varchar(255)
            sql += "\n";
            
            // dados_cliente
            sql += "INSERT INTO dados_cliente VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "'"+(Integer.parseInt(unidade.getIdentificadorDaUnidade().trim()) + 20000)+"'"); //ddados_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'"+(Integer.parseInt(unidade.getIdentificadorDaUnidade().trim()) + 20000)+"'"); //idcliente int(11)
            sql = sql.replaceFirst("\\?", "'13.655.492/0001-03'"); //cnpj varchar(18) 
            sql = sql.replaceFirst("\\?", "'NÃO INFORMADO'"); //razao_social text 
            sql = sql.replaceFirst("\\?", "'"+unidade.getNome().replace("'", "\"")+"'"); //nome_fantasia varchar(255) 
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

            int iddados_cliente = 0;
            
            if (null != contato.getIdentificadorDaUnidade() && !contato.getIdentificadorDaUnidade().isEmpty()) {
                iddados_cliente = Integer.parseInt((null != contato.getIdentificadorDaUnidade() && !contato.getIdentificadorDaUnidade().isEmpty() ? contato.getIdentificadorDaUnidade().trim() : "0"));
                iddados_cliente += 20000;
            }
            
            if (0 == iddados_cliente) {
                iddados_cliente = Integer.parseInt(
                        (null != contato.getIdentificadorDaMatriz() && !contato.getIdentificadorDaMatriz().isEmpty() ? contato.getIdentificadorDaMatriz().trim() : "0"));
            }

            // cidade
            sql += "INSERT INTO contato_cliente VALUES(?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "null"); //idcontato_cliente int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'" + iddados_cliente + "'"); //iddados_cliente int(11)  AI PK 
            sql = sql.replaceFirst("\\?", "'" + contato.getNome().replace("'", "\"") + "'"); //nome varchar(255)
            sql = sql.replaceFirst("\\?", "'1'"); //principal tinyint(1) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getEmail() && !contato.getEmail().isEmpty() ? contato.getEmail().replace("'", "\"") : "Nao informado") + "'"); //email varchar(255) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getTel() && !contato.getTel().isEmpty() ? contato.getTel().replace("'", "\"") : "Nao informado") + "'"); //tel varchar(20) 
            sql = sql.replaceFirst("\\?", "'" + (null != contato.getSetor() && !contato.getSetor().isEmpty() ? contato.getSetor().replace("'", "\"") : "Nao informado") + "'"); //setor varchar(255)
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
            sql += "INSERT INTO acesso_remoto VALUES(?,?,?,?,?,?,?);";
            sql = sql.replaceFirst("\\?", "null"); //id int(11) AI PK
            sql = sql.replaceFirst("\\?", "'"+ar.getIdentificadorDoTipoAcesseo()+"'"); //tipo_acesso_remoto int(11) 
            sql = sql.replaceFirst("\\?", "'"+(Integer.parseInt(ar.getIdentificadorDaUnidade().trim()) + 20000)+"'"); //cliente int(11) 
            sql = sql.replaceFirst("\\?", "'"+ar.getServidor().replace("'", "\"")+"'"); //servidor varchar(255)  
            sql = sql.replaceFirst("\\?", "'"+ar.getUsuario().replace("'", "\"")+"'"); //usuario varchar(255) 
            sql = sql.replaceFirst("\\?", "'"+ar.getSenha().replace("'", "\"")+"'"); //senha varchar(255) 
            sql = sql.replaceFirst("\\?", "'"+ar.getPorta().replace("'", "\"")+"'"); //porta varchar(255)
            sql += "\n";
        }

    }
    
    public static void carregaXMLProdutoCliente() throws MalformedURLException {
        // clientes
        XStream xstream = new XStream();
        xstream.alias("produtos_clientes", List.class);
        xstream.alias("produto_cliente", ProdutoCliente.class);

        List<ProdutoCliente> produtoCliente = (List<ProdutoCliente>) xstream.fromXML(new File("C:\\Users\\TI-Caio\\Documents\\NetBeansProjects\\managerinstore-core\\src\\main\\java\\br\\com\\instore\\dump\\cliente\\produto_cliente.xml").toURI().toURL());
        for (ProdutoCliente pc : produtoCliente) {
            // cidade
            sql += "INSERT INTO produto_cliente VALUES(?,?,?);";
            sql = sql.replaceFirst("\\?", "null"); //id int(11) AI PK 
            sql = sql.replaceFirst("\\?", "'"+pc.getIdentificadorDoProduto()+"'"); //produto int(11) 
            sql = sql.replaceFirst("\\?", "'"+(Integer.parseInt(pc.getIdentificadorDoProdutoCliente().trim()) + 20000)+"'"); //cliente int(11) 
            sql += "\n";
        }
    }

    public static void main(String[] args) throws MalformedURLException {      
        sql += "\ndelete from produto_cliente where id >= 1;";
        sql += "\ndelete from acesso_remoto where id >= 1;";
        sql += "\ndelete from contato_cliente where idcontato_cliente > 0 and iddados_cliente not in(1020,1029,1063,2686,2687,2688,2689,2690,2691,2692,2693,2694,2695,2696,2697,2698,2699,2700,2701,2702,2703,2704,2705,2706,2707,2708,2709,2710,2711,2712,2713,2714,2715,2716,2717,2718,2719,2720,2721,2722,2723,2724,2725,2726,2727,2728,2729,2730,2731,2732,2733,2734,2735,2736,2737,2738,2739,2740,2741,2742,2743,2744,2745,2746,2747,2748,2749,2750,2751,2752,2753,2754,2755,2756,2757,2888,4109,4110,4111,4112);";
        sql += "\ndelete from dados_cliente where iddados_cliente > 1 and idcliente not in(1063,4109,4110,4111,4112,1029,2888,1020,2686,2708,2686,2687,2688,2689,2690,2691,2692,2693,2694,2695,2696,2697,2698,2699,2700,2701,2702,2703,2704,2705,2706,2707,2708,2709,2710,2711,2712,2713,2714,2715,2716,2717,2718,2719,2720,2721,2722,2723,2724,2725,2726,2727,2728,2729,2730,2731,2732,2733,2734,2735,2736,2737,2738,2739,2740,2741,2742,2743,2744,2745,2746,2747,2748,2749,2750,2751,2752,2753,2754,2755,2756,2757);";
        sql += "\ndelete from cliente where idcliente > 1 and idcliente not in(1063,4109,4110,4111,4112,1029,2888,1020,2686,2708,2686,2687,2688,2689,2690,2691,2692,2693,2694,2695,2696,2697,2698,2699,2700,2701,2702,2703,2704,2705,2706,2707,2708,2709,2710,2711,2712,2713,2714,2715,2716,2717,2718,2719,2720,2721,2722,2723,2724,2725,2726,2727,2728,2729,2730,2731,2732,2733,2734,2735,2736,2737,2738,2739,2740,2741,2742,2743,2744,2745,2746,2747,2748,2749,2750,2751,2752,2753,2754,2755,2756,2757);";
        sql += "\ndelete from ocorrencia_usuario where id > 0;";
        sql += "\ndelete from ocorrencia where id > 0;";
        sql += "\ndelete from cliente where idcliente > 0 and idcliente not in(1063,4109,4110,4111,4112,1029,2888,1020,2686,2708,2686,2687,2688,2689,2690,2691,2692,2693,2694,2695,2696,2697,2698,2699,2700,2701,2702,2703,2704,2705,2706,2707,2708,2709,2710,2711,2712,2713,2714,2715,2716,2717,2718,2719,2720,2721,2722,2723,2724,2725,2726,2727,2728,2729,2730,2731,2732,2733,2734,2735,2736,2737,2738,2739,2740,2741,2742,2743,2744,2745,2746,2747,2748,2749,2750,2751,2752,2753,2754,2755,2756,2757);";
        sql += "\ndelete from endereco where idendereco >= 10000;";
        sql += "\ndelete from cep where idcep >= 10000;";
        sql += "\ndelete from bairro where idbairro >= 10000;";
        sql += "\ndelete from cidade where idcidade >= 10000;";
        
        carregaXMLClientes();
        carregaXMLUnidades();
        carregaXMLContatos();
        
        sql += "\n-- INSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('1', 'AUDIO');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('2', 'VIDEO');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('3', 'WEB');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_produto` (`id`, `nome`) VALUES ('4', 'MOBILE');";
        sql += "\n-- INSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('1', '1', 'AUDIOSTORE');";
        sql += "\n-- INSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('2', '2', 'VIDEOONE');";
        sql += "\n-- INSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('3', '3', 'ELLAFM');";
        sql += "\n-- INSERT INTO `intranet`.`produto` (`id`, `tipo_produto`, `nome`) VALUES ('4', '4', 'VIDEOONE-H06C');";        
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('1', 'TEAMVIEWER');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('2', 'LOGMEIN');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('3', 'FTP');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('4', 'SSH');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('5', 'SHOWMYPC');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('6', 'VNC');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('7', 'RDP');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('8', 'AMMY');";
        sql += "\n-- INSERT INTO `intranet`.`tipo_acesso_remoto` (`id`, `nome`) VALUES ('9', 'OUTRO');";
        
        carregaXMLAcessoRemoto();
        carregaXMLProdutoCliente();
        System.out.println(sql);
    }
}
