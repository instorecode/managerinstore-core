package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Auditor;
import br.com.instore.core.orm.Bean;
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
@Table(name = "bug")
public class BugBean extends Bean {

    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "idusuario", nullable = false , insertable = false , updatable = false )
    private UsuarioBean usuario;

    @Column(name = "data_cadastro", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCadastro;

    @Column(name = "descricao", nullable = false)
    private String descricao;

    @Column(name = "tipo_sistema_operacional", nullable = false)
    private Integer tipoSistemaOperacional;

    @Column(name = "services_pack", nullable = false)
    private String servicesPack;

    @Column(name = "data_atualizacao_os", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataAtualizacaoOs;

    @Column(name = "is_servico", nullable = false)
    private Boolean isServico;

    @Column(name = "numero_versao_os", nullable = false)
    private String numeroVersaoOs;

    @Column(name = "arquitetura_processador", nullable = false)
    private String arquiteturaProcessador;

    @Column(name = "usuario_da_maquina", nullable = false)
    private String usuarioDaMaquina;

    @Column(name = "nome_processador", nullable = false)
    private String nomeProcessador;

    @Column(name = "quantidade_memoria_ram", nullable = false)
    private Integer quantidadeMemoriaRam;

    @Column(name = "tamanho_disco", nullable = false)
    private Integer tamanhoDisco;

    @Column(name = "sistema_operacional", nullable = false)
    private String sistemaOperacional;

    @Column(name = "versao_sistema_operacional", nullable = false)
    private String versaoSistemaOperacional;

    public BugBean() {
    }

    public BugBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public Integer getTipoSistemaOperacional() {
        return tipoSistemaOperacional;
    }

    public void setTipoSistemaOperacional(Integer tipoSistemaOperacional) {
        this.tipoSistemaOperacional = tipoSistemaOperacional;
    }

    public String getServicesPack() {
        return servicesPack;
    }

    public void setServicesPack(String servicesPack) {
        this.servicesPack = servicesPack;
    }

    public Date getDataAtualizacaoOs() {
        return dataAtualizacaoOs;
    }

    public void setDataAtualizacaoOs(Date dataAtualizacaoOs) {
        this.dataAtualizacaoOs = dataAtualizacaoOs;
    }

    public String getNumeroVersaoOs() {
        return numeroVersaoOs;
    }

    public void setNumeroVersaoOs(String numeroVersaoOs) {
        this.numeroVersaoOs = numeroVersaoOs;
    }

    public String getArquiteturaProcessador() {
        return arquiteturaProcessador;
    }

    public void setArquiteturaProcessador(String arquiteturaProcessador) {
        this.arquiteturaProcessador = arquiteturaProcessador;
    }

    public String getUsuarioDaMaquina() {
        return usuarioDaMaquina;
    }

    public void setUsuarioDaMaquina(String usuarioDaMaquina) {
        this.usuarioDaMaquina = usuarioDaMaquina;
    }

    public String getNomeProcessador() {
        return nomeProcessador;
    }

    public void setNomeProcessador(String nomeProcessador) {
        this.nomeProcessador = nomeProcessador;
    }

    public Integer getQuantidadeMemoriaRam() {
        return quantidadeMemoriaRam;
    }

    public void setQuantidadeMemoriaRam(Integer quantidadeMemoriaRam) {
        this.quantidadeMemoriaRam = quantidadeMemoriaRam;
    }

    public Integer getTamanhoDisco() {
        return tamanhoDisco;
    }

    public void setTamanhoDisco(Integer tamanhoDisco) {
        this.tamanhoDisco = tamanhoDisco;
    }

    public String getSistemaOperacional() {
        return sistemaOperacional;
    }

    public void setSistemaOperacional(String sistemaOperacional) {
        this.sistemaOperacional = sistemaOperacional;
    }

    public String getVersaoSistemaOperacional() {
        return versaoSistemaOperacional;
    }

    public void setVersaoSistemaOperacional(String versaoSistemaOperacional) {
        this.versaoSistemaOperacional = versaoSistemaOperacional;
    }

    public Boolean getIsServico() {
        return isServico;
    }

    public void setIsServico(Boolean isServico) {
        this.isServico = isServico;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }
}
