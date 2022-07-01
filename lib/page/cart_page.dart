import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_click_daily/models/home_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int counter = 0;
  List<Map<String, dynamic>> cartListData = [];

  @override
  void initState() {
    super.initState();
    getCart();
  }

  getCart() async {
    SharedPreferences cartData = await SharedPreferences.getInstance();
    if (cartData.getString('cart') == null ||
        cartData.getString('cart') == "") {
      cartListData = [];
      setState(() {

      });
    } else {
      List temp = json.decode(cartData.getString('cart'));
      List temp2 = temp.map((e) => e as Map<String, dynamic>).toList();
      cartListData = temp2;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Cart Product",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            color: Colors.green,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _cartCard(cartListData, counter, index);
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 8,
                );
              },
              itemCount: cartListData.length),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total ${cartListData.length} Item",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 100,
                      height: 2,
                      color: Colors.white,
                    ),
                    Text(
                      "Rp 192.000",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "Checkout",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _cartCard(List<Map<String, dynamic>> cartList,  counter, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartList[index]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.close,
                size: 24,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 80,
                padding: EdgeInsets.all(4),
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(cartList[index]['photo']),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Container(
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Rp. ${cartList[index]['price']}/ kg",
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
                              initialRating: cartList[index]['rating'],
                              minRating: cartList[index]['rating'],
                              maxRating: cartList[index]['rating'],
                              itemSize: 18,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: int.parse(cartList[index]['rating']
                                  .toString()
                                  .split("")
                                  .first),
                              onRatingUpdate: (value) {}),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  counter -= 1;
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text("-",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text("$counter"),
                              SizedBox(
                                width: 12,
                              ),
                              InkWell(
                                onTap: () {
                                  counter += 1;
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text("+",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
