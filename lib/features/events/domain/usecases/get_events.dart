import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/events_content.dart';
import '../repositories/events_repository.dart';

@injectable
class GetEvents implements UseCase<EventsContent, NoParams> {
  const GetEvents(this._repository);

  final EventsRepository _repository;

  @override
  Future<Either<Failure, EventsContent>> call(NoParams params) => _repository.fetch();
}
