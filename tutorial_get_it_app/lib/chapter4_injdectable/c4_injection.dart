import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'c4_injection.config.dart';

@InjectableInit()
void configureChapter4() {
  GetIt.I.reset();
  GetIt.I.init();
}
