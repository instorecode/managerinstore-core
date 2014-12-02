package br.com.instore.core.orm;

import java.util.HashMap;
import java.util.LinkedHashMap;

public class Main {

    public static void main(String[] args) throws DataValidatorException {
        LinkedHashMap<Integer , Integer> regras = new LinkedHashMap<Integer, Integer>();
        regras.put(0, 5);
        regras.put(6, 30);
        regras.put(35, 43);
        regras.put(52, 60);
        regras.put(59, 60);
        
        String categoria = "  999             PREVISAO DO TEMPO01/01/0131/12/50200:00:00";
        for (Integer pos : regras.keySet()) {
            System.out.println(categoria.substring(pos, regras.get(pos)));
        }
        
    }
}
