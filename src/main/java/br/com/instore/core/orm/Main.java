
package br.com.instore.core.orm;


public class Main {
   private RepositoryViewer rv;
   
    public static void main(String[] args) {
        new Main().excluir();
    }
    
    public void excluir() {
        System.out.println(rv);
    }

    public RepositoryViewer getRv() {
        if(null==rv) {
            rv = new RepositoryViewer();
        }
        return rv;
    }

    public void setRv(RepositoryViewer rv) {
        this.rv = rv;
    }
    
    
}
