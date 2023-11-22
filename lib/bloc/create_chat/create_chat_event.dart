part of 'create_chat_bloc.dart';

sealed class CreateChatEvent extends Equatable {
  const CreateChatEvent();

  @override
  List<Object> get props => [];
}

final class NewChatEvent extends CreateChatEvent {}
