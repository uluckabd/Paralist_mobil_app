import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniErisim {
  static final dbname = "paralist.db";

  static Future<Database> veritabanierisim() async {
    String dbpath = join(await getDatabasesPath(), dbname);
    print("veritabanı yolu: $dbpath");

    if (await databaseExists(dbpath)) {
      print("Veritabanı MEVCUT.");
    } else {
      ByteData data = await rootBundle.load("veritabani/paralist.db");
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(dbpath).writeAsBytes(bytes, flush: true);
      print("Veritabanı kopyalandı.");
    }

    return await openDatabase(dbpath);
  }
}
