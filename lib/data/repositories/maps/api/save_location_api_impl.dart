import 'dart:convert';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/map_location/map_location_entity.dart';
import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<ExceptionEntity, void>> saveLocationApiImpl({
  required MapLocationEntity location,
  required String userId,
}) async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> locationsSp = sp.getStringList("${userId}_locations") ?? [];

    locationsSp.add(jsonEncode(location.toJson()));
    await sp.setStringList("${userId}_locations", locationsSp);

    return Right(null);
  } on Exception catch (e) {
    print("error on saveLocationApiImpl: $e");
    return Left(ExceptionEntity.fromException(e));
  }
}
