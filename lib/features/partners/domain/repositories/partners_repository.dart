import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/partners_content.dart';

abstract interface class PartnersRepository {
  Future<Either<Failure, PartnersContent>> fetch();
}
