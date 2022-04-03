import 'models.dart';

class Checkup {
  late int id;
  late String clientName;
  late String petName;
  late String petKind;
  late String petSex;
  late DateTime checkupDate;
  CheckupData? data;

  bool get isActive => data == null;

  Checkup({
    required this.id,
    required this.clientName,
    required this.petName,
    required this.petKind,
    required this.petSex,
    required this.checkupDate,
  });

  Checkup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
    petName = json['pet_name'];
    petKind = json['pet_kind'];
    petSex = json['pet_sex'];
    checkupDate = DateTime.parse(json['checkup_date']);
    if (json.containsKey('checkup')) {
      data = CheckupData.fromJson(json['checkup']);
    }
  }
}
