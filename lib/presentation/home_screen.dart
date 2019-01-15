
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_exercise/models/app_route.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/product.dart';

class HomeScreen extends StatefulWidget{

  final Function onInit;
  HomeScreen({this.onInit});

  @override
  _HomeScreen createState() => _HomeScreen();

}

class _HomeScreen extends State<HomeScreen>{
 
  @override
    void initState() {
      widget.onInit();
      super.initState();
    }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fPOS"),
      ),
      body: Scaffold(
        body : Home(),
        floatingActionButton: FloatingActionButton(
        onPressed: (){
           Navigator.pushNamed(context, AppRoute.addProduct);
        },
        child: Icon(Icons.add),
    
      ),
      ),
      
    );
  }

}


class Home extends StatefulWidget{
  Home({Key key}) : super(key: key);
  @override
  _Home createState() => _Home();

}

class _Home extends State<Home>{

    @override
      void initState() {
        super.initState();
      }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
            converter: _ViewModel.fromStore,
            builder: (context, vm){
              print("list all "+vm.products.length.toString());
              return ListView.builder(
              itemCount: vm.products.length,
              itemBuilder: (BuildContext context, int index){
                final product = vm.products[index];
                return ItemList(
                  product: product,
                );
              },
              );
            }
          );
    }

  }


  class _ViewModel{
    final List<Product> products;
    final Product product;
    final bool isLoading;
  _ViewModel({
    @required this.isLoading,
    @required this.products,
    @required this.product
    });
    
    static _ViewModel fromStore(Store<AppState> store){
      print("list store : "+store.state.products.length.toString());
      return _ViewModel(
        isLoading: store.state.isLoading,
        products: store.state.products,
        product: store.state.product
      );
    }
  }

  class ItemList extends StatelessWidget{
  final Product product;
  ItemList({this.product});

  @override
  Widget build(BuildContext context) {
  
    return Container(
          margin: new EdgeInsets.only(top: 8.0, left:16.0, right:16.0, bottom:8.0) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(product.name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text("Rp. "+product.price.toString()),
              Text("Qty : "+product.qty.toString()),
            ],
          )
        
        );
  }

  }

