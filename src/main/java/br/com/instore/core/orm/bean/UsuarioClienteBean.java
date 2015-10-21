package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
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
@Table(name = "usuario_cliente")
public class UsuarioClienteBean extends Bean {
    @Id
    @Column(name = "idusuario_cliente", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idusuarioCliente;
    
    @ManyToOne()
    @JoinColumn(name = "cliente" ,nullable = false)
    private ClienteBean cliente;
    
    @ManyToOne()
    @JoinColumn(name = "idusuario" ,nullable = false)
    private UsuarioBean usuario;

    public UsuarioClienteBean() {
    }

    public Integer getIdusuarioCliente() {
        return idusuarioCliente;
    }

    public void setIdusuarioCliente(Integer idusuarioCliente) {
        this.idusuarioCliente = idusuarioCliente;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }
}
