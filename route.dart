part of dart_web;

typedef void handler(HttpRequest request);

void route(String path, Map handles, HttpRequest request) {
	print("About to route a request to " + path);
	if (handles[path] != null && handles[path] is handler) {
		handles[path](request);
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
