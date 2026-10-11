import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/journey_step.dart';
import '../repositories/how_it_works_repository.dart';

@injectable
class GetHowItWorks implements UseCase<List<JourneyStep>, NoParams> {
  const GetHowItWorks(this._repository);

  final HowItWorksRepository _repository;

  @override
  Future<Either<Failure, List<JourneyStep>>> call(NoParams params) => _repository.fetch();
}
