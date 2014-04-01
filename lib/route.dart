part of dart_web;

typedef void Handler(String method, HttpRequest request, Map<String, String> args);

class Router {
	Map<String, Handler> _handles;
	Controller _defaultController;

	Router(this._defaultController) {
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
			this._defaultController.handle(request.method, request, request.uri.queryParameters);
		}
	}

	void getHandles() {
		return this._handles;
	}
}