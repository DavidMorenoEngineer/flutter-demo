import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/membership_offer.dart';
import '../repositories/membership_repository.dart';

@injectable
class GetMembership implements UseCase<MembershipOffer, NoParams> {
  const GetMembership(this._repository);

  final MembershipRepository _repository;

  @override
  Future<Either<Failure, MembershipOffer>> call(NoParams params) => _repository.fetch();
}
