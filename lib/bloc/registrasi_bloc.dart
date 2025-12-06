import 'dart:convert';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api_url.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi({
    String? nama,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"nama": nama, "email": email, "password": password};

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}
