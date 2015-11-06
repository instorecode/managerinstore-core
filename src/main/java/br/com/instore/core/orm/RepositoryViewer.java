package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.AuditoriaBean;
import br.com.instore.core.orm.bean.AuditoriaDadosBean;
import br.com.instore.core.orm.bean.CategoriaGeralBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.io.Serializable;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    private Object tmp = null;

    public RepositoryViewer() {
        verifySession();
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

    public <T extends Bean> Integer save(T t) {
        Integer ret = 0;
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

                if (null != tmp && tmp.getClass().equals(t.getClass())) {
                    f.set(tmp, f.get(t));
                    t = (T) tmp;
                }

                Serializable ser = session.save(t);
                if (null != ser) {
                    ret = (Integer)ser;
                }
            } else {
                verifySession();
                auditar(usuario, t, (short) 2);

                if (null != tmp && tmp.getClass().equals(t.getClass())) {
                    f.set(tmp, f.get(t));
                    t = (T) tmp;
                }

                session.update(session.merge(t));
            }
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (null != tmp && tmp.getClass().equals(t.getClass())) {
                tmp = null;
            }
        }
        return ret;
    }

    public <T extends Bean> void delete(T t) {
        verifySession();
        session.delete(t);
        try {
            auditar(usuario, t, (short) 3);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public <T extends Bean> T marge(T t) {
        verifySession();
        return (T) session.merge(t);
    }

    public <T extends Bean> T marge(String string, T t) {
        verifySession();
        return (T) session.merge(string, t);
    }

    private <T extends Bean> void auditar(UsuarioBean usuario, T object, short tipo) throws Exception {
        if (null == usuario) {
            throw new Exception("Informe um usuario de auditoria");
        }

        if (!object.getClass().isAnnotationPresent(Auditor.class)) {
            return;
        }

        AuditoriaBean auditoria = new AuditoriaBean();
        auditoria.setAcao(tipo);
        auditoria.setEntidade("Módulo " + object.getClass().getSimpleName().replace("Bean", ""));
        auditoria.setUsuario(usuario);
        auditoria.setData(new Date());

        save(auditoria);
        diff(object, auditoria);
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

        T objTemp = null;

        try {
            objTemp = (T) novoObjeto.getClass().newInstance();
            for (Field field : clazz.getDeclaredFields()) {
                field.setAccessible(true);
                field.set(objTemp, field.get(novoObjeto));
            }
        } catch (InstantiationException e) {
            e.printStackTrace();
            return;
        } catch (IllegalAccessException e) {
            e.printStackTrace();
            return;
        } catch (SecurityException e) {
            e.printStackTrace();
            return;
        }

        if (fieldName != null) {
            try {
                Field f = clazz.getDeclaredField(fieldName);
                f.setAccessible(true);

                if (null != f.get(novoObjeto) && Integer.parseInt(f.get(novoObjeto).toString()) > 0 && auditoriaBean.getAcao() == 2) {
                    session.refresh(novoObjeto);
                }

                T antigo = null;

                if (null != f.get(novoObjeto)) {
                    antigo = find(novoObjeto.getClass(), Integer.parseInt(f.get(novoObjeto).toString()));
                }

                novoObjeto = objTemp;
                tmp = novoObjeto;

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

    public void clearAndClose() {
//        if (null != session && session.isOpen()) {
//            session.clear();
//            session.close();
//        }
    }
}
