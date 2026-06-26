import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastDatabase {
  final String name;

  SembastDatabase(this.name);

  Future<Database> initialize() async {
    return await _initDatabase();
  }

  // Database instance
  Database? _db;

  // Database factory
  static DatabaseFactory get databaseFactory {
    if (kIsWeb) {
      return databaseFactoryWeb;
    } else {
      return databaseFactoryIo;
    }
  }

  // Get database instance
  Database get database {
    return _db!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    if (_db != null) {
      return _db!;
    }
    if (kIsWeb) {
      // Web platform
      _db = await databaseFactory.openDatabase(name);
    } else {
      // Native platform
      // Get the application documents directory
      final appDir = await getApplicationDocumentsDirectory();
      // Make sure it exists
      await appDir.create(recursive: true);
      // Build the database path
      final dbPath = join(appDir.path, name);
      // Open the database
      _db = await databaseFactory.openDatabase(dbPath);
    }
    return _db!;
  }
}
