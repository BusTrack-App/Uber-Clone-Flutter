import 'package:injectable/injectable.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart';
import 'package:uber_clone/src/data/repository/auth_repository_impl.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/login_use_case.dart';

@module
abstract class AppModule {
  // @injectable
  // SharefPref get sharefPref => SharefPref();

  // @injectable
  // Socket get socket => io(
  //     'http://${ApiConfig.API_PROJECT_SOCKET}',
  //     OptionBuilder()
  //         .setTransports(['websocket']) // for Flutter or Dart VM
  //         .disableAutoConnect() // disable auto-connection
  //         .build());

  // @injectable
  // Future<String> get token async {
  //   String token = '';
  //   final userSession = await sharefPref.read('user');
  //   if (userSession != null) {
  //     AuthResponse authResponse = AuthResponse.fromJson(userSession);
  //     token = authResponse.token;
  //   }
  //   return token;
  // }

  @injectable
  AuthService get authService => AuthService();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository)
  );

  // @injectable
  // UsersService get usersService => UsersService(token);

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

  // @injectable
  // AuthRepository get authRepository =>
  //     AuthRepositoryImpl(authService, sharefPref);

  // @injectable
  // UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  // @injectable
  // SocketRepository get socketRepository => SocketRepositoryImpl(socket);

  // @injectable
  // ClientRequestsRepository get clientRequestsRepository =>
  //     ClientRequestsRepositoryImpl(clientRequestsService);

  // @injectable
  // GeolocatorRepository get geolocatorRepository => GeolocatorRepositoryImpl();

  // @injectable
  // DriverPositionRepository get driversPositionRepository =>
  //     DriversPositionRepositoryImpl(driversPositionService);

  // @injectable
  // DriverTripRequestsRepository get driverTripRequestsRepository =>
  //     DriverTripRequestsRepositoryImpl(driverTripRequestsService);

  // @injectable
  // DriverCarInfoRepository get driverCarInfoRepository =>
  //     DriverCarInfoRepositoryImpl(driverCarInfoService);

  // @injectable
  // AuthUseCases get authUseCases => AuthUseCases(
  //     login: LoginUseCase(authRepository),
  //     register: RegisterUseCase(authRepository),
  //     saveUserSession: SaveUserSessionUseCase(authRepository),
  //     getUserSession: GetUserSessionUseCase(authRepository),
  //     logout: LogoutUseCase(authRepository));

  // @injectable
  // UsersUseCases get usersUseCases => UsersUseCases(
  //     update: UpdateUserUseCase(usersRepository),
  //     updateNotificationToken: UpdateNotificationTokenUseCase(usersRepository)
  // );

  // @injectable
  // GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
  //     findPosition: FindPositionUseCase(geolocatorRepository),
  //     createMarker: CreateMarkerUseCase(geolocatorRepository),
  //     getMarker: GetMarkerUseCase(geolocatorRepository),
  //     getPlacemarkData: GetPlacemarkDataUseCase(geolocatorRepository),
  //     getPolyline: GetPolylineUseCase(geolocatorRepository),
  //     getPositionStream: GetPositionStreamUseCase(geolocatorRepository));

  // @injectable
  // SocketUseCases get socketUseCases => SocketUseCases(
  //     connect: ConnectSocketUseCase(socketRepository),
  //     disconnect: DisconnectSocketUseCase(socketRepository));

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
