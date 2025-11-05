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
import 'package:uber_clone/src/data/dataSource/local/shared_pref.dart' as _i653;
import 'package:uber_clone/src/data/dataSource/remote/services/auth_service.dart'
    as _i246;
import 'package:uber_clone/src/di/app_module.dart' as _i807;
import 'package:uber_clone/src/domain/repository/auth_repository.dart' as _i291;
import 'package:uber_clone/src/domain/use_cases/auth/auth_use_case.dart'
    as _i180;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i653.SharedPref>(() => appModule.sharefPref);
    gh.factory<_i246.AuthService>(() => appModule.authService);
    gh.factory<_i291.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i180.AuthUseCases>(() => appModule.authUseCases);
    return this;
  }
}

class _$AppModule extends _i807.AppModule {}
