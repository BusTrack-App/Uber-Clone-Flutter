
import 'package:uber_clone/src/domain/repository/users_repository.dart';

class UpdateNotificationTokenUseCase {

  UsersRepository usersRepository;

  UpdateNotificationTokenUseCase(this.usersRepository);

  run(int id, String notificationToken) => usersRepository.updateNotificationToken(id, notificationToken);

}