import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_demo/features/kix_chat/data/datasources/kix_engine.dart';
import 'package:flutter_demo/features/kix_chat/domain/entities/chat_message.dart';
import 'package:flutter_demo/features/kix_chat/domain/entities/kix_event.dart';
import 'package:flutter_demo/features/kix_chat/domain/entities/journey_map.dart';

const _engine = KixEngine(timing: KixTiming.instant);

ChatMessage user(String text) => ChatMessage(id: text, role: ChatRole.user, text: text);

Future<List<KixEvent>> run(List<ChatMessage> history) => _engine.reply(history).toList();

String textOf(List<KixEvent> events) => events.whereType<KixToken>().map((t) => t.text).join();

void main() {
  test('listens first: asks one question and offers quick replies, no map yet', () async {
    final events = await run([user('I want to open a bakery')]);
    expect(events.whereType<KixMapReady>(), isEmpty);
    expect(textOf(events), contains('biggest thing standing between you and starting'));
    expect(events.whereType<KixQuickReplies>().single.replies, contains('Not enough time'));
  });

  test('after the obstacle is known it draws a personalised Journey Map', () async {
    final events = await run([user('I want to open a bakery'), user('Not enough time')]);
    final map = events.whereType<KixMapReady>().single.map;
    expect(map.milestones, hasLength(4));
    expect(map.milestones.first.steps.first, contains('20-minute'));
    // Food business -> food-specific validation steps.
    expect(map.milestones[1].steps.join(), contains('Taste-test'));
  });

  test('skips the question when the first message already names the obstacle', () async {
    final events = await run([user("I have an app idea but I don't have the money")]);
    final map = events.whereType<KixMapReady>().single.map;
    expect(map.milestones.first.steps.first, contains('zero cost'));
    expect(map.milestones[1].steps.join(), contains('Interview five people'));
  });

  test('follow-ups: advisor suggestion and step 1', () async {
    const map = JourneyMap(goal: 'g', milestones: [
      Milestone(title: 'Get clear', summary: 's', steps: ['Do the thing.']),
    ]);
    final history = [user('idea'), const ChatMessage(id: 'k', role: ChatRole.kix, map: map)];

    final advisor = await run([...history, user('find me an advisor')]);
    expect(advisor.whereType<KixAdvisorSuggested>(), hasLength(1));

    final step = await run([...history, user('show me step 1')]);
    expect(textOf(step), contains('Get clear'));
    expect(textOf(step), contains('Do the thing.'));
  });
}
