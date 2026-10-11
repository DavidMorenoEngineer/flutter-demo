import 'package:flutter/material.dart';

import '../../../../core/layout/breakpoints.dart';
import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/sx_card.dart';
import '../../../kix_chat/presentation/show_kix_chat.dart';
import '../../domain/entities/home_content.dart';
import '../cubit/home_cubit.dart';
import '../widgets/journey_path_art.dart';
import '../widgets/keyword_band.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadableView<HomeCubit, HomeContent>(
      builder: (context, content) => PageBody(children: [
        _Hero(content: content),
        const SizedBox(height: 48),
        KeywordBand(keywords: content.keywords),
        const SizedBox(height: 64),
        Text('THE GAP WE EXIST TO CLOSE', style: SxText.label()),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Text(content.gapTitle, style: SxText.display(context.isCompact ? 32 : 44)),
        ),
        const SizedBox(height: 28),
        ResponsiveGrid(
          minTileWidth: 260,
          maxColumns: 3,
          children: [for (final s in content.stats) _StatCard(stat: s)],
        ),
      ]),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.content});

  final HomeContent content;

  @override
  Widget build(BuildContext context) {
    final wide = !context.isCompact && context.width >= 760;
    final headline = switch (context.windowClass) {
      WindowClass.compact => 58.0,
      WindowClass.medium => 84.0,
      WindowClass.expanded => 112.0,
    };
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SIDEKIX · BEGIN. BUILD. BECOME.', style: SxText.label()),
        const SizedBox(height: 18),
        Text(content.headline, style: SxText.display(headline, color: SxColors.goldLight)),
        Text(content.subheadline, style: SxText.display(headline * 0.42, color: SxColors.gold, weight: FontWeight.w500)),
        const SizedBox(height: 22),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(content.body, style: SxText.body(16, color: SxColors.muted)),
        ),
        const SizedBox(height: 28),
        Wrap(spacing: 12, runSpacing: 12, children: [
          GoldButton(label: 'Talk to Kix', icon: Icons.auto_awesome, onPressed: () => showKixChat(context)),
          GoldButton(label: 'Watch the film', icon: Icons.play_arrow_rounded, outlined: true, onPressed: () {}),
        ]),
      ],
    );
    final art = AspectRatio(aspectRatio: wide ? 1 : 1.5, child: const JourneyPathArt());
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: wide
          ? Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(flex: 6, child: text),
              const SizedBox(width: 32),
              Expanded(flex: 5, child: art),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [text, const SizedBox(height: 24), art]),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final HomeStat stat;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(stat.value, style: SxText.display(64, color: SxColors.gold)),
        const SizedBox(height: 8),
        Text(stat.label, style: SxText.body(14, color: SxColors.muted)),
      ]),
    );
  }
}
