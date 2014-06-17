package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "estado")
public class EstadoBean extends Bean {
    @Id
    @Column(name = "idestado", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idestado;
    
    @Column(name = "nome", nullable = false)
    private String nome;
    
    @Column(name = "sigla", nullable = false)
    private String sigla;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idregiao")
    private RegiaoBean regiao;

    public EstadoBean() {
    }

    public EstadoBean(Integer idestado) {
        this.idestado = idestado;
    }

    public Integer getIdestado() {
        return idestado;
    }

    public void setIdestado(Integer idestado) {
        this.idestado = idestado;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSigla() {
        return sigla;
    }

    public void setSigla(String sigla) {
        this.sigla = sigla;
    }

    public RegiaoBean getRegiao() {
        return regiao;
    }

    public void setRegiao(RegiaoBean regiao) {
        this.regiao = regiao;
    }
}
