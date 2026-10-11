import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/partners_content.dart';
import '../../domain/repositories/partners_repository.dart';
import '../datasources/partners_data_source.dart';

@LazySingleton(as: PartnersRepository)
class PartnersRepositoryImpl implements PartnersRepository {
  const PartnersRepositoryImpl(this._dataSource);

  final PartnersDataSource _dataSource;

  @override
  Future<Either<Failure, PartnersContent>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
