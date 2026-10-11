import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'event_filter_cubit.freezed.dart';

@freezed
abstract class EventFilterState with _$EventFilterState {
  /// `state == null` means "All states".
  const factory EventFilterState({String? state}) = _EventFilterState;
}

@injectable
class EventFilterCubit extends Cubit<EventFilterState> {
  EventFilterCubit() : super(const EventFilterState());

  void select(String? state) => emit(EventFilterState(state: state));
}
