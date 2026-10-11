import 'package:equatable/equatable.dart';

class JourneyStep extends Equatable {
  const JourneyStep({
    required this.number,
    required this.title,
    required this.caption,
    required this.description,
  });

  final String number;
  final String title;
  final String caption;
  final String description;

  @override
  List<Object?> get props => [number, title, caption, description];
}
