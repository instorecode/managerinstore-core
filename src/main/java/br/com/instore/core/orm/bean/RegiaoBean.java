package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="regiao")
public class RegiaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idregiao" , nullable = false)
    private Integer idregiao;
    
    @Column( name = "nome" , nullable = false , length = 255)
    private String nome;

    public RegiaoBean() {
    }

    public RegiaoBean(Integer idregiao) {
        this.idregiao = idregiao;
    }

    public Integer getIdregiao() {
        return idregiao;
    }

    public void setIdregiao(Integer idregiao) {
        this.idregiao = idregiao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
}
