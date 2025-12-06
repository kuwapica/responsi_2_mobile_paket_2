import 'dart:convert';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/api_url.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/model/bahan.dart';

class BahanBloc {
  static Future<List<Bahan>> getBahans() async {
    String apiUrl = ApiUrl.listBahan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listBahan = (jsonObj as Map<String, dynamic>)['data'];
    List<Bahan> bahans = [];
    for (int i = 0; i < listBahan.length; i++) {
      bahans.add(Bahan.fromJson(listBahan[i]));
    }
    return bahans;
  }

  static Future addBahan({Bahan? bahan}) async {
    String apiUrl = ApiUrl.createBahan;

    var body = {
      "nama": bahan!.namaBahan,
      "harga": bahan.hargaBahan.toString(),
      "jumlah": bahan.jumlahBahan.toString(),
      "tanggal_masuk": bahan.tanggalMasuk.toString(),
      "tanggal_kedaluwarsa": bahan.tanggalKedaluwarsa.toString(),
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateBahan({required Bahan bahan}) async {
    String apiUrl = ApiUrl.updateBahan(int.parse(bahan.id!));
    print(apiUrl);

    var body = {
      "nama": bahan!.namaBahan,
      "harga": bahan.hargaBahan.toString(),
      "jumlah": bahan.jumlahBahan.toString(),
      "tanggal_masuk": bahan.tanggalMasuk.toString(),
      "tanggal_kedaluwarsa": bahan.tanggalKedaluwarsa.toString(),
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteBahan({int? id}) async {
    String apiUrl = ApiUrl.deleteBahan(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
