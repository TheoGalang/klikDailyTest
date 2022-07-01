import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:test_click_daily/models/home_model.dart';
import 'package:test_click_daily/page/cart_page.dart';
import 'package:test_click_daily/page/home_page.dart';
import 'package:test_click_daily/page/profile_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  int counter = 0;
  List<Widget> _page = [];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 void initPage(){
   this._page = [
     HomePage(),
     CartPage(),
     ProfilePage()
   ];
 }

 @override
  void initState() {
    super.initState();
    initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: Container(
        height: 75,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => _onItemTapped(0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/home.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Visibility(
                      visible: _selectedIndex == 0 ? true : false,
                      child: Container(
                        color: Colors.green,
                        height: 2,
                        width: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => _onItemTapped(1),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/cart.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Cart",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Visibility(
                      visible: _selectedIndex == 1 ? true : false,
                      child: Container(
                        color: Colors.green,
                        height: 2,
                        width: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => _onItemTapped(2),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/profile.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Visibility(
                      visible: _selectedIndex == 2 ? true : false,
                      child: Container(
                        color: Colors.green,
                        height: 2,
                        width: 40,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: _page[_selectedIndex],
    );
  }
}





