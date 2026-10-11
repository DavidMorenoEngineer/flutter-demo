import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/kix_event.dart';
import '../../domain/usecases/stream_kix_reply.dart';

part 'kix_chat_bloc.freezed.dart';
part 'kix_chat_event.dart';
part 'kix_chat_state.dart';

@lazySingleton
class KixChatBloc extends Bloc<KixChatEvent, KixChatState> {
  KixChatBloc(this._streamReply) : super(_initial) {
    on<KixMessageSent>(_onSent);
    on<KixStepToggled>(_onStepToggled);
    on<KixChatReset>((_, emit) => emit(_initial));
  }

  final StreamKixReply _streamReply;

  static const welcome = ChatMessage(
    id: 'welcome',
    role: ChatRole.kix,
    text: "Hi, I'm Kix. I always start by listening. What's the idea you never built?",
    quickReplies: ['I want to open a bakery', 'I have an app idea', "I'm stuck in my 9-to-5"],
  );

  static final _initial = KixChatState(messages: const [welcome]);

  /// Id of a step checkbox: `<message id>:<milestone>:<step>`.
  static String stepId(String messageId, int milestone, int step) => '$messageId:$milestone:$step';

  Future<void> _onSent(KixMessageSent event, Emitter<KixChatState> emit) async {
    final text = event.text.trim();
    if (text.isEmpty || state.replying) return;

    final n = state.messages.length;
    final user = ChatMessage(id: 'u$n', role: ChatRole.user, text: text);
    var kix = ChatMessage(id: 'k$n', role: ChatRole.kix, streaming: true);
    // Quick replies belong to the latest Kix message only.
    final history = [
      for (final m in state.messages) m.quickReplies.isEmpty ? m : m.copyWith(quickReplies: const []),
      user,
    ];
    emit(state.copyWith(messages: [...history, kix], replying: true));

    void update() => emit(state.copyWith(messages: [...history, kix]));

    await emit.onEach(
      _streamReply(history),
      onData: (result) => result.fold(
        (failure) {
          kix = kix.copyWith(text: 'Sorry — I lost my train of thought. Could you say that again?');
          update();
        },
        (event) {
          kix = switch (event) {
            KixToken(:final text) => kix.copyWith(text: kix.text + text),
            KixMapReady(:final map) => kix.copyWith(map: map),
            KixAdvisorSuggested(:final advisor) => kix.copyWith(advisor: advisor),
            KixQuickReplies(:final replies) => kix.copyWith(quickReplies: replies),
          };
          update();
        },
      ),
    );
    kix = kix.copyWith(streaming: false);
    emit(state.copyWith(messages: [...history, kix], replying: false));
  }

  void _onStepToggled(KixStepToggled event, Emitter<KixChatState> emit) {
    final done = {...state.doneSteps};
    if (!done.remove(event.stepId)) done.add(event.stepId);
    emit(state.copyWith(doneSteps: done));
  }
}
