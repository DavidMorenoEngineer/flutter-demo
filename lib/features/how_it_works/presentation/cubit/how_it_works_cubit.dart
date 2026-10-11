import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/journey_step.dart';
import '../../domain/usecases/get_how_it_works.dart';

@injectable
class HowItWorksCubit extends Cubit<Loadable<List<JourneyStep>>> {
  HowItWorksCubit(this._getHowItWorks) : super(const Loadable.loading());

  final GetHowItWorks _getHowItWorks;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getHowItWorks(const NoParams());
    emit(result.fold(
      (failure) => Loadable<List<JourneyStep>>.failure(failure),
      (data) => Loadable<List<JourneyStep>>.success(data),
    ));
  }
}
