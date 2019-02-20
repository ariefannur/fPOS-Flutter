import 'package:redux_exercise/db/db_helper.dart';
import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/transaction.dart';
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
  Future saveProduct(Product product) async {
    print("Name : "+product.name+" price : "+product.price.toString()+"  qty : "+product.qty.toString());
    final prod = await DbHelper.db.insertProduct(product);
    return prod;
  }

  @override
  Future<List<Product>> searchProducts(String name) async{
     final prod = await DbHelper.db.searchProduct(name);
    return prod;
  }

  @override
  Future saveItemTransaction(List<TransactionData> data, int bill) async{
    var insert =  data.forEach((data) async =>
         await DbHelper.db.insertTransaction(data, bill)
    );

    return insert;
  
  }

  @override
  Future<int> saveBill(Bill billData) async{
    final bill = await DbHelper.db.insertBill(billData);
    return bill;
  }

  @override
  Future<Product> getProducts(String name) async{
    final product = await DbHelper.db.getProduct(name);
    return product;
  }

  @override
  Future<List<Bill>> getBills() async{
    final bills = await DbHelper.db.getBills();
    print("get bills : "+bills.toString());
    return bills;
  }

  @override
  Future<List<TransactionData>> getTransactionDetail(int idBill) async{
    final transactions = await DbHelper.db.getDetailTransaction(idBill);
    return transactions;
  }



}