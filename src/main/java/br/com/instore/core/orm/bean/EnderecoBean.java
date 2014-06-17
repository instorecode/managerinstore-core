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
@Table(name = "endereco")
public class EnderecoBean extends Bean {
    @Id
    @Column(name = "idendereco", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idendereco;
    
    @Column(name = "numero", nullable = false , length = 255)
    private String numero;
    
    @Column(name = "complemento", nullable = false , length = 255)
    private String complemento;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idcep")
    private CepBean cep;

    public EnderecoBean() {
    }

    public EnderecoBean(Integer idendereco) {
        this.idendereco = idendereco;
    }

    public Integer getIdendereco() {
        return idendereco;
    }

    public void setIdendereco(Integer idendereco) {
        this.idendereco = idendereco;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }

    public CepBean getCep() {
        return cep;
    }

    public void setCep(CepBean cep) {
        this.cep = cep;
    }
}
