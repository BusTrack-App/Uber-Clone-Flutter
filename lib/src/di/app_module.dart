import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:uber_clone/src/data/api/api_config.dart';
import 'package:uber_clone/src/data/dataSource/local/shared_pref.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/client_request_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/driver_car_info_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/driver_position_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/driver_trip_request_service.dart';
import 'package:uber_clone/src/data/dataSource/remote/services/users_service.dart';
import 'package:uber_clone/src/data/repository/auth_repository_impl.dart';
import 'package:uber_clone/src/data/repository/client_request_repository_impl.dart';
import 'package:uber_clone/src/data/repository/driver_car_info_repository_impl.dart';
import 'package:uber_clone/src/data/repository/driver_trip_request_repository_impl.dart';
import 'package:uber_clone/src/data/repository/drivers_position_repository_impl.dart';
import 'package:uber_clone/src/data/repository/geolocator_repository_impl.dart';
import 'package:uber_clone/src/data/repository/socket_repository_impl.dart';
import 'package:uber_clone/src/data/repository/users_repository_impl.dart';
import 'package:uber_clone/src/domain/models/auth_response.dart';
import 'package:uber_clone/src/domain/repository/auth_repository.dart';
import 'package:uber_clone/src/domain/repository/client_request_repository.dart';
import 'package:uber_clone/src/domain/repository/driver_car_info_repository.dart';
import 'package:uber_clone/src/domain/repository/driver_trip_request_repository.dart';
import 'package:uber_clone/src/domain/repository/drivers_position_repository.dart';
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart';
import 'package:uber_clone/src/domain/repository/socket_repository.dart';
import 'package:uber_clone/src/domain/repository/users_repository.dart';
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/get_user_session_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/login_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/logout_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/register_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/auth/save_session_user_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/client_requests_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/create_client_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_nearby_trip_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/get_time_and_distance_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/client-requests/update_driver_assigned_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/driver_car_info_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/create_driver_car_info_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-car-info/get_driver_car_info_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/create_driver_trip_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/driver_trip_request_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/driver-trip-request/get_driver_trip_offers_by_client_request_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/create_driver_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/delete_driver_position_use_case.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/drivers_position_use_cases.dart';
import 'package:uber_clone/src/domain/use_cases/drivers-position/get_driver_position_use_case.dart';
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
  // ===================================================================
  // ====================== SHARED PREFERENCES =========================
  // ===================================================================
  @injectable
  SharedPref get sharefPref => SharedPref();

  // ===================================================================
  // =========================== SOCKET.IO =============================
  // ===================================================================
  @injectable
  Socket get socket => io(
    'http://${ApiConfig.API_PROJECT_SOCKET}',
    OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .build(),
  );

  // Repository
  @injectable
  SocketRepository get socketRepository => SocketRepositoryImpl(socket);

  // Use Cases
  @injectable
  SocketUseCases get socketUseCases => SocketUseCases(
    connect: ConnectSocketUseCase(socketRepository),
    disconnect: DisconnectSocketUseCase(socketRepository),
  );


  // ===================================================================
  // =========================== TOKEN =================================
  // ===================================================================
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

  // ===================================================================
  // =========================== AUTH ===================================
  // ===================================================================
  // Service
  @injectable
  AuthService get authService => AuthService();

  // Repository
  @injectable
  AuthRepository get authRepository =>
      AuthRepositoryImpl(authService, sharefPref);

  // Use Cases
  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
  );

  // ===================================================================
  // =========================== USERS ==================================
  // ===================================================================
  // Service
  @injectable
  UsersService get usersService => UsersService(token);

  // Repository
  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  // Use Cases
  @injectable
  UsersUseCases get usersUseCases => UsersUseCases(
    update: UpdateUserUseCase(usersRepository),
    updateNotificationToken: UpdateNotificationTokenUseCase(usersRepository),
  );

  // ===================================================================
  // ====================== DRIVERS POSITION ===========================
  // ===================================================================
  // Service
  @injectable
  DriversPositionService get driversPositionService =>
      DriversPositionService(token);

  // Repository
  @injectable
  DriverPositionRepository get driversPositionRepository =>
      DriversPositionRepositoryImpl(driversPositionService);

  // Use Cases
  @injectable
  DriversPositionUseCases get driversPositionUseCases =>
      DriversPositionUseCases(
        createDriverPosition: CreateDriverPositionUseCase(driversPositionRepository),
        deleteDriverPosition: DeleteDriverPositionUseCase(driversPositionRepository),
        getDriverPosition: GetDriverPositionUseCase(driversPositionRepository)
      );

  // ===================================================================
  // ====================== CLIENT REQUESTS ============================
  // ===================================================================
  // Service
  @injectable
  ClientRequestsService get clientRequestsService =>
      ClientRequestsService(token);

  // Repository
  @injectable
  ClientRequestsRepository get clientRequestsRepository =>
      ClientRequestsRepositoryImpl(clientRequestsService);

  // Use Cases
  @injectable
  ClientRequestsUseCases get clientRequestsUseCases => ClientRequestsUseCases(
    createClientRequest: CreateClientRequestUseCase(clientRequestsRepository),
    getTimeAndDistance: GetTimeAndDistanceUseCase(clientRequestsRepository),
    getNearbyTripRequest: GetNearbyTripRequestUseCase(clientRequestsRepository),
    updateDriverAssigned: UpdateDriverAssignedUseCase(clientRequestsRepository)
  );

  // ===================================================================
  // ======================== DRIVER CAR INFO ==========================
  // ===================================================================
  // Service
  @injectable
  DriverCarInfoService get driverCarInfoService => DriverCarInfoService(token);

  // Repository
  @injectable
  DriverCarInfoRepository get driverCarInfoRepository =>
      DriverCarInfoRepositoryImpl(driverCarInfoService);

  // Use Cases
  @injectable
  DriverCarInfoUseCases get driverCarInfoUseCases => DriverCarInfoUseCases(
      createDriverCarInfo: CreateDriverCarInfoUseCase(driverCarInfoRepository),
      getDriverCarInfo: GetDriverCarInfoUseCase(driverCarInfoRepository));

  // ===================================================================
  // =================== DRIVER TRIP REQUESTS ==========================
  // ===================================================================
  // Service
  @injectable
  DriverTripRequestsService get driverTripRequestsService =>
      DriverTripRequestsService(token);

  // Repository
  @injectable
  DriverTripRequestsRepository get driverTripRequestsRepository =>
      DriverTripRequestsRepositoryImpl(driverTripRequestsService);

  // Use Cases
  @injectable
  DriverTripRequestUseCases get driverTripRequestUseCases =>
      DriverTripRequestUseCases(
          createDriverTripRequest:
              CreateDriverTripRequestUseCase(driverTripRequestsRepository),
          getDriverTripOffersByClientRequest:
              GetDriverTripOffersByClientRequestUseCase(
                  driverTripRequestsRepository));


  // ===================================================================
  // ========================= GEOLOCATOR ==============================
  // ===================================================================
  // Repository
  @injectable
  GeolocatorRepository get geolocatorRepository => GeolocatorRepositoryImpl();

  // Use Cases
  @injectable
  GeolocatorUseCases get geolocatorUseCases => GeolocatorUseCases(
    findPosition: FindPositionUseCase(geolocatorRepository),
    createMarker: CreateMarkerUseCase(geolocatorRepository),
    getMarker: GetMarkerUseCase(geolocatorRepository),
    getPlacemarkData: GetPlacemarkDataUseCase(geolocatorRepository),
    getPolyline: GetPolylineUseCase(geolocatorRepository),
    getPositionStream: GetPositionStreamUseCase(geolocatorRepository),
  );
}