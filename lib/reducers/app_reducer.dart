export 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/reducers/loading_reducer.dart';
import 'package:redux_exercise/reducers/product_reducer.dart';

AppState appReducer(AppState state, action){

  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    products: productReducer(state.products, action),
  );
  
}