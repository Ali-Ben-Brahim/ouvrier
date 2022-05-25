// install get it

import 'package:get_it/get_it.dart';
import 'package:test/provider/conversation_provider.dart';

import '../services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => Auth());
  locator.registerLazySingleton(() => ConversationProvider());
}
