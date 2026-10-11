import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_content.dart';
import '../repositories/home_repository.dart';

@injectable
class GetHome implements UseCase<HomeContent, NoParams> {
  const GetHome(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, HomeContent>> call(NoParams params) => _repository.fetch();
}
