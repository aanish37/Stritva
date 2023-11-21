import 'package:flutter/material.dart';
import 'package:stritva/model/user_data.dart';
import 'package:stritva/view/splash_screen.dart';
import './constant.dart';
import './model/note_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteData(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (context) => UserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            textTheme: const TextTheme(
              bodyMedium: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w400,
              ),
              titleLarge: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(
                fontFamily: 'Ubuntu',
              ),
              titleSmall: TextStyle(
                fontFamily: 'Ubuntu',
              ),
            ),
            scaffoldBackgroundColor: backgroundColor,
            primarySwatch: Colors.pink,
            buttonTheme: ButtonThemeData(buttonColor: buttonColor)),
        home: const SplashScreen(),
      ),
    );
  }
}
