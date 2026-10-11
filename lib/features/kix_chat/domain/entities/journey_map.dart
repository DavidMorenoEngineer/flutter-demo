import 'package:equatable/equatable.dart';

class Milestone extends Equatable {
  const Milestone({required this.title, required this.summary, required this.steps});

  final String title;
  final String summary;
  final List<String> steps;

  @override
  List<Object?> get props => [title, summary, steps];
}

/// The personalised plan Kix draws from the conversation.
class JourneyMap extends Equatable {
  const JourneyMap({required this.goal, required this.milestones});

  final String goal;
  final List<Milestone> milestones;

  int get stepCount => milestones.fold(0, (sum, m) => sum + m.steps.length);

  @override
  List<Object?> get props => [goal, milestones];
}
