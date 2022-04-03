import 'dart:convert';
import 'dart:developer';

import 'package:veterinary_clinic_mobile/models/models.dart';

import '../constants.dart';
import '../services/services.dart';

class CheckupRepository {
  Future<List<Checkup>> getActiveCheckups(String token) async {
    var url = apiUrl + 'api/v1/checkups';
    var headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await NetworkService.get(url, headers);
      var result = (jsonDecode(response) as List)
          .map((e) => Checkup.fromJson(e))
          .toList();
      return result;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<Checkup>> getHistoryCheckups(String token) async {
    var url = apiUrl + 'api/v1/checkups/history';
    var headers = {
      'Authorization': 'Bearer $token',
    };
    try {
      var response = await NetworkService.get(url, headers);
      var result = (jsonDecode(response) as List)
          .map((e) => Checkup.fromJson(e))
          .toList();
      return result;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
