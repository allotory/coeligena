package com.coeligena.dao.impl;

import com.coeligena.dao.FeedsDAO;
import com.coeligena.model.FeedsDO;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;

/**
 * <p>
 *     动态信息持久化
 * </p>
 * Created by Ellery on 2018/5/20.
 */
@Repository
public class FeedsDAOImpl implements FeedsDAO {

    @Resource
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * 添加动态
     * @param feedsDO 动态
     */
    @Override
    public void addFeeds(FeedsDO feedsDO) {
        this.getSession().save(feedsDO);
    }
}