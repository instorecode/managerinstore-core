package br.com.instore.dump.cliente;

import br.com.instore.core.orm.Bean;


public class ProdutoCliente extends Bean {
    private String identificadorDoProdutoCliente;
    private String identificadorDoProduto;
    private String identificadorDoCliente;

    public String getIdentificadorDoProdutoCliente() {
        return identificadorDoProdutoCliente;
    }

    public void setIdentificadorDoProdutoCliente(String identificadorDoProdutoCliente) {
        this.identificadorDoProdutoCliente = identificadorDoProdutoCliente;
    }

    public String getIdentificadorDoProduto() {
        return identificadorDoProduto;
    }

    public void setIdentificadorDoProduto(String identificadorDoProduto) {
        this.identificadorDoProduto = identificadorDoProduto;
    }

    public String getIdentificadorDoCliente() {
        return identificadorDoCliente;
    }

    public void setIdentificadorDoCliente(String identificadorDoCliente) {
        this.identificadorDoCliente = identificadorDoCliente;
    }
}
