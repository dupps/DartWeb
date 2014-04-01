part of dart_web;

typedef void Handler(String method, HttpRequest request, Map<String, String> args);

class Router {
	Map<String, Handler> _handles;

	Router() {
		this._handles = new Map<String, Handler>();
	}

	void addHandle(String key, Handler handler) {
		this._handles[key] = handler;
	}

	void removeHandle(String key) {
		this._handles.remove(key);
	}

	void route(Uri uri, Map handles, HttpRequest request) {
		if (DartWebSettings.isDevelopMode()) {
			log("About to route a ${request.method} request to ${uri.path}");
		}
		if (handles[uri.path] != null && handles[uri.path] is Handler) {
			handles[uri.path](request.method, request, request.uri.queryParameters);
		} else {
			request.response
			..statusCode = HttpStatus.NOT_FOUND
			..headers.add(HttpHeaders.CONTENT_TYPE, "text/html")
			..write("<html><head><title>404 Not Found</title></head>")
			..write("<body><h1>The requested content could not be found</h1></body>")
			..write("</html>")
			..close();	
		}
	}

	void getHandles() {
		return this._handles;
	}
}