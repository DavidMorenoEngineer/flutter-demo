import 'package:injectable/injectable.dart';

import '../../domain/entities/membership_offer.dart';

/// Static, deterministic content — no backend, matching the other showcase repos.
abstract interface class MembershipDataSource {
  Future<MembershipOffer> fetch();
}

@LazySingleton(as: MembershipDataSource)
class MembershipMockDataSource implements MembershipDataSource {
  const MembershipMockDataSource();

  @override
  Future<MembershipOffer> fetch() async => const MembershipOffer(
        plans: [
          PricingPlan(
            name: 'Access',
            monthly: 39,
            yearly: 468,
            features: ['Journey Map access', 'Kix guidance', 'Live community feed', 'Resource library'],
          ),
          PricingPlan(
            name: 'Core',
            monthly: 99,
            yearly: 1188,
            mostPopular: true,
            features: [
              'Everything in Access',
              'Squads',
              'Capital Readiness',
              'Core Grants',
              'More Kix usage',
            ],
          ),
          PricingPlan(
            name: 'Premium',
            monthly: 299,
            yearly: 3588,
            features: [
              'Everything in Core',
              'Advisor Sessions',
              'Investor matching',
              'Priority support',
            ],
          ),
        ],
        creditPack: CreditPack(price: 19, credits: 350, minutes: 90),
        roadmap: [
          RoadmapPhase(label: 'Phase one · live now', title: 'Journey Maps and Kix', live: true),
          RoadmapPhase(label: 'Phase two', title: 'Advisors'),
          RoadmapPhase(label: 'Phase three', title: 'Community and Events'),
          RoadmapPhase(label: 'Phase four', title: 'Discovery and Training'),
        ],
      );
}
