import 'package:flutter/material.dart';

import '../screen/postList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      PostListScreen(),
      Text(
        'FavoriteScreen',
        style: TextStyle(fontSize: 40),
      ),
      Text(
        'MenuScreen',
        style: TextStyle(fontSize: 40),
      ),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    side: BorderSide(color: Colors.red)))),
        child: Text("Sign out"),
      )
    ];

    return Scaffold(
      body: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xFF041e42),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.black54,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star), title: Text('Favorite')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), title: Text('Menu')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), title: Text('My')),
              ],
            ),
            body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          )),
      floatingActionButton: FloatingActionButton(
        heroTag: 'home',
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.navigation),
      ),
    );
  }
}
