part of dart_web;

class DatabaseConnector {
  static Future<Database> connectToPostgresDB(String uri) {
    Future future = postgresql.connect(uri);
    Completer completer = new Completer();

    future.then((conn) {
      completer.complete(new PostgresDatabase(conn));
    });

    return completer.future;
  }
}

abstract class Database {
  void createTable(String tableName, Map<String, String> columns);
  Map select(String statement);
}

class PostgresDatabase implements Database{
  Connection _conn;

  PostgresDatabase(this._conn);

  void createTable(String tableName, Map<String, String> columns) {
    String params = "";
    columns.forEach((k, v) => params += "$k $v ");
    String query = "CREATE TABLE $tableName ($params)" + params;
    if (DartWebSettings.isDevelopMode()) {
      log("About to execute $query");
    }
    _conn.execute("CREATE TABLE $tableName ($params)");
  }
}
