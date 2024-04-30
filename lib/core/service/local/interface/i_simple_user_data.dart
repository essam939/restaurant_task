import 'dart:async';

import 'package:restaurant/core/utilities/defs.dart';



abstract class ISimpleUserData {

  Future<bool> containKey(String key);

  Future<String?> readString(String key);

  Future<int?> readInt(String key);

  Future<bool?> readBool(String key);

  Future<JsonMap?> readJsonMap(String key);

  FutureOr<bool> writeString(String key, String value);

  FutureOr<bool> writeInt(String key, int value);

  FutureOr<bool> writeBool(String key, bool value);

  FutureOr<bool> writeJsonMap(String key, JsonMap value);

  FutureOr<bool> delete(String key);
}
