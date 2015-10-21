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
@Table(name = "audiostore_comercial")
public class AudiostoreComercialBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "categoria" )
    private AudiostoreCategoriaBean audiostoreCategoria;
    
    @Column(name = "arquivo" , length = 30, nullable = false)
    private String arquivo;
    
    @Column(name = "titulo" , length = 30, nullable = false)
    private String titulo;
    
    @Column(name = "tipo_interprete" , nullable = false)
    private short tipoInterprete;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "periodo_inicial" , nullable = false)
    private Date periodoInicial;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "periodo_final" , nullable = false)
    private Date periodoFinal;
    
    @Column(name = "tipo_horario" , nullable = false)
    private short tipoHorario;
    
    @Column(name = "dias_semana" , length = 7 , nullable = false)
    private short diasSemana;
    
    @Column(name = "dias_alternados" , nullable = false)
    private Boolean diasAlternados;
    
    @Temporal(TemporalType.DATE)
    @Column(name = "data" , nullable = false)
    private Date data;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ultima_execucao" , nullable = false)
    private Date ultimaExecucao;
    
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
    
    @Column(name = "dependencia1" , length = 30, nullable = false)
    private String dependencia1;
    
    @Column(name = "dependencia2" , length = 30, nullable = false)
    private String dependencia2;
    
    @Column(name = "dependencia3" , length = 30, nullable = false)
    private String dependencia3;
    
    @Column(name = "frame_inicio" , nullable = false)
    private Integer frameInicio;
    
    @Column(name = "frame_final" , nullable = false)
    private Integer frameFinal;
    
    @Column(name = "msg" , length = 40, nullable = false)
    private String msg;
    
    @Column(name = "sem_som" , nullable = false)
    private Boolean semSom;
    
    @Column(name = "interromper_musica_tocada" , nullable = false)
    private Boolean interromperMusicaTocada;
    
    @ManyToOne
    @JoinColumn(name = "cliente" , nullable = false)
    private ClienteBean cliente;
    
    
    @Column(name = "texto" , nullable = false)
    private String texto;

    public AudiostoreComercialBean() {
    }

    public AudiostoreComercialBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
    public AudiostoreCategoriaBean getAudiostoreCategoria() {
        return audiostoreCategoria;
    }

    public void setAudiostoreCategoria(AudiostoreCategoriaBean audiostoreCategoria) {
        this.audiostoreCategoria = audiostoreCategoria;
    }

    public String getArquivo() {
        return arquivo;
    }

    public void setArquivo(String arquivo) {
        this.arquivo = arquivo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public short getTipoInterprete() {
        return tipoInterprete;
    }

    public void setTipoInterprete(short tipoInterprete) {
        this.tipoInterprete = tipoInterprete;
    }

    public Date getPeriodoInicial() {
        return periodoInicial;
    }

    public void setPeriodoInicial(Date periodoInicial) {
        this.periodoInicial = periodoInicial;
    }

    public Date getPeriodoFinal() {
        return periodoFinal;
    }

    public void setPeriodoFinal(Date periodoFinal) {
        this.periodoFinal = periodoFinal;
    }

    public short getTipoHorario() {
        return tipoHorario;
    }

    public void setTipoHorario(short tipoHorario) {
        this.tipoHorario = tipoHorario;
    }

    public short getDiasSemana() {
        return diasSemana;
    }

    public void setDiasSemana(short diasSemana) {
        this.diasSemana = diasSemana;
    }

    public Boolean getDiasAlternados() {
        return diasAlternados;
    }

    public void setDiasAlternados(Boolean diasAlternados) {
        this.diasAlternados = diasAlternados;
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

    public String getDependencia1() {
        return dependencia1;
    }

    public void setDependencia1(String dependencia1) {
        this.dependencia1 = dependencia1;
    }

    public String getDependencia2() {
        return dependencia2;
    }

    public void setDependencia2(String dependencia2) {
        this.dependencia2 = dependencia2;
    }

    public String getDependencia3() {
        return dependencia3;
    }

    public void setDependencia3(String dependencia3) {
        this.dependencia3 = dependencia3;
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

    public ClienteBean getCliente() {
        return cliente;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public Boolean getInterromperMusicaTocada() {
        return interromperMusicaTocada;
    }

    public void setInterromperMusicaTocada(Boolean interromperMusicaTocada) {
        this.interromperMusicaTocada = interromperMusicaTocada;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }
}
