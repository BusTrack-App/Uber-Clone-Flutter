// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:socket_io_client/socket_io_client.dart' as _i414;
import 'package:uber_clone/src/data/dataSource/local/shared_pref.dart' as _i653;
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart'
    as _i246;
import 'package:uber_clone/src/data/dataSource/remote/services/driver_position_service.dart'
    as _i120;
import 'package:uber_clone/src/data/dataSource/remote/services/users_service.dart'
    as _i720;
import 'package:uber_clone/src/di/app_module.dart' as _i807;
import 'package:uber_clone/src/domain/repository/auth_repository.dart' as _i291;
import 'package:uber_clone/src/domain/repository/drivers_position_repository.dart'
    as _i992;
import 'package:uber_clone/src/domain/repository/geolocator_repository.dart'
    as _i617;
import 'package:uber_clone/src/domain/repository/socket_repository.dart'
    as _i860;
import 'package:uber_clone/src/domain/repository/users_repository.dart'
    as _i374;
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart'
    as _i180;
import 'package:uber_clone/src/domain/use_cases/drivers-position/drivers_position_use_cases.dart'
    as _i135;
import 'package:uber_clone/src/domain/use_cases/geolocator/geolocator_use_cases.dart'
    as _i974;
import 'package:uber_clone/src/domain/use_cases/socket/socket_use_cases.dart'
    as _i332;
import 'package:uber_clone/src/domain/use_cases/users/user_use_case.dart'
    as _i49;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i653.SharedPref>(() => appModule.sharefPref);
    gh.factory<_i414.Socket>(() => appModule.socket);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i246.AuthService>(() => appModule.authService);
    gh.factory<_i291.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i180.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i374.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i49.UsersUseCases>(() => appModule.usersUseCases);
    gh.factory<_i720.UsersService>(() => appModule.usersService);
    gh.factory<_i120.DriversPositionService>(
      () => appModule.driversPositionService,
    );
    gh.factory<_i992.DriverPositionRepository>(
      () => appModule.driversPositionRepository,
    );
    gh.factory<_i135.DriversPositionUseCases>(
      () => appModule.driversPositionUseCases,
    );
    gh.factory<_i860.SocketRepository>(() => appModule.socketRepository);
    gh.factory<_i617.GeolocatorRepository>(
      () => appModule.geolocatorRepository,
    );
    gh.factory<_i974.GeolocatorUseCases>(() => appModule.geolocatorUseCases);
    gh.factory<_i332.SocketUseCases>(() => appModule.socketUseCases);
    return this;
  }
}

class _$AppModule extends _i807.AppModule {}
