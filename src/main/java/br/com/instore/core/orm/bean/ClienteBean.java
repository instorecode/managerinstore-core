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
@Table(name = "cliente")
public class ClienteBean extends Bean {

    @Id
    @Column(name = "idcliente", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idcliente;
    
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
    
    @Column(name = "situacao", nullable = false)
    private Boolean situacao;
    

    public ClienteBean() {
    }

    public ClienteBean(Integer idempresa) {
        this.idcliente = idempresa;
    }

    public Integer getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(Integer idcliente) {
        this.idcliente = idcliente;
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

    public Boolean getSituacao() {
        return situacao;
    }

    public void setSituacao(Boolean situacao) {
        this.situacao = situacao;
    }
}
