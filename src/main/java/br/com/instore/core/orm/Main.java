package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.BairroBean;
import br.com.instore.core.orm.bean.CepBean;
import br.com.instore.core.orm.bean.CidadeBean;
import br.com.instore.core.orm.bean.DadosEmpresaBean;
import br.com.instore.core.orm.bean.EmpresaBean;
import br.com.instore.core.orm.bean.EnderecoBean;
import br.com.instore.core.orm.bean.EstadoBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import br.com.instore.core.orm.bean.property.Cep;
import br.com.instore.core.orm.bean.property.Estado;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.persistence.Id;

public class Main {

    

    public static void dumpEmpresas(RepositoryViewer dao) {
        BufferedReader br = null;
        try {
            File file = new File("C:\\Users\\TI-Caio\\Desktop\\planilha.csv");
            br = new BufferedReader(new FileReader(file));
            String readLine = null;
            List<String> lines = new ArrayList<String>();

            while ((readLine = br.readLine()) != null) {
                lines.add(readLine);
            }
            Integer index = 1;
            for (String line : lines) {
                List<String> columns = Arrays.asList(line.split(";"));
                System.out.println("INCLUINDO EMPRESA " + columns.get(1) + " - " + columns.get(7) + " LINHA " + index);
                EmpresaBean empresa = new EmpresaBean();
                DadosEmpresaBean dados = new DadosEmpresaBean();
                EnderecoBean endereco = new EnderecoBean();

                // dados padrão da empresa
                empresa.setNome(resize(columns.get(1)));
                empresa.setParente(1);
                empresa.setMatriz(false);
                empresa.setInstore(false);

                // dados detalhados da empresa
                dados.setNomeFantasia(resize(columns.get(7)));
                dados.setContato(resize(columns.get(5)));
                dados.setContato2(resize(columns.get(9)));
                dados.setEmail(resize(columns.get(10)));
                dados.setEmailFaturamento(resize(columns.get(4)));
                dados.setTel(resize(columns.get(11)));
                dados.setTelFaturamento(resize(columns.get(6)));


                dados.setDataInicioContrato(new Date());
                dados.setDataFimContrato(new Date());
                dados.setDataFaturamento(new Date());
                dados.setDataReajusteValorFaturamento(new Date());
                dados.setTemReajusteFaturamento(true);
                dados.setValorFaturamento(1500.00);
                dados.setValorPorMatriz(true);
                dados.setValorReajusteFaturamento(5.77);


                dados.setRazaoSocial(resize(columns.get(8)));
                dados.setCnpj(resize(columns.get(2)));

                // endereco da empresa
                CepBean cepBean = null;
                if (dao.query(CepBean.class).eq(Cep.NUMERO, columns.get(14)).count() > 0) {
                    cepBean = dao.query(CepBean.class).eq(Cep.NUMERO, columns.get(14)).findOne();
                } else {
                    cepBean = new CepBean();
                    EstadoBean estado = null;
                    if (dao.query(EstadoBean.class).eq(Estado.SIGLA, columns.get(16)).count() > 0) {
                        estado = dao.query(EstadoBean.class).eq(Estado.SIGLA, columns.get(16)).findOne();
                    }
                    if (estado == null) {
                        estado = dao.query(EstadoBean.class).eq(Estado.IDESTADO, 25).findOne();
                    }

                    CidadeBean cidade = new CidadeBean();
                    cidade.setNome(resize(columns.get(15)));
                    cidade.setEstado(estado);
                    dao.save(cidade);

                    BairroBean bairro = new BairroBean();
                    bairro.setCidade(cidade);
                    bairro.setNome(resize(columns.get(13)));
                    bairro.setRua(resize(columns.get(12)));
                    dao.save(bairro);

                    cepBean.setBairro(bairro);
                    cepBean.setNumero(resize(columns.get(14)));
                    dao.save(cepBean);
                }

                endereco.setComplemento(resize(columns.get(16)));
                endereco.setNumero("sem número");
                endereco.setCep(cepBean);
                dao.save(endereco);

                empresa.setEndereco(endereco);
                dao.save(empresa);

                dados.setEmpresa(empresa);
                dao.save(dados);
                index++;
            }
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
