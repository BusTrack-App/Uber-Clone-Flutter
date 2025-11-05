import 'dart:io';

import 'package:uber_clone/src/data/dataSource/remote/services/users_service.dart';
import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/repository/users_repository.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';


class UsersRepositoryImpl implements UsersRepository {

  UsersService usersService;

  UsersRepositoryImpl(this.usersService);

  @override
  Future<Resource<User>> update(int id, User user, File? file) {
    if (file == null) {
      return usersService.update(id, user);
    }
    return usersService.updateImage(id, user, file);
  }
  
  @override
  Future<Resource<bool>> updateNotificationToken(int id, String token) {
    return usersService.updateNotificationToken(id, token);
  }
  
}