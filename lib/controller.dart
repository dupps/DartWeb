part of dart_web;

abstract class Controller {
	void handle(HttpRequest request);
}

class TestController {
	void handle(HttpRequest request) {
		request.response
			..statusCode = HttpStatus.OK
			..write("watanga")
			..close();
	}
}
