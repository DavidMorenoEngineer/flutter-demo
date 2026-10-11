import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/events_content.dart';
import '../../domain/repositories/events_repository.dart';
import '../datasources/events_data_source.dart';

@LazySingleton(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(this._dataSource);

  final EventsDataSource _dataSource;

  @override
  Future<Either<Failure, EventsContent>> fetch() => TaskEither.tryCatch(
        _dataSource.fetch,
        (error, _) => Failure.unexpected(error.toString()),
      ).run();
}
