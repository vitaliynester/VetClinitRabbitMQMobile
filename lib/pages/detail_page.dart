import 'package:flutter/material.dart';
import 'package:veterinary_clinic_mobile/models/models.dart';
import 'package:veterinary_clinic_mobile/widgets/widgets.dart';

import '../constants.dart';

class DetailPage extends StatelessWidget {
  final Checkup checkup;

  const DetailPage({
    Key? key,
    required this.checkup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'ФИО клиента:',
                    content: checkup.clientName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Кличка питомца:',
                    content: checkup.petName,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Вид питомца:',
                    content: checkup.petKind,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Пол питомца:',
                    content: checkup.petSex,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Дата приема:',
                    content:
                        "${checkup.checkupDate.day.toString().padLeft(2, '0')}.${checkup.checkupDate.month.toString().padLeft(2, '0')}.${checkup.checkupDate.year.toString().padLeft(2, '0')} ${checkup.checkupDate.hour.toString().padLeft(2, '0')}:${checkup.checkupDate.minute.toString().padLeft(2, '0')}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Диагноз:',
                    content: checkup.data!.diagnosis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Лечение:',
                    content: checkup.data!.treatment,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CardInfoWidget(
                    title: 'Жалобы:',
                    content: checkup.data!.complaints,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(height: 2),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Предоставленные услуги',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                _generateFields(checkup.data!.services),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RoundedContainerWidget(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Итоговая стоимость:',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          checkup.data!.sum.toStringAsFixed(2) + ' руб.',
                          style: const TextStyle(
                            color: primaryTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _generateFields(List<Service> fields) {
    var data = <Widget>[];
    for (var field in fields) {
      data.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CardInfoWidget(
            title: field.name,
            content: field.price.toStringAsFixed(2) + ' руб.',
          ),
        ),
      );
    }
    return Column(children: data);
  }
}
