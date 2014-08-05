package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Auditor
@Entity
@Table(name="bairro")
public class BairroBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "idbairro" , nullable = false)
    private Integer idbairro;
    
    @Column( name = "nome" , nullable = false , length = 255)
    private String nome;
    
    @Column( name = "rua" , nullable = false , length = 255)
    private String rua;
    
    @Column( name = "tipo" , nullable = false , length = 255)
    private String tipo;
    
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "idcidade" , nullable = false)
    private CidadeBean cidade;

    public BairroBean() {
    }

    public BairroBean(Integer idbairro) {
        this.idbairro = idbairro;
    }

    public Integer getIdbairro() {
        return idbairro;
    }

    public void setIdbairro(Integer idbairro) {
        this.idbairro = idbairro;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public CidadeBean getCidade() {
        return cidade;
    }

    public void setCidade(CidadeBean cidade) {
        this.cidade = cidade;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
