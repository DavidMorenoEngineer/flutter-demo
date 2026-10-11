import 'package:equatable/equatable.dart';

class HomeStat extends Equatable {
  const HomeStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  List<Object?> get props => [value, label];
}

class HomeContent extends Equatable {
  const HomeContent({
    required this.headline,
    required this.subheadline,
    required this.body,
    required this.keywords,
    required this.gapTitle,
    required this.stats,
  });

  final String headline;
  final String subheadline;
  final String body;
  final List<String> keywords;
  final String gapTitle;
  final List<HomeStat> stats;

  @override
  List<Object?> get props => [headline, subheadline, body, keywords, gapTitle, stats];
}
