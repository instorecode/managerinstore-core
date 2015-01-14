package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

@Entity
@Table(name = "acesso_remoto")
public class AcessoRemotoBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Column(name = "servidor", length = 255)
    private String servidor;
    @Column(name = "usuario", length = 255)
    private String usuario;
    @Column(name = "senha", length = 255)
    private String senha;
    @Column(name = "porta", length = 255)
    private String porta;
    @ManyToOne
    @JoinColumn(name = "tipo_acesso_remoto", nullable = false, insertable = false, updatable = false)
    private TipoAcessoRemotoBean tipoAcessoRemoto;
    @ManyToOne
    @JoinColumn(name = "cliente", nullable = false, insertable = false, updatable = false)
    private ClienteBean cliente;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getServidor() {
        return servidor;
    }

    public void setServidor(String servidor) {
        this.servidor = servidor;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getPorta() {
        return porta;
    }

    public void setPorta(String porta) {
        this.porta = porta;
    }

    public AcessoRemotoBean() {
    }

    public AcessoRemotoBean(Integer id) {
        this.id = id;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public TipoAcessoRemotoBean getTipoAcessoRemoto() {
        return tipoAcessoRemoto;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public void setTipoAcessoRemoto(TipoAcessoRemotoBean tipoAcessoRemoto) {
        this.tipoAcessoRemoto = tipoAcessoRemoto;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}