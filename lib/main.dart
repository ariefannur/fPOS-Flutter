import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/reducers/app_reducer.dart';
import 'package:redux_exercise/middleware/app_middleware.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: createStoreMiddleware()

  );

  @override
    Widget build(BuildContext context) {
      return StoreProvider(
        store:store,
        child:MaterialApp(

        ),
      );
    }
}