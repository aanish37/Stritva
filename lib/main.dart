import 'package:flutter/material.dart';
import 'package:stritva/view/coming_soon.dart';
import './view/home_page.dart';
import './constant.dart';
import './model/note_data.dart';
import 'package:provider/provider.dart';

import './view/first/first.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      child: MaterialApp(
        title: 'Strtiva',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            textTheme: TextTheme(
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
                fontWeight: FontWeight.bold,
              ),
              titleSmall: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
            ),
            scaffoldBackgroundColor: backgroundColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: backgroundColor,
              selectedItemColor: buttonColor,
              unselectedItemColor: buttonColor,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            primarySwatch: Colors.pink,
            buttonTheme: ButtonThemeData(buttonColor: buttonColor)),
        home: Scaffold(resizeToAvoidBottomInset: false, body: FirstPage()),
      ),
    );
  }
}
