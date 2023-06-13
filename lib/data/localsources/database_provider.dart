import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _db;

  DatabaseProvider._init();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await _useDatabe('products.db');
    return _db!;
  }

  Future<Database> _useDatabe(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE $tableProduct(id INTEGER PRIMARY KEY, ${ProductFields.title} TEXT, ${ProductFields.price} INTEGER, ${ProductFields.description} TEXT)');
      },
    );
  }

  Future<List<ProductModel>> getProduct() async {
    final db = await instance.db;
    const orderBy = '${ProductFields.id} ASC';
    final result = await db.query(tableProduct, orderBy: orderBy);
    print('GET PRODUCT DATABASE: $result');
    return result.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> saveProduct(ProductModel product) async {
    final db = await instance.db;
    final id = await db.rawInsert(
        'insert into $tableProduct (${ProductFields.title}, ${ProductFields.price}, ${ProductFields.description}) values (?, ?, ?)',
        [product.title, product.price, product.description]);

    return product.copyWith(id: id);
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final db = await instance.db;
    await db.rawUpdate(
        'update $tableProduct set ${ProductFields.title} = ?, ${ProductFields.price} = ?, ${ProductFields.description} = ? where id = ?',
        [product.title, product.price, product.description, product.id]);
    return product;
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.db;
    return await db.rawDelete('delete from $tableProduct where id = ?', [id]);
  }

  Future<int> deleteAllProduct() async {
    final db = await instance.db;
    return await db.rawDelete('delete from $tableProduct');
  }

  // fechar banco de dados
  Future close() async {
    final db = await instance.db;
    return db.close();
  }
}
