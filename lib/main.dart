import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_exercise/actions/action.dart';
import 'package:redux_exercise/models/app_route.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/presentation/form_product.dart';
import 'package:redux_exercise/presentation/home_screen.dart';
import 'package:redux_exercise/reducers/app_reducer.dart';
import 'package:redux_exercise/middleware/app_middleware.dart';
import 'package:flutter_stetho/flutter_stetho.dart';

void main() {
  Stetho.initialize();
  runApp(MyApp());
}
  

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
          title: "fPOS",
          routes: {
            AppRoute.home:(context){
              return HomeScreen(
                onInit: (){
                  print("init home : ");
                   StoreProvider.of<AppState>(context).dispatch(LoadProductAction());
                },
              );
            },
            AppRoute.addProduct: (context) {
            return AddProductForm();
          },
          }   
        ),
      );
    }
}