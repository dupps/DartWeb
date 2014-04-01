import 'dart:core';

import 'package:args/args.dart';
import 'package:dart_web/dart_web.dart';

void main(List<String> arguments) {
	var parser = new ArgParser();
	parser
	..addOption('port', defaultsTo: '8080')
	..addOption('env', defaultsTo: 'DEVELOP')
	..addOption('host', defaultsTo: '0.0.0.0');

	var opts = parser.parse(arguments);

	var host = opts["host"];
	var port = int.parse(opts["port"]);
	var env = opts["env"];

	DartWebSettings.parseMode(env);
	TestController cont = new TestController();
	Router router = new Router();
	router.addHandle("/", cont.handle);
	WebServer server = new WebServer(host, port, router.getHandles());
	server.start(router.route);
}