part of 'kix_chat_bloc.dart';

@freezed
abstract class KixChatState with _$KixChatState {
  const factory KixChatState({
    required List<ChatMessage> messages,
    @Default(false) bool replying,
    @Default(<String>{}) Set<String> doneSteps,
  }) = _KixChatState;
}
