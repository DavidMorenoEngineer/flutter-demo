import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Domain-level error — the Left side of `Either<Failure, T>`.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.unexpected([String? message]) = UnexpectedFailure;
  const factory Failure.launch(String url) = LaunchFailure;
}
