import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final List<String>? chatters;
  final DateTime? createdAt;
  final DateTime? lastModified;
  final List<Message>? messages;

  const Chat({
    this.chatters,
    this.createdAt,
    this.lastModified,
    this.messages,
  });

  factory Chat.fromMap(Map<String, dynamic> data) => Chat(
        chatters: List<String>.from(data['chatters']),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        lastModified: data['lastModified'] == null
            ? null
            : DateTime.parse(data['lastModified'] as String),
        messages: (data['messages'] as List<dynamic>?)
            ?.map((e) => Message.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'chatters': chatters,
        'createdAt': createdAt?.toIso8601String(),
        'lastModified': lastModified?.toIso8601String(),
        'messages': messages?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Chat].
  factory Chat.fromJson(String data) {
    return Chat.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Chat] to a JSON string.
  String toJson() => json.encode(toMap());

  Chat copyWith({
    List<String>? chatters,
    DateTime? createdAt,
    DateTime? lastModified,
    List<Message>? messages,
  }) {
    return Chat(
      chatters: chatters ?? this.chatters,
      createdAt: createdAt ?? this.createdAt,
      lastModified: lastModified ?? this.lastModified,
      messages: messages ?? this.messages,
    );
  }

  @override
  List<Object?> get props {
    return [
      chatters,
      createdAt,
      lastModified,
      messages,
    ];
  }
}
