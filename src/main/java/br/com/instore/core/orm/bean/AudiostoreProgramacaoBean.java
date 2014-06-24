package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table( name = "audiostore_programacao")
public class AudiostoreProgramacaoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false , length = 30)
    private Integer id;
    
    @Column( name = "descricao" , nullable = false , length = 30 , unique = true)
    private String descricao;
    
    @ManyToOne
    @JoinColumn(name = "idcliente", nullable = true)
    private ClienteBean cliente;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_inicio" , nullable = false)
    private Date dataInicio;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_final" , nullable = false )
    private Date dataFinal;
    
    @Temporal(TemporalType.TIME)
    @Column( name = "hora_inicio" , nullable = false)
    private Date horaInicio;
    
    @Temporal(TemporalType.TIME)
    @Column( name = "hora_final" , nullable = false)
    private Date horaFinal;
    
    @Column( name = "segunda_feira" , nullable = false)
    private Boolean segundaFeira;
    
    @Column( name = "terca_feira" , nullable = false)
    private Boolean tercaFeira;
    
    @Column( name = "quarta_feira" , nullable = false)
    private Boolean quartaFeira;
    
    @Column( name = "quinta_feira" , nullable = false)
    private Boolean quintaFeira;
    
    @Column( name = "sexta_feira" , nullable = false)
    private Boolean sextaFeira;
    
    @Column( name = "sabado" , nullable = false)
    private Boolean sabado;
    
    @Column( name = "domingo" , nullable = false)
    private Boolean domingo;
    
    public AudiostoreProgramacaoBean() {
    }

    public AudiostoreProgramacaoBean(Integer id) {
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

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
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

    public Date getHoraInicio() {
        return horaInicio;
    }

    public void setHoraInicio(Date horaInicio) {
        this.horaInicio = horaInicio;
    }

    public Date getHoraFinal() {
        return horaFinal;
    }

    public void setHoraFinal(Date horaFinal) {
        this.horaFinal = horaFinal;
    }

    public Boolean getSegundaFeira() {
        return segundaFeira;
    }

    public void setSegundaFeira(Boolean segundaFeira) {
        this.segundaFeira = segundaFeira;
    }

    public Boolean getTercaFeira() {
        return tercaFeira;
    }

    public void setTercaFeira(Boolean tercaFeira) {
        this.tercaFeira = tercaFeira;
    }

    public Boolean getQuartaFeira() {
        return quartaFeira;
    }

    public void setQuartaFeira(Boolean quartaFeira) {
        this.quartaFeira = quartaFeira;
    }

    public Boolean getQuintaFeira() {
        return quintaFeira;
    }

    public void setQuintaFeira(Boolean quintaFeira) {
        this.quintaFeira = quintaFeira;
    }

    public Boolean getSextaFeira() {
        return sextaFeira;
    }

    public void setSextaFeira(Boolean sextaFeira) {
        this.sextaFeira = sextaFeira;
    }

    public Boolean getSabado() {
        return sabado;
    }

    public void setSabado(Boolean sabado) {
        this.sabado = sabado;
    }

    public Boolean getDomingo() {
        return domingo;
    }

    public void setDomingo(Boolean domingo) {
        this.domingo = domingo;
    }
}
