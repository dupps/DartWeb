part of dart_web;

abstract class Controller {
	void handle(String method, HttpRequest request, Map<String, String> args);

	void writeValidHttpHeader(int statusCode, HttpResponse response) {
		response
			..statusCode = statusCode
			..headers.add(HttpHeaders.CONTENT_TYPE, "text/html");
	}
}

class TestController extends Controller{
	void handle(String method, HttpRequest request, Map<String, String> args) {
		super.writeValidHttpHeader(HttpStatus.OK, request.response);
		request.response
			..write("<html>")
			..write("<head><title>Ok Status</title></head>")
			..write("<body>")
			..write("<h1>This should be valid HTML</h1>")
			..write("</body>")
			..write("</html>")
			..close();
	}
}
