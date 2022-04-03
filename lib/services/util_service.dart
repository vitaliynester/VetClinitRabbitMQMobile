import 'package:flutter/material.dart';

class UtilService {
  static void showSnackBar(BuildContext context, String body) {
    var snackBar = SnackBar(content: Text(body));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showCustomDialog(BuildContext context, VoidCallback function) {
    Widget cancelButton = TextButton(
      child: const Text("Отмена"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Продолжить"),
      onPressed: () {
        function();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Добавить событие"),
      content:
          const Text("Вы уверены, что хотите добавить событие в календарь?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
