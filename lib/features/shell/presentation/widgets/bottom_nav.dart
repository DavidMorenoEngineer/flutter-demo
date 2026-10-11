import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../app_destination.dart';

/// All seven website nav items in one bar. Material's NavigationBar is capped
/// at five destinations, so this is a purpose-built equal-width bar.
class SxBottomNav extends StatelessWidget {
  const SxBottomNav({super.key, required this.selected, required this.onSelected});

  final AppDestination selected;
  final ValueChanged<AppDestination> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: SxColors.surface,
        border: Border(top: BorderSide(color: SxColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              for (final d in AppDestination.values)
                Expanded(child: _Item(destination: d, selected: d == selected, onTap: () => onSelected(d))),
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.destination, required this.selected, required this.onTap});

  final AppDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? SxColors.gold : SxColors.dim;
    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 34,
              height: 22,
              decoration: BoxDecoration(
                color: selected ? SxColors.gold.withValues(alpha: 0.18) : Colors.transparent,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Icon(selected ? destination.selectedIcon : destination.icon, size: 19, color: color),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(destination.label, maxLines: 1, style: SxText.body(10, color: color, weight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
