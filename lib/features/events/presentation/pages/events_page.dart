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
import '../../domain/entities/events_content.dart';
import '../cubit/event_filter_cubit.dart';
import '../cubit/events_cubit.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(children: [
      const SectionHeader(
        eyebrow: 'Learn. Connect. Move forward.',
        title: 'Opportunities are everywhere.',
        subtitle:
            'Events run online, livestreamed, or in person, hosted by colleges, nonprofits, banks, and companies in every state.',
      ),
      const SizedBox(height: 28),
      LoadableView<EventsCubit, EventsContent>(
        builder: (context, c) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('BROWSE BY STATE', style: SxText.label()),
          const SizedBox(height: 12),
          _StateChips(states: c.states),
          const SizedBox(height: 28),
          Text('UPCOMING EVENTS', style: SxText.label()),
          const SizedBox(height: 14),
          BlocBuilder<EventFilterCubit, EventFilterState>(
            builder: (context, filter) {
              final events = [
                for (final e in c.events)
                  if (filter.state == null || e.state == filter.state) e,
              ];
              if (events.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text('No events listed for ${filter.state} this week.', style: SxText.body(14, color: SxColors.muted)),
                );
              }
              return ResponsiveGrid(
                minTileWidth: 340,
                maxColumns: 2,
                children: [for (final e in events) _EventCard(event: e)],
              );
            },
          ),
          const SizedBox(height: 36),
          const _WaitlistCard(),
        ]),
      ),
    ]);
  }
}

class _StateChips extends StatelessWidget {
  const _StateChips({required this.states});

  final List<StateCount> states;

  @override
  Widget build(BuildContext context) {
    final selected = context.select((EventFilterCubit c) => c.state.state);
    Widget chip(String label, bool on, VoidCallback tap) => ChoiceChip(
          label: Text(label, style: SxText.body(12.5, color: on ? SxColors.goldInk : SxColors.textSoft)),
          selected: on,
          showCheckmark: false,
          selectedColor: SxColors.gold,
          backgroundColor: SxColors.surface,
          side: BorderSide(color: on ? SxColors.gold : SxColors.line),
          shape: const StadiumBorder(),
          onSelected: (_) => tap(),
        );
    final cubit = context.read<EventFilterCubit>();
    return Wrap(spacing: 8, runSpacing: 8, children: [
      chip('All states', selected == null, () => cubit.select(null)),
      for (final s in states) chip('${s.name} · ${s.count}', selected == s.name, () => cubit.select(s.name)),
    ]);
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context) {
    final icon = switch (event.format) {
      'In person' => Icons.place_outlined,
      'Livestream' => Icons.podcasts_rounded,
      _ => Icons.videocam_outlined,
    };
    return SxCard(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 16, color: SxColors.gold),
          const SizedBox(width: 6),
          Text(event.format.toUpperCase(), style: SxText.label(size: 10)),
          const Spacer(),
          Text(event.cost, style: SxText.body(11.5, color: SxColors.muted)),
        ]),
        const SizedBox(height: 12),
        Text(event.title, style: SxText.display(23, weight: FontWeight.w600)),
        const SizedBox(height: 10),
        Text('${event.host} · ${event.state}', style: SxText.body(12.5, color: SxColors.textSoft)),
        const SizedBox(height: 2),
        Text(event.when, style: SxText.body(12.5, color: SxColors.muted)),
      ]),
    );
  }
}

class _WaitlistCard extends StatelessWidget {
  const _WaitlistCard();

  @override
  Widget build(BuildContext context) {
    return SxCard(
      highlight: true,
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 24,
        runSpacing: 16,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('EVERY MONDAY', style: SxText.label()),
              const SizedBox(height: 8),
              Text('The list, before the week starts.', style: SxText.display(30)),
              const SizedBox(height: 6),
              Text(
                "Join the waitlist and get the week's events on Monday mornings, plus early access to SideKix.",
                style: SxText.body(13.5, color: SxColors.muted),
              ),
            ]),
          ),
          GoldButton(label: 'Join the waitlist', onPressed: () {}),
        ],
      ),
    );
  }
}
