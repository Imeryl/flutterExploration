import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp defaultApp = await Firebase.initializeApp();
  runApp(const FlutterChatApp());
}

class FlutterChatApp extends StatelessWidget {
  const FlutterChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ChatScreen(),
    );
  }
}
