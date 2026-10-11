import 'package:equatable/equatable.dart';

class CommunityEvent extends Equatable {
  const CommunityEvent({
    required this.title,
    required this.host,
    required this.when,
    required this.format,
    required this.cost,
    required this.state,
  });

  final String title;
  final String host;
  final String when;
  final String format;
  final String cost;
  final String state;

  @override
  List<Object?> get props => [title, host, when, format, cost, state];
}

class StateCount extends Equatable {
  const StateCount(this.name, this.count);

  final String name;
  final int count;

  @override
  List<Object?> get props => [name, count];
}

class EventsContent extends Equatable {
  const EventsContent({required this.events, required this.states});

  final List<CommunityEvent> events;
  final List<StateCount> states;

  @override
  List<Object?> get props => [events, states];
}
