import 'package:firebase_core/firebase_core.dart';
import 'package:firestoretest/bloc/auth_bloc.dart';
import 'package:firestoretest/bloc/create_chat/create_chat_bloc.dart';
import 'package:firestoretest/bloc/send_message/send_message_bloc.dart';
import 'package:firestoretest/firebase_options.dart';
import 'package:firestoretest/pages/chat.dart';
import 'package:firestoretest/pages/home_page.dart';
import 'package:firestoretest/pages/login.dart';
import 'package:firestoretest/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => AuthBloc()..add(AuthCheckEvent())),
    BlocProvider(create: (context) => CreateChatBloc()),
    BlocProvider(create: (context) => SendMessageBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: {
        SignInScreen.routeName: (context) => const SignInScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomePage.routeName: (context) => HomePage(),
        ChatMessagesPage.routeName: (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return ChatMessagesPage(chatId: args['chatId'] as String);
        }
      },
    );
  }
}
