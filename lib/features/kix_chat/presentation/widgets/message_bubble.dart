import 'package:flutter/material.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../../../advisors/domain/entities/advisor.dart';
import '../../domain/entities/chat_message.dart';
import 'journey_map_card.dart';
import 'kix_avatar.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    final maxWidth = MediaQuery.sizeOf(context).width;
    final bubbleMax = (maxWidth * 0.8).clamp(0.0, 360.0);
    final hasText = message.text.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[const KixAvatar(size: 30), const SizedBox(width: 8)],
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: message.map != null ? 420 : bubbleMax),
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (hasText || message.streaming)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: isUser ? SxColors.gold : SxColors.surfaceHigh,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 4),
                          bottomRight: Radius.circular(isUser ? 4 : 16),
                        ),
                      ),
                      child: hasText
                          ? Text(
                              message.text,
                              style: SxText.body(14, color: isUser ? SxColors.goldInk : SxColors.text),
                            )
                          : const _TypingDots(),
                    ),
                  if (message.map != null) ...[
                    const SizedBox(height: 8),
                    JourneyMapCard(messageId: message.id, map: message.map!),
                  ],
                  if (message.advisor != null) ...[
                    const SizedBox(height: 8),
                    _AdvisorChip(advisor: message.advisor!),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvisorChip extends StatelessWidget {
  const _AdvisorChip({required this.advisor});

  final Advisor advisor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: SxColors.bgDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SxColors.line),
      ),
      child: Row(children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: SxColors.gold,
          child: Text(advisor.initials, style: SxText.body(14, color: SxColors.goldInk, weight: FontWeight.w700)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(advisor.name, style: SxText.body(14, weight: FontWeight.w600, color: SxColors.goldLight)),
            Text(advisor.title, style: SxText.body(12, color: SxColors.muted)),
            const SizedBox(height: 4),
            Text(advisor.level.toUpperCase(), style: SxText.label(size: 9.5)),
          ]),
        ),
      ]),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 20,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, _) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < 3; i++)
              Opacity(
                opacity: 0.35 + 0.65 * (((_c.value * 3 - i) % 3) < 1 ? 1 - ((_c.value * 3 - i) % 3) : 0),
                child: const CircleAvatar(radius: 3.5, backgroundColor: SxColors.goldLight),
              ),
          ],
        ),
      ),
    );
  }
}
