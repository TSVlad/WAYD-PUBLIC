package ru.tsvlad.waydnotification.repository;

import org.springframework.data.repository.CrudRepository;
import ru.tsvlad.waydnotification.entity.UserEntity;

import java.util.List;

public interface UserRepository extends CrudRepository<UserEntity, String> {
    List<UserEntity> findAllByUserIdIn(List<String> ids);
}
