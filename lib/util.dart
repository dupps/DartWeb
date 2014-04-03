part of dart_web;

void log(String msg) {
  if (DartWebSettings.isDevelopMode()) {
    var date = (new DateTime.now()).toString();
    print("[$date] " + msg);
  }
}

class CleanupManager {
  static List<Function> cleanups = new List<Function>();

  static void addCleanup(Function f) => cleanups.add(f);

  static void init() {
    ProcessSignal.SIGINT.watch().listen((signal) {
      log("Starting cleanup...");
      cleanups.forEach((f) => f());
      log("Finished cleanup");
      exit(0);
    });
  }
}