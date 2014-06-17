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
    @Column( name = "idconfig_app" , nullable = false)
    private Integer configApp;
    
    @Column( name = "data_path" , nullable = false , length = 255)
    private String dataPath;

    public ConfigAppBean() {
    }

    public ConfigAppBean(Integer configApp, String dataPath) {
        this.configApp = configApp;
        this.dataPath = dataPath;
    }

    public Integer getConfigApp() {
        return configApp;
    }

    public void setConfigApp(Integer configApp) {
        this.configApp = configApp;
    }

    public String getDataPath() {
        return dataPath;
    }

    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }
}
