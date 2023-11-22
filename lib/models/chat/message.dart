import 'dart:convert';

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String? content;
  final String? senderId;
  final String? senderName;
  final DateTime? createdAt;

  const Message({
    this.content,
    this.senderId,
    this.senderName,
    this.createdAt,
  });

  factory Message.fromMap(Map<String, dynamic> data) => Message(
        content: data['content'] as String?,
        senderId: data['senderId'] as String?,
        senderName: data['senderName'] as String?,
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
      );

  Map<String, dynamic> toMap() => {
        'content': content,
        'senderId': senderId,
        'senderName': senderName,
        'createdAt': createdAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Message].
  factory Message.fromJson(String data) {
    return Message.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Message] to a JSON string.
  String toJson() => json.encode(toMap());

  Message copyWith({
    String? content,
    String? senderId,
    String? senderName,
    DateTime? createdAt,
  }) {
    return Message(
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [content, senderId, senderName, createdAt];
}
