import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'resource_filter_cubit.freezed.dart';

@freezed
abstract class ResourceFilterState with _$ResourceFilterState {
  const factory ResourceFilterState({@Default('Everything') String category, @Default('') String query}) =
      _ResourceFilterState;
}

@injectable
class ResourceFilterCubit extends Cubit<ResourceFilterState> {
  ResourceFilterCubit() : super(const ResourceFilterState());

  void selectCategory(String category) => emit(state.copyWith(category: category));

  void search(String query) => emit(state.copyWith(query: query));
}
