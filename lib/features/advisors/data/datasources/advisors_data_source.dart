import 'package:injectable/injectable.dart';

import '../../domain/entities/advisor.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class AdvisorsDataSource {
  Future<List<Advisor>> fetch();
}

@LazySingleton(as: AdvisorsDataSource)
class AdvisorsMockDataSource implements AdvisorsDataSource {
  const AdvisorsMockDataSource();

  @override
  Future<List<Advisor>> fetch() async => const [
        Advisor(
          id: 'a1',
          name: 'Maya Okafor',
          title: 'Founder, neighbourhood bakery group',
          level: 'Level 3',
          why: 'I started with one oven and a borrowed van. I know exactly how scary the first month feels.',
          skills: ['Food business', 'Pricing', 'Hiring first staff'],
          style: 'Direct and practical',
          offers: ['Sessions', 'Content'],
        ),
        Advisor(
          id: 'a2',
          name: 'Daniel Reyes',
          title: 'Ex-CFO, two bootstrapped exits',
          level: 'Level 4',
          why: 'Cash flow kills more good ideas than competition does. I help you see it coming.',
          skills: ['Capital readiness', 'Cash flow', 'Grants'],
          style: 'Numbers first, jargon never',
          offers: ['Sessions', 'Events'],
        ),
        Advisor(
          id: 'a3',
          name: 'Priya Nair',
          title: 'Product lead turned solo founder',
          level: 'Level 3',
          why: 'I left a great job for an idea that scared me. I can help you de-risk the leap.',
          skills: ['Software products', 'MVPs', 'Side-to-full-time'],
          style: 'Warm, structured',
          offers: ['Sessions', 'Content', 'Events'],
        ),
        Advisor(
          id: 'a4',
          name: 'Jordan Ellis',
          title: 'Small-business attorney',
          level: 'Level 2',
          why: 'Most legal mistakes are made in week one. I make sure you do not make them.',
          skills: ['LLC vs sole prop', 'Contracts', 'Trademarks'],
          style: 'Plain English',
          offers: ['Sessions', 'Content'],
        ),
        Advisor(
          id: 'a5',
          name: 'Amara Diallo',
          title: 'Community builder and coach',
          level: 'Level 4',
          why: 'Isolation is the silent killer of founders. Let me help you find your people.',
          skills: ['Community', 'Mindset', 'Accountability'],
          style: 'Encouraging, honest',
          offers: ['Sessions', 'Events'],
        ),
        Advisor(
          id: 'a6',
          name: 'Tomás Herrera',
          title: 'Marketing strategist, 15 years in local retail',
          level: 'Level 3',
          why: 'You do not need a big budget — you need a clear message and the right ten customers.',
          skills: ['Positioning', 'First customers', 'Local marketing'],
          style: 'Energetic, hands-on',
          offers: ['Sessions', 'Content'],
        ),
      ];
}
