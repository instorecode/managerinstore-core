package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
import java.util.Date;
import javax.persistence.CascadeType;
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
@Table(name="ocorrencia")
public class OcorrenciaBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @Column( name = "descricao" , nullable = false)
    private String descricao;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_cadastro" , nullable = false)
    private Date dataCadastro;
    
    @Column(name = "ocorrencia_problema" , nullable = true)
    private Integer ocorrenciaProblema;
    
    @Column(name = "ocorrencia_solucao" , nullable = true)
    private Integer ocorrenciaSolucao;
    
    @ManyToOne
    @JoinColumn(name = "ocorrencia_origem" , nullable = false)
    private OcorrenciaOrigemBean ocorrenciaOrigem;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_resolucao" , nullable = false)
    private Date dataResolucao;
    
    @ManyToOne
    @JoinColumn(name = "usuario_criacao" , nullable = false)
    private UsuarioBean usuarioCriacao;
    
    @ManyToOne
    @JoinColumn(name = "ocorrencia_prioridade" , nullable = false)
    private OcorrenciaPrioridadeBean ocorrenciaPrioridade;
    
    @ManyToOne
    @JoinColumn(name = "cliente" , nullable = false)
    private ClienteBean cliente;
    
    public OcorrenciaBean() {
    }

    public OcorrenciaBean(Integer id) {
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

    public Date getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public Integer getOcorrenciaProblema() {
        return ocorrenciaProblema;
    }

    public void setOcorrenciaProblema(Integer ocorrenciaProblema) {
        this.ocorrenciaProblema = ocorrenciaProblema;
    }

    public Integer getOcorrenciaSolucao() {
        return ocorrenciaSolucao;
    }

    public void setOcorrenciaSolucao(Integer ocorrenciaSolucao) {
        this.ocorrenciaSolucao = ocorrenciaSolucao;
    }

    public OcorrenciaOrigemBean getOcorrenciaOrigem() {
        return ocorrenciaOrigem;
    }

    public void setOcorrenciaOrigem(OcorrenciaOrigemBean ocorrenciaOrigem) {
        this.ocorrenciaOrigem = ocorrenciaOrigem;
    }

    public Date getDataResolucao() {
        return dataResolucao;
    }

    public void setDataResolucao(Date dataResolucao) {
        this.dataResolucao = dataResolucao;
    }

    public UsuarioBean getUsuarioCriacao() {
        return usuarioCriacao;
    }

    public void setUsuarioCriacao(UsuarioBean usuarioCriacao) {
        this.usuarioCriacao = usuarioCriacao;
    }

    public OcorrenciaPrioridadeBean getOcorrenciaPrioridade() {
        return ocorrenciaPrioridade;
    }

    public void setOcorrenciaPrioridade(OcorrenciaPrioridadeBean ocorrenciaPrioridade) {
        this.ocorrenciaPrioridade = ocorrenciaPrioridade;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }
}
