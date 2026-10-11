import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/kix_event.dart';
import '../../domain/repositories/kix_repository.dart';
import '../datasources/kix_data_source.dart';

@LazySingleton(as: KixRepository)
class KixRepositoryImpl implements KixRepository {
  const KixRepositoryImpl(this._dataSource);

  final KixDataSource _dataSource;

  @override
  Stream<Either<Failure, KixEvent>> reply(List<ChatMessage> history) async* {
    try {
      await for (final event in _dataSource.reply(history)) {
        yield right(event);
      }
    } catch (error) {
      yield left(Failure.unexpected(error.toString()));
    }
  }
}
