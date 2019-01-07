import 'package:redux/redux.dart';
import 'package:redux_exercise/actions/action.dart';
final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, ProductLoadedAction>(_setLoaded),
  TypedReducer<bool, ProductNotLoadedAction>(_setLoaded)
]);

bool _setLoaded(bool state, action) {
  return false;
}