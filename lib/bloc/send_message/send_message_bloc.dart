import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoretest/models/chat/message.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc() : super(SendMessageInitial()) {
    on<SendNewMessageEvent>(_handleSendMessage);
  }

  FutureOr<void> _handleSendMessage(
      SendNewMessageEvent event, Emitter<SendMessageState> emit) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      var currentUser = FirebaseAuth.instance.currentUser!;
      final chat = Message(
        senderId: userId,
        content: event.message,
        createdAt: DateTime.now(),
        senderName: currentUser.displayName ?? currentUser.email,
      );

      await FirebaseFirestore.instance
          .collection("chats")
          .doc(event.chatId)
          .collection("messages")
          .add(chat.toMap());

      await FirebaseFirestore.instance
          .collection("chats")
          .doc(event.chatId)
          .update({"lastModified": DateTime.now().toIso8601String()});
    } on FirebaseAuthException catch (e) {
      emit(SendMessageErrorState(e.message!));
    }
  }
}
