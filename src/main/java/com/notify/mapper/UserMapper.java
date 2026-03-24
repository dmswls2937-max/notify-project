package com.notify.mapper;

import com.notify.domain.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
    User findByEmail(@Param("email") String email);
    User findById(@Param("userId") Long userId);
    int insert(User user);
}
