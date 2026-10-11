import 'package:equatable/equatable.dart';

class PartnerTrack extends Equatable {
  const PartnerTrack({
    required this.title,
    required this.headline,
    required this.bullets,
    required this.cta,
  });

  final String title;
  final String headline;
  final List<String> bullets;
  final String cta;

  @override
  List<Object?> get props => [title, headline, bullets, cta];
}

class PartnersContent extends Equatable {
  const PartnersContent({
    required this.headline,
    required this.subheadline,
    required this.companyCount,
    required this.tracks,
    required this.national,
    required this.partners,
    required this.local,
  });

  final String headline;
  final String subheadline;
  final String companyCount;
  final List<PartnerTrack> tracks;
  final List<String> national;
  final List<String> partners;
  final List<String> local;

  @override
  List<Object?> get props => [headline, subheadline, companyCount, tracks, national, partners, local];
}
