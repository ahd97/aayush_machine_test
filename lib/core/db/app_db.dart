import 'package:hive/hive.dart';

import '../locator.dart';

class AppDB {
  static const _appDbBox = '_appDbBox';
  static const fcmKey = 'fcm_key';
  static const platform = 'platform';
  final Box<dynamic> _box;

  AppDB._(this._box);

  static Future<AppDB> getInstance() async {
    final box = await Hive.openBox<dynamic>(_appDbBox);
    return AppDB._(box);
  }

  T getValue<T>(dynamic key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue) as T;

  Future<void> setValue<T>(dynamic key, T value) => _box.put(key, value);

  bool get firstTime => getValue("firstTime", defaultValue: false);

  set firstTime(bool update) => setValue("firstTime", update);

  bool get isLogin => getValue("isLogin", defaultValue: false);

  set isLogin(bool update) => setValue("isLogin", update);

  String get token => getValue("token", defaultValue: "");

  set token(String update) => setValue("token", update);

  logout() {
    token = "";
    isLogin = false;
    firstTime = true;
  }
}

final appDB = locator<AppDB>();
