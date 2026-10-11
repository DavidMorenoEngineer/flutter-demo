import 'package:injectable/injectable.dart';

import '../services/url_launcher_service.dart';

@module
abstract class AppModule {
  @lazySingleton
  UrlLauncherService get urlLauncher => const UrlLauncherService();
}
