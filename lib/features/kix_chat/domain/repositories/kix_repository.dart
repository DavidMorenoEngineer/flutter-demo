import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../entities/chat_message.dart';
import '../entities/kix_event.dart';

abstract interface class KixRepository {
  /// Streams Kix's reply to the last user message in [history].
  Stream<Either<Failure, KixEvent>> reply(List<ChatMessage> history);
}
