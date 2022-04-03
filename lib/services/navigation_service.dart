import 'package:flutter/material.dart';

class NavigationService {
  static Future pushAndRemoveUntil(BuildContext context, Widget page) async {
    return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static Future push(BuildContext context, Widget page) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
