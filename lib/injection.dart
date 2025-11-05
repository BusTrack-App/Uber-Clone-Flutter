import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uber_clone/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
// ignore: await_only_futures
Future<void> configureDependencies() async => await locator.init();

