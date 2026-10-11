import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failure.dart';
import '../entities/chat_message.dart';
import '../entities/kix_event.dart';
import '../repositories/kix_repository.dart';

@injectable
class StreamKixReply {
  const StreamKixReply(this._repository);

  final KixRepository _repository;

  Stream<Either<Failure, KixEvent>> call(List<ChatMessage> history) => _repository.reply(history);
}
