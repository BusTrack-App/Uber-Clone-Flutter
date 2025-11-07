import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/data/dataSource/local/shared_pref.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/users_service.dart';
import 'package:uber_clone/src/data/repository/auth_repository_impl.dart';
import 'package:uber_clone/src/data/repository/geolocator_repository_impl.dart';
import 'package:uber_clone/src/data/repository/socket_repository_impl.dart';
import 'package:uber_clone/src/data/repository/users_repository_impl.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';
import 'package:uber_clone/src/domain/repository/socket_repository.dart';
import 'package:uber_clone/src/domain/repository/users_repository.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/get_user_session_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/login_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/logout_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/register_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/save_session_user_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/create_marker_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/find_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_marker_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_placemark_data_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_polyline_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/geolocator/get_position_stream_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/socket/connect_socket_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/socket/disconnect_socket_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/users/update_notification_token_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/users/update_user_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/users/user_use_case.dart';

@module
abstract class AppModule {
  
  @injectable
  SharedPref get sharefPref => SharedPref();

  @injectable
  Socket get socket => io(
      'http://${ApiConfig.API_PROJECT_SOCKET}',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .build());

  @injectable
  Future<String> get token async {
    String token = '';
    final userSession = await sharefPref.read('user');
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    return token;
  }

  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharefPref);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository)
  );

  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  @injectable
  UsersUseCases get usersUseCases => UsersUseCases(
      update: UpdateUserUseCase(usersRepository),
      updateNotificationToken: UpdateNotificationTokenUseCase(usersRepository)
  );

  @injectable
  UsersService get usersService => UsersService(token);

  // @injectable
  // DriversPositionService get driversPositionService =>
  //     DriversPositionService(token);

  // @injectable
  // ClientRequestsService get clientRequestsService =>
  //     ClientRequestsService(token);

  // @injectable
  // DriverTripRequestsService get driverTripRequestsService =>
  //     DriverTripRequestsService(token);

  // @injectable
  // DriverCarInfoService get driverCarInfoService => DriverCarInfoService(token);

  @injectable
  SocketRepository get socketRepository => SocketRepositoryImpl(socket);

  // @injectable
  // ClientRequestsRepository get clientRequestsRepository =>
  //     ClientRequestsRepositoryImpl(clientRequestsService);

  @injectable
  GeolocatorRepository get geolocatorRepository => GeolocatorRepositoryImpl();

  @injectable
  GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
      findPosition: FindPositionUseCase(geolocatorRepository),
      createMarker: CreateMarkerUseCase(geolocatorRepository),
      getMarker: GetMarkerUseCase(geolocatorRepository),
      getPlacemarkData: GetPlacemarkDataUseCase(geolocatorRepository),
      getPolyline: GetPolylineUseCase(geolocatorRepository),
      getPositionStream: GetPositionStreamUseCase(geolocatorRepository)
    );

  // @injectable
  // DriverPositionRepository get driversPositionRepository =>
  //     DriversPositionRepositoryImpl(driversPositionService);

  // @injectable
  // DriverTripRequestsRepository get driverTripRequestsRepository =>
  //     DriverTripRequestsRepositoryImpl(driverTripRequestsService);

  // @injectable
  // DriverCarInfoRepository get driverCarInfoRepository =>
  //     DriverCarInfoRepositoryImpl(driverCarInfoService);





  @injectable
  SocketUseCases get socketUseCases => SocketUseCases(
      connect: ConnectSocketUseCase(socketRepository),
      disconnect: DisconnectSocketUseCase(socketRepository));

  // @injectable
  // DriversPositionUseCases get driversPositionUseCases =>
  //     DriversPositionUseCases(
  //         createDriverPosition:
  //             CreateDriverPositionUseCase(driversPositionRepository),
  //         deleteDriverPosition:
  //             DeleteDriverPositionUseCase(driversPositionRepository),
  //         getDriverPosition:
  //             GetDriverPositionUseCase(driversPositionRepository));

  // @injectable
  // ClientRequestsUseCases get clientRequestsUseCases => ClientRequestsUseCases(
  //     createClientRequest: CreateClientRequestUseCase(clientRequestsRepository),
  //     getTimeAndDistance: GetTimeAndDistanceUseCase(clientRequestsRepository),
  //     getNearbyTripRequest:
  //         GetNearbyTripRequestUseCase(clientRequestsRepository),
  //     updateDriverAssigned:
  //         UpdateDriverAssignedUseCase(clientRequestsRepository),
  //     getByClientRequest: GetByClientRequestUseCase(clientRequestsRepository),
  //     updateStatusClientRequest:
  //         UpdateStatusClientRequestUseCase(clientRequestsRepository),
  //     updateClientRating: UpdateClientRatingUseCase(clientRequestsRepository),
  //     updateDriverRating: UpdateDriverRatingUseCase(clientRequestsRepository),
  //     getByClientAssigned: GetByClientAssignedUseCase(clientRequestsRepository),
  //     getByDriverAssigned:
  //         GetByDriverAssignedUseCase(clientRequestsRepository));

  // @injectable
  // DriverTripRequestUseCases get driverTripRequestUseCases =>
  //     DriverTripRequestUseCases(
  //         createDriverTripRequest:
  //             CreateDriverTripRequestUseCase(driverTripRequestsRepository),
  //         getDriverTripOffersByClientRequest:
  //             GetDriverTripOffersByClientRequestUseCase(
  //                 driverTripRequestsRepository));

  // @injectable
  // DriverCarInfoUseCases get driverCarInfoUseCases => DriverCarInfoUseCases(
  //     createDriverCarInfo: CreateDriverCarInfoUseCase(driverCarInfoRepository),
  //     getDriverCarInfo: GetDriverCarInfoUseCase(driverCarInfoRepository));
}
