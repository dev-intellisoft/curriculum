import 'dart:io';
import 'package:curriculum/core/classes/resume.dart';
import 'package:curriculum/core/classes/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'resume.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        username TEXT,
        password TEXT
      )
      ''');

    await db.execute('''
      CREATE TABLE resumes(
        resume_id INTEGER PRIMARY KEY,
        name TEXT,
        first_name TEXT,
        last_name TEXT,
        telephone TEXT,
        email TEXT,
        location TEXT,
        linked_in TEXT,
        github TEXT
        )
    ''');

    await db.execute('''
      CREATE TABLE experiences(
        experience_id INTEGER PRIMARY KEY,
        resume_id INTEGER,
        company TEXT,
        title TEXT,
        location TEXT,
        start TEXT,
        end TEXT,
        keywords TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE educations (
        education_id INTEGER PRIMARY KEY,
        resume_id INTEGER,
        course TEXT,
        institution TEXT,
        location TEXT,
        description TEXT,
        start TEXT,
        end TEXT
      )
    ''');
  }

  Future<bool> userExists() async {
    Database db = await instance.database;
    var _user = await db.query('user', limit: 1);
    return _user.isNotEmpty;
  }

  Future<bool> login(User user) async {
    Database db = await instance.database;
    var data = await db.rawQuery('SELECT username FROM user WHERE username = ? AND password = ? LIMIT 1', [user.username, user.password]);
    return data.isNotEmpty;
  }

  Future<int> addUser(User user) async {
    Database db = await instance.database;
    //todo add password as md5
    return await db.insert('user', user.toMap());
  }

  Future<dynamic> getResumes() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM resumes');
  }

  Future<int> saveResume(Resume resume) async {
    Database db = await instance.database;
    return await db.insert('resumes', resume.prepareInsert());
  }
}
