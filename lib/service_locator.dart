import 'package:get_it/get_it.dart';
import 'db_helper.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => DBHelper());
}
