import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _db;

  DatabaseProvider._init();

  // retorna instancia do banco de dados
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await _useDatabe('products.db');
    return _db!;
  }

  // cria o banco de dados
  Future<Database> _useDatabe(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    // descomente para deletar o banco de dados
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE product(id INTEGER PRIMARY KEY, ${ProductFields.title} TEXT, ${ProductFields.price} INTEGER, ${ProductFields.description} TEXT)');
      },
    );
  }

  // buscar notas
  Future<List<ProductModel>> getProduct() async {
    final db = await instance.db;
    final result = await db.rawQuery('select * from product order by id');

    return result.map((json) => ProductModel.fromMap(json)).toList();
  }

  // salvar nota
  Future<ProductModel> saveProduct(ProductModel product) async {
    final db = await instance.db;
    final id = await db.rawInsert(
        'insert into product (${ProductFields.title}, ${ProductFields.price}, ${ProductFields.description}) values (?, ?, ?)',
        [product.title, product.price, product.description]);
    print('ID: $id');
    return product.copyWith(id: id);
  }

  // atualizar nota
  Future<ProductModel> updateProduct(ProductModel product) async {
    final db = await instance.db;
    await db.rawUpdate(
        'update product set ${ProductFields.title} = ?, ${ProductFields.price} = ?, ${ProductFields.description} = ? where id = ?',
        [product.title, product.price, product.description, product.id]);
    return product;
  }

  // deletar nota
  Future<int> deleteProduct(int id) async {
    final db = await instance.db;
    return await db.rawDelete('delete from product where id = ?', [id]);
  }

  // deletar todas as notas
  Future<int> deleteAllProduct() async {
    final db = await instance.db;
    return await db.rawDelete('delete from product');
  }

  // fechar banco de dados
  Future close() async {
    final db = await instance.db;
    return db.close();
  }
}
