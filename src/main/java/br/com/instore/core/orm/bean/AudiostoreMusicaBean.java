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
@Table(name = "audiostore_musica")
public class AudiostoreMusicaBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "cliente" , nullable = false)
    private ClienteBean cliente;

    @ManyToOne
    @JoinColumn(name = "categoria1" , nullable = false)
    private AudiostoreCategoriaBean categoria1;
    
    @ManyToOne
    @JoinColumn(name = "categoria2" , nullable = true)
    private AudiostoreCategoriaBean categoria2;
    
    @ManyToOne
    @JoinColumn(name = "categoria3" , nullable = true)
    private AudiostoreCategoriaBean categoria3;
    
    @Column(name = "arquivo" , length = 30, nullable = false)
    private String arquivo;
    
    @Column(name = "interprete" , length = 30, nullable = false)
    private String interprete;
    
    @Column(name = "tipo_interprete" , nullable = false)
    private short tipoInterprete;
    
    @Column(name = "titulo" , length = 30, nullable = false)
    private String titulo;
    
    @Column(name = "cut" , nullable = false)
    private Boolean cut;
    
    @Column(name = "crossover" , nullable = false)
    private Boolean crossover;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data_vencimento_crossover" , nullable = false)
    private Date dataVencimentoCrossover;
    
    @Column(name = "dia_execucao1" , nullable = false)
    private Integer diaExecucao1;
    
    @Column(name = "dia_execucao2" , nullable = false)
    private Integer diaExecucao2;
    
    @Column(name = "afinidade1" , length = 30, nullable = false)
    private String afinidade1;
    
    @Column(name = "afinidade2" , length = 30, nullable = false)
    private String afinidade2;
    
    @Column(name = "afinidade3" , length = 30, nullable = false)
    private String afinidade3;
    
    @Column(name = "afinidade4" , length = 30, nullable = false)
    private String afinidade4;
    
    @Column(name = "ano_gravacao" , nullable = false)
    private Integer anoGravacao;
    
    @Column(name = "velocidade" , nullable = false)
    private short velocidade;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data" , nullable = false)
    private Date data;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ultima_execucao" , nullable = false)
    private Date ultimaExecucao;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "ultima_execucao_dia" , nullable = false)
    private Date ultimaExecucaoDia;
    
    @Temporal(TemporalType.TIME)
    @Column(name = "tempo_total" , nullable = false)
    private Date tempoTotal;
    
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

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
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

    public String getArquivo() {
        return arquivo;
    }

    public void setArquivo(String arquivo) {
        this.arquivo = arquivo;
    }

    public String getInterprete() {
        return interprete;
    }

    public void setInterprete(String interprete) {
        this.interprete = interprete;
    }

    public short getTipoInterprete() {
        return tipoInterprete;
    }

    public void setTipoInterprete(short tipoInterprete) {
        this.tipoInterprete = tipoInterprete;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
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

    public Integer getDiaExecucao1() {
        return diaExecucao1;
    }

    public void setDiaExecucao1(Integer diaExecucao1) {
        this.diaExecucao1 = diaExecucao1;
    }

    public Integer getDiaExecucao2() {
        return diaExecucao2;
    }

    public void setDiaExecucao2(Integer diaExecucao2) {
        this.diaExecucao2 = diaExecucao2;
    }

    public String getAfinidade1() {
        return afinidade1;
    }

    public void setAfinidade1(String afinidade1) {
        this.afinidade1 = afinidade1;
    }

    public String getAfinidade2() {
        return afinidade2;
    }

    public void setAfinidade2(String afinidade2) {
        this.afinidade2 = afinidade2;
    }

    public String getAfinidade3() {
        return afinidade3;
    }

    public void setAfinidade3(String afinidade3) {
        this.afinidade3 = afinidade3;
    }

    public String getAfinidade4() {
        return afinidade4;
    }

    public void setAfinidade4(String afinidade4) {
        this.afinidade4 = afinidade4;
    }

    public Integer getAnoGravacao() {
        return anoGravacao;
    }

    public void setAnoGravacao(Integer anoGravacao) {
        this.anoGravacao = anoGravacao;
    }

    public short getVelocidade() {
        return velocidade;
    }

    public void setVelocidade(short velocidade) {
        this.velocidade = velocidade;
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

    public Date getUltimaExecucaoDia() {
        return ultimaExecucaoDia;
    }

    public void setUltimaExecucaoDia(Date ultimaExecucaoDia) {
        this.ultimaExecucaoDia = ultimaExecucaoDia;
    }

    public Date getTempoTotal() {
        return tempoTotal;
    }

    public void setTempoTotal(Date tempoTotal) {
        this.tempoTotal = tempoTotal;
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
}
