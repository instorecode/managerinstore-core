package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_parte4")
public class OrdemServicoParte4Bean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "fk", nullable = false)
    private Integer fk;

    @Column(name = "categoria", nullable = false)
    private Integer categoria;

    @Column(name = "tipo", nullable = false)
    private Integer tipo;

    @Column(name = "frequencia", nullable = false , length = 255)
    private String frequencia;

    @Column(name = "dinicial", nullable = false , length = 10)
    private String dinicial;

    @Column(name = "dfinal", nullable = false , length = 10)
    private String dfinal;
    
    @Column(name = "dvencimento", nullable = false , length = 10)
    private String dvencimento;
    
    @Column(name = "unidades", nullable = false)
    private String unidades;
    
    @Column(name = "horarios", nullable = false)
    private String horarios;

    public OrdemServicoParte4Bean() {
    }

    public OrdemServicoParte4Bean(Integer id) {
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

    public Integer getCategoria() {
        return categoria;
    }

    public void setCategoria(Integer categoria) {
        this.categoria = categoria;
    }

    public Integer getTipo() {
        return tipo;
    }

    public void setTipo(Integer tipo) {
        this.tipo = tipo;
    }

    public String getFrequencia() {
        return frequencia;
    }

    public void setFrequencia(String frequencia) {
        this.frequencia = frequencia;
    }

    public String getDinicial() {
        return dinicial;
    }

    public void setDinicial(String dinicial) {
        this.dinicial = dinicial;
    }

    public String getDfinal() {
        return dfinal;
    }

    public void setDfinal(String dfinal) {
        this.dfinal = dfinal;
    }

    public String getDvencimento() {
        return dvencimento;
    }

    public void setDvencimento(String dvencimento) {
        this.dvencimento = dvencimento;
    }

    public String getUnidades() {
        return unidades;
    }

    public void setUnidades(String unidades) {
        this.unidades = unidades;
    }

    public String getHorarios() {
        return horarios;
    }

    public void setHorarios(String horarios) {
        this.horarios = horarios;
    }    
}
