export 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/reducers/loading_reducer.dart';
import 'package:redux_exercise/reducers/product_reducer.dart';

AppState appReducer(AppState state, action){

  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    products: productReducer(state.products, action),
    product: oneProductReducer(state.product, action),
    transactions: transactionRecuder(state.transactions, action),
    bills: billRecuder(state.bills, action),
    query: queryReducer(state.query, action)
  );
  
}