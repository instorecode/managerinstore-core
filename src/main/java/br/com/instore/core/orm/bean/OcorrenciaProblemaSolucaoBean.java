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
@Table(name="ocorrencia_orgiem")
public class OcorrenciaProblemaSolucaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ocorrencia_problema" , nullable = false)
    private OcorrenciaProblemaBean ocorrenciaProblema;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "ocorrencia_solucao" , nullable = false)
    private OcorrenciaSolucaoBean ocorrenciaSolucao;

    public OcorrenciaProblemaSolucaoBean() {
    }

    public OcorrenciaProblemaSolucaoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public OcorrenciaProblemaBean getOcorrenciaProblema() {
        return ocorrenciaProblema;
    }

    public void setOcorrenciaProblema(OcorrenciaProblemaBean ocorrenciaProblema) {
        this.ocorrenciaProblema = ocorrenciaProblema;
    }

    public OcorrenciaSolucaoBean getOcorrenciaSolucao() {
        return ocorrenciaSolucao;
    }

    public void setOcorrenciaSolucao(OcorrenciaSolucaoBean ocorrenciaSolucao) {
        this.ocorrenciaSolucao = ocorrenciaSolucao;
    }
}
