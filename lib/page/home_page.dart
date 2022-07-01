import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_click_daily/models/home_model.dart';
import 'package:test_click_daily/models/profile_model.dart';
import 'package:test_click_daily/services/profile_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String type = "apple";

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cart = [];
  ProfileResponse profileData;

  @override
  void initState() {
    super.initState();
    getCartData();
    getProfile();
  }

  getProfile() {
    ProfileService().getProfile().then((response) => {
      if (response != null)
        {
          setState(() {
            profileData = response;
          }),
        }
      else
        {print("error")}
    });
    setState(() {});
  }

  void getCartData() async {
    SharedPreferences cartData = await SharedPreferences.getInstance();
    if (cartData.getString('cart') == null ||
        cartData.getString('cart') == "") {
      cart = [];
    } else {
      List temp = json.decode(cartData.getString('cart'));
      List temp2 = temp.map((e) => e as Map<String, dynamic>).toList();
      cart = temp2;

    }
  }

  void addToCart(Map<String, dynamic> dataCart) async {
    SharedPreferences cartData = await SharedPreferences.getInstance();
    cart.add(dataCart);
    String data = jsonEncode(cart);
    cartData.setString('cart', data);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Find",
                    style: TextStyle(color: Colors.orange, fontSize: 24),
                  ),
                  Text(
                    "Fresh Groceries",
                    style: TextStyle(color: Colors.green, fontSize: 24),
                  ),
                  SizedBox(
                    width: 32,
                  ),
                  profileData == null ? CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 30,
                  ) : CachedNetworkImage(
                    imageUrl: "${profileData.results[0].picture.medium}" ?? "",
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.green,
                ),
                border: OutlineInputBorder(),
                hintText: 'Search Groceries',
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Categories",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      type = "apple";
                    });
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: type != "apple"
                            ? Colors.grey.shade100
                            : Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Apple",
                          style: TextStyle(
                              color:
                                  type != "apple" ? Colors.grey : Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      type = "orange";
                    });
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: type != "orange"
                            ? Colors.grey.shade100
                            : Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Orange",
                          style: TextStyle(
                              color:
                                  type != "orange" ? Colors.grey : Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    type = "banana";
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: type != "banana"
                            ? Colors.grey.shade100
                            : Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text("Banana",
                          style: TextStyle(
                              color:
                                  type != "banana" ? Colors.grey : Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _cardFruit(HomeModel(), index, type);
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 16,
                  );
                },
                itemCount: HomeModel().appleCart.length),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardFruit(HomeModel fruits, index, type) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 80,
            padding: EdgeInsets.all(4),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(type == "apple"
                ? fruits.appleCart[index]['photo']
                : type == "orange"
                    ? fruits.orangeCart[index]['photo']
                    : fruits.bananasCart[index]['photo']),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    type == "apple"
                        ? fruits.appleCart[index]['name']
                        : type == "orange"
                            ? fruits.orangeCart[index]['name']
                            : fruits.bananasCart[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Rp. ${type == "apple" ? fruits.appleCart[index]['price'] : type == "orange" ? fruits.orangeCart[index]['price'] : fruits.bananasCart[index]['price']}/ kg",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                          itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                          initialRating: type == "apple"
                              ? fruits.appleCart[index]['rating']
                              : type == "orange"
                                  ? fruits.orangeCart[index]['rating']
                                  : fruits.bananasCart[index]['rating'],
                          minRating: type == "apple"
                              ? fruits.appleCart[index]['rating']
                              : type == "orange"
                                  ? fruits.orangeCart[index]['rating']
                                  : fruits.bananasCart[index]['rating'],
                          maxRating: type == "apple"
                              ? fruits.appleCart[index]['rating']
                              : type == "orange"
                                  ? fruits.orangeCart[index]['rating']
                                  : fruits.bananasCart[index]['rating'],
                          itemSize: 18,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: type == "apple"
                              ? int.parse(fruits.appleCart[index]['rating']
                                  .toString()
                                  .split("")
                                  .first)
                              : type == "orange"
                                  ? int.parse(fruits.orangeCart[index]['rating']
                                      .toString()
                                      .split("")
                                      .first)
                                  : int.parse(fruits.bananasCart[index]
                                          ['rating']
                                      .toString()
                                      .split("")
                                      .first),
                          onRatingUpdate: (value) {}),
                      InkWell(
                        onTap: () => addToCart(type == "apple"
                            ? fruits.appleCart[index]
                            : type == "orange"
                                ? fruits.orangeCart[index]
                                : fruits.bananasCart[index]),
                        child: Container(
                          width: 70,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text("Buy",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
