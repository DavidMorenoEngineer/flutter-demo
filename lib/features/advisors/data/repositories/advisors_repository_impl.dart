import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/advisor.dart';
import '../../domain/repositories/advisors_repository.dart';
import '../datasources/advisors_data_source.dart';

@LazySingleton(as: AdvisorsRepository)
class AdvisorsRepositoryImpl implements AdvisorsRepository {
  const AdvisorsRepositoryImpl(this._dataSource);

  final AdvisorsDataSource _dataSource;

  @override
  Future<Either<Failure, List<Advisor>>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
