package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "audiostore_categoria")
public class AudiostoreCategoriaBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "codigo" , nullable = false)
    private Integer codigo;
    
    @Column( name = "categoria" , nullable = false , length = 30)
    private String categoria;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_inicio" , nullable = false )
    private Date dataInicio;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_final" , nullable = false)
    private Date dataFinal;
    
    @Column( name = "tipo" , nullable = false )
    private short tipo;
    
    @Temporal(TemporalType.TIME)
    @Column( name = "tempo" , nullable = false)
    private Date tempo;
    
    @ManyToOne
    @JoinColumn(name = "idempresa")
    private EmpresaBean empresa;

    public AudiostoreCategoriaBean() {
    }

    public AudiostoreCategoriaBean(Integer codigo) {
        this.codigo = codigo;
    }

    public Integer getIdaudiostoreCategoria() {
        return codigo;
    }

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
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

    public short getTipo() {
        return tipo;
    }

    public void setTipo(short tipo) {
        this.tipo = tipo;
    }

    public Date getTempo() {
        return tempo;
    }

    public void setTempo(Date tempo) {
        this.tempo = tempo;
    }

    public EmpresaBean getEmpresa() {
        return empresa;
    }

    public void setEmpresa(EmpresaBean empresa) {
        this.empresa = empresa;
    }
}
