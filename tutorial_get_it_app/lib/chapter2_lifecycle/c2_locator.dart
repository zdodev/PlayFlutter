import 'package:get_it/get_it.dart';
import 'c2_services.dart';

void setupChapter2() {
  GetIt.I.reset();
  GetIt.I.registerSingleton<SingletonObj>(SingletonObj());
  GetIt.I.registerFactory<FactoryObj>(() => FactoryObj());
}
