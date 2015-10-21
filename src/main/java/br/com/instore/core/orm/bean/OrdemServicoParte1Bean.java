
package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ordem_servico_parte1")
public class OrdemServicoParte1Bean  extends Bean {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;
    
    @Column(name = "cliente", nullable = false )
    private Integer cliente;
    
    @Column(name = "usuario", nullable = false )
    private Integer usuario;
    
    @Column(name = "data", nullable = false , length = 20)
    private String data;
    
    @Column(name = "nome", nullable = false , length = 255)
    private String nome;
    
    @Column(name = "quem_solicitou", nullable = false , length = 60000)
    private String quemSolicitou;
    
    @Column(name = "quem_solicitou_email", nullable = false , length = 60000)
    private String quemSolicitouEmail;
    
    @Column(name = "quando_solicitou", nullable = false , length = 10)
    private String quandoSolicitou;
    
    @Column(name = "data_max_distribuicao", nullable = false , length = 10)
    private String dataMaxDistribuicao;
    
    @Column(name = "tipo", nullable = false )
    private Integer tipo;

    public OrdemServicoParte1Bean() {
    }

    public OrdemServicoParte1Bean(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCliente() {
        return cliente;
    }

    public void setCliente(Integer cliente) {
        this.cliente = cliente;
    }

    public Integer getUsuario() {
        return usuario;
    }

    public void setUsuario(Integer usuario) {
        this.usuario = usuario;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getQuemSolicitou() {
        return quemSolicitou;
    }

    public void setQuemSolicitou(String quemSolicitou) {
        this.quemSolicitou = quemSolicitou;
    }

    public String getQuandoSolicitou() {
        return quandoSolicitou;
    }

    public void setQuandoSolicitou(String quandoSolicitou) {
        this.quandoSolicitou = quandoSolicitou;
    }

    public String getDataMaxDistribuicao() {
        return dataMaxDistribuicao;
    }

    public void setDataMaxDistribuicao(String dataMaxDistribuicao) {
        this.dataMaxDistribuicao = dataMaxDistribuicao;
    }

    public Integer getTipo() {
        return tipo;
    }

    public void setTipo(Integer tipo) {
        this.tipo = tipo;
    }    

    public String getQuemSolicitouEmail() {
        return quemSolicitouEmail;
    }

    public void setQuemSolicitouEmail(String quemSolicitouEmail) {
        this.quemSolicitouEmail = quemSolicitouEmail;
    }
}


