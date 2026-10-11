import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/loadable.dart';
import '../theme/sx_colors.dart';
import '../theme/sx_theme.dart';

/// Renders a `Loadable<T>` cubit: spinner, error, or the success builder.
class LoadableView<C extends StateStreamable<Loadable<T>>, T> extends StatelessWidget {
  const LoadableView({super.key, required this.builder});

  final Widget Function(BuildContext context, T data) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, Loadable<T>>(
      builder: (context, state) => switch (state) {
        LoadableLoading() => const Padding(
            padding: EdgeInsets.all(48),
            child: Center(child: CircularProgressIndicator(color: SxColors.gold)),
          ),
        LoadableSuccess(:final data) => builder(context, data),
        LoadableFailure() => Padding(
            padding: const EdgeInsets.all(48),
            child: Center(child: Text('Something went wrong', style: SxText.body(14, color: SxColors.muted))),
          ),
      },
    );
  }
}
