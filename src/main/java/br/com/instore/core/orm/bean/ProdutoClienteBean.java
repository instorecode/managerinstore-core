package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

@Entity
@Table(name = "produto_cliente")
public class ProdutoClienteBean extends Bean {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    
    @ManyToOne
    @JoinColumn(name = "produto", nullable = false)
    private ProdutoBean produto;
    
    @ManyToOne
    @JoinColumn(name = "cliente", nullable = false)
    private ClienteBean cliente;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public ProdutoClienteBean() {
    }

    public ProdutoClienteBean(Integer id) {
        this.id = id;
    }

    public ClienteBean getCliente() {
        return cliente;
    }

    public ProdutoBean getProduto() {
        return produto;
    }

    public void setCliente(ClienteBean cliente) {
        this.cliente = cliente;
    }

    public void setProduto(ProdutoBean produto) {
        this.produto = produto;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
    }
}