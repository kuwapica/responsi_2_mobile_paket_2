import 'package:responsi_2_mobile_paket_2_h1d023070/helper/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}
