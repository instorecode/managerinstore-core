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
@Table(name="config_app")
public class ConfigAppBean extends Bean {
    @Id
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "data_path" , nullable = false , length = 255)
    private String dataPath;
    
    @Column( name = "audiostore_musica_dir_origem" , nullable = false , length = 255)
    private String audiostoreMusicaDirOrigem;
    
    @Column( name = "audiostore_musica_dir_destino" , nullable = false , length = 255)
    private String audiostoreMusicaDirDestino;

    public ConfigAppBean() {
    }

    public ConfigAppBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDataPath() {
        return dataPath;
    }

    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }

    public String getAudiostoreMusicaDirOrigem() {
        return audiostoreMusicaDirOrigem;
    }

    public void setAudiostoreMusicaDirOrigem(String audiostoreMusicaDirOrigem) {
        this.audiostoreMusicaDirOrigem = audiostoreMusicaDirOrigem;
    }

    public String getAudiostoreMusicaDirDestino() {
        return audiostoreMusicaDirDestino;
    }

    public void setAudiostoreMusicaDirDestino(String audiostoreMusicaDirDestino) {
        this.audiostoreMusicaDirDestino = audiostoreMusicaDirDestino;
    }
}
