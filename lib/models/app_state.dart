import 'package:redux_exercise/models/product.dart';
import 'package:meta/meta.dart';

@immutable
class AppState{
  final bool isLoading;
  final List<Product> products;
  final Product product;

  AppState({this.isLoading = false, this.products = const [], this.product});

  factory AppState.loading() => AppState(isLoading: true);
}