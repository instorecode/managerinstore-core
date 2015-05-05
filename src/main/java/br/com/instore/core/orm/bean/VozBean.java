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
@Table(name = "voz")
public class VozBean extends Bean {
    @Id
    @Column(name = "idvoz", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idvoz;    
    
    @Column(name = "idcliente", nullable = false)
    private Integer idcliente;
    
    @Column(name = "genero", nullable = false)
    private boolean genero;
    
    @Column(name = "tipo", nullable = false)
    private short tipo;
    
    @Column(name = "nome", nullable = false , length = 255)
    private String nome;
    
    @Column(name = "email", nullable = false  , length = 255)
    private String email;
    
    @Column(name = "tel", nullable = false , length = 20)
    private String tel;

    public VozBean() {
    }

    public VozBean(Integer idvoz) {
        this.idvoz = idvoz;
    }

    public Integer getIdvoz() {
        return idvoz;
    }

    public void setIdvoz(Integer idvoz) {
        this.idvoz = idvoz;
    }

    public Integer getIdcliente() {
        return idcliente;
    }

    public void setIdcliente(Integer idcliente) {
        this.idcliente = idcliente;
    }

    public boolean isGenero() {
        return genero;
    }

    public void setGenero(boolean genero) {
        this.genero = genero;
    }

    public short getTipo() {
        return tipo;
    }

    public void setTipo(short tipo) {
        this.tipo = tipo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}
