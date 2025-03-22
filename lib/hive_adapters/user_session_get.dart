import 'package:hive_flutter/hive_flutter.dart';
import 'user_session.dart';

UserSession? getUserSession() {
  final box = Hive.box<UserSession>('userSessionBox');
  return box.get('userSession');
}