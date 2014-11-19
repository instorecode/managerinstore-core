package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name="plantao")
public class PlantaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "idusuario" , nullable = false)
    private UsuarioBean usuario;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data" , nullable = false)
    private Date date;

    public PlantaoBean() {
    }

    public PlantaoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}
