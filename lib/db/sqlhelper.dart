import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class SQLHelper {
  static sql.Database? _database;

  static Future<sql.Database> db() async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDir.path, 'projectease.db');

    return sql.openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
      onOpen: (db) async {
        await createTables(db);
      },
    );
  }

  static Future<void> closeDatabase() async {
    final db = await SQLHelper.db();
    await db.close();
  }

  static Future<void> createTables(sql.Database database) async {
    //await database.execute('DROP TABLE IF EXISTS users');
    //await database.delete('users');
    //await database.delete('projects');
    //await database.delete('groups');
    /*await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (1,'divya@example.com', 'Divya V L', '1234', NULL)
      """);

    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (2,'sujithra@example.com', 'Sujithra M S', '1234', NULL)
      """);
    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (3,'sreeja@example.com', 'Sreeja Nair M P', '1234', NULL)
      """);

    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (4,'josemary@example.com', 'Josemary A ', '1234', NULL)
      """);

    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (5,'vani@example.com', 'Vani V Prakash', '1234', NULL)
      """);
    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (6,'remya@example.com', 'Remya R', '1234', NULL)
      """);
    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (6,'remya@example.com', 'Remya R', '1234', NULL)
      """);*/
    /* await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (7,'aparna@example.com', 'Aparna A S', '1234', NULL)
      """);
    await database.execute("""
      INSERT INTO users (id,email, username, password, phno)
      VALUES (8,'arun@example.com', 'Arun P Kuttappan', '1234', NULL)
      """);*/

    await database.execute("""
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      email TEXT,
      username TEXT,
      password TEXT,
      phno TEXT,
      groupno INTEGER ,
      FOREIGN KEY (groupno) REFERENCES groups(groupno)
    )
  """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS groups(
      groupno INTEGER PRIMARY KEY NOT NULL,
      guide TEXT,
      member1 TEXT,
      member2 TEXT,
      member3 TEXT,
      member4 TEXT,
      FOREIGN KEY (guide) REFERENCES users(username),
      FOREIGN KEY (member1) REFERENCES users(username),
      FOREIGN KEY (member2) REFERENCES users(username),
      FOREIGN KEY (member3) REFERENCES users(username),
      FOREIGN KEY (member4) REFERENCES users(username)
    )
  """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS projects(
      groupno INTEGER PRIMARY KEY NOT NULL,
      projname TEXT UNIQUE,
      FOREIGN KEY (groupno) REFERENCES groups(groupno)
    )
  """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS project_documents(
      documentId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      groupno INTEGER,
      documentPath TEXT,
      FOREIGN KEY (groupno) REFERENCES projects(groupno)
    )
  """);

    await database.execute("""
    CREATE TABLE IF NOT EXISTS project_documents_path(
      groupno INTEGER PRIMARY KEY NOT NULL,
      abstract TEXT,
      intro TEXT DEFAULT NULL,
      design TEXT DEFAULT NULL,
      implementation TEXT DEFAULT NULL,
      finalpresent TEXT DEFAULT NULL,
      FOREIGN KEY (groupno) REFERENCES projects(groupno)
    )
  """);

    await database.execute("""
CREATE TABLE IF NOT EXISTS comments (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  userId INTEGER,
  comment TEXT,
  groupno INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id),
  FOREIGN KEY (groupno) REFERENCES groups(groupno)
)
""");
  }

  static Future<int> addUserDetails(
      String username, String email, String password, String phoneno) async {
    final db = await SQLHelper.db();
    final data = {
      "email": email,
      "username": username,
      "password": password,
      "phno": phoneno
    };
    final id = await db.insert("users", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    final List<Map<String, dynamic>> result =
        await db.query('users', orderBy: 'id');

    print('Users Data:');
    for (final user in result) {
      print("LOOOKKKK UNDERRRRRRRRRRRRRRR");
      print(
          'ID: ${user['id']}, Email: ${user['email']}, Username: ${user['username']}, Password: ${user['password']}, Phone: ${user['phno']},Group no: ${user['groupno']}');
    }
    return id;
  }

  ///
  ///
  ///
  ///
  ///
  static Future<void> editUserGroupNo(String username, int groupno) async {
    final db = await SQLHelper.db();
    await db.update(
      'users',
      {'groupno': groupno},
      where: 'username = ?',
      whereArgs: [username],
    );
  }

  ///
  ///
  ///
  ///
  ///
  ///
  static Future<void> updateGuide(int groupNo, String guide) async {
    final db = await SQLHelper.db();
    await db.update(
      'groups',
      {'guide': guide},
      where: 'groupNo = ?',
      whereArgs: [groupNo],
    );
  }

  ///
  ///
  ///
  ///
  ///

  ///
  ///
  ///
  ///
  ///
  ///
  static Future<Map<String, dynamic>?> getUserDetails(String username) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null; // User not found
  }

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  static Future<Map<String, dynamic>?> getUserDetailsEmail(String email) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null; // User not found
  }

  ///
  ///
  ///
  static Future<bool> authenticateUser(String email, String password) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  ///
  ///
  ///
  ///
  ///
  static Future<int> addProject(String groupno, String projname) async {
    final db = await SQLHelper.db();
    final data = {
      "groupno": groupno,
      "projname": projname,
    };
    final id = await db.insert("projects", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    final List<Map<String, dynamic>> result1 =
        await db.query('projects', orderBy: 'groupno');

    print('Projects Data:');
    for (final project in result1) {
      print("PROJECCCCCCCCC");
      print('groupno: ${project['groupno']}, projname: ${project['projname']}');
    }
    return id;
  }

//
//
////
/////
  ///
  ///
  ///
  ///
  static Future<Map<String, dynamic>?> getProjectDetails(int groupno) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'projects',
      where: 'groupno = ?',
      whereArgs: [groupno],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null; // User not found
  }

  ///
  ///
  ///

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  static Future<int> addGroupDetails(int groupno, String? guide, String member1,
      String member2, String member3, String member4) async {
    final db = await SQLHelper.db();

    // Check if any of the members are already part of a group
    final members = [member1, member2, member3, member4];
    for (final member in members) {
      final result = await db.rawQuery("""
      SELECT groupno FROM users WHERE username = '$member' AND groupno IS NOT NULL
    """);

      if (result.isNotEmpty) {
        await db.update(
          'users',
          {'groupno': groupno},
          where: "username = ?",
          whereArgs: [member],
        );
      }
    }

    final data = {
      "groupno": groupno,
      "guide": guide,
      "member1": member1,
      "member2": member2,
      "member3": member3,
      "member4": member4
    };
    final id = await db.insert("groups", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    final List<Map<String, dynamic>> result1 =
        await db.query('groups', orderBy: 'groupno');

    print('Groups Data:');
    for (final group in result1) {
      print("GROUPPPPPPSSSSSSSSSSSSSSS");
      print(
          'groupno: ${group['groupno']}, guide: ${group['guide']}, member1: ${group['member1']}, member2: ${group['member2']}, member3: ${group['member3']}, member4: ${group['member4']}');
    }
    return id;
  }

//
  ///
//////
  ///
  //
  //

  static Future<Map<String, dynamic>?> getDocumentDetails(int groupno) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'project_documents_path',
      where: 'groupno = ?',
      whereArgs: [groupno],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first;
    }

    return null; // User not found
  }

  //
  //
  //

  static Future<Map<String, dynamic>?> getGroupDetails(int groupno) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.query(
      'groups',
      where: 'groupno = ?',
      whereArgs: [groupno],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null; // User not found
  }

  ///
  ///
  ///
  ///
  ///
  static Future<List<Map<String, dynamic>>> userAlreadyFound(
      String username, String email) async {
    final db = await SQLHelper.db();
    final dataFound = await db.rawQuery(
        "SELECT * FROM users WHERE username = '$username' OR email = '$email'");
    return dataFound;
  }

  static Future<List<String>> getUsernames() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT username FROM users WHERE id > 10',
    );
    return result.map((user) => user['username'] as String).toList();
  }

  static Future<List<String>> getGuides() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT username FROM users WHERE id < 10',
    );
    return result.map((user) => user['username'] as String).toList();
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await SQLHelper.db();
    return db.query('users', orderBy: 'id');
  }

// Get the documents for a project
  /*static Future<List<String>> getAllProjectDocuments(int groupno) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> documents = await db.query(
      'project_documents',
      where: 'groupno = ?',
      whereArgs: [groupno],
    );
    return documents.map((doc) => doc['documentPath'] as String).toList();
  }*/

  ///
  ///
  ///
  ///
  ///
  Future<void> insertFilePath(int groupno, String? filePath) async {
    final db = await SQLHelper.db();
    await db.insert(
      'project_documents_path',
      {'groupno': groupno, 'abstract': filePath},
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> result =
        await db.query('project_documents_path', orderBy: 'groupno');

    print('Doc path Data:');
    for (final doc in result) {
      print("LOOOKKKK UNDERRRRRRRRRRRRRRR");
      print(
          'groupno: ${doc['groupno']}, abstract: ${doc['abstract']}, intro: ${doc['intro']}, design: ${doc['design']}, Implementation: ${doc['implementation']},final: ${doc['finalpresent']}');
    }
  }
}
