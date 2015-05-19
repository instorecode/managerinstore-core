package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_parte2")
public class OrdemServicoParte2Bean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "fk", nullable = false)
    private Integer fk;

    @Column(name = "locutor", nullable = false)
    private Integer locutor;

    @Column(name = "texto", nullable = false)
    private String texto;

    @Column(name = "prazo_locucao", nullable = false, length = 10)
    private String prazoLocucao;

    public OrdemServicoParte2Bean() {
    }

    public OrdemServicoParte2Bean(Integer id) {
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

    public Integer getLocutor() {
        return locutor;
    }

    public void setLocutor(Integer locutor) {
        this.locutor = locutor;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getPrazoLocucao() {
        return prazoLocucao;
    }

    public void setPrazoLocucao(String prazoLocucao) {
        this.prazoLocucao = prazoLocucao;
    }
}
