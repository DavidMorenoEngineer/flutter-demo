import 'package:equatable/equatable.dart';

class Advisor extends Equatable {
  const Advisor({
    required this.id,
    required this.name,
    required this.title,
    required this.level,
    required this.why,
    required this.skills,
    required this.style,
    required this.offers,
  });

  final String id;
  final String name;
  final String title;
  final String level;
  final String why;
  final List<String> skills;
  final String style;
  final List<String> offers;

  String get initials => name.split(' ').map((p) => p[0]).take(2).join();

  @override
  List<Object?> get props => [id, name, title, level, why, skills, style, offers];
}
