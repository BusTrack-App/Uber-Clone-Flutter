
import 'package:uber_clone/src/domain/use_cases/users/update_notification_token_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/users/update_user_use_case.dart';

class UsersUseCases {

  UpdateUserUseCase update;
  UpdateNotificationTokenUseCase updateNotificationToken;

  UsersUseCases({
    required this.update,
    required this.updateNotificationToken,
  });

}