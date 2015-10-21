package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
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
@Table(name = "cliente_suspenso")
public class ClienteSuspensoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "cliente")
    private ClienteBean cliente;
    
    @ManyToOne
    @JoinColumn(name = "usuario")
    private UsuarioBean usuario;
    
    @Column( name = "suspenso" , nullable = false)
    private Boolean suspenso;
    
    @Column( name = "motivo" , nullable = false)
    private String motivo;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column( name = "data" , nullable = false)
    private Date data;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column( name = "data_inicio" , nullable = false)
    private Date dataInicio;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column( name = "data_fim" , nullable = false)
    private Date dataFim;

    public ClienteSuspensoBean() {
    }

    public ClienteSuspensoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public Boolean getSuspenso() {
        return suspenso;
    }

    public void setSuspenso(Boolean suspenso) {
        this.suspenso = suspenso;
    }

    public String getMotivo() {
        return motivo;
    }

    public void setMotivo(String motivo) {
        this.motivo = motivo;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Date getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(Date dataInicio) {
        this.dataInicio = dataInicio;
    }

    public Date getDataFim() {
        return dataFim;
    }

    public void setDataFim(Date dataFim) {
        this.dataFim = dataFim;
    }
}
