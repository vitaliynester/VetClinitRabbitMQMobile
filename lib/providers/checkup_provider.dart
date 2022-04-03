import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:veterinary_clinic_mobile/repositories/checkup_repository.dart';
import 'package:veterinary_clinic_mobile/services/services.dart';

import '../models/models.dart';

class CheckupProvider extends ChangeNotifier {
  late List<Checkup> activeCheckups;
  late List<Checkup> historyCheckups;

  int get totalCheckupsCount => activeCheckups.length;
  int get todayCheckupsCount {
    var date = DateTime.now();
    int count = 0;
    for (var checkup in activeCheckups) {
      if (checkup.checkupDate.day == date.day &&
          checkup.checkupDate.month == date.month &&
          checkup.checkupDate.year == date.year) {
        count += 1;
      }
    }
    return count;
  }

  Future<bool> getAllCheckups() async {
    try {
      var user = await UserService().getUser();
      var repos = CheckupRepository();
      activeCheckups = await repos.getActiveCheckups(user!.accessToken);
      historyCheckups = await repos.getHistoryCheckups(user.accessToken);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
