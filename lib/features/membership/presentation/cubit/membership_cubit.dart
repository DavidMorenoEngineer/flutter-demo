import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/membership_offer.dart';
import '../../domain/usecases/get_membership.dart';

@injectable
class MembershipCubit extends Cubit<Loadable<MembershipOffer>> {
  MembershipCubit(this._getMembership) : super(const Loadable.loading());

  final GetMembership _getMembership;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getMembership(const NoParams());
    emit(result.fold(
      (failure) => Loadable<MembershipOffer>.failure(failure),
      (data) => Loadable<MembershipOffer>.success(data),
    ));
  }
}
