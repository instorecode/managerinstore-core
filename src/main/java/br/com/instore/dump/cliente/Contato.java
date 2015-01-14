package br.com.instore.dump.cliente;

import br.com.instore.core.orm.Bean;

public class Contato extends Bean {
    private String identificadorDaMatriz;
    private String identificadorDaUnidade;
    private String nome;
    private String email;
    private String tel;
    private String setor;

    public String getIdentificadorDaMatriz() {
        return identificadorDaMatriz;
    }

    public void setIdentificadorDaMatriz(String identificadorDaMatriz) {
        this.identificadorDaMatriz = identificadorDaMatriz;
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

    public String getSetor() {
        return setor;
    }

    public void setSetor(String setor) {
        this.setor = setor;
    }

    public String getIdentificadorDaUnidade() {
        return identificadorDaUnidade;
    }

    public void setIdentificadorDaUnidade(String identificadorDaUnidade) {
        this.identificadorDaUnidade = identificadorDaUnidade;
    }
}
