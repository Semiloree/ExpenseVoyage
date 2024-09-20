package com.example.techwizexpensevoyageproject.Dao;

import com.example.techwizexpensevoyageproject.model.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

public class UserDao {
    @PersistenceContext
    private EntityManager em;

    public void registerUser(User user) {
        em.persist(user);
    }

    public User findByEmail(String email) {
        TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
        query.setParameter("email", email);
        return query.getSingleResult();
    }
}