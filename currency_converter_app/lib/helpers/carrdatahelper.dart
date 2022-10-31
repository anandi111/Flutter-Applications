import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sky_scrapper_1/models/carrdata.dart';

class CarrAPIHelper {
  CarrAPIHelper._();

  static final CarrAPIHelper currAPIHelper = CarrAPIHelper._();

  Future<CurrData?> fetchingUserData(
      {required String From,
      required String To,
      required double amount,
      required String error}) async {
    http.Response response = await http.get(
        Uri.parse(
            "https://api.api-ninjas.com/v1/convertcurrency?want=$To&have=$From&amount=$amount"),
        headers: {'X-Api-Key': 'aiDw8vt6l6n27GVF9nevQBCvyM8T7ocC8QPYBiqZ'});

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      CurrData currData = CurrData(
          data: decodedData["new_amount"],
          error: decodedData["error"] ?? error);

      return currData;
    }
    return null;
  }
}
