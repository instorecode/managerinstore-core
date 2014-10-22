package br.com.instore.dump.categoria;

public class Dump {
//    static RepositoryViewer rv = new RepositoryViewer();
//    public static void main(String[] args) {
//        lerDiretorio();
//    }
//
//    public static void lerDiretorio() {
//
//        try {
//            
//            SmbFile diretorioRoot = new SmbFile("smb://192.168.1.249/Clientes/audiostore/migracao/", new NtlmPasswordAuthentication("", "admin", "q1a2s3"));
//            List<SmbFile> diretorioLista = new ArrayList<SmbFile>();
//
//            if (diretorioRoot.exists() && diretorioRoot.listFiles().length <= 0) {
//                List<ClienteBean> list = rv.query(ClienteBean.class).eq("matriz", true).eq("parente", 0).findAll();
//
//                for (ClienteBean bean : list) {
//                    String nome = bean.getNome();
//                    nome = bean.getIdcliente().toString().concat("___").concat(StringUtils.deleteWhitespace(nome.replaceAll("[^\\p{Print}]", "_")).toUpperCase());
//
//                    SmbFile smbFile = new SmbFile("smb://192.168.1.249/Clientes/audiostore/migracao/" + nome + "/", new NtlmPasswordAuthentication("", "admin", "q1a2s3"));
//
//                    if (!smbFile.exists()) {
//                        smbFile.mkdirs();
//                    } else {
//                        diretorioLista.add(smbFile);
//                    }
//                }
//            } else {
//                for (SmbFile diretorio : diretorioRoot.listFiles()) {
//                    diretorioLista.add(diretorio);
//                }
//            }
//
//            for (SmbFile diretorio : diretorioLista) {
//                for (SmbFile file : diretorio.listFiles()) {
//                    if (file.isFile()) {
//                        if (file.getName().endsWith(".DB") || file.getName().endsWith(".db")) {
//                            lerArquivoParadox(file);
//                        }
//                    }
//                }
//            }
//
//        } catch (MalformedURLException e) {
//            e.printStackTrace();
//        } catch (SmbException e) {
//            e.printStackTrace();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//    
//    public static ClienteBean clienteByDiretorio(SmbFile file) {
//        String [] parts = file.getParent().split("/");
//        if(parts.length > 0) {
//            String [] nomeComposto = parts[parts.length-1].split("__");
//            if(nomeComposto.length > 0) {
//                return rv.find(ClienteBean.class, Integer.parseInt(nomeComposto[0].trim()));                
//            }
//        }
//        return null;
//    }
//    
//    public static void lerArquivoParadox(SmbFile file) {
//        ClienteBean cliente = clienteByDiretorio(file);
//        if (null == cliente) {
//            return;
//        }
//        
//        String url = "jdbc:paradox:smb://admin:q1a2s3@".concat(file.getParent().replace("smb://", ""));
//        
//        try {
//            Class.forName("com.hxtt.sql.paradox.ParadoxDriver").newInstance();
//            Connection con = DriverManager.getConnection(url, "admin", "q1a2s3");
//            String sql = "select * from categoria";
//
//            Statement stmt = con.createStatement();
//            stmt.setFetchSize(10);
//
//            ResultSet rs = stmt.executeQuery(sql);
//
//            ResultSetMetaData resultSetMetaData = rs.getMetaData();
//            int iNumCols = resultSetMetaData.getColumnCount();
//
//            while (rs.next()) {
//                AudiostoreCategoriaBean categoria = new AudiostoreCategoriaBean();
//                categoria.setCliente(cliente);
//                for (int i = 1; i <= iNumCols; i++) {
//                    
//                    if("Codigo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        String value = rs.getString(i);
//                        categoria.setCodInterno((value.length() < 3 ? (value.length() == 1 ? "00"+value: (value.length() == 2 ? "0"+value: value)) : value ));
//                    }
//                    
//                    if("Categoria".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        String value = rs.getString(i);
//                        categoria.setCategoria(value);
//                    }
//                    
//                    if("DataInicio".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        categoria.setDataInicio(rs.getDate(i));
//                    }
//                    
//                    if("DataFinal".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        categoria.setDataFinal(rs.getDate(i));
//                    }
//                    if("Tipo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        categoria.setTipo(rs.getShort(i));
//                    }
//                    if("Tempo".equals(resultSetMetaData.getColumnLabel(i).trim())) {
//                        categoria.setTempo(rs.getDate(i));
//                    }
//                }
//                rv.save2(categoria);
//            }
//
//            rs.close();
//
//            con.close();
//            rv.finalize();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//    public static void incluirCategoria() {
//    }
}
