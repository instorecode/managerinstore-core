package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import java.util.Date;
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

@Entity
@Table(name = "auditoria")
public class AuditoriaBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "idauditoria")
    private Integer idauditoria;
    
    @ManyToOne
    @JoinColumn(name = "idusuario", nullable = false)
    private UsuarioBean usuario;
    
    @Column(name = "acao" , nullable = false)
    private Short acao;
    
    @Column(name = "entidade" , nullable = false)
    private String entidade;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "data" , nullable = false)
    private Date data;

    public AuditoriaBean() {
    }

    public AuditoriaBean(Integer idauditoria) {
        this.idauditoria = idauditoria;
    }

    public Integer getIdauditoria() {
        return idauditoria;
    }

    public void setIdauditoria(Integer idauditoria) {
        this.idauditoria = idauditoria;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public Short getAcao() {
        return acao;
    }

    public void setAcao(Short acao) {
        this.acao = acao;
    }

    public String getEntidade() {
        return entidade;
    }

    public void setEntidade(String entidade) {
        this.entidade = entidade;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }
}
