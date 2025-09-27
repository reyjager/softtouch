import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:softtouch/app_widget.dart';
import 'package:softtouch/model/app_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(UserRoleAdapter())
    ..registerAdapter(AppUserAdapter());
  await Hive.openBox<AppUser>('current_user');

  runApp(MyApp());
}

