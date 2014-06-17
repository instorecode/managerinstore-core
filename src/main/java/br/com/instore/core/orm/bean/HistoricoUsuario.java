package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "historico_usuario")
public class HistoricoUsuario extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "idhistorico_usuario", nullable = false)
    private Integer idhistoricoUsuario;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "login", nullable = false)
    private Date login;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "logout", nullable = false)
    private Date logout;

    @ManyToOne()
    @JoinColumn(name = "idusuario" ,nullable = false)
    private UsuarioBean usuario;
    
    public HistoricoUsuario() {
    }

    public HistoricoUsuario(Integer idhistoricoUsuario) {
        this.idhistoricoUsuario = idhistoricoUsuario;
    }

    public Integer getIdhistoricoUsuario() {
        return idhistoricoUsuario;
    }

    public void setIdhistoricoUsuario(Integer idhistoricoUsuario) {
        this.idhistoricoUsuario = idhistoricoUsuario;
    }

    public Date getLogin() {
        return login;
    }

    public void setLogin(Date login) {
        this.login = login;
    }

    public Date getLogout() {
        return logout;
    }

    public void setLogout(Date logout) {
        this.logout = logout;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }
}
