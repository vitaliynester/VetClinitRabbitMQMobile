import 'dart:developer';

import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart';

import '../models/models.dart' as models;

class CalendarService {
  late DeviceCalendarPlugin _deviceCalendarPlugin;

  CalendarService() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }

  Future<Calendar?> retrieveDefaultCalendar() async {
    try {
      var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionsGranted.isSuccess &&
          (permissionsGranted.data == null ||
              permissionsGranted.data == false)) {
        permissionsGranted = await _deviceCalendarPlugin.requestPermissions();
        if (!permissionsGranted.isSuccess ||
            permissionsGranted.data == null ||
            permissionsGranted.data == false) {
          return null;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      var calendars = calendarsResult.data as List<Calendar>;
      var defaultCalendar = calendars
          .where((element) => element.isDefault == true)
          .toList()
          .first;
      return defaultCalendar;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> createEventInCalendar(
    Calendar calendar,
    models.Checkup checkup,
  ) async {
    var startDate = _generateTZFromDT(checkup.checkupDate);
    var endDate = _generateTZFromDT(
      checkup.checkupDate.add(
        const Duration(minutes: 30),
      ),
    );
    var title =
        "Прием клиента ${checkup.clientName} с питомцем ${checkup.petName}";
    var description =
        'Прием: ${checkup.petKind} по кличке ${checkup.petName}, пол: ${checkup.petSex}';
    var event = Event(
      calendar.id,
      title: title,
      start: startDate,
      end: endDate,
      description: description,
      reminders: [Reminder(minutes: 15)],
    );
    try {
      await _deviceCalendarPlugin.createOrUpdateEvent(event);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  TZDateTime _generateTZFromDT(DateTime dt) {
    var result = TZDateTime.local(
      dt.year,
      dt.month,
      dt.day,
      dt.hour,
      dt.minute,
      dt.second,
      dt.millisecond,
      dt.microsecond,
    );
    return result;
  }
}
