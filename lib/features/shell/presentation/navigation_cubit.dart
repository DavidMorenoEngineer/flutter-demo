import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_destination.dart';

@injectable
class NavigationCubit extends Cubit<AppDestination> {
  NavigationCubit() : super(AppDestination.home);

  void select(AppDestination destination) => emit(destination);

  /// Deep link for web/demos: `?tab=membership` (matches [AppDestination.name]).
  void selectByName(String? name) {
    for (final d in AppDestination.values) {
      if (d.name == name) return select(d);
    }
  }
}
