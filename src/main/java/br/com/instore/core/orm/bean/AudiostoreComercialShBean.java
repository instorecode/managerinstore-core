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
@Table(name = "audiostore_comercial_sh")
public class AudiostoreComercialShBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "semana", length = 7 , nullable = false)
    private String semana;
    
    @Temporal(TemporalType.TIME)
    @Column(name = "horario", length = 7 , nullable = false)
    private Date horario;
    
    @ManyToOne
    @JoinColumn(name = "comercial" , nullable = false)
    private AudiostoreComercialBean comercial;
    
    @Column(name = "interromper_musica_tocada" , nullable = false)
    private Boolean interromperMusicaTocada;

    public AudiostoreComercialShBean() {
    }

    public AudiostoreComercialShBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSemana() {
        return semana;
    }

    public void setSemana(String semana) {
        this.semana = semana;
    }

    public Date getHorario() {
        return horario;
    }

    public void setHorario(Date horario) {
        this.horario = horario;
    }

    public AudiostoreComercialBean getComercial() {
        return comercial;
    }

    public void setComercial(AudiostoreComercialBean comercial) {
        this.comercial = comercial;
    }

    public Boolean getInterromperMusicaTocada() {
        return interromperMusicaTocada;
    }

    public void setInterromperMusicaTocada(Boolean interromperMusicaTocada) {
        this.interromperMusicaTocada = interromperMusicaTocada;
    }
}
