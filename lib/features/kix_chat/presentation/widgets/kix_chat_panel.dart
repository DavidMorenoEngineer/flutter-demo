import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/sx_colors.dart';
import '../../../../core/theme/sx_theme.dart';
import '../bloc/kix_chat_bloc.dart';
import 'kix_avatar.dart';
import 'message_bubble.dart';

/// The chat itself — hosted full-screen on phones and in a floating panel on
/// wide screens (see `showKixChat`).
class KixChatPanel extends StatefulWidget {
  const KixChatPanel({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<KixChatPanel> createState() => _KixChatPanelState();
}

class _KixChatPanelState extends State<KixChatPanel> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    context.read<KixChatBloc>().add(KixMessageSent(text));
    _controller.clear();
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SxColors.bg,
      child: Column(
        children: [
          _Header(onClose: widget.onClose),
          const Divider(height: 1, color: SxColors.line),
          Expanded(
            child: BlocConsumer<KixChatBloc, KixChatState>(
              listenWhen: (a, b) => a.messages.length != b.messages.length || a.messages.last != b.messages.last,
              listener: (_, _) => _scrollToEnd(),
              builder: (context, state) {
                final last = state.messages.last;
                return ListView(
                  controller: _scroll,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  children: [
                    for (final m in state.messages) MessageBubble(key: ValueKey(m.id), message: m),
                    if (!state.replying && last.quickReplies.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 38, top: 6),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final r in last.quickReplies)
                              ActionChip(
                                label: Text(r, style: SxText.body(12.5, color: SxColors.goldLight)),
                                backgroundColor: SxColors.surface,
                                side: const BorderSide(color: SxColors.gold),
                                shape: const StadiumBorder(),
                                onPressed: () => _send(r),
                              ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          _Composer(controller: _controller, onSend: _send),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: Row(children: [
          const KixAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Kix', style: SxText.display(24)),
              Text('YOUR GUIDE · BEGIN. BUILD. BECOME.', style: SxText.label(size: 9, color: SxColors.muted)),
            ]),
          ),
          IconButton(
            tooltip: 'Start over',
            onPressed: () => context.read<KixChatBloc>().add(const KixChatReset()),
            icon: const Icon(Icons.restart_alt_rounded, color: SxColors.muted),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded, color: SxColors.muted),
          ),
        ]),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    final replying = context.select((KixChatBloc b) => b.state.replying);
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 12, 12),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: SxColors.line))),
        child: Row(children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: !replying,
              textInputAction: TextInputAction.send,
              onSubmitted: onSend,
              style: SxText.body(14),
              cursorColor: SxColors.gold,
              decoration: InputDecoration(
                hintText: replying ? 'Kix is typing…' : 'Tell Kix about your idea…',
                hintStyle: SxText.body(14, color: SxColors.dim),
                filled: true,
                fillColor: SxColors.surface,
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(99), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            onPressed: replying ? null : () => onSend(controller.text),
            style: IconButton.styleFrom(backgroundColor: SxColors.gold, foregroundColor: SxColors.goldInk),
            icon: const Icon(Icons.arrow_upward_rounded),
          ),
        ]),
      ),
    );
  }
}
