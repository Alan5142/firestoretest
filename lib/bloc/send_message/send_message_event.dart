part of 'send_message_bloc.dart';

sealed class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object> get props => [];
}

final class SendNewMessageEvent extends SendMessageEvent {
  final String message;
  final String chatId;

  const SendNewMessageEvent({
    required this.message,
    required this.chatId,
  });

  @override
  List<Object> get props => [message, chatId];
}
