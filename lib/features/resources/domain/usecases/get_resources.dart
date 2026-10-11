import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/resource_item.dart';
import '../repositories/resources_repository.dart';

@injectable
class GetResources implements UseCase<List<ResourceItem>, NoParams> {
  const GetResources(this._repository);

  final ResourcesRepository _repository;

  @override
  Future<Either<Failure, List<ResourceItem>>> call(NoParams params) => _repository.fetch();
}
