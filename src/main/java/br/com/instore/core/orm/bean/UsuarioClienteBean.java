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
@Table(name = "usuario_empresa")
public class UsuarioClienteBean extends Bean {
    @Id
    @Column(name = "idusuario_empresa", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idusuarioEmpresa;
    
    @ManyToOne()
    @JoinColumn(name = "cliente" ,nullable = false)
    private ClienteBean cliente;
    
    @ManyToOne()
    @JoinColumn(name = "idusuario" ,nullable = false)
    private UsuarioBean usuario;

    public UsuarioClienteBean() {
    }

    public UsuarioClienteBean(Integer idusuarioEmpresa) {
        this.idusuarioEmpresa = idusuarioEmpresa;
    }

    public Integer getIdusuarioEmpresa() {
        return idusuarioEmpresa;
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
