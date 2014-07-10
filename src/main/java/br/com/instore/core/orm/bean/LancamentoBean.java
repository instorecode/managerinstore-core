package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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

    @Column(name = "loop", nullable = false)
    private Boolean loop;

    @Temporal(TemporalType.DATE)
    @Column(name = "loop_data_inicio", nullable = false)
    private Date loopDataInicio;

    @Temporal(TemporalType.DATE)
    @Column(name = "loop_data_fim", nullable = false)
    private Date loopDataFim;

    @Temporal(TemporalType.DATE)
    @Column(name = "mes", nullable = false)
    private Date mes;

    @Column(name = "valor", nullable = false)
    private Double valor;

    @Column(name = "debito", nullable = false)
    private Boolean debito;

    @Column(name = "credito", nullable = false)
    private Boolean credito;

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

    public Boolean isLoop() {
        return loop;
    }

    public void setLoop(Boolean loop) {
        this.loop = loop;
    }

    public Date getLoopDataInicio() {
        return loopDataInicio;
    }

    public void setLoopDataInicio(Date loopDataInicio) {
        this.loopDataInicio = loopDataInicio;
    }

    public Date getLoopDataFim() {
        return loopDataFim;
    }

    public void setLoopDataFim(Date loopDataFim) {
        this.loopDataFim = loopDataFim;
    }

    public Date getMes() {
        return mes;
    }

    public void setMes(Date mes) {
        this.mes = mes;
    }

    public Double getValor() {
        return valor;
    }

    public void setValor(Double valor) {
        this.valor = valor;
    }

    public Boolean isDebito() {
        return debito;
    }

    public void setDebito(Boolean debito) {
        this.debito = debito;
    }

    public Boolean isCredito() {
        return credito;
    }

    public void setCredito(Boolean credito) {
        this.credito = credito;
    }    
}
