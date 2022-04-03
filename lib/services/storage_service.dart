import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /// Установка значения по ключу
  ///
  /// Параметры:
  /// [key] - ключ по которому необходимо установить значение
  /// [value] - устанавливаемое значение
  ///
  /// Возвращаемое значение:
  /// [bool] - успешность установки значения
  static Future<bool> setValue(String key, String value) async {
    var prefs = await _getPrefs();
    return await prefs.setString(key, value);
  }

  /// Удалить значение по ключу
  ///
  /// Параметры:
  /// [key] - ключ по которому необходимо удалить значение
  ///
  /// Возвращаемое значение:
  /// [bool] - успешность выполнения удаления
  static Future<bool> removeValue(String key) async {
    var prefs = await _getPrefs();
    return await prefs.remove(key);
  }

  /// Получение значения по ключу
  ///
  /// Параметры:
  /// [key] - ключ по которому необходимо получить значение
  ///
  /// Возвращаемое значение:
  /// [String] - полученное значение по указанному ключу или NULL
  static Future<String?> getStringValue(String key) async {
    var prefs = await _getPrefs();
    return prefs.getString(key);
  }

  /// Подготовка локального значения
  ///
  /// Возвращаемое значение:
  /// [SharedPreferences] - локальное хранилище
  static Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }
}
