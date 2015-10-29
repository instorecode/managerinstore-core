package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.ViewLabel;
import br.com.instore.core.orm.Auditor;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
    @ViewLabel("Nome")
    private String categoria;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_inicio" , nullable = false )    
    @ViewLabel("Data de ínicio")
    private Date dataInicio;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_final" , nullable = false)
    @ViewLabel("Data de terminos")
    private Date dataFinal;
    
    @Column( name = "tipo" , nullable = false )
    @ViewLabel("Tipo")
    private Short tipo;
    
    @Column( name = "cod_interno" , nullable = false , length = 3 )
    @ViewLabel("Código")
    private String codInterno;
    
    @Temporal(TemporalType.TIME)
    @Column( name = "tempo" , nullable = false)
    @ViewLabel("Tempo de duração")
    private Date tempo;
    
    @ManyToOne
    @JoinColumn(name = "idcliente")
    private ClienteBean cliente;

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

    public Short getTipo() {
        return tipo;
    }

    public void setTipo(Short tipo) {
        this.tipo = tipo;
    }

    public Date getTempo() {
        return tempo;
    }

    public void setTempo(Date tempo) {
        this.tempo = tempo;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public String getCodInterno() {
        return codInterno;
    }

    public void setCodInterno(String codInterno) {
        this.codInterno = codInterno;
    }
}
