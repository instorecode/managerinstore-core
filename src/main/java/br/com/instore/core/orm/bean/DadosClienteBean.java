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
@Table(name = "dados_cliente")
public class DadosClienteBean extends Bean {
    @Id
    @Column(name = "iddados_cliente", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer iddadosCliente;    
    
    @ManyToOne()
    @JoinColumn(name = "idcliente" ,nullable = false)
    private ClienteBean cliente;
    
    @Column(name = "cnpj", nullable = false , length = 18)
    private String cnpj;
    
    @Column(name = "razao_social", nullable = false , length = 255)
    private String razaoSocial;
    
    @Column(name = "nome_fantasia", nullable = false , length = 255)
    private String nomeFantasia;
    
    @Column(name = "indice_reajuste_contrato", nullable = false)
    private Double indiceReajusteContrato;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data_inicio_contrato", nullable = false)
    private Date dataInicioContrato;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data_termino_contrato", nullable = false)
    private Date dataTerminoContrato;
    
    @Column(name = "renovacao_automatica", nullable = false)
    private Boolean renovacaoAutomatica;
    
    @Column( name = "valor_contrato" , nullable = true)
    private Double valorContrato;
    
    @Column(name = "local_origem_musica", nullable = false , length = 255)
    private String localOrigemMusica;
    
    @Column(name = "local_destino_musica", nullable = false , length = 255)
    private String localDestinoMusica;
    
    @Column(name = "local_origem_spot", nullable = false , length = 255)
    private String localOrigemSpot;
    
    @Column(name = "local_destino_spot", nullable = false , length = 255)
    private String localDestinoSpot;
    
    @Column(name = "local_destino_exp", nullable = false , length = 255)
    private String localDestinoExp;
    
    @ManyToOne
    @JoinColumn(name = "indice_reajuste")
    private IndiceReajusteBean indiceReajuste;

    public DadosClienteBean() {
    }

    public DadosClienteBean(Integer iddadosCliente) {
        this.iddadosCliente = iddadosCliente;
    }

    public Integer getIddadosCliente() {
        return iddadosCliente;
    }

    public void setIddadosCliente(Integer iddadosCliente) {
        this.iddadosCliente = iddadosCliente;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getRazaoSocial() {
        return razaoSocial;
    }

    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }

    public String getNomeFantasia() {
        return nomeFantasia;
    }

    public void setNomeFantasia(String nomeFantasia) {
        this.nomeFantasia = nomeFantasia;
    }

    public Double getIndiceReajusteContrato() {
        return indiceReajusteContrato;
    }

    public void setIndiceReajusteContrato(Double indiceReajusteContrato) {
        this.indiceReajusteContrato = indiceReajusteContrato;
    }

    public Date getDataInicioContrato() {
        return dataInicioContrato;
    }

    public void setDataInicioContrato(Date dataInicioContrato) {
        this.dataInicioContrato = dataInicioContrato;
    }

    public Date getDataTerminoContrato() {
        return dataTerminoContrato;
    }

    public void setDataTerminoContrato(Date dataTerminoContrato) {
        this.dataTerminoContrato = dataTerminoContrato;
    }

    public Boolean getRenovacaoAutomatica() {
        return renovacaoAutomatica;
    }

    public void setRenovacaoAutomatica(Boolean renovacaoAutomatica) {
        this.renovacaoAutomatica = renovacaoAutomatica;
    }

    public Double getValorContrato() {
        return valorContrato;
    }

    public void setValorContrato(Double valorContrato) {
        this.valorContrato = valorContrato;
    }

    public String getLocalOrigemMusica() {
        return localOrigemMusica;
    }

    public void setLocalOrigemMusica(String localOrigemMusica) {
        this.localOrigemMusica = localOrigemMusica;
    }

    public String getLocalDestinoMusica() {
        return localDestinoMusica;
    }

    public void setLocalDestinoMusica(String localDestinoMusica) {
        this.localDestinoMusica = localDestinoMusica;
    }

    public String getLocalOrigemSpot() {
        return localOrigemSpot;
    }

    public void setLocalOrigemSpot(String localOrigemSpot) {
        this.localOrigemSpot = localOrigemSpot;
    }

    public String getLocalDestinoSpot() {
        return localDestinoSpot;
    }

    public void setLocalDestinoSpot(String localDestinoSpot) {
        this.localDestinoSpot = localDestinoSpot;
    }

    public String getLocalDestinoExp() {
        return localDestinoExp;
    }

    public void setLocalDestinoExp(String localDestinoExp) {
        this.localDestinoExp = localDestinoExp;
    }

    public IndiceReajusteBean getIndiceReajuste() {
        return indiceReajuste;
    }

    public void setIndiceReajuste(IndiceReajusteBean indiceReajuste) {
        this.indiceReajuste = indiceReajuste;
    }
}
