// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorStudentDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StudentDatabaseBuilder databaseBuilder(String name) =>
      _$StudentDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$StudentDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$StudentDatabaseBuilder(null);
}

class _$StudentDatabaseBuilder {
  _$StudentDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$StudentDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$StudentDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<StudentDatabase> build() async {
    final path = name != null
        ? join(await sqflite.getDatabasesPath(), name)
        : ':memory:';
    final database = _$StudentDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$StudentDatabase extends StudentDatabase {
  _$StudentDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StudentDao _studentDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Student` (`studentID` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  StudentDao get studentDao {
    return _studentDaoInstance ??= _$StudentDao(database, changeListener);
  }
}

class _$StudentDao extends StudentDao {
  _$StudentDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _studentInsertionAdapter = InsertionAdapter(
            database,
            'Student',
            (Student item) => <String, dynamic>{
                  'studentID': item.studentID,
                  'name': item.name
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _studentMapper = (Map<String, dynamic> row) =>
      Student(studentID: row['studentID'] as int, name: row['name'] as String);

  final InsertionAdapter<Student> _studentInsertionAdapter;

  @override
  Stream<List<Student>> getAllStudents() {
    return _queryAdapter.queryListStream('SELECT * FROM Student',
        tableName: 'Student', mapper: _studentMapper);
  }

  @override
  Future<void> insertStudent(Student student) async {
    await _studentInsertionAdapter.insert(
        student, sqflite.ConflictAlgorithm.abort);
  }
}
