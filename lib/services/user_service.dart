import 'dart:convert';
import 'dart:developer';

import '../constants.dart';
import '../models/models.dart';
import 'services.dart';

class UserService {
  /// Авторизация пользователя
  ///
  /// Параметры:
  /// [login] - логин для авторизации
  /// [password] - пароль для авторизации
  ///
  /// Возвращаемое значение:
  /// [bool] - успешность авторизации пользователя
  Future<bool> authorizeUser(String login, String password) async {
    var url = apiUrl + 'api/v1/login';
    var body = {
      "login": login,
      "password": password,
    };
    try {
      var response = await NetworkService.post(url, {}, body);
      var user = User.fromJson(jsonDecode(response));
      return await StorageService.setValue('user', jsonEncode(user.toJson()));
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /// Получение данных пользователя
  ///
  /// Возвращаемое значение:
  /// [User] - заполненная модель пользователя или NULL
  Future<User?> getUser() async {
    var userRaw = await StorageService.getStringValue('user');
    try {
      var user = User.fromJson(jsonDecode(userRaw!));
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Проверяет авторизован ли пользователь
  ///
  /// Возвращаемое значение:
  /// [bool] - авторизован ли пользователь (наличие токена в памяти)
  Future<bool> isAuthorized() async {
    var token = await StorageService.getStringValue('user');
    return token != null;
  }

  /// Удаляет токен доступа из локального хранилища
  ///
  /// Возвращаемое значние:
  /// [bool] - удалось ли удалить данное значение
  Future<bool> logout() async {
    return await StorageService.removeValue('user');
  }
}
