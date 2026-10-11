import '../../../advisors/domain/entities/advisor.dart';
import 'journey_map.dart';

/// One increment of Kix's streamed reply.
sealed class KixEvent {
  const KixEvent();
}

final class KixToken extends KixEvent {
  const KixToken(this.text);
  final String text;
}

final class KixMapReady extends KixEvent {
  const KixMapReady(this.map);
  final JourneyMap map;
}

final class KixAdvisorSuggested extends KixEvent {
  const KixAdvisorSuggested(this.advisor);
  final Advisor advisor;
}

final class KixQuickReplies extends KixEvent {
  const KixQuickReplies(this.replies);
  final List<String> replies;
}
