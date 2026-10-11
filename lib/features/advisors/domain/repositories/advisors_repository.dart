import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/advisor.dart';

abstract interface class AdvisorsRepository {
  Future<Either<Failure, List<Advisor>>> fetch();
}
