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
@Table(name = "indice_reajuste_historico")
public class IndiceReajusteHistoricoBean extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column( name = "id" , nullable = false)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "indice_reajuste")
    private IndiceReajusteBean indiceReajuste;
    
    @ManyToOne
    @JoinColumn(name = "usuario")
    private UsuarioBean usuario;
    
    @Column( name = "texto" , nullable = false , length = 255)
    private String texto;
    
    @Temporal(TemporalType.TIMESTAMP)
    @Column( name = "data" , nullable = false , length = 255)
    private Date data;

    public IndiceReajusteHistoricoBean() {
    }

    public IndiceReajusteHistoricoBean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public IndiceReajusteBean getIndiceReajuste() {
        return indiceReajuste;
    }

    public void setIndiceReajuste(IndiceReajusteBean indiceReajuste) {
        this.indiceReajuste = indiceReajuste;
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }
}
