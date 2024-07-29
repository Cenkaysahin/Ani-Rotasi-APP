import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oua_bootcamp/pages/aipage.dart';
import 'package:oua_bootcamp/pages/gezipage.dart';
import 'package:oua_bootcamp/pages/homepage.dart';
import 'package:oua_bootcamp/pages/profilepage.dart';

class Navigationmenu extends StatefulWidget {
  const Navigationmenu({super.key});

  @override
  State<Navigationmenu> createState() => _NavigationmenuState();
}

class _NavigationmenuState extends State<Navigationmenu> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> _pages = [
    Aipage(),
    Gezipage(),
    Profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Color(0xffd6c6a6),
        buttonBackgroundColor: Color(0xff5e5235),
        color: Color(0xff34322c),
        animationDuration: Duration(milliseconds: 300),
        height: 60.0,
        items: [
          Icon(Icons.face, color: Colors.white),
          Icon(Icons.add_location_alt, color: Colors.white),
          Icon(Icons.photo_library_rounded, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
