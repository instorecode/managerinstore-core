package br.com.instore.dump.cliente;

import br.com.instore.core.orm.Bean;


public class AcessoRemoto extends Bean {
    private String identificadorDoTipoAcesseo;
    private String identificadorDaUnidade;
    private String servidor;
    private String usuario;
    private String senha;
    private String porta;

    public String getIdentificadorDoTipoAcesseo() {
        return identificadorDoTipoAcesseo;
    }

    public void setIdentificadorDoTipoAcesseo(String identificadorDoTipoAcesseo) {
        this.identificadorDoTipoAcesseo = identificadorDoTipoAcesseo;
    }

    public String getIdentificadorDaUnidade() {
        return identificadorDaUnidade;
    }

    public void setIdentificadorDaUnidade(String identificadorDaUnidade) {
        this.identificadorDaUnidade = identificadorDaUnidade;
    }

    public String getServidor() {
        return servidor;
    }

    public void setServidor(String servidor) {
        this.servidor = servidor;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getPorta() {
        return porta;
    }

    public void setPorta(String porta) {
        this.porta = porta;
    }
}
