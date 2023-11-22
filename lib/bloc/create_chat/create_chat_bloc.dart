import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoretest/models/chat/chat.dart';

part 'create_chat_event.dart';
part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  CreateChatBloc() : super(CreateChatInitial()) {
    on<NewChatEvent>(_handleCreateChat);
  }

  FutureOr<void> _handleCreateChat(
      NewChatEvent event, Emitter<CreateChatState> emit) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final chat = Chat(
        chatters: [userId],
        messages: const [],
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
      );

      FirebaseFirestore.instance.collection("chats").doc().set(chat.toMap());
    } on FirebaseAuthException catch (e) {
      emit(CreateChatError(e.message!));
    }
  }
}
