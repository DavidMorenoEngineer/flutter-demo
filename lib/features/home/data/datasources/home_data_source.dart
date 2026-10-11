import 'package:injectable/injectable.dart';

import '../../domain/entities/home_content.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class HomeDataSource {
  Future<HomeContent> fetch();
}

@LazySingleton(as: HomeDataSource)
class HomeMockDataSource implements HomeDataSource {
  const HomeMockDataSource();

  @override
  Future<HomeContent> fetch() async => const HomeContent(
        headline: 'Build it now.',
        subheadline: 'The idea you never built.',
        body:
            'SideKix gives you a personalized path from where you are to where you want to be — one clear next step at a time.',
        keywords: [
          'Begin', 'Build', 'Become', 'Community', 'Advisors',
          'Planning', 'Training', 'Resources', 'Discovery', 'Challenges',
        ],
        gapTitle: 'The barrier was never talent or ambition. It was always access.',
        stats: [
          HomeStat(value: '92%', label: 'of people with a business idea never act on it'),
          HomeStat(value: '73%', label: 'of small business owners have felt alone running their business'),
          HomeStat(value: '5x', label: 'more likely to start with support'),
        ],
      );
}
