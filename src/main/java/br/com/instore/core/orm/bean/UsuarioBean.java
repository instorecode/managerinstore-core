package br.com.instore.core.orm.bean;

import br.com.instore.core.orm.Bean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.util.Date;
import java.util.List;
import java.util.Set;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Auditor
@Entity
@Table(name = "usuario")
public class UsuarioBean extends Bean {

    @Id
    @Column(name = "idusuario", nullable = false)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer idusuario;
    @ManyToOne
    @JoinColumn(name = "idendereco", nullable = true)
    private EnderecoBean endereco;
    @Column(name = "data_cadastro", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date dataCadastro;
    @Column(name = "nome", nullable = false, length = 255)
    private String nome;
    @Column(name = "cpf", nullable = false, length = 14)
    private String cpf;
    @Column(name = "email", nullable = false, length = 255)
    private String email;
    @Column(name = "senha", nullable = false, length = 32)
    private String senha;
    
    @OneToMany
    @JoinTable(
                name = "usuario_empresa", 
                joinColumns = @JoinColumn(name = "idusuario"),
                inverseJoinColumns = @JoinColumn(name = "idempresa")
            )
    private List<ClienteBean> empresaBeanList;
    
    @OneToMany
    @JoinTable(
                name = "perfil_usuario", 
                joinColumns = @JoinColumn(name = "idusuario"),
                inverseJoinColumns = @JoinColumn(name = "idperfil")
            )
    private List<PerfilBean> perfilBeanList;

    public UsuarioBean() {
    }

    public UsuarioBean(Integer idusuario) {
        this.idusuario = idusuario;
    }

    public Integer getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Integer idusuario) {
        this.idusuario = idusuario;
    }

    public EnderecoBean getEndereco() {
        return endereco;
    }

    public void setEndereco(EnderecoBean endereco) {
        this.endereco = endereco;
    }

    public Date getDataCadastro() {
        return dataCadastro;
    }

    public void setDataCadastro(Date dataCadastro) {
        this.dataCadastro = dataCadastro;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public List<ClienteBean> getEmpresaBeanList() {
        return empresaBeanList;
    }

    public void setEmpresaBeanList(List<ClienteBean> empresaBeanList) {
        this.empresaBeanList = empresaBeanList;
    }

    public List<PerfilBean> getPerfilBeanList() {
        return perfilBeanList;
    }

    public void setPerfilBeanList(List<PerfilBean> perfilBeanList) {
        this.perfilBeanList = perfilBeanList;
    }
}
