import 'package:redux_exercise/db/db_helper.dart';
import 'package:redux_exercise/repository/data_repo.dart';
import 'package:redux_exercise/models/product.dart';
import 'dart:async';


class LocalRepository implements DataRepository{

  const LocalRepository();

  @override
  Future<List<Product>> loadAllProducts() async {
    
    final products = await DbHelper.db.getAllproduct();
    print("load product : "+products.length.toString());
    return products;
  }

  @override
  Future saveProduct(List<Product> products) async {
    //print("Name : "+product.name+" price : "+product.price.toString()+"  qty : "+product.qty.toString());
    final prod = await DbHelper.db.insertProduct(products[0]);
    return prod;
  }

  @override
  Future<List<Product>> searchProducts(String name) async{
     final prod = await DbHelper.db.searchProduct(name);
    return prod;
  }



}