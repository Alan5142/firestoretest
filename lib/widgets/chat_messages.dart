import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String senderName;
  final String message;
  final bool isMe;
  final DateTime createdAt;
  const ChatMessage(
      {super.key,
      required this.senderName,
      required this.message,
      required this.isMe,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(16.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              senderName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(message),
            Text(
              createdAt.toIso8601String().substring(11, 16),
              style: const TextStyle(
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
