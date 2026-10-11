import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/membership_offer.dart';
import '../../domain/repositories/membership_repository.dart';
import '../datasources/membership_data_source.dart';

@LazySingleton(as: MembershipRepository)
class MembershipRepositoryImpl implements MembershipRepository {
  const MembershipRepositoryImpl(this._dataSource);

  final MembershipDataSource _dataSource;

  @override
  Future<Either<Failure, MembershipOffer>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
