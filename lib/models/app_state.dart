import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:meta/meta.dart';
import 'package:redux_exercise/models/transaction.dart';

@immutable
class AppState{
  final bool isLoading;
  final List<Product> products;
  final Product product;
  final List<TransactionData> transactions;
  final List<Bill> bills;
  final String query;
  final int idBill;

  AppState({this.isLoading = false, this.products = const [], this.product, this.transactions, this.bills, this.query, this.idBill});
  factory AppState.loading() => AppState(isLoading: true);
}