import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  
  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: _index==0?Icon(Icons.dashboard_rounded):Icon(Icons.dashboard_outlined) , label: 'Dashboard'),
            BottomNavigationBarItem(icon: _index==1?Icon(Icons.calendar_month_sharp): Icon(Icons.calendar_month_outlined), label: 'Search'),
            BottomNavigationBarItem(
                icon: _index==2?Icon(Icons.messenger_outlined): Icon(Icons.messenger_outline_outlined), label: 'Message'),
            BottomNavigationBarItem(
                icon:_index==3? Icon(Icons.manage_accounts_rounded):Icon(Icons.manage_accounts_outlined), label: 'Settings')
          ],
          currentIndex: _index,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: Text('Home Page'),
        ));
  }
}
