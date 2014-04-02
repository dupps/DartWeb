import 'dart:core';
import 'dart:io';


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

	var databaseUri = Platform.environment["DATABASE_URL"];
	if (databaseUri != null && !(databaseUri.isEmpty)) {
		DatabaseConnector.connectToPostgresDB(databaseUri).then((db) {
			db.createTable("Test", {"about" : "text"});
		});
	}

	DartWebSettings.parseMode(env);
	TestController cont = new TestController();
	Router router = new Router(new DefaultController());
	router.addHandle("/", cont.handle);
	WebServer server = new WebServer(host, port, router.getHandles());
	server.start(router.route);
}