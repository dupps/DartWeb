part of dart_web;

class DartWebSettings {
	static final DartWebSettings _singleton = new DartWebSettings._internal();

	factory DartWebSettings() {
		return _singleton;
	}

	static const num DEVELOP = 1;
	static const num TEST = 2;
	static const num PRODUCTION = 3;

	num _mode;

	static num getMode() => _singleton._mode;
	static bool isDevelopMode() => (_singleton._mode == DEVELOP);
	static bool isTestMode() => (_singleton._mode == TEST);
	static bool isProductionMode() => (_singleton._mode == PRODUCTION);

	static void parseMode(String mode) {
		switch(mode) {
			case "DEVELOP": _singleton._mode = DEVELOP; break;
			case "TEST": _singleton._mode = TEST; break;
			case "PRODUCTION": _singleton._mode = PRODUCTION; break;
			default: _singleton._mode = DEVELOP;
		}
	}

	DartWebSettings._internal() {
		_mode = DEVELOP;
	}
}