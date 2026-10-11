import 'package:flutter/material.dart';

import '../../../../core/layout/breakpoints.dart';
import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../app_destination.dart';

/// Website-style header for wide windows: brand left, seven links right.
class SxTopNav extends StatelessWidget implements PreferredSizeWidget {
  const SxTopNav({super.key, required this.selected, required this.onSelected});

  final AppDestination selected;
  final ValueChanged<AppDestination> onSelected;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: SxColors.bg,
        border: Border(bottom: BorderSide(color: SxColors.line)),
      ),
      padding: EdgeInsets.symmetric(horizontal: context.gutter),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Breakpoints.contentMaxWidth),
          child: Row(children: [
            Text('SideKix', style: SxText.display(32, color: SxColors.goldLight, weight: FontWeight.w700)),
            const SizedBox(width: 24),
            // Scales the seven links down instead of overflowing on ~900px windows.
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  for (final d in AppDestination.values)
                    _Link(destination: d, selected: d == selected, onTap: () => onSelected(d)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({required this.destination, required this.selected, required this.onTap});

  final AppDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            destination.label,
            style: SxText.body(13.5, color: selected ? SxColors.gold : SxColors.muted, weight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 2,
            width: selected ? 22 : 0,
            color: SxColors.gold,
          ),
        ]),
      ),
    );
  }
}
