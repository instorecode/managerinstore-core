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
@Table(name="ocorrencia_usuario")
public class OcorrenciaUsuarioBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ocorrencia" , nullable = true)
    private OcorrenciaBean ocorrenciaBean;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "usuario" , nullable = false)
    private UsuarioBean usuario;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "prazo_resolucao" , nullable = false)
    private Date prazoResolucao;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ocorrencia_status" , nullable = true)
    private OcorrenciaStatusBean ocorrenciaStatus;
    
    public OcorrenciaUsuarioBean() {
    }

    public OcorrenciaUsuarioBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    public OcorrenciaBean getOcorrenciaBean() {
        return ocorrenciaBean;
    }

    public void setOcorrenciaBean(OcorrenciaBean ocorrenciaBean) {
        this.ocorrenciaBean = ocorrenciaBean;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public Date getPrazoResolucao() {
        return prazoResolucao;
    }

    public void setPrazoResolucao(Date prazoResolucao) {
        this.prazoResolucao = prazoResolucao;
    }

    public OcorrenciaStatusBean getOcorrenciaStatus() {
        return ocorrenciaStatus;
    }

    public void setOcorrenciaStatus(OcorrenciaStatusBean ocorrenciaStatus) {
        this.ocorrenciaStatus = ocorrenciaStatus;
    }
}
