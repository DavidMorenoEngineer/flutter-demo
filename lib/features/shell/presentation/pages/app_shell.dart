import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/layout/breakpoints.dart';
import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../kix_chat/presentation/show_kix_chat.dart';
import '../app_destination.dart';
import '../navigation_cubit.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/top_nav.dart';

/// Responsive scaffold: bottom navigation on phones, top navigation on wide
/// windows, and the "Talk to Kix" button floating over both.
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<NavigationCubit>().state;
    final cubit = context.read<NavigationCubit>();
    final wide = context.isExpanded;

    return Scaffold(
      appBar: wide ? SxTopNav(selected: selected, onSelected: cubit.select) : null,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selected.index,
          children: [
            for (final d in AppDestination.values)
              // Hidden tabs stop animating so they cost nothing off-screen.
              TickerMode(enabled: d == selected, child: d.pageBuilder()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showKixChat(context),
        backgroundColor: SxColors.gold,
        foregroundColor: SxColors.goldInk,
        icon: const Icon(Icons.auto_awesome_rounded),
        label: Text('Talk to Kix', style: SxText.body(14, color: SxColors.goldInk, weight: FontWeight.w600)),
      ),
      bottomNavigationBar: wide ? null : SxBottomNav(selected: selected, onSelected: cubit.select),
    );
  }
}
