import 'package:freezed_annotation/freezed_annotation.dart';

import '../error/failure.dart';

part 'loadable.freezed.dart';

/// Generic async view state shared by every read-only feature cubit.
@freezed
sealed class Loadable<T> with _$Loadable<T> {
  const factory Loadable.loading() = LoadableLoading<T>;
  const factory Loadable.success(T data) = LoadableSuccess<T>;
  const factory Loadable.failure(Failure failure) = LoadableFailure<T>;
}
