import 'dart:convert';

import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api_url.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
