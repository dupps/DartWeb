library dart_web;

import 'dart:io';
import 'dart:async';
import 'dart:mirrors' as mirrors;

import 'refl.dart';
import 'package:postgresql/postgresql.dart' as postgresql;

part 'dart_web_settings.dart';
part 'route.dart';
part 'web_server.dart';
part 'controller.dart';
part 'model.dart';
part 'database.dart';

void log(String msg) {
	var date = (new DateTime.now()).toString();
	print("[$date] " + msg);
}