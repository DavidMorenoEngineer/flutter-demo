import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/home_content.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, HomeContent>> fetch();
}
