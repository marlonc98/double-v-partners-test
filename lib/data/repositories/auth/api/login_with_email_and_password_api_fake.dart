import 'dart:convert';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserEntity?> _getUserOfSp({
  required String email,
  required String password,
  required String spKey,
}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<String> usersSp = sp.getStringList("${spKey}_users") ?? [];
  if (usersSp.isNotEmpty) {
    //get user where user.email and password are correct
    List<dynamic> mapped = usersSp.map((user) => jsonDecode(user)).toList();
    //get the correct
    for (var element in mapped) {
      UserEntity parsedUser = UserEntity.fromJson(element['user']);
      if (parsedUser.email == email && element["password"] == password) {
        return parsedUser;
      }
    }
  }
  return null;
}

Future<Either<ExceptionEntity, UserEntity>> loginWithEmailAndPasswordApiFake({
  required String email,
  required String password,
  required String spKey,
}) async {
  UserEntity? user = await _getUserOfSp(
    email: email,
    password: password,
    spKey: spKey,
  );
  if (user != null) {
    final secureStorage = FlutterSecureStorage();

    String parseData = jsonEncode({'email': email, 'password': password});
    await secureStorage.write(key: "${spKey}_current_user", value: parseData);
    await secureStorage.write(key: "${spKey}_email", value: email);
    return Right(user);
  } else {
    return Left(ExceptionEntity(code: KeyWordsLocalization.InvalidPassword));
  }
}
