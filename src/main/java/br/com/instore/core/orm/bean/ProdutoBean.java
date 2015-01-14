package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

@Entity
@Table(name = "produto")
public class ProdutoBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    
    @Column(name = "nome", length = 255)
    private String nome;
    
    @ManyToOne
    @JoinColumn(name = "tipo_produto" ,nullable = false , insertable = false , updatable = false)
    private TipoProdutoBean tipoProduto;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public ProdutoBean() {
    }

    public ProdutoBean(Integer id) {
        this.id = id;
    }

    public TipoProdutoBean getTipoProduto() {
        return tipoProduto;
    }

    public void setTipoProduto(TipoProdutoBean tipoProduto) {
        this.tipoProduto = tipoProduto;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}