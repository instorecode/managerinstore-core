package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
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

@Auditor
@Entity
@Table(name="ocorrencia_usuario_info")
public class OcorrenciaUsuarioInfoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "ocorrencia_usuario" , nullable = true)
    private OcorrenciaUsuarioBean ocorrenciaUsuario;
    
    @Column(name = "comentario")
    private String comentario;
    
    @Temporal(TemporalType.TIME)
    @Column(name = "tempo")
    private Date tempo;

    public OcorrenciaUsuarioInfoBean() {
    }

    public OcorrenciaUsuarioInfoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public OcorrenciaUsuarioBean getOcorrenciaUsuario() {
        return ocorrenciaUsuario;
    }

    public void setOcorrenciaUsuario(OcorrenciaUsuarioBean ocorrenciaUsuario) {
        this.ocorrenciaUsuario = ocorrenciaUsuario;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public Date getTempo() {
        return tempo;
    }

    public void setTempo(Date tempo) {
        this.tempo = tempo;
    }
}
