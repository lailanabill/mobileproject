import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// DBHelper is a singleton class that provides methods for interacting with the SQLite database.
// It manages database initialization, creation, and CRUD operations for the 'projects' table.
class DBHelper {
  static final DBHelper instance = DBHelper._init(); // Singleton instance of DBHelper.
  static Database? _database; // Holds the reference to the database instance.

  DBHelper._init(); // Private constructor to ensure singleton implementation.

  // Getter for the database instance. Initializes the database if it is not already initialized.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('projects.db'); // Initializes the database with the given name.
    return _database!;
  }

  // Initializes the SQLite database.
  //
  // Parameters:
  // - filePath: Name of the database file.
  //
  // Returns:
  // - A reference to the opened database.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); // Gets the path for storing databases on the device.
    final path = join(dbPath, filePath); // Combines the path and file name.

    return await openDatabase(
      path,
      version: 1, // Database version for managing migrations.
      onCreate: _createDB, // Callback for database creation.
    );
  }

  // Creates the 'projects' table in the database.
  //
  // Parameters:
  // - db: The database instance.
  // - version: The version number of the database.
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS projects (
      id INTEGER PRIMARY KEY AUTOINCREMENT, // Auto-incrementing ID.
      name TEXT NOT NULL,                   // Name of the project.
      transcription TEXT NOT NULL           // Transcription associated with the project.
    )
  ''');
  }

  // Inserts a new project into the 'projects' table.
  //
  // Parameters:
  // - name: The name of the project.
  // - transcription: The transcription associated with the project.
  //
  // Returns:
  // - The ID of the inserted row.
  Future<int> insertProject(String name, String transcription) async {
    final db = await database;
    return await db.insert('projects', {'name': name, 'transcription': transcription});
  }

  // Deletes a project from the 'projects' table by its ID.
  //
  // Parameters:
  // - id: The ID of the project to delete.
  //
  // Returns:
  // - The number of rows affected.
  Future<int> deleteProject(int id) async {
    final db = await database;
    return await db.delete(
      'projects',
      where: 'id = ?', // Specifies the condition for deletion.
      whereArgs: [id], // Arguments for the condition.
    );
  }

  // Retrieves all projects from the 'projects' table.
  //
  // Returns:
  // - A list of maps, where each map represents a project.
  Future<List<Map<String, dynamic>>> getProjects() async {
    final db = await database;
    return await db.query('projects');
  }

  // Retrieves a project by its ID.
  //
  // Parameters:
  // - id: The ID of the project to retrieve.
  //
  // Returns:
  // - A map representing the project.
  Future<Map<String, dynamic>> getProjectById(int id) async {
    final db = await database;
    final result = await db.query('projects', where: 'id = ?', whereArgs: [id]);
    return result.first; // Returns the first (and only) result.
  }
}
