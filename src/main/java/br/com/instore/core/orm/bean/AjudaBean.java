package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.ViewLabel;
import br.com.instore.core.orm.bean.annotation.Auditor;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ajuda")
public class AjudaBean extends Bean{
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    
    @Column(name = "titulo", nullable = false , length = 100)
    @ViewLabel ("Titulo")
    private String titulo;
    
    @Column(name = "texto" , nullable = false , length = 255)
    @ViewLabel("Texto")
    private String texto;
    
    @ManyToOne
    @JoinColumn(name = "idfuncionalidade", nullable = false)
    private FuncionalidadeBean funcionalidade;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public FuncionalidadeBean getFuncionalidade() {
        return funcionalidade;
    }

    public void setFuncionalidade(FuncionalidadeBean funcionalidade) {
        this.funcionalidade = funcionalidade;
    }
    
    
    
}
