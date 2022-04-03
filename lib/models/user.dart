class User {
  late String fullName;
  late String phone;
  late String accessToken;

  User({
    required this.fullName,
    required this.phone,
    required this.accessToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phone = json['phone'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'phone': phone,
        'access_token': accessToken,
      };
}
