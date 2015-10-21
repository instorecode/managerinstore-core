package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
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
@Table( name = "audiostore_programacao_categoria")
public class AudiostoreProgramacaoCategoriaBean extends Bean {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idaudiostore_programacao_categoria" , nullable = false , length = 30)
    private Integer idaudiostoreProgramacaoCategoria;
    
    @ManyToOne
    @JoinColumn(name = "codigo", nullable = true)
    private AudiostoreCategoriaBean audiostoreCategoria;
    
    @ManyToOne
    @JoinColumn(name = "id", nullable = true)
    private AudiostoreProgramacaoBean audiostoreProgramacao;

    public AudiostoreProgramacaoCategoriaBean() {
    }

    public AudiostoreProgramacaoCategoriaBean(Integer idaudiostoreProgramacaoCategoria) {
        this.idaudiostoreProgramacaoCategoria = idaudiostoreProgramacaoCategoria;
    }

    public Integer getIdaudiostoreProgramacaoCategoria() {
        return idaudiostoreProgramacaoCategoria;
    }

    public void setIdaudiostoreProgramacaoCategoria(Integer idaudiostoreProgramacaoCategoria) {
        this.idaudiostoreProgramacaoCategoria = idaudiostoreProgramacaoCategoria;
    }

    public AudiostoreCategoriaBean getAudiostoreCategoria() {
        return audiostoreCategoria;
    }

    public void setAudiostoreCategoria(AudiostoreCategoriaBean audiostoreCategoria) {
        this.audiostoreCategoria = audiostoreCategoria;
    }

    public AudiostoreProgramacaoBean getAudiostoreProgramacao() {
        return audiostoreProgramacao;
    }

    public void setAudiostoreProgramacao(AudiostoreProgramacaoBean audiostoreProgramacao) {
        this.audiostoreProgramacao = audiostoreProgramacao;
    }
}
