part of dart_web;

class DatabaseConnector {
  static Future<Database> connectToPostgresDB(String uri) {
    Future future = postgresql.connect(uri);
    Completer completer = new Completer();

    future.then((conn) {
      PostgresDatabase db = new PostgresDatabase(conn);
      CleanupManager.addCleanup(() => db.disconnect());
      completer.complete(db);
    });

    return completer.future;
  }
}

abstract class Database {
  void createTable(String tableName, Map<String, String> columns);
  void dropTable(String tableName);
  void disconnect();
  bool isClosed();
  Map select(String statement);
}

class PostgresDatabase implements Database{
  Connection _conn;
  bool _closed;

  PostgresDatabase(this._conn) {
    _closed = false;
  }

  void createTable(String tableName, Map<String, String> columns) {
    String params = "";
    columns.forEach((k, v) => params += "$k $v");
    params = params.trim();
    String query = "CREATE TABLE $tableName ($params)";
    log("About to execute '$query'");
    _conn.execute(query).then((value) => log(value))
      .catchError((error) => log("$error"));
  }

  void dropTable(String tableName, {bool ifExists: true, bool cascade: false}) {
    String query = "DROP TABLE ";
    if (ifExists) {
      query += "IF EXISTS ";
    }
    query += tableName;
    if (cascade) {
      query += " CASCADE";
    }
    log("About to execute '$query'");
    _conn.execute(query).then((value) => log(value))
      .catchError((error) => log("$error"));
  }

  void disconnect() {
    _conn.onClosed.then((_) {
      _closed = true;
    });
    _conn.close();
  }

  bool isClosed() {
    return _closed;
  }
}
