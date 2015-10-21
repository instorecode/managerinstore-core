package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "excecao")
public class ExcecaoBean extends Bean{
    
    @Id
    @Column(name = "id", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    
    @Column(name = "mensagem", nullable = false)
    private String mensagem;
    
    @Column(name = "linha", nullable = false)
    private String linha;
    
    @Column(name = "codigo", nullable = false)
    private String codigo;
    
    @Column(name = "excecao_data", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date excecaoData;
    
    @Column(name = "excecao_arquivo", nullable = false)
    private String excecaoArquivo;
    
    @Column(name = "id_usuario", nullable = false)
    private String idUsuario;

    public ExcecaoBean(Integer id) {
        this.id = id;
    }

    public ExcecaoBean() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public String getLinha() {
        return linha;
    }

    public void setLinha(String linha) {
        this.linha = linha;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public Date getExcecaoData() {
        return excecaoData;
    }

    public void setExcecaoData(Date excecaoData) {
        this.excecaoData = excecaoData;
    }

    public String getExcecaoArquivo() {
        return excecaoArquivo;
    }

    public void setExcecaoArquivo(String excecaoArquivo) {
        this.excecaoArquivo = excecaoArquivo;
    }

    public String getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }
    
    
    
    
}
