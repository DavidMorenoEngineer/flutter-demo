import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/advisor.dart';
import '../../domain/usecases/get_advisors.dart';

@injectable
class AdvisorsCubit extends Cubit<Loadable<List<Advisor>>> {
  AdvisorsCubit(this._getAdvisors) : super(const Loadable.loading());

  final GetAdvisors _getAdvisors;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getAdvisors(const NoParams());
    emit(result.fold(
      (failure) => Loadable<List<Advisor>>.failure(failure),
      (data) => Loadable<List<Advisor>>.success(data),
    ));
  }
}
