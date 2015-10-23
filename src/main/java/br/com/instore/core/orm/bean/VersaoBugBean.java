package br.com.instore.core.orm.bean;

import javax.persistence.Table;
import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.persistence.GenerationType;
import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;

@Auditor
@Entity
@Table (name = "versao_bug")
public class VersaoBugBean extends Bean{
    
    @Id
    @GeneratedValue (strategy = GenerationType.AUTO)
    @Column(name = "idversao_bug")
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "idbug")
    private BugBean bug;
    
    @ManyToOne
    @JoinColumn(name = "idversao")
    private VersaoBean versao;
    
    @ManyToOne
    @JoinColumn(name = "idacontecimento_bug")
    private AcontecimentoBugBean acontecimentoBug;
    
    @ManyToOne
    @JoinColumn(name = "idsolucao")
    private SolucaoBean solucao;

    public VersaoBugBean() {
    }

    public VersaoBugBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public BugBean getBug() {
        return bug;
    }

    public void setBug(BugBean bug) {
        this.bug = bug;
    }

    public VersaoBean getVersao() {
        return versao;
    }

    public void setVersao(VersaoBean versao) {
        this.versao = versao;
    }

    public AcontecimentoBugBean getAcontecimentoBug() {
        return acontecimentoBug;
    }

    public void setAcontecimentoBug(AcontecimentoBugBean acontecimentoBug) {
        this.acontecimentoBug = acontecimentoBug;
    }

    public SolucaoBean getSolucao() {
        return solucao;
    }

    public void setSolucao(SolucaoBean solucao) {
        this.solucao = solucao;
    }
    
    
    
}
