part of 'kix_chat_bloc.dart';

sealed class KixChatEvent {
  const KixChatEvent();
}

final class KixMessageSent extends KixChatEvent {
  const KixMessageSent(this.text);
  final String text;
}

final class KixStepToggled extends KixChatEvent {
  const KixStepToggled(this.stepId);
  final String stepId;
}

final class KixChatReset extends KixChatEvent {
  const KixChatReset();
}
