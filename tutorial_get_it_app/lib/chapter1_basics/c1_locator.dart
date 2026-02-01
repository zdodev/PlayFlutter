import 'package:get_it/get_it.dart';
import 'package:tutorial_get_it_app/chapter1_basics/c1_service.dart';

void setupChapter1() {
  GetIt.I.reset();
  GetIt.I.registerSingleton<C1Service>(C1Service());
}
