import 'package:injectable/injectable.dart';

import '../../domain/entities/journey_step.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class HowItWorksDataSource {
  Future<List<JourneyStep>> fetch();
}

@LazySingleton(as: HowItWorksDataSource)
class HowItWorksMockDataSource implements HowItWorksDataSource {
  const HowItWorksMockDataSource();

  @override
  Future<List<JourneyStep>> fetch() async => const [
        JourneyStep(
          number: '01',
          title: 'Begin',
          caption: 'Explore ideas and get a personalized next step.',
          description:
              'Kix starts by listening. Tell it where you are and what you want, and it turns that conversation into a map built from your own words.',
        ),
        JourneyStep(
          number: '02',
          title: 'Build',
          caption: 'Work the plan one action at a time, with help from Kix and Advisors.',
          description:
              'Each milestone opens into small, finishable steps. Advisors, resources and trainings appear exactly when they are useful — with a reason why.',
        ),
        JourneyStep(
          number: '03',
          title: 'Become',
          caption: 'Grow alongside others doing the same.',
          description:
              'A live community feed, topic rooms and private squads keep you moving, so you are never building alone.',
        ),
      ];
}
