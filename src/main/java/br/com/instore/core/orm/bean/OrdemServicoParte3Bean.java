package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_parte3")
public class OrdemServicoParte3Bean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "fk", nullable = false)
    private Integer fk;

    @Column(name = "prazo_estudio", nullable = false, length = 10)
    private String prazoEstudio;

    public OrdemServicoParte3Bean() {
    }

    public OrdemServicoParte3Bean(Integer id) {
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

    public String getPrazoEstudio() {
        return prazoEstudio;
    }

    public void setPrazoEstudio(String prazoEstudio) {
        this.prazoEstudio = prazoEstudio;
    }    
}
