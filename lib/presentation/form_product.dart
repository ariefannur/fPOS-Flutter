import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_exercise/actions/action.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/product.dart';

class AddProductForm extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    
     return StoreConnector<AppState, OnSaveCallback>(
       converter: (Store<AppState> store){
          return (name, prize, qty ){
            print("Name "+name+" prize "+prize.toString()+" qty "+qty.toString());
            store.dispatch(AddProductAction(Product(id:0,
              name:name,
              price:prize,
              qty:qty
            )));
          };
       },
       builder: (context, onSave){
         return FormAddProduct(
           onSave: onSave,
         );
       },
     );
       
    }
       
     
}
     
typedef OnSaveCallback = Function(String name, int prize, int qty);

class FormAddProduct extends StatefulWidget{
  final OnSaveCallback onSave;
  FormAddProduct({this.onSave});

  @override
  _FormAddProduct createState()  => new _FormAddProduct();

}
class _FormAddProduct extends State<FormAddProduct>{

  final formKey = GlobalKey<FormState>();

  final productNameController = new TextEditingController();
  final productPrizeController = new TextEditingController();
  final productQtyController = new TextEditingController();
  String name = "";
  String price = "";
  String qty = "";
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
           appBar: AppBar(
             title: Text("Add Product"),
           ),
           body: Container(
             margin: EdgeInsets.all(16.0),
             child: Form(
               key: formKey,
               child: Column(
                  children: <Widget>[
                   TextFormField(
                    controller: productNameController,
                     decoration: const InputDecoration(
                       hintText: "Product Name",
                       labelText:"Product Name"
                     ),
                     keyboardType: TextInputType.text,
                      onSaved: (String text){
                       this.name = text;
                     },
                    
                   ),
                   
                   TextFormField(
                     controller: productPrizeController,
                     decoration: const InputDecoration(
                       hintText: "Price",
                       labelText:"Price"
                     ),
                     keyboardType: TextInputType.number,
                     onSaved: (String text){
                       this.price = text;
                     },
                  
                   ),
                  
                   TextFormField(
                    controller: productQtyController,
                     decoration: const InputDecoration(
                       hintText: "Qty",
                      labelText:"Qty"
                     ),
                     keyboardType: TextInputType.number,
                     onSaved: (String text){
                       this.qty = text;
                     },
                   ),
                   
                   new Container(
                     child: new RaisedButton(
                       child: new Text(
                         'Add',
                         style: new TextStyle(
                           color: Colors.white
                         ),
                       ),
                       onPressed: () {
                         name = productNameController.text;
                         qty = productQtyController.text;
                         price = productPrizeController.text;
                          print("NAME INPUT : "+name+" : "+qty+" : "+price);
                           widget.onSave(productNameController.text, int.parse(productPrizeController.text), int.parse(productQtyController.text));
                           
                           productNameController.text = "";
                           productQtyController.text = "";
                           productPrizeController.text = "";
                       },
                       color: Colors.blue,
                     ),
                     margin: new EdgeInsets.only(
                       top: 30.0
                     ),
                   )
     
               ],
             )
             )
           ),
         );
  }

}
