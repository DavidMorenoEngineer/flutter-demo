import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/events_content.dart';
import '../../domain/usecases/get_events.dart';

@injectable
class EventsCubit extends Cubit<Loadable<EventsContent>> {
  EventsCubit(this._getEvents) : super(const Loadable.loading());

  final GetEvents _getEvents;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getEvents(const NoParams());
    emit(result.fold(
      (failure) => Loadable<EventsContent>.failure(failure),
      (data) => Loadable<EventsContent>.success(data),
    ));
  }
}
