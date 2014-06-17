package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
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
@Table(name = "empresa")
public class EmpresaBean extends Bean {

    @Id
    @Column(name = "idempresa", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idempresa;
    
    @ManyToOne
    @JoinColumn(name = "idendereco", nullable = true)
    private EnderecoBean endereco;
    
    @Column(name = "parente", nullable = false)
    private Integer parente;
    
    @Column(name = "nome", nullable = false, length = 255)
    private String nome;
    
    @Column(name = "matriz", nullable = false)
    private Boolean matriz;
    
    @Column(name = "instore", nullable = false)
    private Boolean instore;
    

    public EmpresaBean() {
    }

    public EmpresaBean(Integer idempresa) {
        this.idempresa = idempresa;
    }

    public Integer getIdempresa() {
        return idempresa;
    }

    public void setIdempresa(Integer idempresa) {
        this.idempresa = idempresa;
    }

    public EnderecoBean getEndereco() {
        return endereco;
    }

    public void setEndereco(EnderecoBean endereco) {
        this.endereco = endereco;
    }

    public Integer getParente() {
        return parente;
    }

    public void setParente(Integer parente) {
        this.parente = parente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Boolean getMatriz() {
        return matriz;
    }

    public void setMatriz(Boolean matriz) {
        this.matriz = matriz;
    }

    public Boolean getInstore() {
        return instore;
    }

    public void setInstore(Boolean instore) {
        this.instore = instore;
    }
}
