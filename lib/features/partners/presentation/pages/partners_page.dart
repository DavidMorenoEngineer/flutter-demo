import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/sx_card.dart';
import '../../domain/entities/partners_content.dart';
import '../cubit/partners_cubit.dart';

class PartnersPage extends StatelessWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadableView<PartnersCubit, PartnersContent>(
      builder: (context, c) => PageBody(children: [
        SectionHeader(eyebrow: 'Partners', title: c.headline, subtitle: c.subheadline),
        const SizedBox(height: 16),
        Row(children: [
          const Icon(Icons.groups_2_outlined, color: SxColors.gold, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text('${c.companyCount} already in the network', style: SxText.body(14, color: SxColors.goldLight))),
        ]),
        const SizedBox(height: 28),
        ResponsiveGrid(
          minTileWidth: 300,
          maxColumns: 3,
          children: [for (final t in c.tracks) _TrackCard(track: t)],
        ),
        const SizedBox(height: 48),
        Text('WHO IS ALREADY HERE', style: SxText.label()),
        const SizedBox(height: 16),
        _NameGroup(title: 'National affiliates', names: c.national),
        _NameGroup(title: 'Partners', names: c.partners),
        _NameGroup(title: 'Local · Wilmington, NC', names: c.local),
        const SizedBox(height: 12),
        Text(
          'Placement is never bought. SideKix earns a commission on sign-ups with affiliates only.',
          style: SxText.body(12, color: SxColors.dim),
        ),
      ]),
    );
  }
}

class _TrackCard extends StatelessWidget {
  const _TrackCard({required this.track});

  final PartnerTrack track;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(track.title.toUpperCase(), style: SxText.label()),
        const SizedBox(height: 10),
        Text(track.headline, style: SxText.display(27)),
        const SizedBox(height: 16),
        for (final b in track.bullets)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 5, color: SxColors.gold),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(b, style: SxText.body(13, color: SxColors.muted))),
            ]),
          ),
        const SizedBox(height: 18),
        GoldButton(label: track.cta, outlined: true, onPressed: () {}),
      ]),
    );
  }
}

class _NameGroup extends StatelessWidget {
  const _NameGroup({required this.title, required this.names});

  final String title;
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: SxText.body(13, color: SxColors.goldLight, weight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final n in names)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: SxColors.surface,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: SxColors.line),
              ),
              child: Text(n, style: SxText.body(12.5, color: SxColors.textSoft)),
            ),
        ]),
      ]),
    );
  }
}
