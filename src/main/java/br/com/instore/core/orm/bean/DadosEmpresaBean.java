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
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "dados_empresa")
public class DadosEmpresaBean extends Bean {
    @Id
    @Column(name = "iddados_empresa", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer iddadosEmpresa;
    
    @ManyToOne
    @JoinColumn(name = "idempresa" ,nullable = false)
    private EmpresaBean empresa;
    
    @Column(name = "data_inicio_contrato" , nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataInicioContrato;
    
    @Column(name = "data_fim_contrato" , nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataFimContrato;
    
    @Column(name = "data_faturamento" , nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataFaturamento;
    
    @Column(name = "data_reajuste_valor_faturamento" , nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataReajusteValorFaturamento;
    
    @Column(name = "cnpj", length = 255)
    private String cnpj;
    
    @Column(name = "email", length = 255)
    private String email;
    
    @Column(name = "email_faturamento", length = 255)
    private String emailFaturamento;
    
    @Column(name = "tel", length = 255)
    private String tel;
    
    @Column(name = "tel_faturamento", length = 255)
    private String telFaturamento;
    
    @Column(name = "contato", length = 255)
    private String contato;
    
    @Column(name = "contato2", length = 255)
    private String contato2;
    
    @Column(name = "nome_fantasia", length = 255)
    private String nomeFantasia;
    
    @Column(name = "razao_social", length = 255)
    private String razaoSocial;
    
    @Column(name = "tem_reajuste_faturamento" , nullable = false)
    private Boolean temReajusteFaturamento;
    
    @Column(name = "valor_reajuste_faturamento" , nullable = false)
    private Double valorReajusteFaturamento;
    
    @Column(name = "valor_faturamento" , nullable = false)
    private Double valorFaturamento;
    
    @Column(name = "valor_por_matriz" , nullable = false)
    private Boolean valorPorMatriz;

    public DadosEmpresaBean() {
    }

    public DadosEmpresaBean(Integer iddadosEmpresa) {
        this.iddadosEmpresa = iddadosEmpresa;
    }

    public Integer getIddadosEmpresa() {
        return iddadosEmpresa;
    }

    public void setIddadosEmpresa(Integer iddadosEmpresa) {
        this.iddadosEmpresa = iddadosEmpresa;
    }

    public EmpresaBean getEmpresa() {
        return empresa;
    }

    public void setEmpresa(EmpresaBean empresa) {
        this.empresa = empresa;
    }

    public Date getDataInicioContrato() {
        return dataInicioContrato;
    }

    public void setDataInicioContrato(Date dataInicioContrato) {
        this.dataInicioContrato = dataInicioContrato;
    }

    public Date getDataFimContrato() {
        return dataFimContrato;
    }

    public void setDataFimContrato(Date dataFimContrato) {
        this.dataFimContrato = dataFimContrato;
    }

    public Date getDataFaturamento() {
        return dataFaturamento;
    }

    public void setDataFaturamento(Date dataFaturamento) {
        this.dataFaturamento = dataFaturamento;
    }

    public Date getDataReajusteValorFaturamento() {
        return dataReajusteValorFaturamento;
    }

    public void setDataReajusteValorFaturamento(Date dataReajusteValorFaturamento) {
        this.dataReajusteValorFaturamento = dataReajusteValorFaturamento;
    }

    public String getCnpj() {
        return cnpj;
    }

    public void setCnpj(String cnpj) {
        this.cnpj = cnpj;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmailFaturamento() {
        return emailFaturamento;
    }

    public void setEmailFaturamento(String emailFaturamento) {
        this.emailFaturamento = emailFaturamento;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getTelFaturamento() {
        return telFaturamento;
    }

    public void setTelFaturamento(String telFaturamento) {
        this.telFaturamento = telFaturamento;
    }

    public String getContato() {
        return contato;
    }

    public void setContato(String contato) {
        this.contato = contato;
    }

    public String getContato2() {
        return contato2;
    }

    public void setContato2(String contato2) {
        this.contato2 = contato2;
    }

    public String getNomeFantasia() {
        return nomeFantasia;
    }

    public void setNomeFantasia(String nomeFantasia) {
        this.nomeFantasia = nomeFantasia;
    }

    public String getRazaoSocial() {
        return razaoSocial;
    }

    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }

    public Boolean getTemReajusteFaturamento() {
        return temReajusteFaturamento;
    }

    public void setTemReajusteFaturamento(Boolean temReajusteFaturamento) {
        this.temReajusteFaturamento = temReajusteFaturamento;
    }

    public Double getValorReajusteFaturamento() {
        return valorReajusteFaturamento;
    }

    public void setValorReajusteFaturamento(Double valorReajusteFaturamento) {
        this.valorReajusteFaturamento = valorReajusteFaturamento;
    }

    public Double getValorFaturamento() {
        return valorFaturamento;
    }

    public void setValorFaturamento(Double valorFaturamento) {
        this.valorFaturamento = valorFaturamento;
    }

    public Boolean getValorPorMatriz() {
        return valorPorMatriz;
    }

    public void setValorPorMatriz(Boolean valorPorMatriz) {
        this.valorPorMatriz = valorPorMatriz;
    }
}
