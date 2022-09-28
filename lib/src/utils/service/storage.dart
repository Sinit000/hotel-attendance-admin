import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';

class Storage {
  final storage = FlutterSecureStorage();
  Future<void> saveToken({required String token}) async {
    await storage.deleteAll();
    // await storage.write(key: 'name', value: user.name);
    // await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'token', value: token);
    // await storage.write(key: 'id', value: user.id);
    // await storage.write(key: 'verifyStatus', value: user.verifyStatus);
  }

  static List<String> convertStringtoListString({required String data}) {
    return json.decode(data);
  }

  Future<String?> getToken() async {
    // String name = await storage.read(key: 'name');
    // String phone = await storage.read(key: 'phone');
    String? token = await storage.read(key: 'token');
    // String id = await storage.read(key: 'id');
    // String verifyStatus = await storage.read(key: 'verifyStatus');
    // if (name != null &&
    //     phone != null &&
    //     token != null &&
    //     id != null &&
    //     verifyStatus != null)
    if (token != null) {
      return token;
    } else
      return null;
  }

  Future<void> removeToken() async {
    await storage.deleteAll();
    print("delete all token");
    return;
  }

  Future<void> saveSearchHistory({required String history}) async {
    await storage.write(key: "searchHistory", value: history);
    return;
  }

  Future<String?> getSearchHistory() async {
    return await storage.read(key: 'searchHistory');
  }

  Future<void> saveCurrentUser({required UserModel user}) async {
    await storage.deleteAll();

    await storage.write(key: "id", value: user.id);
    await storage.write(key: "name", value: user.name);
    await storage.write(key: "email", value: user.email);
    await storage.write(key: "token", value: user.token);
    print(user.id);
    print(user.name);
    print(user.email);
    print(user.token);

    // await storage.write(key: "type", value: user.type.toString());
    return;
  }

  // if user have logged in or not
  Future<UserModel?> getCurrentUser() async {
    String? _id = await storage.read(key: "id");
    String? _email = await storage.read(key: "email");
    String? _name = await storage.read(key: "name");

    String? _token = await storage.read(key: "token");

    //  String _type = await storage.read(key: "type");

    if ((_id != null) && _email != null && _token != null && _name != null) {
      return UserModel(
        id: _id,
        name: _name,
        email: _email,
        token: _token,
      );
    } else {
      return null;
    }
  }

  Future<void> deleteCurrentUser() async {
    await storage.deleteAll();
    return;
  }
}
