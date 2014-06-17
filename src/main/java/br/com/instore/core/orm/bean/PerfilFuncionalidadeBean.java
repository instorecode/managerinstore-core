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

@Entity
@Table(name = "perfil_funcionalidade")
public class PerfilFuncionalidadeBean extends Bean {
    @Id
    @Column(name = "idperfil_funcionalidade", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idperfilFuncionalidade;
    
    @ManyToOne
    @JoinColumn(name = "idperfil" , nullable = false)
    private PerfilBean perfilBean;
    
    @ManyToOne
    @JoinColumn(name = "idfuncionalidade" , nullable = false)
    private FuncionalidadeBean funcionalidade;

    public PerfilFuncionalidadeBean() {
    }

    public PerfilFuncionalidadeBean(Integer idperfilFuncionalidade) {
        this.idperfilFuncionalidade = idperfilFuncionalidade;
    }

    public Integer getIdperfilFuncionalidade() {
        return idperfilFuncionalidade;
    }

    public void setIdperfilFuncionalidade(Integer idperfilFuncionalidade) {
        this.idperfilFuncionalidade = idperfilFuncionalidade;
    }

    public PerfilBean getPerfilBean() {
        return perfilBean;
    }

    public void setPerfilBean(PerfilBean perfilBean) {
        this.perfilBean = perfilBean;
    }

    public FuncionalidadeBean getFuncionalidade() {
        return funcionalidade;
    }

    public void setFuncionalidade(FuncionalidadeBean funcionalidade) {
        this.funcionalidade = funcionalidade;
    }
}
