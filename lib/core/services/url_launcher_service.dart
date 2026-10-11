import 'package:fpdart/fpdart.dart';
import 'package:url_launcher/url_launcher.dart';

import '../error/failure.dart';

/// Opens external links in the system browser.
class UrlLauncherService {
  const UrlLauncherService();

  Future<Either<Failure, Unit>> open(String url) async {
    try {
      final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      return ok ? right(unit) : left(Failure.launch(url));
    } catch (_) {
      return left(Failure.launch(url));
    }
  }
}
