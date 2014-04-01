part of dart_web;

class WebServer {
	String _address;
	num _port;
	Map _handles;

	WebServer(this._address, this._port, this._handles);

	void start(void router(String path, Map handles, HttpRequest request)) {
		if (DartWebSettings.isDevelopMode()) {
			log('Starting server at $_address:$_port');
		}
		HttpServer.bind(_address, _port).then((server) {
			server.listen((HttpRequest request) {
				router(request.uri, _handles, request);
			});
		});
	}
}