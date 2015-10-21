package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.Auditor;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Auditor
@Entity
@Table(name = "perfil")
public class PerfilBean extends Bean {
    @Id
    @Column(name = "idperfil", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idperfil;
    
    
    @Column(name = "nome", nullable = false)
    private String nome;
    
    @Column(name = "icone", nullable = false)
    private String icone;
    
    @OneToMany()
    @JoinTable(
                name = "perfil_funcionalidade", 
                joinColumns = @JoinColumn(name = "idperfil"),
                inverseJoinColumns = @JoinColumn(name = "idfuncionalidade")
            )
    private List<FuncionalidadeBean> funcionalidadeBeanList;

    public List<FuncionalidadeBean> getFuncionalidadeBeanList() {
        return funcionalidadeBeanList;
    }

    public void setFuncionalidadeBeanList(List<FuncionalidadeBean> funcionalidadeBeanList) {
        this.funcionalidadeBeanList = funcionalidadeBeanList;
    }
    
    public PerfilBean() {
    }

    public PerfilBean(Integer idperfil) {
        this.idperfil = idperfil;
    }

    public Integer getIdperfil() {
        return idperfil;
    }

    public void setIdperfil(Integer idperfil) {
        this.idperfil = idperfil;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getIcone() {
        return icone;
    }

    public void setIcone(String icone) {
        this.icone = icone;
    }
}
