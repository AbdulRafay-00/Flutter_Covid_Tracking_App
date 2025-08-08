import 'dart:convert';

import 'package:covid_19_app/ApiModels/Models.dart';
import 'package:http/http.dart' as http;

class ApiResponce {
  Future<CovidData> fetchCovidData() async {
    final response = await http.get(
      Uri.parse("https://disease.sh/v3/covid-19/all"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data.cases?.toDouble());
      return CovidData.fromJson(data);
    } else {
      throw Exception("Failed to load COVID data");
    }
  }

  // Country List Function
  Future<List<CovidCountryData>> fetchCovidCountryData() async {
    List<CovidCountryData> list = [];
    final response = await http.get(
      Uri.parse("https://disease.sh/v3/covid-19/countries"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var item in data) {
        print("was in for loop");
        list.add(CovidCountryData.fromJson(item));
      }
      return list;
    } else {
      return throw Exception("Failed to load COVID data");
    }
    return list;
  }
}
