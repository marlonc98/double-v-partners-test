import 'dart:convert';

import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserEntity?> _getUserOfSp({
  required String email,
  required String spKey,
}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  print("spKey: $spKey");
  List<String> usersSp = sp.getStringList("${spKey}_users") ?? [];
  print("usersSp _getUser: $usersSp");
  if (usersSp.isNotEmpty) {
    List<dynamic> mapped = usersSp.map((user) => jsonDecode(user)).toList();
    for (var element in mapped) {
      UserEntity parsedUser = UserEntity.fromJson(element['user']);
      if (parsedUser.email == email) {
        return parsedUser;
      }
    }
  }
  return null;
}

Future<Either<ExceptionEntity, UserEntity>> signUpWithEmailAndPasswordApiFake({
  required String email,
  required String password,
  required String name,
  required DateTime birthDate,
  required String spKey,
}) async {
  try {
    UserEntity? existingUser = await _getUserOfSp(email: email, spKey: spKey);

    if (existingUser != null) {
      return Left(
        ExceptionEntity(code: KeyWordsLocalization.EmailAlreadyInUse),
      );
    }

    UserEntity newUser = UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      birthday: birthDate,
    );

    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> usersSp = sp.getStringList("${spKey}_users") ?? [];
    usersSp.add(jsonEncode({"password": password, "user": newUser.toJson()}));
    await sp.setStringList("${spKey}_users", usersSp);

    final secureStorage = FlutterSecureStorage();

    String parseData = jsonEncode({'email': email, 'password': password});
    await secureStorage.write(key: "${spKey}_current_user", value: parseData);
    await secureStorage.write(key: "${spKey}_email", value: email);

    return Right(newUser);
  } on Exception catch (e) {
    return Left(ExceptionEntity.fromException(e));
  }
}
