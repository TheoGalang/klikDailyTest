import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_click_daily/models/profile_model.dart';
import 'package:test_click_daily/services/profile_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileResponse profileData;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: profileData == null
          ? Center(child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/2,),
              CircularProgressIndicator(),
            ],
          ))
          : Column(
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  color: Colors.green,
                ),
                SizedBox(
                  height: 32,
                ),
                CachedNetworkImage(
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
                SizedBox(
                  height: 12,
                ),
                Text("${profileData.results[0].name.title} ${profileData.results[0].name.first} ${profileData.results[0].name.last}") ??
                    "",
                SizedBox(
                  height: 64,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64,
                      ),
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/ktp.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                                "${profileData.results[0].name.title} ${profileData.results[0].name.first}" ??
                                    "")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/email.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("${profileData.results[0].email}" ?? "")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/phone.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text("${profileData.results[0].phone}" ?? "")
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              width: 30,
                              height: 30,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${profileData.results[0].location.city}" ??
                                        ""),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "${profileData.results[0].location.street.name} ${profileData.results[0].location.street.number}" ??
                                        ""),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
