package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "lancamento")
public class LancamentoBean extends Bean {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "descricao", nullable = false)
    private String descricao;


    @Temporal(TemporalType.DATE)
    @Column(name = "mes", nullable = false)
    private Date mes;

    @Temporal(TemporalType.DATE)
    @Column(name = "data_fechamento", nullable = true)
    private Date datFechamento;

    @Column(name = "valor", nullable = false, precision = 10, scale = 2)
    private Double valor;

    @Column(name = "debito", nullable = false)
    private Boolean debito;

    @Column(name = "credito", nullable = false)
    private Boolean credito;
    
    @ManyToOne()
    @JoinColumn(name = "usuario" ,nullable = false)
    private UsuarioBean usuario;
    
    @ManyToOne()
    @JoinColumn(name = "lancamento_cnpj" ,nullable = false)
    private LancamentoCnpjBean lancamentoCnpj;
    
    @Column(name = "positivo", nullable = false)
    private Boolean positivo;

    public LancamentoBean() {
    }

    public LancamentoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getMes() {
        return mes;
    }

    public void setMes(Date mes) {
        this.mes = mes;
    }

    public Date getDatFechamento() {
        return datFechamento;
    }

    public void setDatFechamento(Date datFechamento) {
        this.datFechamento = datFechamento;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Boolean getDebito() {
        return debito;
    }

    public void setDebito(Boolean debito) {
        this.debito = debito;
    }

    public Boolean getCredito() {
        return credito;
    }

    public void setCredito(Boolean credito) {
        this.credito = credito;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public LancamentoCnpjBean getLancamentoCnpj() {
        return lancamentoCnpj;
    }

    public void setLancamentoCnpj(LancamentoCnpjBean lancamentoCnpj) {
        this.lancamentoCnpj = lancamentoCnpj;
    }

    public Boolean getPositivo() {
        return positivo;
    }

    public void setPositivo(Boolean positivo) {
        this.positivo = positivo;
    }
}
