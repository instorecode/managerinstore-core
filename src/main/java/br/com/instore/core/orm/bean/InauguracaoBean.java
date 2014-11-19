package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Auditor
@Entity
@Table(name="plantao")
public class InauguracaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "texto" , nullable = false)
    private String texto;

    public InauguracaoBean() {
    }

    public InauguracaoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
}
