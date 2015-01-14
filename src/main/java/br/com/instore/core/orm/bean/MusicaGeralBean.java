package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
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
@Table(name = "musica_geral")
public class MusicaGeralBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Column(name = "comun_jamendo_megatrax", nullable = false)
    private Integer comunJamendoMegatrax;
    @Column(name = "codigo_interno", nullable = false)
    private String codigoInterno;
    @Column(name = "codigo_externo", nullable = false)
    private String codigoExterno;
    @Column(name = "velocidade", nullable = false)
    private Integer velocidade;
    @Column(name = "categoria_geral", nullable = false)
    private Integer categoriaGeral;
    @Column(name = "usuario", nullable = false)
    private Integer usuario;
    @Column(name = "gravadora", nullable = false)
    private Integer gravadora;
    @Column(name = "titulo", nullable = false, length = 255)
    private String titulo;
    @Column(name = "interprete", nullable = false)
    private String interprete;
    @Column(name = "tipo_interprete", nullable = false)
    private short tipoInterprete;
    @Column(name = "letra", nullable = false)
    private String letra;
    @Column(name = "bpm", nullable = false)
    private short bpm;
    @Column(name = "tempo_total", nullable = false, length = 30)
    private String tempoTotal;
    @Column(name = "ano_gravacao", nullable = false)
    private Integer anoGravacao;
    @Column(name = "afinidade1", nullable = false, length = 255)
    private String afinidade1;
    @Column(name = "afinidade2", nullable = false, length = 255)
    private String afinidade2;
    @Column(name = "afinidade3", nullable = false, length = 255)
    private String afinidade3;
    @Column(name = "afinidade4", nullable = false, length = 255)
    private String afinidade4;
    @Column(name = "arquivo", nullable = false, length = 255)
    private String arquivo;
    @Column(name = "ultima_importacao", nullable = false)
    private Boolean ultimaImportacao;
    @Temporal(TemporalType.DATE)
    @Column(name = "data_cadastro", nullable = false)
    private Date dataCadastro;

    public MusicaGeralBean() {
    }

    public MusicaGeralBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCategoriaGeral() {
        return categoriaGeral;
    }

    public void setCategoriaGeral(Integer categoriaGeral) {
        this.categoriaGeral = categoriaGeral;
    }

    public Integer getUsuario() {
        return usuario;
    }

    public void setUsuario(Integer usuario) {
        this.usuario = usuario;
    }

    public Integer getGravadora() {
        return gravadora;
    }

    public void setGravadora(Integer gravadora) {
        this.gravadora = gravadora;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
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

    public String getLetra() {
        return letra;
    }

    public void setLetra(String letra) {
        this.letra = letra;
    }

    public short getBpm() {
        return bpm;
    }

    public void setBpm(short bpm) {
        this.bpm = bpm;
    }

    public String getTempoTotal() {
        return tempoTotal;
    }

    public void setTempoTotal(String tempoTotal) {
        this.tempoTotal = tempoTotal;
    }

    public Integer getAnoGravacao() {
        return anoGravacao;
    }

    public void setAnoGravacao(Integer anoGravacao) {
        this.anoGravacao = anoGravacao;
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

    public String getArquivo() {
        return arquivo;
    }

    public void setArquivo(String arquivo) {
        this.arquivo = arquivo;
    }

    public Integer getComunJamendoMegatrax() {
        return comunJamendoMegatrax;
    }

    public void setComunJamendoMegatrax(Integer comunJamendoMegatrax) {
        this.comunJamendoMegatrax = comunJamendoMegatrax;
    }

    public String getCodigoInterno() {
        return codigoInterno;
    }

    public void setCodigoInterno(String codigoInterno) {
        this.codigoInterno = codigoInterno;
    }

    public String getCodigoExterno() {
        return codigoExterno;
    }

    public void setCodigoExterno(String codigoExterno) {
        this.codigoExterno = codigoExterno;
    }

    public Integer getVelocidade() {
        return velocidade;
    }

    public void setVelocidade(Integer velocidade) {
        this.velocidade = velocidade;
    }

    public Boolean getUltimaImportacao() {
        return ultimaImportacao;
    }

    public void setUltimaImportacao(Boolean ultimaImportacao) {
        this.ultimaImportacao = ultimaImportacao;
    }

    public Date getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }
}
