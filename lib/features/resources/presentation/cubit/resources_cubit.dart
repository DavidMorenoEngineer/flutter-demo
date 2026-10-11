import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/state/loadable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/resource_item.dart';
import '../../domain/usecases/get_resources.dart';

@injectable
class ResourcesCubit extends Cubit<Loadable<List<ResourceItem>>> {
  ResourcesCubit(this._getResources) : super(const Loadable.loading());

  final GetResources _getResources;

  Future<void> load() async {
    emit(const Loadable.loading());
    final result = await _getResources(const NoParams());
    emit(result.fold(
      (failure) => Loadable<List<ResourceItem>>.failure(failure),
      (data) => Loadable<List<ResourceItem>>.success(data),
    ));
  }
}
