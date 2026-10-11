import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../domain/entities/journey_map.dart';
import '../bloc/kix_chat_bloc.dart';

/// The Journey Map Kix "draws" inside the conversation: milestones open into
/// finishable steps, and progress is tracked in the chat bloc.
class JourneyMapCard extends StatelessWidget {
  const JourneyMapCard({super.key, required this.messageId, required this.map});

  final String messageId;
  final JourneyMap map;

  @override
  Widget build(BuildContext context) {
    final done = context.select((KixChatBloc b) => b.state.doneSteps);
    final doneCount = done.where((id) => id.startsWith('$messageId:')).length;
    final progress = map.stepCount == 0 ? 0.0 : doneCount / map.stepCount;
    // Material (not a coloured DecoratedBox) so the ExpansionTiles' ink shows.
    return Material(
      color: SxColors.bgDeep,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: SxColors.gold.withValues(alpha: 0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.alt_route_rounded,
                  color: SxColors.gold,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'YOUR JOURNEY MAP',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: SxText.label(size: 10.5),
                  ),
                ),
                const Spacer(),
                Text(
                  '$doneCount / ${map.stepCount}',
                  style: SxText.label(size: 10.5, color: SxColors.muted),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(map.goal, style: SxText.display(22)),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: progress),
                duration: const Duration(milliseconds: 350),
                builder: (_, value, _) => LinearProgressIndicator(
                  value: value,
                  minHeight: 5,
                  backgroundColor: SxColors.surfaceHigh,
                  color: SxColors.gold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            for (var m = 0; m < map.milestones.length; m++)
              _MilestoneTile(
                messageId: messageId,
                index: m,
                milestone: map.milestones[m],
                initiallyOpen: m == 0,
              ),
          ],
        ),
      ),
    );
  }
}

class _MilestoneTile extends StatelessWidget {
  const _MilestoneTile({
    required this.messageId,
    required this.index,
    required this.milestone,
    required this.initiallyOpen,
  });

  final String messageId;
  final int index;
  final Milestone milestone;
  final bool initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final done = context.select((KixChatBloc b) => b.state.doneSteps);
    final finished = [
      for (var s = 0; s < milestone.steps.length; s++)
        done.contains(KixChatBloc.stepId(messageId, index, s)),
    ].where((d) => d).length;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyOpen,
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: 6),
        iconColor: SxColors.gold,
        collapsedIconColor: SxColors.muted,
        leading: CircleAvatar(
          radius: 13,
          backgroundColor: finished == milestone.steps.length
              ? SxColors.gold
              : SxColors.surfaceHigh,
          child: finished == milestone.steps.length
              ? const Icon(
                  Icons.check_rounded,
                  size: 16,
                  color: SxColors.goldInk,
                )
              : Text(
                  '${index + 1}',
                  style: SxText.label(size: 11, color: SxColors.goldLight),
                ),
        ),
        title: Text(
          milestone.title,
          style: SxText.body(
            14,
            weight: FontWeight.w600,
            color: SxColors.goldLight,
          ),
        ),
        subtitle: Text(
          milestone.summary,
          style: SxText.body(12, color: SxColors.muted),
        ),
        children: [
          for (var s = 0; s < milestone.steps.length; s++)
            _StepRow(
              stepId: KixChatBloc.stepId(messageId, index, s),
              text: milestone.steps[s],
              done: done.contains(KixChatBloc.stepId(messageId, index, s)),
            ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.stepId,
    required this.text,
    required this.done,
  });

  final String stepId;
  final String text;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => context.read<KixChatBloc>().add(KixStepToggled(stepId)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done ? SxColors.gold : Colors.transparent,
                border: Border.all(
                  color: done ? SxColors.gold : SxColors.dim,
                  width: 1.5,
                ),
              ),
              child: done
                  ? const Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: SxColors.goldInk,
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style:
                    SxText.body(
                      13,
                      color: done ? SxColors.dim : SxColors.text,
                    ).copyWith(
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
