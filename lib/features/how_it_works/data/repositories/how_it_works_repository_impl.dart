import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/journey_step.dart';
import '../../domain/repositories/how_it_works_repository.dart';
import '../datasources/how_it_works_data_source.dart';

@LazySingleton(as: HowItWorksRepository)
class HowItWorksRepositoryImpl implements HowItWorksRepository {
  const HowItWorksRepositoryImpl(this._dataSource);

  final HowItWorksDataSource _dataSource;

  @override
  Future<Either<Failure, List<JourneyStep>>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
