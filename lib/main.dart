import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/helper/user_info.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/bahan_page.dart';
import 'package:responsi_2_mobile_paket_2_h1d023070/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const BahanPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris Bahan Makanan',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}
