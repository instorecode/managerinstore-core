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
@Table(name = "audiostore_musica")
public class AudiostoreMusicaBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "musica_geral" , nullable = false)
    private Integer musicaGeral;

    @ManyToOne
    @JoinColumn(name = "categoria1" , nullable = false , insertable = false, updatable = false)
    private AudiostoreCategoriaBean categoria1;
    
    @ManyToOne(cascade = {CascadeType.REMOVE})
    @JoinColumn(name = "categoria2" , nullable = true, insertable = false, updatable = false)
    private AudiostoreCategoriaBean categoria2;
    
    @ManyToOne(cascade = {CascadeType.REMOVE})
    @JoinColumn(name = "categoria3" , nullable = true, insertable = false, updatable = false)
    private AudiostoreCategoriaBean categoria3;
    
    @Column(name = "cut" , nullable = false)
    private Boolean cut;
    
    @Column(name = "crossover" , nullable = false)
    private Boolean crossover;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data_vencimento_crossover" , nullable = false)
    private Date dataVencimentoCrossover;
    
    @Column(name = "dias_execucao1" , nullable = false)
    private Integer diasExecucao1;
    
    @Column(name = "dias_execucao2" , nullable = false)
    private Integer diasExecucao2;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data" , nullable = false)
    private Date data;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ultima_execucao" , nullable = false)
    private Date ultimaExecucao;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "ultima_execucao_data" , nullable = false)
    private Date ultimaExecucaoData;
    
    @Column(name = "random" , nullable = false)
    private Integer random;
    
    @Column(name = "qtde_player" , nullable = false)
    private Integer qtdePlayer;
    
    @Column(name = "qtde" , nullable = false)
    private Integer qtde;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data_vencimento" , nullable = false)
    private Date dataVencimento;
    
    @Column(name = "frame_inicio" , nullable = false)
    private Integer frameInicio;
    
    @Column(name = "frame_final" , nullable = false)
    private Integer frameFinal;
    
    @Column(name = "msg" , length = 40, nullable = false)
    private String msg;
    
    @Column(name = "sem_som" , nullable = false)
    private Boolean semSom;
    
    @Column(name = "super_crossover" , nullable = false)
    private Boolean superCrossover;
    
    @Column(name = "ultima_importacao" , nullable = false)
    private Boolean ultimaImportacao;
    
    @ManyToOne
    @JoinColumn(name = "cliente" , nullable = false)
    private ClienteBean cliente;

    public AudiostoreMusicaBean() {
    }

    public AudiostoreMusicaBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getMusicaGeral() {
        return musicaGeral;
    }

    public void setMusicaGeral(Integer musicaGeral) {
        this.musicaGeral = musicaGeral;
    }

    public AudiostoreCategoriaBean getCategoria1() {
        return categoria1;
    }

    public void setCategoria1(AudiostoreCategoriaBean categoria1) {
        this.categoria1 = categoria1;
    }

    public AudiostoreCategoriaBean getCategoria2() {
        return categoria2;
    }

    public void setCategoria2(AudiostoreCategoriaBean categoria2) {
        this.categoria2 = categoria2;
    }

    public AudiostoreCategoriaBean getCategoria3() {
        return categoria3;
    }

    public void setCategoria3(AudiostoreCategoriaBean categoria3) {
        this.categoria3 = categoria3;
    }

    public Boolean getCut() {
        return cut;
    }

    public void setCut(Boolean cut) {
        this.cut = cut;
    }

    public Boolean getCrossover() {
        return crossover;
    }

    public void setCrossover(Boolean crossover) {
        this.crossover = crossover;
    }

    public Date getDataVencimentoCrossover() {
        return dataVencimentoCrossover;
    }

    public void setDataVencimentoCrossover(Date dataVencimentoCrossover) {
        this.dataVencimentoCrossover = dataVencimentoCrossover;
    }

    public Integer getDiasExecucao1() {
        return diasExecucao1;
    }

    public void setDiasExecucao1(Integer diasExecucao1) {
        this.diasExecucao1 = diasExecucao1;
    }

    public Integer getDiasExecucao2() {
        return diasExecucao2;
    }

    public void setDiasExecucao2(Integer diasExecucao2) {
        this.diasExecucao2 = diasExecucao2;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Date getUltimaExecucao() {
        return ultimaExecucao;
    }

    public void setUltimaExecucao(Date ultimaExecucao) {
        this.ultimaExecucao = ultimaExecucao;
    }

    public Date getUltimaExecucaoData() {
        return ultimaExecucaoData;
    }

    public void setUltimaExecucaoData(Date ultimaExecucaoData) {
        this.ultimaExecucaoData = ultimaExecucaoData;
    }

    public Integer getRandom() {
        return random;
    }

    public void setRandom(Integer random) {
        this.random = random;
    }

    public Integer getQtdePlayer() {
        return qtdePlayer;
    }

    public void setQtdePlayer(Integer qtdePlayer) {
        this.qtdePlayer = qtdePlayer;
    }

    public Integer getQtde() {
        return qtde;
    }

    public void setQtde(Integer qtde) {
        this.qtde = qtde;
    }

    public Date getDataVencimento() {
        return dataVencimento;
    }

    public void setDataVencimento(Date dataVencimento) {
        this.dataVencimento = dataVencimento;
    }

    public Integer getFrameInicio() {
        return frameInicio;
    }

    public void setFrameInicio(Integer frameInicio) {
        this.frameInicio = frameInicio;
    }

    public Integer getFrameFinal() {
        return frameFinal;
    }

    public void setFrameFinal(Integer frameFinal) {
        this.frameFinal = frameFinal;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Boolean getSemSom() {
        return semSom;
    }

    public void setSemSom(Boolean semSom) {
        this.semSom = semSom;
    }

    public Boolean getSuperCrossover() {
        return superCrossover;
    }

    public void setSuperCrossover(Boolean superCrossover) {
        this.superCrossover = superCrossover;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public Boolean getUltimaImportacao() {
        return ultimaImportacao;
    }

    public void setUltimaImportacao(Boolean ultimaImportacao) {
        this.ultimaImportacao = ultimaImportacao;
    }
}
