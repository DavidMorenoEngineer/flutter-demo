import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/partners_content.dart';
import '../repositories/partners_repository.dart';

@injectable
class GetPartners implements UseCase<PartnersContent, NoParams> {
  const GetPartners(this._repository);

  final PartnersRepository _repository;

  @override
  Future<Either<Failure, PartnersContent>> call(NoParams params) => _repository.fetch();
}
