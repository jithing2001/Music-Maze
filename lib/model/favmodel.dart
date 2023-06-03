import 'package:hive_flutter/hive_flutter.dart';

part 'favmodel.g.dart';

@HiveType(typeId: 0)
class Favmodel extends HiveObject {
  @HiveField(0)
  int? id;

  Favmodel({required this.id});
}
