library dart_web;

import 'dart:io';

part 'dart_web_settings.dart';
part 'route.dart';
part 'web_server.dart';
part 'controller.dart';
part 'model.dart';

void log(String msg) {
	var date = (new DateTime.now()).toString();
	print("[$date] " + msg);
}