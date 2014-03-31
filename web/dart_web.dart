library dart_web;

import 'dart:io';

part 'route.dart';
part 'web_server.dart';
part 'controller.dart';


void main() {
	ArgParser parser = new ArgParser();
	parser
	..addOption('port', defaultsTo: '8080')
	..addOption('host', defaultsTo: '0.0.0.0');

	List<String> argv = (new Options()).arguments;
	var opts = parser.parse(argv);

	var host = opts["host"];
	var port = opts["port"];

	TestController cont = new TestController();
	Map handles = new Map();
	handles["/"] = cont.handle;
	WebServer server = new WebServer(host, port, handles);
	server.start(route);
}