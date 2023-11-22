part of 'create_chat_bloc.dart';

sealed class CreateChatState extends Equatable {
  const CreateChatState();

  @override
  List<Object> get props => [];
}

final class CreateChatInitial extends CreateChatState {}

final class CreateChatError extends CreateChatState {
  final String message;

  const CreateChatError(this.message);

  @override
  List<Object> get props => [message];
}
