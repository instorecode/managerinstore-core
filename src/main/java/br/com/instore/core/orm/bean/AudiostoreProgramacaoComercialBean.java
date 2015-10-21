package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Auditor
@Entity
@Table( name = "audiostore_programacao_comercial")
public class AudiostoreProgramacaoComercialBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "programacao")
    private Integer programacao;
    
    @Column(name = "comercial")
    private Integer comercial;
    
    @Column(name = "inicial_final")
    private Boolean inicialFinal;
    
    @Column(name = "intervalo")
    private String intervalo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProgramacao() {
        return programacao;
    }

    public void setProgramacao(Integer programacao) {
        this.programacao = programacao;
    }

    public Integer getComercial() {
        return comercial;
    }

    public void setComercial(Integer comercial) {
        this.comercial = comercial;
    }

    public Boolean getInicialFinal() {
        return inicialFinal;
    }

    public void setInicialFinal(Boolean inicialFinal) {
        this.inicialFinal = inicialFinal;
    }

    public String getIntervalo() {
        return intervalo;
    }

    public void setIntervalo(String intervalo) {
        this.intervalo = intervalo;
    }
}
