import 'package:flutter/material.dart';

import '../../entities/user/user_entity.dart';

abstract class UserState with ChangeNotifier {
  UserEntity? _user;
  UserEntity? get user => _user;

  set user(UserEntity? user) {
    _user = user;
    notifyListeners();
  }
}
