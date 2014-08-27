
import br.com.instore.core.orm.RepositoryViewer;
import br.com.instore.core.orm.bean.MusicaGeralBean;
import java.util.ArrayList;
import java.util.List;

public class Main {

    public static class Test {
        Integer id;
        String param_a;
        String param_b;
        String param_c;
    }

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        List<Test> tests = rv.query("select \n"
                + "    mg.id as id,\n"
                + "	'param_a' as param_a,\n"
                + "	'param_b' as param_b,\n"
                + "	'param_c' as param_c\n"
                + "from\n"
                + "    categoria_musica_geral as cmg\n"
                + "inner join categoria_geral as cg on cg.id = cmg.categoria\n"
                + "inner join musica_geral as mg on mg.id = cmg.musica\n"
                + "where cg.nome like  '%po%'").executeSQL(Test.class);
        
        List<Integer> integerList = new ArrayList<Integer>();
        
        for (Test test : tests) {
            integerList.add(test.id);
        }
        
        System.out.println(rv.query(MusicaGeralBean.class).in("id", integerList.toArray( new Integer[integerList.size()])).findAll());
    }
}
