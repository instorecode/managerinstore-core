package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "funcionalidade")
public class FuncionalidadeBean extends Bean {
    @Id
    @Column(name = "idfuncionalidade", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idfuncionalidade;
    
    @Column(name = "mapping_id", nullable = false , length = 255)
    private String mappingId;
    
    @Column(name = "nome", nullable = false , length = 255)
    private String nome;
    
    @Column(name = "icone", nullable = false , length = 30)
    private String icone;
    
    @Column(name = "parente", nullable = false )
    private Integer parente;
    
    @Column(name = "visivel", nullable = false )
    private Boolean visivel;

    public FuncionalidadeBean() {
    }

    public FuncionalidadeBean(Integer idfuncionalidade) {
        this.idfuncionalidade = idfuncionalidade;
    }

    public Integer getIdfuncionalidade() {
        return idfuncionalidade;
    }

    public void setIdfuncionalidade(Integer idfuncionalidade) {
        this.idfuncionalidade = idfuncionalidade;
    }

    public String getMappingId() {
        return mappingId;
    }

    public void setMappingId(String mappingId) {
        this.mappingId = mappingId;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }

    public Integer getParente() {
        return parente;
    }

    public void setParente(Integer parente) {
        this.parente = parente;
    }

    public Boolean getVisivel() {
        return visivel;
    }

    public void setVisivel(Boolean visivel) {
        this.visivel = visivel;
    }
}
