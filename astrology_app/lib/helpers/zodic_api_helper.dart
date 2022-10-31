import 'dart:convert';
import 'package:astrology_app/modals/zodic.dart';
import 'package:http/http.dart' as http;

class ZodicAPIHelper {
  ZodicAPIHelper._();

  static final ZodicAPIHelper zodicAPIHelper = ZodicAPIHelper._();

  Future<Zodic?> fetchingUserData({required String sign}) async {
    http.Response response = await http.get(
      Uri.parse(
          "https://any.ge/horoscope/api/?sign=$sign&type=daily&day=today&lang=en"),
    );

    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);

      Zodic zodic = Zodic(
        date: decodedData[0]["date"],
        discription: decodedData[0]["text"].split(">")[1].split("<")[0],
      );

      return zodic;
    }
    return null;
  }
}
