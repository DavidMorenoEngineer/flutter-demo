import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/sx_card.dart';
import '../../../kix_chat/presentation/show_kix_chat.dart';
import '../../domain/entities/journey_step.dart';
import '../cubit/how_it_works_cubit.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(children: [
      const SectionHeader(
        eyebrow: 'How it works',
        title: 'Three moves. One momentum.',
        subtitle: 'A complete business operating system that finds a personalized path from where you are to where you want to be.',
      ),
      const SizedBox(height: 36),
      LoadableView<HowItWorksCubit, List<JourneyStep>>(
        builder: (context, steps) => ResponsiveGrid(
          minTileWidth: 300,
          maxColumns: 3,
          children: [for (final s in steps) _StepCard(step: s)],
        ),
      ),
      const SizedBox(height: 40),
      SxCard(
        highlight: true,
        padding: const EdgeInsets.all(24),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 16,
          spacing: 24,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Kix listens first', style: SxText.display(30)),
                const SizedBox(height: 6),
                Text(
                  'Start with a conversation. Kix builds a map from your own words and is candid about what it does not know.',
                  style: SxText.body(14, color: SxColors.muted),
                ),
              ]),
            ),
            GoldButton(label: 'Try it now', icon: Icons.auto_awesome, onPressed: () => showKixChat(context)),
          ],
        ),
      ),
    ]);
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({required this.step});

  final JourneyStep step;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      padding: const EdgeInsets.all(26),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(step.number, style: SxText.label(size: 12, color: SxColors.dim)),
        const SizedBox(height: 10),
        Text(step.title, style: SxText.display(46)),
        const SizedBox(height: 8),
        Text(step.caption, style: SxText.body(14, color: SxColors.gold, weight: FontWeight.w500)),
        const SizedBox(height: 14),
        Text(step.description, style: SxText.body(13.5, color: SxColors.muted)),
      ]),
    );
  }
}
