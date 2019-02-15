import 'package:redux_exercise/models/bill.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/models/transaction.dart';


class DbHelper{
  DbHelper._();

  static final DbHelper db = DbHelper._();

  Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Product ("
          "id INTEGER PRIMARY KEY,"
          "product_name VARCHAR(40),"
          "qty INTEGER,"
          "price INTEGER"
          ");");

      await db.execute("CREATE TABLE ItemTransaction ("
          "id_transaction INTEGER PRIMARY KEY,"
          "product_id INTEGER,"
          "count INTEGER,"
          "bill_id INTEGER,"
          "item_price INTEGER"
          ");");

      await db.execute("CREATE TABLE Bill ("
          "id_bill INTEGER PRIMARY KEY,"
          "total_price INTEGER,"
          "date INTEGER"
          ");");    

    });
  }

  insertProduct(Product product) async{
    
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into Product (product_name, qty, price) VALUES (?, ?, ?)",
      [product.name, product.qty, product.price]
    );
    return raw;
  }

 insertTransaction(TransactionData transaction, int billId) async{
    
    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into ItemTransaction (product_id, count, bill_id, item_price) VALUES (?, ?, ?, ?)",
      [transaction.productId, transaction.count, transaction.itemPrice]
    );
    return raw;
  }

  insertBill(Bill bill) async{

    final db = await database;
    var raw = await db.rawInsert(
      "INSERT into Bill (date, total_price) VALUES (?, ?)",
      [bill.date, bill.totalPrice]
    );
    return raw;

  }


  Future<List<Product>> getAllproduct() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product");
    print("load product "+res.isEmpty.toString());
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list;
  }

  Future<List<Product>> searchProduct(String name) async{

    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product WHERE product_name like '%"+name+"%'");
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list;
  }


Future<Product> getProduct(String name) async{

    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Product WHERE product_name ='"+name+"'");
    List<Product> list =res.isNotEmpty ? res.map((c) => Product.fromMap(c)).toList() : [];
    
    return list[0];
  }

}