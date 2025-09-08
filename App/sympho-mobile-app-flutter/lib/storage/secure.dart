import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageCrud {
  final storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<T?> read<T>(String key, {bool ignoreParse = false}) async {
    String? stored = await storage.read(key: key);
    if (stored != null) {
      if (!ignoreParse) {
        try {
          final parsed = json.decode(stored);
          return parsed as T;
        } catch (err) {
          return null;
        }
      } else {
        return stored as T;
      }
    }
    return null;
  }

  Future<bool> write(
    String key,
    dynamic data, {
    bool ignoreStringify = false,
  }) async {
    String stored;

    if (!ignoreStringify) {
      try {
        final stringify = json.encode(data);
        stored = stringify;
      } catch (err) {
        return false;
      }
    } else {
      stored = data;
    }

    try {
      await storage.write(key: key, value: stored);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<bool> delete(String key) async {
    try {
      await storage.delete(key: key);
      return true;
    } catch (err) {
      return false;
    }
  }
}
