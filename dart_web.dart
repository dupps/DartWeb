library dart_web;

import 'dart:io';

part 'route.dart';
part 'web_server.dart';
part 'controller.dart';


void main() {
	TestController cont = new TestController();
	Map handles = new Map();
	handles["/"] = cont.handle;
	WebServer server = new WebServer("localhost", 8080, handles);
	server.start(route);
}