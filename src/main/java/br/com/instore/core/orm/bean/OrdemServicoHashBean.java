package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_hash")
public class OrdemServicoHashBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "usuario", nullable = false)
    private Integer usuario;
    
    @Column(name = "data", nullable = false)
    private String data;
    
    @Column(name = "fk", nullable = false)
    private Integer fk;
    
    @Column(name = "metadata", nullable = false)
    private String metadata;
    
    @Column(name = "email", nullable = false)
    private String email;
    
    @Column(name = "finalizado", nullable = false)
    private Integer finalizado;
    
    @Column(name = "obs", nullable = false)
    private String obs;
    
    @Column(name = "hash", nullable = false)
    private String hash;
    
    @Column(name = "situacao", nullable = false)
    private Integer situacao;

    public OrdemServicoHashBean() {
    }

    public OrdemServicoHashBean(Integer id) {
        this.id = id;
    }    

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUsuario() {
        return usuario;
    }

    public void setUsuario(Integer usuario) {
        this.usuario = usuario;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public Integer getFk() {
        return fk;
    }

    public void setFk(Integer fk) {
        this.fk = fk;
    }

    public String getMetadata() {
        return metadata;
    }

    public void setMetadata(String metadata) {
        this.metadata = metadata;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getFinalizado() {
        return finalizado;
    }

    public void setFinalizado(Integer finalizado) {
        this.finalizado = finalizado;
    }

    public String getObs() {
        return obs;
    }

    public void setObs(String obs) {
        this.obs = obs;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public Integer getSituacao() {
        return situacao;
    }

    public void setSituacao(Integer situacao) {
        this.situacao = situacao;
    }
}
