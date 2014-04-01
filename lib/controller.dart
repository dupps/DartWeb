part of dart_web;

abstract class Controller {
	void handle(String method, HttpRequest request, Map<String, String> args);

	void writeValidHttpHeader(HttpResponse response) {
		response
			..statusCode = HttpStatus.OK
			..headers.add(HttpHeaders.CONTENT_TYPE, "text/html");
	}
}

class TestController extends Controller{
	void handle(String method, HttpRequest request, Map<String, String> args) {
		super.writeValidHttpHeader(request.response);
		request.response
			..statusCode = HttpStatus.OK
			..write("<html>")
			..write("<head><title>Ok Status</title></head>")
			..write("<body>")
			..write("<h1>This should be valid HTML</h1>")
			..write("</body>")
			..write("</html>")
			..close();
	}
}
