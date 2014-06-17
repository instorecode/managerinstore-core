package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Auditor
@Entity
@Table(name="contato_cliente")
public class ContatoClienteBean extends Bean {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idcontato_cliente" , nullable = false)
    private Integer idcontatoCliente;
    
    @ManyToOne()
    @JoinColumn(name = "iddados_cliente" ,nullable = false)
    private DadosClienteBean dadosCliente;
    
    @Column( name = "principal" , nullable = false)
    private boolean principal;
    
    @Column( name = "email" , nullable = false , length = 255)
    private String email;
    
    @Column( name = "tel" , nullable = false , length = 20)
    private String tel;
    
    @Column( name = "setor" , nullable = false , length = 255)
    private String setor;

    public ContatoClienteBean() {
    }

    public ContatoClienteBean(Integer idcontatoCliente) {
        this.idcontatoCliente = idcontatoCliente;
    }

    public Integer getIdcontatoCliente() {
        return idcontatoCliente;
    }

    public void setIdcontatoCliente(Integer idcontatoCliente) {
        this.idcontatoCliente = idcontatoCliente;
    }

    public DadosClienteBean getDadosCliente() {
        return dadosCliente;
    }

    public void setDadosCliente(DadosClienteBean dadosCliente) {
        this.dadosCliente = dadosCliente;
    }

    public boolean isPrincipal() {
        return principal;
    }

    public void setPrincipal(boolean principal) {
        this.principal = principal;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getSetor() {
        return setor;
    }

    public void setSetor(String setor) {
        this.setor = setor;
    }
}
