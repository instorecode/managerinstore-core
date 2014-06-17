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
@Table(name = "perfil_usuario")
public class PerfilUsuarioBean extends Bean {
    @Id
    @Column(name = "idperfil_usuario", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idperfilUsuario;
    
    @ManyToOne(cascade = {
        CascadeType.REMOVE
    })
    @JoinColumn(name = "idperfil" ,nullable = false )
    private PerfilBean perfil;
    
    @ManyToOne(cascade = {
        CascadeType.REMOVE
    })
    @JoinColumn(name = "idusuario" ,nullable = false)
    private UsuarioBean usuario;

    public PerfilUsuarioBean() {
    }

    public PerfilUsuarioBean(Integer idperfilUsuario) {
        this.idperfilUsuario = idperfilUsuario;
    }

    public Integer getIdperfilUsuario() {
        return idperfilUsuario;
    }

    public void setIdperfilUsuario(Integer idperfilUsuario) {
        this.idperfilUsuario = idperfilUsuario;
    }

    public PerfilBean getPerfil() {
        return perfil;
    }

    public void setPerfil(PerfilBean perfil) {
        this.perfil = perfil;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }
}
