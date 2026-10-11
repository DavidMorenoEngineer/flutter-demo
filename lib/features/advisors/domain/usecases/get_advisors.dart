import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/advisor.dart';
import '../repositories/advisors_repository.dart';

@injectable
class GetAdvisors implements UseCase<List<Advisor>, NoParams> {
  const GetAdvisors(this._repository);

  final AdvisorsRepository _repository;

  @override
  Future<Either<Failure, List<Advisor>>> call(NoParams params) => _repository.fetch();
}
