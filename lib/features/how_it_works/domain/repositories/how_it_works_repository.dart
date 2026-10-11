import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/journey_step.dart';

abstract interface class HowItWorksRepository {
  Future<Either<Failure, List<JourneyStep>>> fetch();
}
