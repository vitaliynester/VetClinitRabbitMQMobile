import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:veterinary_clinic_mobile/models/models.dart';
import 'package:veterinary_clinic_mobile/pages/pages.dart';

import '../constants.dart';
import '../services/services.dart';
import 'widgets.dart';

class PreviewCardWidget extends StatelessWidget {
  final Checkup checkup;

  const PreviewCardWidget({
    Key? key,
    required this.checkup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!checkup.isActive) {
          NavigationService.push(context, DetailPage(checkup: checkup));
        } else {
          UtilService.showCustomDialog(context, () async {
            var service = CalendarService();
            var calendar = await service.retrieveDefaultCalendar();
            await service.createEventInCalendar(calendar!, checkup);
          });
        }
      },
      child: RoundedContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ФИО клиента',
              style: TextStyle(
                color: lineColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              checkup.clientName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryTextColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Питомец',
              style: TextStyle(
                color: lineColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${checkup.petKind} по кличке ${checkup.petName}, пол: ${checkup.petSex.toLowerCase()}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryTextColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Запись на',
              style: TextStyle(
                color: lineColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${checkup.checkupDate.day.toString().padLeft(2, "0")}.${checkup.checkupDate.month.toString().padLeft(2, "0")}.${checkup.checkupDate.year.toString().padLeft(2, "0")}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: primaryTextColor,
                fontSize: 18,
              ),
            ),
            !checkup.isActive
                ? const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      'Посмотреть подробности',
                      style: TextStyle(color: ancientColor),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
