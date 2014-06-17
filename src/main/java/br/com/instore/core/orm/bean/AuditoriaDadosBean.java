package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "auditoria_dados")
public class AuditoriaDadosBean extends Bean {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "auditoria_dados")
    private Integer auditoriaDados;
    
    @ManyToOne
    @JoinColumn(name = "idauditoria", nullable = false)
    private AuditoriaBean auditoria;
    
    
    @Column(name = "coluna" ,nullable = false)
    private String coluna;
    
    @Column(name = "valor_atual" ,nullable = false)
    private String valorAtual;
    
    @Column(name = "valor_novo" ,nullable = false)
    private String valorNovo;

    public AuditoriaDadosBean() {
    }

    public AuditoriaDadosBean(Integer auditoriaDados) {
        this.auditoriaDados = auditoriaDados;
    }

    public Integer getAuditoriaDados() {
        return auditoriaDados;
    }

    public void setAuditoriaDados(Integer auditoriaDados) {
        this.auditoriaDados = auditoriaDados;
    }

    public AuditoriaBean getAuditoria() {
        return auditoria;
    }

    public void setAuditoria(AuditoriaBean auditoria) {
        this.auditoria = auditoria;
    }

    public String getColuna() {
        return coluna;
    }

    public void setColuna(String coluna) {
        this.coluna = coluna;
    }

    public String getValorAtual() {
        return valorAtual;
    }

    public void setValorAtual(String valorAtual) {
        this.valorAtual = valorAtual;
    }

    public String getValorNovo() {
        return valorNovo;
    }

    public void setValorNovo(String valorNovo) {
        this.valorNovo = valorNovo;
    }
}
