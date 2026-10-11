import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/features/kix_chat/data/datasources/kix_data_source.dart';
import 'package:flutter_demo/features/kix_chat/data/datasources/kix_engine.dart';
import 'package:flutter_demo/features/kix_chat/data/repositories/kix_repository_impl.dart';
import 'package:flutter_demo/features/kix_chat/domain/entities/chat_message.dart';
import 'package:flutter_demo/features/kix_chat/domain/entities/kix_event.dart';
import 'package:flutter_demo/features/kix_chat/domain/usecases/stream_kix_reply.dart';
import 'package:flutter_demo/features/kix_chat/presentation/bloc/kix_chat_bloc.dart';

class _InstantDataSource implements KixDataSource {
  @override
  Stream<KixEvent> reply(List<ChatMessage> history) => const KixEngine(timing: KixTiming.instant).reply(history);
}

class _BrokenDataSource implements KixDataSource {
  @override
  Stream<KixEvent> reply(List<ChatMessage> history) => Stream.error(StateError('model offline'));
}

KixChatBloc bloc(KixDataSource ds) => KixChatBloc(StreamKixReply(KixRepositoryImpl(ds)));

void main() {
  test('starts with the welcome message and quick replies', () {
    final b = bloc(_InstantDataSource());
    expect(b.state.messages.single.text, contains("I'm Kix"));
    expect(b.state.messages.single.quickReplies, isNotEmpty);
  });

  test('a two-turn conversation ends with a Journey Map and clears old quick replies', () async {
    final b = bloc(_InstantDataSource());
    b.add(const KixMessageSent('I want to open a bakery'));
    await b.stream.firstWhere((s) => !s.replying && s.messages.length == 3);
    b.add(const KixMessageSent('Not enough time'));
    final done = await b.stream.firstWhere((s) => !s.replying && s.messages.length == 5);

    final reply = done.messages.last;
    expect(reply.map, isNotNull);
    expect(reply.streaming, isFalse);
    // Only the latest Kix message keeps its quick replies.
    expect(done.messages.take(4).every((m) => m.quickReplies.isEmpty), isTrue);
  });

  test('ignores a send while Kix is still replying', () async {
    final b = bloc(_InstantDataSource());
    b.add(const KixMessageSent('first'));
    b.add(const KixMessageSent('second, sent too early'));
    final done = await b.stream.firstWhere((s) => !s.replying && s.messages.length >= 3);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect(b.state.messages.where((m) => m.role == ChatRole.user), hasLength(1));
    expect(done.messages.length, 3);
  });

  blocTest<KixChatBloc, KixChatState>(
    'toggling a step marks it done, toggling again clears it',
    build: () => bloc(_InstantDataSource()),
    act: (b) => b
      ..add(const KixStepToggled('k1:0:0'))
      ..add(const KixStepToggled('k1:0:0')),
    expect: () => [
      isA<KixChatState>().having((s) => s.doneSteps, 'done', {'k1:0:0'}),
      isA<KixChatState>().having((s) => s.doneSteps, 'done', isEmpty),
    ],
  );

  test('a failing model surfaces a friendly message instead of crashing', () async {
    final b = bloc(_BrokenDataSource());
    b.add(const KixMessageSent('hello'));
    final done = await b.stream.firstWhere((s) => !s.replying && s.messages.length == 3);
    expect(done.messages.last.text, contains('lost my train of thought'));
  });
}
