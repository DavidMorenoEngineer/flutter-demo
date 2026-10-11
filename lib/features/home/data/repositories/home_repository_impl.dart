import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/home_content.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._dataSource);

  final HomeDataSource _dataSource;

  @override
  Future<Either<Failure, HomeContent>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
