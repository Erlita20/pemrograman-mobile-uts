import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:toko_bangunan/model/barang.dart';
import 'package:toko_bangunan/model/pelanggan.dart';

//class Dbhelper
class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'toko.db';
    //create, read databases
    var tokoDatabase = openDatabase(path,
        version: 4, onCreate: _createDb, onUpgrade: _onUpgrade);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return tokoDatabase;
  }

  //mengupgrade database
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    _createDb(db, newVersion);
  }

  //membuat tabel baru dengan nama barang dan pelanggan
  void _createDb(Database db, int version) async {
    var batch = db.batch();
    //tabel Barang
    batch.execute('''
              CREATE TABLE barang (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              kode TEXT,
              nama TEXT,
              harga INTEGER,
              stok INTEGER
              )
              ''');
    // tabel Pelanggan
    batch.execute('''
              CREATE TABLE pelanggan (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nama TEXT,
              alamat TEXT,
              telepon INTEGER
            )
              ''');

    await batch.commit();
  }

  //select databases barang
  Future<List<Map<String, dynamic>>> selectBarang() async {
    Database db = await this.initDb();
    var mapList = await db.query('barang', orderBy: 'kode');
    return mapList;
  }

  //select databases pelanggan
  Future<List<Map<String, dynamic>>> selectPelanggan() async {
    Database db = await this.initDb();
    var mapList = await db.query('pelanggan', orderBy: 'nama');
    return mapList;
  }

  //create data tabel barang
  Future<int> insertBarang(Barang object) async {
    Database db = await this.initDb();
    int count = await db.insert('barang', object.toMap());
    return count;
  }

  //create data tabel pelanggan
  Future<int> insertPelanggan(Pelanggan object) async {
    Database db = await this.initDb();
    int count = await db.insert('pelanggan', object.toMap());
    return count;
  }

  //update data tabel barang
  Future<int> updateBarang(Barang object) async {
    Database db = await this.initDb();
    int count = await db.update('barang', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update data tabel pelanggan
  Future<int> updatePelanggan(Pelanggan object) async {
    Database db = await this.initDb();
    int count = await db.update('pelanggan', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete data tabel barang
  Future<int> deleteBarang(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('barang', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete data tabel pelanggan
  Future<int> deletePelanggan(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('pelanggan', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //list data tabel barang
  Future<List<Barang>> getBarangList() async {
    var barangMapList = await selectBarang();
    int count = barangMapList.length;
    // ignore: deprecated_member_use
    List<Barang> barangList = List<Barang>();
    for (int i = 0; i < count; i++) {
      barangList.add(Barang.fromMap(barangMapList[i]));
    }
    return barangList;
  }

  //list data tabel pelanggan
  Future<List<Pelanggan>> getPelangganList() async {
    var pelangganMapList = await selectPelanggan();
    int count = pelangganMapList.length;
    // ignore: deprecated_member_use
    List<Pelanggan> pelangganList = List<Pelanggan>();
    for (int i = 0; i < count; i++) {
      pelangganList.add(Pelanggan.fromMap(pelangganMapList[i]));
    }
    return pelangganList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
