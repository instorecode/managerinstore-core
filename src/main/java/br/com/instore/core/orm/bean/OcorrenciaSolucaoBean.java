package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name="ocorrencia_solucao")
public class OcorrenciaSolucaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "descricao" , nullable = false)
    private String descricao;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column( name = "prazo_resolucao" , nullable = false)
    private Date prazoPesolucao;

    public OcorrenciaSolucaoBean() {
    }

    public OcorrenciaSolucaoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Date getPrazoPesolucao() {
        return prazoPesolucao;
    }

    public void setPrazoPesolucao(Date prazoPesolucao) {
        this.prazoPesolucao = prazoPesolucao;
    }
}
