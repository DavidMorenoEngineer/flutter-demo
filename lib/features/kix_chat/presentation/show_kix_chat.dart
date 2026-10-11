import 'package:flutter/material.dart';

import '../../../core/layout/breakpoints.dart';
import '../../../core/theme/sx_colors.dart';
import 'widgets/kix_chat_panel.dart';

/// Opens Kix. Phones get a full-screen page; wide screens get the floating
/// panel anchored bottom-right, like the website's "Talk to Kix" widget.
/// The chat bloc is provided above `MaterialApp`, so history survives closing.
Future<void> showKixChat(BuildContext context) {
  if (!context.isExpanded) {
    return Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => KixChatPanel(onClose: () => Navigator.of(context).pop()),
      ),
    );
  }
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close Kix',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 220),
    transitionBuilder: (context, animation, _, child) => FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(animation),
        child: child,
      ),
    ),
    pageBuilder: (context, _, _) {
      final height = MediaQuery.sizeOf(context).height;
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              width: 440,
              height: (height - 48).clamp(360.0, 720.0),
              decoration: BoxDecoration(
                border: Border.all(color: SxColors.gold.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(22),
              ),
              child: KixChatPanel(onClose: () => Navigator.of(context).pop()),
            ),
          ),
        ),
      );
    },
  );
}
