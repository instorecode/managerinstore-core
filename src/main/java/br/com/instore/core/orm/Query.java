package br.com.instore.core.orm;

import br.com.instore.core.orm.bean.AuditoriaBean;
import br.com.instore.core.orm.bean.UsuarioBean;
import java.lang.reflect.Field;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

public class Query {

    private Boolean connectorAndOr = null;
    private boolean not = false;
    protected List<Criterion> criterionList = new ArrayList<Criterion>();
    protected List<Order> orderList = new ArrayList<Order>();
    protected Class<? extends Bean> clazz;
    protected Query q;
    private RepositoryViewer dao;
    private Criteria criteria;
    private String querySQL;

    public Query(Class<? extends Bean> clazz, RepositoryViewer dao) {
        criteria = dao.session.createCriteria(clazz);
        this.clazz = clazz;
        this.dao = dao;
    }

    public Query(String querySQL, RepositoryViewer dao) {
        this.querySQL = querySQL;
        this.dao = dao;
    }

    public <T extends Bean> T findOne() {
        T ret = null;
        if (criterionList.size() > 0) {
            for (Criterion criterion : criterionList) {
                criteria.add(criterion);
            }
        }

        criteria.setMaxResults(1);

        List resultSet = criteria.list();

        if (resultSet.size() > 0) {
            ret = (T) resultSet.get(0);
        }
        
        
        dao.clearAndClose();
        return ret;
    }

    public <T> T findAll() {
        if (criterionList.size() > 0) {
            for (Criterion criterion : criterionList) {
                criteria.add(criterion);
            }
        }

        if (orderList.size() > 0) {
            for (Order order : orderList) {
                criteria.addOrder(order);
            }
        }
        T ret = (T) criteria.list();
        dao.clearAndClose();
        return ret;
    }

    public Long count() {
        Long ret = 0l;
        if (criterionList.size() > 0) {
            for (Criterion criterion : criterionList) {
                criteria.add(criterion);
            }
        }
        Object object = criteria.setProjection(Projections.rowCount()).uniqueResult();
        if(null != object) {
            ret = new Long(object.toString());
        }
        
        dao.clearAndClose();
        return ret;
    }

    public <T> Query orderAsc(String column) {
        orderList.add(Order.asc(column));
        return this;
    }

    public <T> Query orderDesc(String column) {
        orderList.add(Order.desc(column));
        return this;
    }

    public <T> Query eq(String column, T t) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.eq(column, t)));
            } else {
                criterionList.add(Restrictions.eq(column, t));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.eq(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.eq(column, t)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.eq(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.eq(column, t)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query between(String column, T t1, T t2) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.between(column, t1, t2)));
            } else {
                criterionList.add(Restrictions.between(column, t1, t2));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.between(column, t1, t2))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.between(column, t1, t2)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.between(column, t1, t2))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.between(column, t1, t2)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query in(String column, T... t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.in(column, Arrays.asList(t))));
            } else {
                criterionList.add(Restrictions.in(column, Arrays.asList(t)));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.in(column, Arrays.asList(t)))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.in(column, Arrays.asList(t))));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.in(column, Arrays.asList(t)))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.in(column, Arrays.asList(t))));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query more(String column, T t) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.gt(column, t)));
            } else {
                criterionList.add(Restrictions.gt(column, t));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.gt(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.gt(column, t)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.gt(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.gt(column, t)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query moreEqual(String column, T t) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.ge(column, t)));
            } else {
                criterionList.add(Restrictions.ge(column, t));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.ge(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.ge(column, t)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.ge(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.ge(column, t)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query less(String column, T t) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.lt(column, t)));
            } else {
                criterionList.add(Restrictions.lt(column, t));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.lt(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.lt(column, t)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.lt(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.lt(column, t)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query lessEqual(String column, T t) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.le(column, t)));
            } else {
                criterionList.add(Restrictions.le(column, t));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.le(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.le(column, t)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.le(column, t))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.le(column, t)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query likeStart(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.like(column, t, MatchMode.START)));
            } else {
                criterionList.add(Restrictions.like(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.like(column, t, MatchMode.START))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.like(column, t, MatchMode.START)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.like(column, t, MatchMode.START))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.like(column, t, MatchMode.START)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query likeEnd(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.like(column, t, MatchMode.END)));
            } else {
                criterionList.add(Restrictions.like(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.like(column, t, MatchMode.END))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.like(column, t, MatchMode.END)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.like(column, t, MatchMode.END))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.like(column, t, MatchMode.END)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query likeAnyWhere(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.like(column, t, MatchMode.ANYWHERE)));
            } else {
                criterionList.add(Restrictions.like(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.like(column, t, MatchMode.ANYWHERE))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.like(column, t, MatchMode.ANYWHERE)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.like(column, t, MatchMode.ANYWHERE))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.like(column, t, MatchMode.ANYWHERE)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query ilikeStart(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.ilike(column, t, MatchMode.START)));
            } else {
                criterionList.add(Restrictions.like(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.START))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.START)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.START))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.START)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query ilikeEnd(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.ilike(column, t, MatchMode.END)));
            } else {
                criterionList.add(Restrictions.ilike(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.END))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.END)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.END))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.END)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query ilikeAnyWhere(String column, String t) {

        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.ilike(column, t, MatchMode.ANYWHERE)));
            } else {
                criterionList.add(Restrictions.ilike(column, t, MatchMode.ANYWHERE));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.ANYWHERE))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.ilike(column, t, MatchMode.ANYWHERE)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.ANYWHERE))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.ilike(column, t, MatchMode.ANYWHERE)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query isEmpty(String column) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.isEmpty(column)));
            } else {
                criterionList.add(Restrictions.isEmpty(column));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.isEmpty(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.isEmpty(column)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.isEmpty(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.isEmpty(column)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query isNotEmpty(String column) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.isNotEmpty(column)));
            } else {
                criterionList.add(Restrictions.isNotEmpty(column));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.isNotEmpty(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.isNotEmpty(column)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.isNotEmpty(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.isNotEmpty(column)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query isNull(String column) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.isNull(column)));
            } else {
                criterionList.add(Restrictions.isNull(column));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.isNull(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.isNull(column)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.isNull(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.isNull(column)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query isNotNull(String column) {
        if (connectorAndOr == null) {
            if (not) {
                criterionList.add(Restrictions.not(Restrictions.isNotNull(column)));
            } else {
                criterionList.add(Restrictions.isNotNull(column));
            }

        } else {
            if (criterionList.size() > 0) {
                Criterion r = criterionList.get(criterionList.size() - 1);
                if (connectorAndOr) {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.and(r, Restrictions.isNotNull(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.and(r, Restrictions.isNotNull(column)));
                    }

                } else {
                    if (not) {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.not(Restrictions.or(r, Restrictions.isNotNull(column))));
                    } else {
                        criterionList.remove(criterionList.size() - 1);
                        criterionList.add(Restrictions.or(r, Restrictions.isNotNull(column)));
                    }
                }
            }
        }

        connectorAndOr = null;
        not = false;
        return this;
    }

    public <T> Query limit(Integer limit) {
        criteria.setMaxResults(limit);
        return this;
    }

    public <T> Query limit(Integer begin, Integer end) {
        criteria.setFirstResult(begin);
        criteria.setMaxResults(end);
        return this;
    }

    public Query and() {
        connectorAndOr = true;
        return this;
    }

    public Query or() {
        connectorAndOr = false;
        return this;
    }

    public Query not() {
        not = true;
        return this;
    }

    public List executeSQL() {
        List obs = dao.session.createSQLQuery(querySQL).list();
        return obs;
    }

    public void executeSQL(Each object) {
        try {
            List<String> parts1 = Arrays.asList(querySQL.split("from"));
            String fieldsWithSeparator = parts1.get(0).replace("select", "").trim();
            List<String> fieldsWithAS = Arrays.asList(fieldsWithSeparator.split(","));

            List<String> fields = new ArrayList<String>();

            for (String fwas : fieldsWithAS) {
                if (fwas.contains(" as ")) {
                    fields.add(Arrays.asList(fwas.split(" as ")).get(1).toString());
                    continue;
                }

                if (fwas.contains(" ")) {
                    List<String> fs = Arrays.asList(fwas.split(" "));
                    if (fs.size() > 1) {
                        fields.add(fs.get(fs.size() - 1).toString().trim());
                    } else {
                        fields.add(fwas.trim());
                    }
                    continue;
                }

                if (!fwas.contains(" as ") && !fwas.contains(" ")) {
                    fields.add(fwas.trim().replace(" ", ""));
                    continue;
                }
            }

            List objectList = dao.session.createSQLQuery(querySQL).list();
            for (Object objectItem : objectList) {
                Object[] objectArray = (Object[]) objectItem;
                for (int i = 0; i < objectArray.length; i++) {
                    Object value = objectArray[i];

                    Field field = object.getClass().getDeclaredFields()[i];
                    field.setAccessible(true);
                    field.set(object, field.getType().cast(value));
                }
                object.each();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public <T> List<T> executeSQL(Class<?> klass) {
        try {
            List<String> parts1 = Arrays.asList(querySQL.split("from"));
            String fieldsWithSeparator = parts1.get(0).replace("select", "").trim();
            List<String> fieldsWithAS = Arrays.asList(fieldsWithSeparator.split(","));

            List<String> fields = new ArrayList<String>();

            for (String fwas : fieldsWithAS) {
                if (fwas.contains(" as ")) {
                    fields.add(Arrays.asList(fwas.split(" as ")).get(1).toString());
                    continue;
                }

                if (fwas.contains(" ")) {
                    List<String> fs = Arrays.asList(fwas.split(" "));
                    if (fs.size() > 1) {
                        fields.add(fs.get(fs.size() - 1).toString().trim());
                    } else {
                        fields.add(fwas.trim());
                    }
                    continue;
                }

                if (!fwas.contains(" as ") && !fwas.contains(" ")) {
                    fields.add(fwas.trim().replace(" ", ""));
                    continue;
                }
            }

            List objectList = dao.session.createSQLQuery(querySQL).list();
            List<T> list = new ArrayList<T>();

            for (Object objectItem : objectList) {
                Object[] objectArray = (Object[]) objectItem;

                T t = (T) klass.newInstance();

                for (int i = 0; i < objectArray.length; i++) {
                    Object value = objectArray[i];
                    String column = fields.get(i).toString().trim();

                    Field field = klass.getDeclaredField(column);
                    field.setAccessible(true);

                    field.set(t, field.getType().cast(value));
                }
                list.add(t);
            }

            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public void executeSQLCommand() throws DataValidatorException {
        AuditoriaBean auditoria = new AuditoriaBean();
        auditoria.setAcao((short) 4);
        auditoria.setEntidade("Script executado: " + querySQL);
        auditoria.setUsuario(dao.usuario);
        auditoria.setData(new Date());

        dao.save(auditoria);
        dao.session.createSQLQuery(querySQL).executeUpdate();
        dao.finalize();
    }
    
    public void executeSQLCommand2() throws DataValidatorException {
        dao.session.createSQLQuery(querySQL).executeUpdate();
        dao.finalize();
    }

    public Long executeSQLCount() {
        try {
            List<String> parts1 = Arrays.asList(querySQL.split("from"));
            String fieldsWithSeparator = parts1.get(0).replace("select", "").trim();
            List<String> fieldsWithAS = Arrays.asList(fieldsWithSeparator.split(","));

            List<String> fields = new ArrayList<String>();

            for (String fwas : fieldsWithAS) {
                if (fwas.contains(" as ")) {
                    fields.add(Arrays.asList(fwas.split(" as ")).get(1).toString());
                    continue;
                }

                if (fwas.contains(" ")) {
                    List<String> fs = Arrays.asList(fwas.split(" "));
                    if (fs.size() > 1) {
                        fields.add(fs.get(fs.size() - 1).toString().trim());
                    } else {
                        fields.add(fwas.trim());
                    }
                    continue;
                }

                if (!fwas.contains(" as ") && !fwas.contains(" ")) {
                    fields.add(fwas.trim().replace(" ", ""));
                    continue;
                }
            }

            List objectList = dao.session.createSQLQuery(querySQL).list();

            Long ret = 0L;

            for (Object objectItem : objectList) {
                BigInteger bi = (BigInteger) objectItem;
                ret = bi.longValue();
            }

            return ret;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
