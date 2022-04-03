import 'models.dart';

class CheckupData {
  late String diagnosis;
  late String treatment;
  late String complaints;
  late List<Service> services;
  late double sum;

  CheckupData({
    required this.diagnosis,
    required this.treatment,
    required this.complaints,
    required this.services,
    required this.sum,
  });

  CheckupData.fromJson(Map<String, dynamic> json) {
    diagnosis = json['diagnosis'];
    treatment = json['treatment'];
    complaints = json['complaints'];
    services =
        (json['services'] as List).map((e) => Service.fromJson(e)).toList();
    sum = double.parse(json['sum'].toString());
  }
}
