import 'package:flutter/material.dart';
import './view/home_page.dart';
import './constant.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey,
        
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          
          backgroundColor: backgroundColor,
          selectedItemColor: backgroundColor,
          unselectedItemColor:backgroundColor,

        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch:Colors.purple ,
      ),
      home:  HomePage(),
    );
  }
}
