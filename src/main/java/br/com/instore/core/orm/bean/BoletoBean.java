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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.hibernate.annotations.Type;

@Auditor
@Entity
@Table(name="dados_bancario")
public class BoletoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idboleto" , nullable = false)
    private Integer idboleto;
    
    @ManyToOne
    @JoinColumn(name = "idempresa", nullable = true)
    private ClienteBean empresa;
    
    @ManyToOne
    @JoinColumn(name = "iddados_bancario", nullable = true)
    private DadosBancarioBean dadosBancario;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_emissao" , nullable = false)
    private Date dataEmissao;
    
    @Column( name = "arquivo" , nullable = false)
    @Lob
    private byte[] arquivo;
    
    @Column( name = "pagamento_efetuado" , nullable = false)
    private Boolean pagamentoEfetuado;
    
    @Temporal(TemporalType.DATE)
    @Column( name = "data_pagamento" , nullable = false)
    private Date dataPagamento;
    
    @Column( name = "valor_pagamento" , nullable = false)
    private Double valorPagamento;
    
    @Column( name = "numero_documento" , nullable = false)
    private Double numeroDocumento;

    public BoletoBean() {
    }

    public BoletoBean(Integer idboleto) {
        this.idboleto = idboleto;
    }

    public Integer getIdboleto() {
        return idboleto;
    }

    public void setIdboleto(Integer idboleto) {
        this.idboleto = idboleto;
    }

    public ClienteBean getEmpresa() {
        return empresa;
    }

    public void setEmpresa(ClienteBean empresa) {
        this.empresa = empresa;
    }

    public DadosBancarioBean getDadosBancario() {
        return dadosBancario;
    }

    public void setDadosBancario(DadosBancarioBean dadosBancario) {
        this.dadosBancario = dadosBancario;
    }

    public Date getDataEmissao() {
        return dataEmissao;
    }

    public void setDataEmissao(Date dataEmissao) {
        this.dataEmissao = dataEmissao;
    }

    public byte[] getArquivo() {
        return arquivo;
    }

    public void setArquivo(byte[] arquivo) {
        this.arquivo = arquivo;
    }

    public Boolean getPagamentoEfetuado() {
        return pagamentoEfetuado;
    }

    public void setPagamentoEfetuado(Boolean pagamentoEfetuado) {
        this.pagamentoEfetuado = pagamentoEfetuado;
    }

    public Date getDataPagamento() {
        return dataPagamento;
    }

    public void setDataPagamento(Date dataPagamento) {
        this.dataPagamento = dataPagamento;
    }

    public Double getValorPagamento() {
        return valorPagamento;
    }

    public void setValorPagamento(Double valorPagamento) {
        this.valorPagamento = valorPagamento;
    }

    public Double getNumeroDocumento() {
        return numeroDocumento;
    }

    public void setNumeroDocumento(Double numeroDocumento) {
        this.numeroDocumento = numeroDocumento;
    }
}
