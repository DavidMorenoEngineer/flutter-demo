import 'package:equatable/equatable.dart';

import '../../../advisors/domain/entities/advisor.dart';
import 'journey_map.dart';

enum ChatRole { user, kix }

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.role,
    this.text = '',
    this.map,
    this.advisor,
    this.quickReplies = const [],
    this.streaming = false,
  });

  final String id;
  final ChatRole role;
  final String text;
  final JourneyMap? map;
  final Advisor? advisor;
  final List<String> quickReplies;
  final bool streaming;

  ChatMessage copyWith({
    String? text,
    JourneyMap? map,
    Advisor? advisor,
    List<String>? quickReplies,
    bool? streaming,
  }) =>
      ChatMessage(
        id: id,
        role: role,
        text: text ?? this.text,
        map: map ?? this.map,
        advisor: advisor ?? this.advisor,
        quickReplies: quickReplies ?? this.quickReplies,
        streaming: streaming ?? this.streaming,
      );

  @override
  List<Object?> get props => [id, role, text, map, advisor, quickReplies, streaming];
}
