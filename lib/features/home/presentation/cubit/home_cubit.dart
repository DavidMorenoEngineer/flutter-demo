import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/usecases/get_home.dart';

@injectable
class HomeCubit extends Cubit<Loadable<HomeContent>> {
  HomeCubit(this._getHome) : super(const Loadable.loading());

  final GetHome _getHome;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getHome(const NoParams());
    emit(result.fold(
      (failure) => Loadable<HomeContent>.failure(failure),
      (data) => Loadable<HomeContent>.success(data),
    ));
  }
}
