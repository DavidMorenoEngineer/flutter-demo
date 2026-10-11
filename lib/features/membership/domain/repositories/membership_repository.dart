import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/membership_offer.dart';

abstract interface class MembershipRepository {
  Future<Either<Failure, MembershipOffer>> fetch();
}
