import 'package:injectable/injectable.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/kix_event.dart';
import 'kix_engine.dart';

/// Seam for the model behind Kix. The default is the offline [KixEngine];
/// a remote LLM client would implement the same interface.
abstract interface class KixDataSource {
  Stream<KixEvent> reply(List<ChatMessage> history);
}

@LazySingleton(as: KixDataSource)
class ScriptedKixDataSource implements KixDataSource {
  ScriptedKixDataSource();

  final KixEngine _engine = const KixEngine();

  @override
  Stream<KixEvent> reply(List<ChatMessage> history) => _engine.reply(history);
}
