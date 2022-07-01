import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_click_daily/models/profile_model.dart';


class ProfileService {
  Future<ProfileResponse> getProfile() async {
    String url = "https://randomuser.me/api/";
    final response = await http.get(
      Uri.parse(url),
    );
    var errorStatus = json.decode(response.body);
    if (errorStatus != null) {
      return ProfileResponse.fromJson(jsonDecode(response.body));
    } else {
      return ProfileResponse.fromJson(jsonDecode(response.body));
    }
  }

}