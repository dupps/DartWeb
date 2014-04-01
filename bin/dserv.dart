import 'dart:core';

import 'package:args/args.dart';
import 'package:dart_web/dart_web.dart';

void main(List<String> arguments) {
	var parser = new ArgParser();
	parser
	..addOption('port', defaultsTo: '8080')
	..addOption('host', defaultsTo: '0.0.0.0');

	var opts = parser.parse(arguments);

	var host = opts["host"];
	var port = int.parse(opts["port"]);
	print("Host is $host");
	print("Port is $port");

	TestController cont = new TestController();
	Map handles = new Map();
	handles["/"] = cont.handle;
	WebServer server = new WebServer(host, port, handles);
	server.start(route);
}