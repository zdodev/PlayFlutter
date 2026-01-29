import 'package:get_it/get_it.dart';
import 'package:my_auto_route_app/data/repositories/memo_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<MemoRepository>(() => MemoRepository());
}
