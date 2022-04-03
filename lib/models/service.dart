class Service {
  late String name;
  late double price;

  Service({required this.name, required this.price});

  Service.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = double.parse(json['price'].toString());
  }
}
