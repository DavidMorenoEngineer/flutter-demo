import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/resource_item.dart';
import '../../domain/repositories/resources_repository.dart';
import '../datasources/resources_data_source.dart';

@LazySingleton(as: ResourcesRepository)
class ResourcesRepositoryImpl implements ResourcesRepository {
  const ResourcesRepositoryImpl(this._dataSource);

  final ResourcesDataSource _dataSource;

  @override
  Future<Either<Failure, List<ResourceItem>>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
