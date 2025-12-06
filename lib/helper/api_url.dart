class ApiUrl {
  static const String baseUrl = 'http://192.168.1.18:8080';

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listBahan = baseUrl + '/bahan';
  static const String createBahan = baseUrl + '/bahan';

  static String updateBahan(int id) {
    return baseUrl + '/bahan/' + id.toString();
  }

  static String showBahan(int id) {
    return baseUrl + '/bahan/' + id.toString();
  }

  static String deleteBahan(int id) {
    return baseUrl + '/bahan/' + id.toString();
  }
}
