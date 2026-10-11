import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/partners_content.dart';
import '../../domain/usecases/get_partners.dart';

@injectable
class PartnersCubit extends Cubit<Loadable<PartnersContent>> {
  PartnersCubit(this._getPartners) : super(const Loadable.loading());

  final GetPartners _getPartners;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getPartners(const NoParams());
    emit(result.fold(
      (failure) => Loadable<PartnersContent>.failure(failure),
      (data) => Loadable<PartnersContent>.success(data),
    ));
  }
}
