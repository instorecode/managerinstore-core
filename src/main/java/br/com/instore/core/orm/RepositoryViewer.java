package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.AuditoriaBean;
import br.com.instore.core.orm.bean.AuditoriaDadosBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import br.com.instore.core.orm.bean.annotation.Auditor;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import org.hibernate.ResourceClosedException;
import org.hibernate.Session;
import org.hibernate.TransactionException;
import org.hibernate.criterion.Restrictions;

public class RepositoryViewer {

    protected Session session;
    private Query query;
    protected UsuarioBean usuario;
    
    public RepositoryViewer() {
        
    }

    public RepositoryViewer(Session session) {
        this.session = session;
    }

    public Session getSession() {
        return session;
    }

    public void setSession(Session session) {
        this.session = session;
    }

    protected void verifySession() {
        try {
            if (session == null) {
                session = SessionFactoryUtils.getInstance().session();
                session.beginTransaction();
                SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy.hh.mm.ss");
                System.out.println("SESSION-OPEN-INSTORE-" + sdf.format(new Date()));
            } else {
                if (!session.isOpen() || !session.isConnected()) {
                    session = session.getSessionFactory().openSession();
                    session.beginTransaction();
                    SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy.hh.mm.ss");
                    System.out.println("SESSION-REOPEN-INSTORE-" + sdf.format(new Date()));
                }
            }
        } catch (TransactionException e) {
            if (null != session && session.isOpen()) {
                session.clear();
                session.close();
            }
            verifySession();
        } catch (ResourceClosedException e) {
            if (null != session && session.isOpen()) {
                session.clear();
                session.close();
            }
            verifySession();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void finalize() {
        if (session != null && session.isOpen()) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy.hh.mm.ss");
            System.out.println("SESSION-CLOSE-INSTORE-" + sdf.format(new Date()));
            try {
                if (session.getTransaction().isActive() && !session.getTransaction().wasCommitted()) {
                    session.getTransaction().commit();
                }
            } catch (Exception e) {
                e.printStackTrace();

                if (session.getTransaction().isActive() && !session.getTransaction().wasRolledBack()) {
                    session.getTransaction().rollback();
                }
            } finally {
                session.flush();
                session.clear();
                session.close();
            }
        }
        System.gc();
    }

    public <T extends Bean> T find(Class<? extends Bean> clazz, Integer id) {
        String column = null;
        for (Field f : clazz.getDeclaredFields()) {
            if (f.isAnnotationPresent(Id.class)) {
                column = f.getName();
            }
        }

        if (column == null) {
            return null;
        }

        verifySession();

        List objects = session.createCriteria(clazz).add(Restrictions.eq(column, id)).list();

        if (objects.size() <= 0) {
            return null;
        }

        return (T) clazz.cast(objects.get(0));
    }

    public Query query(Class<? extends Bean> clazz) {
        verifySession();
        query = new Query(clazz, this);
        return query;
    }

    public Query query(String querySQL) {
        verifySession();
        query = new Query(querySQL, this);
        return query;
    }

    public <T extends Bean> void save(T t) {
        try {
            Class<?> clazz = t.getClass();

            String fieldName = null;
            for (Field field : clazz.getDeclaredFields()) {
                if (field.isAnnotationPresent(Id.class)) {
                    fieldName = field.getName();
                    break;
                }
            }

            Field f = clazz.getDeclaredField(fieldName);
            f.setAccessible(true);

            if (null == f.get(t)) {
                verifySession();
                auditar(usuario, t, (short) 1);
                session.save(t);
            } else {
                verifySession();
                auditar(usuario, t, (short) 2);
                session.update(t);
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public <T extends Bean> void save2(T t) {
        try {
            Class<?> clazz = t.getClass();

            String fieldName = null;
            for (Field field : clazz.getDeclaredFields()) {
                if (field.isAnnotationPresent(Id.class)) {
                    fieldName = field.getName();
                    break;
                }
            }

            Field f = clazz.getDeclaredField(fieldName);
            f.setAccessible(true);

            if (null == f.get(t)) {
                verifySession();
                session.save(t);
            } else {
                verifySession();
                session.update(t);
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public <T extends Bean> void delete(T t) {
        verifySession();
        session.delete(t);
        auditar(usuario, t, (short) 3);
    }

    public <T extends Bean> T marge(T t) {
        verifySession();
        return (T) session.merge(t);
    }

    public <T extends Bean> T marge(String string, T t) {
        verifySession();
        return (T) session.merge(string, t);
    }

    private <T extends Bean> void auditar(UsuarioBean usuario, T object, short tipo) {

        if (!object.getClass().isAnnotationPresent(Auditor.class)) {
            return;
        }

        AuditoriaBean auditoria = new AuditoriaBean();
        auditoria.setAcao(tipo);
        auditoria.setEntidade("Módulo " + object.getClass().getSimpleName().replace("Bean", ""));
        auditoria.setUsuario(usuario);
        auditoria.setData(new Date());

        save(auditoria);

        // CREATE
        if (tipo == 1) {
            diff(object, auditoria);
        }

        // UPDATE
        if (tipo == 2) {
            diff(object, auditoria);
        }
    }

    private <T extends Bean> void diff(T novoObjeto, AuditoriaBean auditoriaBean) {
        Class<?> clazz = novoObjeto.getClass();

        if (!clazz.isAnnotationPresent(Auditor.class)) {
            return;
        }

        String fieldName = null;
        for (Field field : clazz.getDeclaredFields()) {
            if (field.isAnnotationPresent(Id.class)) {
                fieldName = field.getName();
                break;
            }
        }

        if (fieldName != null) {
            try {
                Field f = clazz.getDeclaredField(fieldName);
                f.setAccessible(true);

                T antigo = null;

                if (null != f.get(novoObjeto)) {
                    antigo = find(novoObjeto.getClass(), Integer.parseInt(f.get(novoObjeto).toString()));
                }


                if (null != antigo) {
                    for (Field field : clazz.getDeclaredFields()) {

                        if (field.isAnnotationPresent(JoinTable.class) || field.isAnnotationPresent(JoinColumn.class)) {
                            continue;
                        }

                        field.setAccessible(true);
                        Field field2 = novoObjeto.getClass().getDeclaredField(field.getName());
                        field2.setAccessible(true);

                        AuditoriaDadosBean auditoriaDadosBean = new AuditoriaDadosBean();
                        auditoriaDadosBean.setColuna(field.getName());
                        auditoriaDadosBean.setAuditoria(auditoriaBean);

                        if (field.getType().toString().contains("br.com.instore.core.orm.bean.")) {
                            if (null != field2.get(novoObjeto)) {
                                diff((T) field2.get(novoObjeto), auditoriaBean);
                            }
                        } else {
                            if (Bean.class != field.getClass().getSuperclass()) {
                                if (null == field.get(antigo)) {
                                    auditoriaDadosBean.setValorAtual("em branco");
                                } else {
                                    auditoriaDadosBean.setValorAtual((String) field.get(antigo).toString());
                                }

                                if (null == field2.get(novoObjeto)) {
                                    auditoriaDadosBean.setValorNovo("em branco");
                                } else {
                                    auditoriaDadosBean.setValorNovo((String) field2.get(novoObjeto).toString());
                                }
                            }
                            save(auditoriaDadosBean);
                        }
                    }
                } else {
                    for (Field field : clazz.getDeclaredFields()) {

                        if (field.isAnnotationPresent(JoinTable.class) || field.isAnnotationPresent(JoinColumn.class)) {
                            continue;
                        }

                        field.setAccessible(true);
                        Field field2 = novoObjeto.getClass().getDeclaredField(field.getName());
                        field2.setAccessible(true);

                        AuditoriaDadosBean auditoriaDadosBean = new AuditoriaDadosBean();
                        auditoriaDadosBean.setColuna(field.getName());
                        auditoriaDadosBean.setAuditoria(auditoriaBean);

                        if (field.getType().toString().contains("br.com.instore.core.orm.bean.")) {
                            if (null != field2.get(novoObjeto)) {
                                diff((T) field2.get(novoObjeto), auditoriaBean);
                            }
                        } else {
                            if (Bean.class != field.getClass().getSuperclass()) {
                                auditoriaDadosBean.setValorAtual("");
                                if (null == field2.get(novoObjeto)) {
                                    auditoriaDadosBean.setValorNovo("em branco");
                                } else {
                                    auditoriaDadosBean.setValorNovo((String) field2.get(novoObjeto).toString());
                                }
                            }
                            save(auditoriaDadosBean);
                        }
                    }
                }
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            } catch (SecurityException e) {
                e.printStackTrace();
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }

    public UsuarioBean getUsuario() {
        return usuario;
    }

    public void setUsuario(UsuarioBean usuario) {
        this.usuario = usuario;
    }

    public static void main(String[] args) {
        RepositoryViewer rv = new RepositoryViewer();
        String q = "";
        q = "select \n"
                + "    count(*) as size\n"
                + "from\n"
                + "    perfil_funcionalidade\n"
                + "left join perfil_usuario using(idperfil)\n"
                + "inner join funcionalidade using(idfuncionalidade)\n"
                + "where mapping_id = '/usuario' and idusuario = " + 1 + " \n group by idfuncionalidade";
        System.out.println(rv.query(q).executeSQLCount());;
    }

    public void clearAndClose() {
//        if (null != session && session.isOpen()) {
//            session.clear();
//            session.close();
//        }
    }
}
