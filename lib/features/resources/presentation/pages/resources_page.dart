import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../../core/widgets/loadable_view.dart';
import '../../../../core/widgets/page_body.dart';
import '../../../../core/widgets/responsive_grid.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../core/widgets/sx_card.dart';
import '../../domain/entities/resource_item.dart';
import '../cubit/resource_filter_cubit.dart';
import '../cubit/resources_cubit.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(children: [
      const SectionHeader(
        eyebrow: 'Resources',
        title: 'Answers, before you need them.',
        subtitle: 'Guides, templates and answers for people building something. Written to be used, not skimmed.',
      ),
      const SizedBox(height: 28),
      LoadableView<ResourcesCubit, List<ResourceItem>>(
        builder: (context, items) {
          final categories = ['Everything', ...{for (final i in items) i.category}.toList()..sort()];
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _SearchField(),
            const SizedBox(height: 16),
            _CategoryChips(categories: categories),
            const SizedBox(height: 24),
            BlocBuilder<ResourceFilterCubit, ResourceFilterState>(
              builder: (context, f) {
                final q = f.query.trim().toLowerCase();
                final shown = [
                  for (final i in items)
                    if ((f.category == 'Everything' || i.category == f.category) &&
                        (q.isEmpty || i.title.toLowerCase().contains(q)))
                      i,
                ];
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('SHOWING ${shown.length} OF ${items.length} PIECES', style: SxText.label(size: 10.5, color: SxColors.dim)),
                  const SizedBox(height: 14),
                  if (shown.isEmpty)
                    Text('Nothing matches that yet.', style: SxText.body(14, color: SxColors.muted))
                  else
                    ResponsiveGrid(
                      minTileWidth: 300,
                      maxColumns: 3,
                      children: [for (final i in shown) _ResourceCard(item: i)],
                    ),
                ]);
              },
            ),
          ]);
        },
      ),
    ]);
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: context.read<ResourceFilterCubit>().search,
      style: SxText.body(14),
      cursorColor: SxColors.gold,
      decoration: InputDecoration(
        hintText: 'Search guides, templates and tools',
        hintStyle: SxText.body(14, color: SxColors.dim),
        prefixIcon: const Icon(Icons.search_rounded, color: SxColors.muted),
        filled: true,
        fillColor: SxColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(99), borderSide: const BorderSide(color: SxColors.line)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(99), borderSide: const BorderSide(color: SxColors.gold)),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final selected = context.select((ResourceFilterCubit c) => c.state.category);
    return Wrap(spacing: 8, runSpacing: 8, children: [
      for (final c in categories)
        ChoiceChip(
          label: Text(c, style: SxText.body(12.5, color: c == selected ? SxColors.goldInk : SxColors.textSoft)),
          selected: c == selected,
          showCheckmark: false,
          selectedColor: SxColors.gold,
          backgroundColor: SxColors.surface,
          side: BorderSide(color: c == selected ? SxColors.gold : SxColors.line),
          shape: const StadiumBorder(),
          onSelected: (_) => context.read<ResourceFilterCubit>().selectCategory(c),
        ),
    ]);
  }
}

class _ResourceCard extends StatelessWidget {
  const _ResourceCard({required this.item});

  final ResourceItem item;

  @override
  Widget build(BuildContext context) {
    return SxCard(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(item.category.toUpperCase(), style: SxText.label(size: 10)),
        const SizedBox(height: 10),
        Text(item.title, style: SxText.display(22, weight: FontWeight.w600)),
        const SizedBox(height: 14),
        Text(item.isTool ? 'Open it →' : 'Read it →', style: SxText.body(12.5, color: SxColors.gold, weight: FontWeight.w600)),
      ]),
    );
  }
}
