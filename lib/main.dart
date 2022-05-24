import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './Widgets/user_transcation.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          titleSmall: TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      home: UserTranscation(),
    );
  }
}
