import 'dart:io';

import 'package:uber_clone/src/domain/models/user.dart';
import 'package:uber_clone/src/domain/utils/resource.dart';

abstract class UsersRepository {

  Future<Resource<User>> update(int id, User user, File? file);
  Future<Resource<bool>> updateNotificationToken(int id, String token);

}