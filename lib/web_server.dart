part of dart_web;

class WebServer {
	static const num DEVELOP = 1;
	static const num TEST = 2;
	static const num PRODUCTION = 3;
	String _address;
	num _port;
	num _mode;
	Map _handles;

	WebServer(this._address, this._port, this._handles, [num mode]) {
		if (mode == null) {
			_mode = DEVELOP;
		}
	}

	void start(void router(String path, Map handles, HttpRequest request)) {
		if (isDevelopMode()) {
			print('Starting server at $_address:$_port');
		}
		HttpServer.bind(_address, _port).then((server) {
			server.listen((HttpRequest request) {
				String path = request.uri.toFilePath();
				router(path, _handles, request);
			});
		});
	}

	bool isDevelopMode() => this._mode == DEVELOP;
}