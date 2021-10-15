import 'package:dro_hometask/domain/item.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider instance = DatabaseProvider._();

  static String itemName;
  static int itemCost;
  static int itemAmount;
  static String itemMass;
  static String itemImage;
  Database database;

  Future<Database> get db async {
    if (database != null) {
      return database;
    }
    database = await initDB();
    return database;
  }

  delete() async {
    String path = await getDatabasesPath();
    String dataPath = path + "cart";
    await deleteDatabase(dataPath);
    print("deleted");
  }

  initDB() async {
    String path = await getDatabasesPath();
    String dataPath = path + "cart";
    var data = await openDatabase(dataPath, version: 1, onCreate: _onCreate);
    return data;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT,itemName TEXT, itemImage TEXT, itemCost INT, itemAmount INT, itemMass TEXT )");
  }

  Future addToCart(Items model) async {
    var dbClient = await db;
    var res = dbClient.insert("cart", model.toJson());
    return res;
/*    if (getItem(model.objID) == null) {
      throw Exception("Item already exist in cart");
    } else {
      var res = dbClient.insert("cart", model.toJson());
      return res;
    }*/
  }

  updateCart(Items model, int id) async {
    var dbClient = await db;
    Items mod = Items(
        itemCost: model.itemCost,
        itemName: model.itemName,
        itemImage: model.itemImage,
        itemMass: model.itemMass,
        itemAmount: model.itemAmount);
    var res =
        dbClient.update("cart", mod.toJson(), where: "id = ?", whereArgs: [id]);
    return res;
  }

  Future deleteCart(int id) async {
    final dbClient = await db;
    dbClient.delete("cart", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final dbClient = await db;
    dbClient.rawDelete("Delete * from cart");
  }

  Future<List<Items>> getCart() async {
    final dbClient = await db;
    var res = await dbClient.query("cart");
    List<Items> list =
        res.isNotEmpty ? res.map((c) => Items.fromJson(c)).toList() : [];
    return list;
  }

  getItem(String id) async {
    final dbClient = await db;
    var res = await dbClient.query("cart", where: "objID = ?", whereArgs: [id]);
    return res;
  }
}
