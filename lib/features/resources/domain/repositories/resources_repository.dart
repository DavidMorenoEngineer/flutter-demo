import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/resource_item.dart';

abstract interface class ResourcesRepository {
  Future<Either<Failure, List<ResourceItem>>> fetch();
}
