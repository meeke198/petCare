package com.petCare.service;

import java.util.List;

public interface GeneralService<T>{
    List<T> findAll();

    T findById(Long id);

    T findByName(String name);

    void remove(Long id);

    T save (T t) ;



}
