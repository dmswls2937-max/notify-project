package com.notify.common;

import java.io.Serializable;

public class LoginUser implements Serializable {

    private Long userId;
    private String name;
    private String email;

    public LoginUser() {
    }

    public LoginUser(Long userId, String name, String email) {
        this.userId = userId;
        this.name = name;
        this.email = email;
    }

    public Long getUserId() {
        return userId;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }
}