import '../../../advisors/domain/entities/advisor.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/journey_map.dart';
import '../../domain/entities/kix_event.dart';

/// How fast Kix "types". Tests use [KixTiming.instant].
class KixTiming {
  const KixTiming({this.thinking = const Duration(milliseconds: 700), this.perWord = const Duration(milliseconds: 28)});

  static const instant = KixTiming(thinking: Duration.zero, perWord: Duration.zero);

  final Duration thinking;
  final Duration perWord;
}

enum _Field { food, software, service, product, general }

enum _Obstacle { time, money, confidence, clarity }

/// A deterministic, offline stand-in for the Kix model.
///
/// It reproduces the product's behaviour — *listen first*, ask one good
/// question, then draw a personalised Journey Map — without any API key. The
/// [KixDataSource] seam is where a real LLM client would plug in.
class KixEngine {
  const KixEngine({this.timing = const KixTiming()});

  final KixTiming timing;

  static const _sampleAdvisor = Advisor(
    id: 'a3',
    name: 'Priya Nair',
    title: 'Product lead turned solo founder',
    level: 'Level 3',
    why: 'I left a great job for an idea that scared me. I can help you de-risk the leap.',
    skills: ['Software products', 'MVPs', 'Side-to-full-time'],
    style: 'Warm, structured',
    offers: ['Sessions', 'Content', 'Events'],
  );

  Stream<KixEvent> reply(List<ChatMessage> history) async* {
    final userTurns = history.where((m) => m.role == ChatRole.user).toList();
    final latest = userTurns.last.text;
    final lower = latest.toLowerCase();
    final alreadyMapped = history.any((m) => m.map != null);

    await Future<void>.delayed(timing.thinking);

    if (alreadyMapped) {
      yield* _followUp(lower, history);
      return;
    }

    final field = _fieldOf(userTurns.map((m) => m.text).join(' ').toLowerCase());
    final obstacle = _obstacleOf(userTurns.map((m) => m.text).join(' ').toLowerCase());

    if (userTurns.length == 1 && obstacle == null) {
      yield* _say(
        "Love that — and I'm glad you said it out loud. Before I draw anything: "
        'what feels like the biggest thing standing between you and starting?',
      );
      yield const KixQuickReplies([
        'Not enough time',
        'Money worries',
        "I don't know where to start",
        'Feeling alone in it',
      ]);
      return;
    }

    final o = obstacle ?? _Obstacle.clarity;
    yield* _say(
      "${_acknowledge(o)} Here's the map I'd draw from what you told me — "
      'small, finishable steps in the right order.',
    );
    yield KixMapReady(_buildMap(field, o, userTurns.first.text));
    yield* _say('Tap a milestone to open its steps and tick them off as you go. Want a hand with the first one?');
    yield const KixQuickReplies(['Show me step 1', 'Find me an advisor', 'What does this cost?']);
  }

  Stream<KixEvent> _followUp(String lower, List<ChatMessage> history) async* {
    final map = history.firstWhere((m) => m.map != null).map!;
    if (RegExp(r'advisor|mentor|someone who|expert').hasMatch(lower)) {
      yield* _say("Someone has stood exactly where you are. Based on your plan, I'd start with Priya:");
      yield const KixAdvisorSuggested(_sampleAdvisor);
      yield const KixQuickReplies(['Show me step 1', 'What does this cost?']);
    } else if (RegExp(r'step 1|first step|start|begin|next').hasMatch(lower)) {
      final first = map.milestones.first;
      yield* _say(
        'Your first milestone is "${first.title}". Step one: ${first.steps.first} '
        "Keep it small — ten honest minutes beats an hour of planning. I'll be here when it's done.",
      );
      yield const KixQuickReplies(['Find me an advisor', 'What does this cost?']);
    } else if (RegExp(r'cost|price|pay|credit|free|member').hasMatch(lower)) {
      yield* _say(
        'The work costs nothing to start — your first Journey Map steps are free. '
        'Kix credits are \$19 for 350 and never expire, and membership tiers start at \$39 a month. '
        'Check the Membership tab for the details.',
      );
      yield const KixQuickReplies(['Show me step 1', 'Find me an advisor']);
    } else if (RegExp(r'thank|great|awesome|love').hasMatch(lower)) {
      yield* _say("That means a lot. You've got a real plan with ${map.stepCount} small steps. Begin. Build. Become.");
      yield const KixQuickReplies(['Show me step 1']);
    } else {
      yield* _say(
        "I hear you. Let's keep it simple: pick the next unchecked step on your map and do just that. "
        'If it feels too big, tell me and I will break it down further.',
      );
      yield const KixQuickReplies(['Show me step 1', 'Find me an advisor']);
    }
  }

  Stream<KixEvent> _say(String text) async* {
    final words = text.split(' ');
    for (var i = 0; i < words.length; i++) {
      if (timing.perWord > Duration.zero) await Future<void>.delayed(timing.perWord);
      yield KixToken(i == 0 ? words[i] : ' ${words[i]}');
    }
  }

  _Field _fieldOf(String t) {
    if (RegExp(r'bak|restaurant|food|cafe|coffee|cater|kitchen').hasMatch(t)) return _Field.food;
    if (RegExp(r'\bapp\b|software|saas|website|tech|startup|platform').hasMatch(t)) return _Field.software;
    if (RegExp(r'coach|consult|freelanc|agency|service|clean|design').hasMatch(t)) return _Field.service;
    if (RegExp(r'shop|store|sell|product|craft|etsy|ecommerce|brand').hasMatch(t)) return _Field.product;
    return _Field.general;
  }

  _Obstacle? _obstacleOf(String t) {
    if (RegExp(r'time|busy|9-to-5|9 to 5|job|schedule').hasMatch(t)) return _Obstacle.time;
    if (RegExp(r'money|fund|cost|afford|capital|cash|broke').hasMatch(t)) return _Obstacle.money;
    if (RegExp(r'alone|lonely|overwhelm|scared|afraid|fear|doubt').hasMatch(t)) return _Obstacle.confidence;
    if (RegExp(r"know where|don't know|not sure|clarity|where to start").hasMatch(t)) return _Obstacle.clarity;
    return null;
  }

  String _acknowledge(_Obstacle o) => switch (o) {
        _Obstacle.time => "Time is the most honest obstacle there is, so we'll build around it.",
        _Obstacle.money => "Money worries are real — so we'll start with what costs nothing.",
        _Obstacle.confidence => "You're not alone in that, and you don't have to be. We'll make it a team effort.",
        _Obstacle.clarity => "Not knowing where to start is exactly what a map is for.",
      };

  JourneyMap _buildMap(_Field field, _Obstacle o, String idea) {
    final firstStep = switch (o) {
      _Obstacle.time => 'Block three 20-minute sessions on your calendar this week.',
      _Obstacle.money => 'List everything you can start with at zero cost.',
      _Obstacle.confidence => 'Write one honest paragraph on why you want this.',
      _Obstacle.clarity => 'Describe your idea in a single sentence.',
    };
    final (validate, launch) = switch (field) {
      _Field.food => (
          ['Taste-test your signature item with 10 people', 'Cost out one batch, ingredient by ingredient', 'Check local cottage-food and permit rules'],
          ['Pick a first sales channel: market stall, pre-orders or wholesale', 'Price for a real margin, not a hopeful one', 'Run a launch weekend and note every question you get'],
        ),
      _Field.software => (
          ['Interview five people who have the problem', 'Sketch the smallest thing that solves it', 'Decide what you will not build yet'],
          ['Ship a clickable prototype to your five', 'Set one success metric for week one', 'Collect feedback in a single doc'],
        ),
      _Field.service => (
          ['Define who you serve in one sentence', 'Write down your three best proof points', 'Set a starter price you can say out loud'],
          ['Offer a pilot to two warm contacts', 'Document the process as you deliver it', 'Ask for a testimonial the same week'],
        ),
      _Field.product => (
          ['Order or build three samples', 'Calculate landed cost and margin', 'Photograph the product simply and honestly'],
          ['Open one storefront, not three', 'Write the listing the way you would explain it to a friend', 'Make your first ten sales personal'],
        ),
      _Field.general => (
          ['Talk to five potential customers', 'Write down what they would actually pay for', 'Pick the smallest version worth testing'],
          ['Run a tiny version of the idea', 'Track what worked and what did not', 'Decide: adjust, continue or stop'],
        ),
    };
    return JourneyMap(
      goal: idea.length > 70 ? '${idea.substring(0, 67)}…' : idea,
      milestones: [
        Milestone(
          title: 'Get clear',
          summary: 'Turn the idea into something you can explain in one breath.',
          steps: [firstStep, 'Name who it is for', 'Write down what "done" looks like for the first 90 days'],
        ),
        Milestone(title: 'Test it', summary: 'Find out what is true before you spend anything.', steps: validate),
        Milestone(title: 'Make it real', summary: 'Put a first version in front of real people.', steps: launch),
        const Milestone(
          title: 'Keep going',
          summary: 'Build the rhythm that carries you past the first month.',
          steps: ['Pick a weekly check-in day', 'Join a squad or find an accountability partner', 'Book one advisor session'],
        ),
      ],
    );
  }
}
