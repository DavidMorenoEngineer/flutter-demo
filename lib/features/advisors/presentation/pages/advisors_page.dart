import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/section_header.dart';
import '../../domain/entities/advisor.dart';
import '../cubit/advisors_cubit.dart';
import '../widgets/flip_card.dart';

class AdvisorsPage extends StatelessWidget {
  const AdvisorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(children: [
      const SectionHeader(
        eyebrow: 'In your corner',
        title: "Meet the Advisors who've been there.",
        subtitle: 'Tap a card to flip it and see why they do this, what they know, and how they work.',
      ),
      const SizedBox(height: 32),
      LoadableView<AdvisorsCubit, List<Advisor>>(
        builder: (context, advisors) => ResponsiveGrid(
          minTileWidth: 290,
          maxColumns: 3,
          children: [
            for (final a in advisors)
              FlipCard(height: 390, front: _Front(advisor: a), back: _Back(advisor: a)),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Illustrative sample advisors, written for this demo — not real people.',
        style: SxText.body(12, color: SxColors.dim),
      ),
    ]);
  }
}

BoxDecoration _faceDecoration({bool gold = false}) => BoxDecoration(
      color: SxColors.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: gold ? SxColors.gold : SxColors.line, width: gold ? 1.5 : 1),
    );

class _Front extends StatelessWidget {
  const _Front({required this.advisor});

  final Advisor advisor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _faceDecoration(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 88,
            height: 88,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [SxColors.surfaceHigh, SxColors.line]),
            ),
            child: Text(advisor.initials, style: SxText.display(38)),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: SxColors.gold),
            ),
            child: Text(advisor.level.toUpperCase(), style: SxText.label(size: 9.5)),
          ),
        ]),
        const Spacer(),
        Text(advisor.name, style: SxText.display(32)),
        const SizedBox(height: 4),
        Text(advisor.title, style: SxText.body(13, color: SxColors.muted)),
        const SizedBox(height: 14),
        Wrap(spacing: 6, runSpacing: 6, children: [
          for (final s in advisor.skills.take(2)) _Tag(s),
        ]),
        const SizedBox(height: 14),
        Row(children: [
          const Icon(Icons.touch_app_outlined, size: 14, color: SxColors.dim),
          const SizedBox(width: 6),
          Text('Tap to flip', style: SxText.body(11.5, color: SxColors.dim)),
        ]),
      ]),
    );
  }
}

class _Back extends StatelessWidget {
  const _Back({required this.advisor});

  final Advisor advisor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: _faceDecoration(gold: true),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('WHY I DO THIS', style: SxText.label(size: 10)),
        const SizedBox(height: 8),
        Text('"${advisor.why}"', style: SxText.display(21, weight: FontWeight.w500), maxLines: 4, overflow: TextOverflow.ellipsis),
        const SizedBox(height: 12),
        Wrap(spacing: 6, runSpacing: 6, children: [for (final s in advisor.skills) _Tag(s)]),
        const SizedBox(height: 10),
        Text('Style: ${advisor.style}', style: SxText.body(12, color: SxColors.muted)),
        Text('Offers: ${advisor.offers.join(' · ')}', style: SxText.body(12, color: SxColors.muted)),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: GoldButton(
            label: 'Book a Session',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sessions open in phase two — noted your interest in ${advisor.name}.')),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(color: SxColors.surfaceHigh, borderRadius: BorderRadius.circular(7)),
        child: Text(text, style: SxText.body(11, color: SxColors.textSoft)),
      );
}
