import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:finish_intern_prog/constants.dart';
import 'package:finish_intern_prog/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await windowManager.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(300, 300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(150, 300),
    alwaysOnTop: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

Future<void> appwriteTest() async {
  Client client = Client();
  Account account = Account(client);
  Database database = Database(client);

  client.setEndpoint('http://192.168.1.45:4442/v1').setProject('62b0b0eab2623ab9b180').setSelfSigned(status: true);

  print('-----------------------------------------');

  Session res = await account.createSession(email: 'samuel.michaux@gmail.com', password: '72683564&Sm');
  print(res);

  print('-----------------------------------------');

  Future result = database.createDocument(
    collectionId: '62b0b7957631dc91349f',
    documentId: 'user2',
    data: {'name': 'Samuel MICHAUX', 'age': 40},
  );

  print(result);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // appwriteTest();

    return MaterialApp(
      title: 'Check User Finish',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
