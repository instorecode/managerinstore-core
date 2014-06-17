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
@Table(name="cep")
public class CepBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idcep" , nullable = false)
    private Integer idcep;
    
    @Column( name = "numero" , nullable = false , length = 10)
    private String numero;
    
    @ManyToOne
    @JoinColumn(name = "idbairro")
    private BairroBean bairro;

    public CepBean() {
    }

    public CepBean(Integer idcep) {
        this.idcep = idcep;
    }

    public Integer getIdcep() {
        return idcep;
    }

    public void setIdcep(Integer idcep) {
        this.idcep = idcep;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public BairroBean getBairro() {
        return bairro;
    }

    public void setBairro(BairroBean bairro) {
        this.bairro = bairro;
    }
}
