import 'package:flutter/material.dart';
import '../constant.dart';
import 'coming_soon.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const ComingSoon();
                  }),
                );
              },
              color: buttonColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('asset/images/profile.png'),
                ),
              ),
            ),
          ],
          title: Text(
            'Stritva',
            style: TextStyle(
                fontWeight: FontWeight.w700, color: buttonColor, fontSize: 28),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: backgroundColor,
          elevation: 5,
          items: [
            BottomNavigationBarItem(
                icon: _index == 0
                    ? Icon(Icons.dashboard_rounded)
                    : Icon(Icons.dashboard_outlined),
                label: 'dashboard'),
            BottomNavigationBarItem(
                icon: _index == 1
                    ? Icon(Icons.calendar_month_sharp)
                    : Icon(Icons.calendar_month_outlined),
                label: 'calendar'),
            BottomNavigationBarItem(
                icon: _index == 2
                    ? Icon(Icons.tips_and_updates_sharp)
                    : Icon(Icons.tips_and_updates_outlined),
                label: 'info'),
            BottomNavigationBarItem(
                icon: _index == 3
                    ? Icon(Icons.manage_accounts_rounded)
                    : Icon(Icons.manage_accounts_outlined),
                label: 'Profile')
          ],
          currentIndex: _index,
          onTap: _onItemTapped,
        ),
        body: pages[_index]);
  }
}
