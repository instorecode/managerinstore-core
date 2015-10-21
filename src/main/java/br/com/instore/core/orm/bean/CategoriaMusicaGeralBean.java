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
@Table(name="categoria_musica_geral")
public class CategoriaMusicaGeralBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "categoria" , nullable = false)
    private Integer categoria;
    
    @Column( name = "musica" , nullable = false)
    private Integer musica;

    public CategoriaMusicaGeralBean() {
    }

    public CategoriaMusicaGeralBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCategoria() {
        return categoria;
    }

    public void setCategoria(Integer categoria) {
        this.categoria = categoria;
    }

    public Integer getMusica() {
        return musica;
    }

    public void setMusica(Integer musica) {
        this.musica = musica;
    }
}
