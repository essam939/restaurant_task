import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant/core/utilities/defs.dart';

import 'local/interface/i_simple_user_data.dart';

class SimpleSecureData extends ISimpleUserData {

  final FlutterSecureStorage _pref;

  SimpleSecureData(this._pref);

  @override
  FutureOr<bool> delete(String key) async {
    try {
      await _pref.delete(key: key);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<String?> _read(String key) async {
    try {
      return _pref.read(key: key);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> readString(String key) async {
    return _read(key);
  }

  @override
  Future<int?> readInt(String key) async {
    final value = await _read(key);
    return value.let(int.tryParse);
  }

  @override
  Future<bool?> readBool(String key) async {
    final value = await _read(key);
    if (value == null) return null;
    return value == 'true';
  }

  @override
  Future<JsonMap?> readJsonMap(String key) async {
    final value = await _read(key);
    return value.let((data) => jsonDecode(data) as JsonMap);
  }

  FutureOr<bool> _write(String key, String value) async {
    try {
      await _pref.write(key: key, value: value);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  FutureOr<bool> writeBool(String key, bool value) async {
    return _write(key, value.toString());
  }

  @override
  FutureOr<bool> writeInt(String key, int value) async {
    return _write(key, value.toString());
  }

  @override
  FutureOr<bool> writeString(String key, String value) async {
    return _write(key, value);
  }

  @override
  FutureOr<bool> writeJsonMap(String key, JsonMap value) async {
    final data = jsonEncode(value);
    return _write(key, data);
  }

  @override
  Future<bool> containKey(String key) async {
    return _pref.read(key: key).then((value) => value != null);
  }
}
extension NullableObjectUtils<T> on T? {
  /// Apply the [mapper] to the value if it's not null,
  /// then return the result of the mapping operation.
  S? let<S>(S? Function(T it) mapper) {
    if (this is T) {
      return mapper(this as T);
    }
    return null;
  }

  /// Apply the [mapper] if provided and return the result.
  /// If the no mapper was provided return the object if it is of type [S]
  S? maybeLet<S>([S? Function(T it)? mapper]) {
    final value = this;
    if (value is T) {
      return mapper?.call(value);
    }
    if (value is S) {
      return value;
    }
    return null;
  }
}