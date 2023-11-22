import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:firestoretest/bloc/auth_bloc.dart';
import 'package:firestoretest/bloc/create_chat/create_chat_bloc.dart';
import 'package:firestoretest/models/chat/chat.dart';
import 'package:firestoretest/pages/login.dart';
import 'package:firestoretest/widgets/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/';

  final chatsQuery = FirebaseFirestore.instance
      .collection("chats")
      .withConverter<Chat>(
        fromFirestore: (snapshot, _) => Chat.fromMap(snapshot.data()!),
        toFirestore: (chat, _) => chat.toMap(),
      )
      .where("chatters", arrayContains: FirebaseAuth.instance.currentUser?.uid)
      .orderBy("lastModified", descending: true);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          return _buildHomePage();
        } else if (state is AuthNotLoggedInState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          });
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FirestoreListView<Chat>(
        query: chatsQuery,
        itemBuilder: (context, doc) {
          var chat = doc.data();
          return ChatTile(
            chatId: doc.id,
            lastMessage: chat.messages?.isEmpty ?? true
                ? "No messages yet"
                : chat.messages?.last.content ?? "No messages yet",
            lastMessageTime: chat.messages?.isEmpty ?? true
                ? ""
                : chat.messages?.last.createdAt?.toIso8601String() ?? "",
          );
        },
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            BlocProvider.of<CreateChatBloc>(context).add(NewChatEvent());
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
