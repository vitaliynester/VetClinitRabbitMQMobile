import 'package:flutter/widgets.dart';

import '../models/models.dart';
import '../services/services.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User get user => _user!;

  /// Проверка авторизации пользователя с последующим его сохранением
  ///
  /// Возвращаемое значение:
  /// [User] - заполненная модель пользователя или NULL
  Future<User?> checkAuthorization() async {
    var userService = UserService();
    var isAuthorized = await userService.isAuthorized();
    if (isAuthorized) {
      var user = await userService.getUser();
      _user = user;
      notifyListeners();
      return user;
    }
    return null;
  }

  /// Обновить локально модель пользователя
  ///
  /// Принимаемые значения:
  /// [user] - локальная модель пользователя для сохранения
  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }
}
