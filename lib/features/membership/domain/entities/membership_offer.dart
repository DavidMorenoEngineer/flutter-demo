import 'package:equatable/equatable.dart';

class PricingPlan extends Equatable {
  const PricingPlan({
    required this.name,
    required this.monthly,
    required this.yearly,
    required this.features,
    this.mostPopular = false,
  });

  final String name;
  final int monthly;
  final int yearly;
  final List<String> features;
  final bool mostPopular;

  @override
  List<Object?> get props => [name, monthly, yearly, features, mostPopular];
}

class CreditPack extends Equatable {
  const CreditPack({required this.price, required this.credits, required this.minutes});

  final int price;
  final int credits;
  final int minutes;

  @override
  List<Object?> get props => [price, credits, minutes];
}

class RoadmapPhase extends Equatable {
  const RoadmapPhase({required this.label, required this.title, this.live = false});

  final String label;
  final String title;
  final bool live;

  @override
  List<Object?> get props => [label, title, live];
}

class MembershipOffer extends Equatable {
  const MembershipOffer({required this.plans, required this.creditPack, required this.roadmap});

  final List<PricingPlan> plans;
  final CreditPack creditPack;
  final List<RoadmapPhase> roadmap;

  @override
  List<Object?> get props => [plans, creditPack, roadmap];
}
