import 'package:hive_flutter/hive_flutter.dart';
import 'user_session_save.dart';

Future<void> saveUserSession(UserSession session) async {
  final box = Hive.box<UserSession>('userSessionBox');
  await box.put('userSession', session); // Store the session with a key
}


import 'package:hive_flutter/hive_flutter.dart';
import 'user_session_save.dart';

UserSession? getUserSession() {
  final box = Hive.box<UserSession>('userSessionBox');
  return box.get('userSession');
}

