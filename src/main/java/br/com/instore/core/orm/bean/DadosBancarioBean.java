package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Auditor
@Entity
@Table(name="dados_bancario")
public class DadosBancarioBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "iddados_bancario" , nullable = false)
    private Integer iddadosBancario;
    
    @Column( name = "agencia" , nullable = false , length = 45)
    private String agencia;
    
    @Column( name = "numero_conta" , nullable = false , length = 45)
    private String numeroConta;
    
    @Column( name = "carteira" , nullable = false , length = 45)
    private String carteira;
    
    @Column( name = "nosso_numero" , nullable = false , length = 45)
    private String nossoNumero;
    
    @Column( name = "nosso_numero_digito" , nullable = false , length = 45)
    private String nossoNumeroDigito;
    
    @Column( name = "codigo_banco" , nullable = false , length = 45)
    private String codigoBanco;
    
    @Column( name = "ultimo_documento" , nullable = false , length = 45)
    private String ultimoDocumento;
    
    

    public DadosBancarioBean() {
    }

    public DadosBancarioBean(Integer iddadosBancario) {
        this.iddadosBancario = iddadosBancario;
    }

    public Integer getIddadosBancario() {
        return iddadosBancario;
    }

    public void setIddadosBancario(Integer iddadosBancario) {
        this.iddadosBancario = iddadosBancario;
    }

    public String getAgencia() {
        return agencia;
    }

    public void setAgencia(String agencia) {
        this.agencia = agencia;
    }

    public String getNumeroConta() {
        return numeroConta;
    }

    public void setNumeroConta(String numeroConta) {
        this.numeroConta = numeroConta;
    }

    public String getCarteira() {
        return carteira;
    }

    public void setCarteira(String carteira) {
        this.carteira = carteira;
    }

    public String getNossoNumero() {
        return nossoNumero;
    }

    public void setNossoNumero(String nossoNumero) {
        this.nossoNumero = nossoNumero;
    }

    public String getNossoNumeroDigito() {
        return nossoNumeroDigito;
    }

    public void setNossoNumeroDigito(String nossoNumeroDigito) {
        this.nossoNumeroDigito = nossoNumeroDigito;
    }

    public String getCodigoBanco() {
        return codigoBanco;
    }

    public void setCodigoBanco(String codigoBanco) {
        this.codigoBanco = codigoBanco;
    }

    public String getUltimoDocumento() {
        return ultimoDocumento;
    }

    public void setUltimoDocumento(String ultimoDocumento) {
        this.ultimoDocumento = ultimoDocumento;
    }
}
