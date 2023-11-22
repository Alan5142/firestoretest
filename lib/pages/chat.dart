import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:firestoretest/bloc/send_message/send_message_bloc.dart';
import 'package:firestoretest/models/chat/message.dart';
import 'package:firestoretest/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesPage extends StatefulWidget {
  static const routeName = '/chat-messages';
  final String chatId;
  late Query<Message> messagesQuery;

  ChatMessagesPage({super.key, required this.chatId}) {
    messagesQuery = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .withConverter<Message>(
          fromFirestore: (snapshot, _) => Message.fromMap(snapshot.data()!),
          toFirestore: (message, _) => message.toMap(),
        )
        .orderBy("createdAt", descending: false);
  }

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirestoreListView<Message>(
              query: widget.messagesQuery,
              itemBuilder: (context, doc) {
                var message = doc.data();
                return ChatMessage(
                  createdAt: message.createdAt!,
                  isMe: message.senderId ==
                      FirebaseAuth.instance.currentUser?.uid,
                  message: message.content!,
                  senderName: message.senderName!,
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a message',
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _textController.text.trim().isEmpty
                      ? null
                      : () {
                          BlocProvider.of<SendMessageBloc>(context).add(
                            SendNewMessageEvent(
                              chatId: widget.chatId,
                              message: _textController.text,
                            ),
                          );
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
