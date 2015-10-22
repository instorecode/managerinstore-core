package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Auditor;
import br.com.instore.core.orm.Bean;
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
@Table(name = "acontecimento")
public class AcontecimentoBean extends Bean{
    
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column (name = "data_inicio", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataInicio;
    
    @Column(name = "data_final", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataFinal;
    
    public AcontecimentoBean (){}
    
    public AcontecimentoBean (Integer id){
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(Date dataInicio) {
        this.dataInicio = dataInicio;
    }

    public Date getDataFinal() {
        return dataFinal;
    }

    public void setDataFinal(Date dataFinal) {
        this.dataFinal = dataFinal;
    }
}
