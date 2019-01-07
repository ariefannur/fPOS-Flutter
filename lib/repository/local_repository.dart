import 'package:redux_exercise/db/db_helper.dart';
import 'package:redux_exercise/repository/data_repo.dart';
import 'package:redux_exercise/models/product.dart';
import 'dart:async';


class LocalRepository implements DataRepository{

  const LocalRepository();

  @override
  Future<List<Product>> loadAllProducts() async {
    final products = await DbHelper.db.getAllproduct();
    return products;
  }

  @override
  Future saveProduct(Product product) async {
    final prod = await DbHelper.db.insertProduct(product);
    return prod;
  }



}