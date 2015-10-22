package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Auditor;
import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Main;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "versao")
public class VersaoBean extends Bean {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column(name = "data_criacao", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCriacao;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "descricao", nullable = false)
    private String descricao;

    @Column(name = "id_projeto", nullable = false)
    private Integer idProjeto;

    @Column(name = "link_svn", nullable = false)
    private String linkSvn;

    @Column(name = "download", nullable = false)
    private Boolean download;

    public VersaoBean() {
    }

    public VersaoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDataCriacao() {
        return dataCriacao;
    }

    public void setDataCriacao(Date dataCriacao) {
        this.dataCriacao = dataCriacao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Integer getIdProjeto() {
        return idProjeto;
    }

    public void setIdProjeto(Integer idProjeto) {
        this.idProjeto = idProjeto;
    }

    public String getLinkSvn() {
        return linkSvn;
    }

    public void setLinkSvn(String linkSvn) {
        this.linkSvn = linkSvn;
    }

    public Boolean getDownload() {
        return download;
    }

    public void setDownload(Boolean download) {
        this.download = download;
    }

}
