import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserEntity?> getCurrentUserApiFake(String spKey) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  String? email = sp.getString(spKey);
  if (email != null) {
    return null;
  }
  return null;
}
