// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  EventDao? _eventDaoInstance;

  LevelDao? _levelDaoInstance;

  MedalDao? _medalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `pranzo1` TEXT NOT NULL, `pranzo2` TEXT NOT NULL, `pranzo3` TEXT NOT NULL, `pranzo4` TEXT NOT NULL, `cena1` TEXT NOT NULL, `cena2` TEXT NOT NULL, `cena3` TEXT NOT NULL, `cena4` TEXT NOT NULL, `snack` TEXT NOT NULL, `colazione` TEXT NOT NULL, `from` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Level` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `counter` REAL NOT NULL, `livello` REAL NOT NULL, `a` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Medal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `medal1` INTEGER, `medal2` INTEGER, `medal3` INTEGER, `medal4` INTEGER, `medal5` INTEGER, `medal6` INTEGER, `medal7` INTEGER, `medal8` INTEGER, `medal9` INTEGER, `medal10` INTEGER, `medal11` INTEGER, `medal12` INTEGER, `medal13` INTEGER, `medal14` INTEGER, `medal15` INTEGER, `medal16` INTEGER, `medal17` INTEGER, `medal18` INTEGER, `medal19` INTEGER, `medal20` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }

  @override
  LevelDao get levelDao {
    return _levelDaoInstance ??= _$LevelDao(database, changeListener);
  }

  @override
  MedalDao get medalDao {
    return _medalDaoInstance ??= _$MedalDao(database, changeListener);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'pranzo1': item.pranzo1,
                  'pranzo2': item.pranzo2,
                  'pranzo3': item.pranzo3,
                  'pranzo4': item.pranzo4,
                  'cena1': item.cena1,
                  'cena2': item.cena2,
                  'cena3': item.cena3,
                  'cena4': item.cena4,
                  'snack': item.snack,
                  'colazione': item.colazione,
                  'from': _dateTimeConverter.encode(item.from)
                }),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'Event',
            ['id'],
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'pranzo1': item.pranzo1,
                  'pranzo2': item.pranzo2,
                  'pranzo3': item.pranzo3,
                  'pranzo4': item.pranzo4,
                  'cena1': item.cena1,
                  'cena2': item.cena2,
                  'cena3': item.cena3,
                  'cena4': item.cena4,
                  'snack': item.snack,
                  'colazione': item.colazione,
                  'from': _dateTimeConverter.encode(item.from)
                }),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'Event',
            ['id'],
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'pranzo1': item.pranzo1,
                  'pranzo2': item.pranzo2,
                  'pranzo3': item.pranzo3,
                  'pranzo4': item.pranzo4,
                  'cena1': item.cena1,
                  'cena2': item.cena2,
                  'cena3': item.cena3,
                  'cena4': item.cena4,
                  'snack': item.snack,
                  'colazione': item.colazione,
                  'from': _dateTimeConverter.encode(item.from)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Future<List<Event>> findAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event',
        mapper: (Map<String, Object?> row) => Event(
            row['id'] as int?,
            row['pranzo1'] as String,
            row['pranzo2'] as String,
            row['pranzo3'] as String,
            row['pranzo4'] as String,
            row['cena1'] as String,
            row['cena2'] as String,
            row['cena3'] as String,
            row['cena4'] as String,
            row['snack'] as String,
            row['colazione'] as String,
            _dateTimeConverter.decode(row['from'] as int)));
  }

  @override
  Future<void> insertEvent(Event meal) async {
    await _eventInsertionAdapter.insert(meal, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvent(Event meal) async {
    await _eventUpdateAdapter.update(meal, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEvent(Event task) async {
    await _eventDeletionAdapter.delete(task);
  }
}

class _$LevelDao extends LevelDao {
  _$LevelDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _levelInsertionAdapter = InsertionAdapter(
            database,
            'Level',
            (Level item) => <String, Object?>{
                  'id': item.id,
                  'counter': item.counter,
                  'livello': item.livello,
                  'a': item.a
                }),
        _levelUpdateAdapter = UpdateAdapter(
            database,
            'Level',
            ['id'],
            (Level item) => <String, Object?>{
                  'id': item.id,
                  'counter': item.counter,
                  'livello': item.livello,
                  'a': item.a
                }),
        _levelDeletionAdapter = DeletionAdapter(
            database,
            'Level',
            ['id'],
            (Level item) => <String, Object?>{
                  'id': item.id,
                  'counter': item.counter,
                  'livello': item.livello,
                  'a': item.a
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Level> _levelInsertionAdapter;

  final UpdateAdapter<Level> _levelUpdateAdapter;

  final DeletionAdapter<Level> _levelDeletionAdapter;

  @override
  Future<List<Level>> findAllLevels() async {
    return _queryAdapter.queryList('SELECT * FROM Level',
        mapper: (Map<String, Object?> row) => Level(
            row['id'] as int?,
            row['counter'] as double,
            row['livello'] as double,
            row['a'] as double));
  }

  @override
  Future<void> insertLevel(Level livello) async {
    await _levelInsertionAdapter.insert(livello, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateLevel(Level livello) async {
    await _levelUpdateAdapter.update(livello, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteLevel(Level livello) async {
    await _levelDeletionAdapter.delete(livello);
  }
}

class _$MedalDao extends MedalDao {
  _$MedalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _medalInsertionAdapter = InsertionAdapter(
            database,
            'Medal',
            (Medal item) => <String, Object?>{
                  'id': item.id,
                  'medal1': item.medal1,
                  'medal2': item.medal2,
                  'medal3': item.medal3,
                  'medal4': item.medal4,
                  'medal5': item.medal5,
                  'medal6': item.medal6,
                  'medal7': item.medal7,
                  'medal8': item.medal8,
                  'medal9': item.medal9,
                  'medal10': item.medal10,
                  'medal11': item.medal11,
                  'medal12': item.medal12,
                  'medal13': item.medal13,
                  'medal14': item.medal14,
                  'medal15': item.medal15,
                  'medal16': item.medal16,
                  'medal17': item.medal17,
                  'medal18': item.medal18,
                  'medal19': item.medal19,
                  'medal20': item.medal20
                }),
        _medalUpdateAdapter = UpdateAdapter(
            database,
            'Medal',
            ['id'],
            (Medal item) => <String, Object?>{
                  'id': item.id,
                  'medal1': item.medal1,
                  'medal2': item.medal2,
                  'medal3': item.medal3,
                  'medal4': item.medal4,
                  'medal5': item.medal5,
                  'medal6': item.medal6,
                  'medal7': item.medal7,
                  'medal8': item.medal8,
                  'medal9': item.medal9,
                  'medal10': item.medal10,
                  'medal11': item.medal11,
                  'medal12': item.medal12,
                  'medal13': item.medal13,
                  'medal14': item.medal14,
                  'medal15': item.medal15,
                  'medal16': item.medal16,
                  'medal17': item.medal17,
                  'medal18': item.medal18,
                  'medal19': item.medal19,
                  'medal20': item.medal20
                }),
        _medalDeletionAdapter = DeletionAdapter(
            database,
            'Medal',
            ['id'],
            (Medal item) => <String, Object?>{
                  'id': item.id,
                  'medal1': item.medal1,
                  'medal2': item.medal2,
                  'medal3': item.medal3,
                  'medal4': item.medal4,
                  'medal5': item.medal5,
                  'medal6': item.medal6,
                  'medal7': item.medal7,
                  'medal8': item.medal8,
                  'medal9': item.medal9,
                  'medal10': item.medal10,
                  'medal11': item.medal11,
                  'medal12': item.medal12,
                  'medal13': item.medal13,
                  'medal14': item.medal14,
                  'medal15': item.medal15,
                  'medal16': item.medal16,
                  'medal17': item.medal17,
                  'medal18': item.medal18,
                  'medal19': item.medal19,
                  'medal20': item.medal20
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Medal> _medalInsertionAdapter;

  final UpdateAdapter<Medal> _medalUpdateAdapter;

  final DeletionAdapter<Medal> _medalDeletionAdapter;

  @override
  Future<List<Medal>> findAllMedals() async {
    return _queryAdapter.queryList('SELECT * FROM Medal',
        mapper: (Map<String, Object?> row) => Medal(
            row['id'] as int?,
            row['medal1'] as int?,
            row['medal2'] as int?,
            row['medal3'] as int?,
            row['medal4'] as int?,
            row['medal5'] as int?,
            row['medal6'] as int?,
            row['medal7'] as int?,
            row['medal8'] as int?,
            row['medal9'] as int?,
            row['medal10'] as int?,
            row['medal11'] as int?,
            row['medal12'] as int?,
            row['medal13'] as int?,
            row['medal14'] as int?,
            row['medal15'] as int?,
            row['medal16'] as int?,
            row['medal17'] as int?,
            row['medal18'] as int?,
            row['medal19'] as int?,
            row['medal20'] as int?));
  }

  @override
  Future<void> insertMedals(Medal medaglie) async {
    await _medalInsertionAdapter.insert(medaglie, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMedals(Medal medaglie) async {
    await _medalUpdateAdapter.update(medaglie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMedals(Medal medaglie) async {
    await _medalDeletionAdapter.delete(medaglie);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
