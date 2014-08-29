
import br.com.instore.core.orm.DataValidatorException;
import br.com.instore.core.orm.RepositoryViewer;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Main {
    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        try {
            rv.query(" CALL SP_SINCRONIZACAO_MUSICA_GERAL "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); "
                    + " CALL SP_SINCRONIZACAO_MUSICA_GERAL(1,0,'J000394.wav','',1,'00:00',2014,'','','','','smb://192.168.1.249/Clientes/audiostore/teste_alex/microsoft/musicas/mp3_1/J000394.wav/'); ").executeSQLCommand2();
            rv.finalize();
        } catch (DataValidatorException e) {
            e.printStackTrace();
        }
    }
}
