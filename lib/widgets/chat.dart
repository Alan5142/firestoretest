import 'package:firestoretest/pages/chat.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String lastMessage;
  final String lastMessageTime;
  final String chatId;
  const ChatTile(
      {super.key,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.chatId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatMessagesPage.routeName,
            arguments: {'chatId': chatId});
      },
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(lastMessage, overflow: TextOverflow.ellipsis),
        subtitle: Text(lastMessage),
        trailing: Text(lastMessageTime),
      ),
    );
  }
}
