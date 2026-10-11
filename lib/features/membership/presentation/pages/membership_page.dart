import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/gold_button.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/sx_card.dart';
import '../../domain/entities/membership_offer.dart';
import '../cubit/billing_cubit.dart';
import '../cubit/membership_cubit.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(children: [
      const SectionHeader(
        eyebrow: 'Membership',
        title: 'Start where you are, pay for what you need.',
        subtitle: 'A personalized path from where you are to where you want to be.',
      ),
      const SizedBox(height: 28),
      const _BillingToggle(),
      const SizedBox(height: 24),
      LoadableView<MembershipCubit, MembershipOffer>(
        builder: (context, offer) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ResponsiveGrid(
            minTileWidth: 290,
            maxColumns: 3,
            children: [for (final p in offer.plans) _PlanCard(plan: p)],
          ),
          const SizedBox(height: 28),
          _CreditPackCard(pack: offer.creditPack),
          const SizedBox(height: 40),
          Text('WHAT COMES NEXT', style: SxText.label()),
          const SizedBox(height: 14),
          ResponsiveGrid(
            minTileWidth: 220,
            maxColumns: 4,
            children: [for (final r in offer.roadmap) _PhaseCard(phase: r)],
          ),
        ]),
      ),
    ]);
  }
}

class _BillingToggle extends StatelessWidget {
  const _BillingToggle();

  @override
  Widget build(BuildContext context) {
    final yearly = context.select((BillingCubit c) => c.state.yearly);
    Widget option(String label, bool value) {
      final on = yearly == value;
      return Semantics(
        button: true,
        selected: on,
        child: GestureDetector(
          onTap: () => context.read<BillingCubit>().setYearly(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            decoration: BoxDecoration(color: on ? SxColors.gold : Colors.transparent, borderRadius: BorderRadius.circular(99)),
            child: Text(label, style: SxText.body(13, color: on ? SxColors.goldInk : SxColors.muted, weight: FontWeight.w600)),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: SxColors.surface,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: SxColors.line),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [option('Monthly', false), option('Yearly', true)]),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});

  final PricingPlan plan;

  @override
  Widget build(BuildContext context) {
    final yearly = context.select((BillingCubit c) => c.state.yearly);
    return SxCard(
      highlight: plan.mostPopular,
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(alignment: WrapAlignment.spaceBetween, crossAxisAlignment: WrapCrossAlignment.center, spacing: 12, runSpacing: 8, children: [
          Text(plan.name, style: SxText.display(34)),
          if (plan.mostPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: SxColors.gold, borderRadius: BorderRadius.circular(99)),
              child: Text('MOST POPULAR', style: SxText.label(size: 9, color: SxColors.goldInk)),
            ),
        ]),
        const SizedBox(height: 12),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: Row(
            key: ValueKey(yearly),
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text('\$${yearly ? plan.yearly : plan.monthly}', style: SxText.display(54, color: SxColors.gold)),
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(yearly ? 'a year' : 'a month', style: SxText.body(13, color: SxColors.muted)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final f in plan.features)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 3),
                child: Icon(Icons.check_rounded, size: 16, color: SxColors.gold),
              ),
              const SizedBox(width: 8),
              Expanded(child: Text(f, style: SxText.body(13.5))),
            ]),
          ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: GoldButton(label: 'Join the waitlist', outlined: !plan.mostPopular, onPressed: () {}),
        ),
      ]),
    );
  }
}

class _CreditPackCard extends StatelessWidget {
  const _CreditPackCard({required this.pack});

  final CreditPack pack;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 32,
        runSpacing: 16,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ALWAYS KNOW WHAT TO DO NEXT', style: SxText.label()),
              const SizedBox(height: 10),
              Text('${pack.credits} Kix credits · \$${pack.price}', style: SxText.display(34)),
              const SizedBox(height: 8),
              Text(
                'Up to ${pack.minutes} minutes of conversation. Never expires. The work costs nothing. No surprises. '
                'One-time purchase, no subscription.',
                style: SxText.body(13.5, color: SxColors.muted),
              ),
            ]),
          ),
          GoldButton(label: 'Purchase ${pack.credits} credits', onPressed: () {}),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  const _PhaseCard({required this.phase});

  final RoadmapPhase phase;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      highlight: phase.live,
      padding: const EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(phase.label.toUpperCase(), style: SxText.label(size: 10, color: phase.live ? SxColors.gold : SxColors.dim)),
        const SizedBox(height: 8),
        Text(phase.title, style: SxText.display(24)),
      ]),
    );
  }
}
