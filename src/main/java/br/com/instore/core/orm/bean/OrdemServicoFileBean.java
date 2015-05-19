
package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_fila")
public class OrdemServicoFileBean  extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    
    @Column(name = "fk", nullable = false )
    private Integer fk;
    
    @Column(name = "usuario", nullable = false )
    private Integer usuario;
    
    @Column(name = "data", nullable = false , length = 20)
    private String data;
    
    @Column(name = "prioridade", nullable = false )
    private Integer prioridade;
    
    @Column(name = "situacao", nullable = false )
    private Integer situacao;

    public OrdemServicoFileBean() {
    }

    public OrdemServicoFileBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFk() {
        return fk;
    }

    public void setFk(Integer fk) {
        this.fk = fk;
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

    public Integer getPrioridade() {
        return prioridade;
    }

    public void setPrioridade(Integer prioridade) {
        this.prioridade = prioridade;
    }

    public Integer getSituacao() {
        return situacao;
    }

    public void setSituacao(Integer situacao) {
        this.situacao = situacao;
    }    
}


