import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/presentation/bottomsheet.dart';

class FormTransaction extends StatefulWidget {
  final Function setUp;

  FormTransaction({this.setUp});

  @override
  _Transaction createState() => new _Transaction();
}

class _Transaction extends State<FormTransaction> {
  static GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  var textCurrent = "";
  String qty = "";
  final productQtyController = new TextEditingController();
  final productAController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Product> lisProduct = List();
  List<Product> localProductList = List();

  @override
  Widget build(BuildContext context) {
    List<String> names = List<String>();
    localProductList= StoreProvider.of<AppState>(context).state.products;
    localProductList.forEach((d) => names.add(d.name));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Transaction"),
        actions: <Widget>[
          IconButton(
              icon: Text("save"),
              onPressed: () {
                
              },
          )
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(left:24.0, top: 16.0, right:24.0, bottom: 16.0),
          child: 
                ListView.builder(
            itemCount: lisProduct.length,
            itemBuilder: (BuildContext ctxt, int index) {
              var totalItem = lisProduct[index].qty * lisProduct[index].price; 
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Text(lisProduct[index].name, style: TextStyle(fontSize: 16.0))
                  ),
                  Expanded(
                   child: Text("x"+lisProduct[index].qty.toString()+" Rp."+totalItem.toString(), style: TextStyle(fontSize: 16.0))
                  ),
                ],
              );
            },
          )
          
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheetApp(
              context: context,
              builder: (BuildContext builder) {
                return SizedBox(
                    height: 250.0,
                    child: Container(
                      padding: new EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          new Text(
                            'Add Product',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          new SimpleAutoCompleteTextField(
                            key: key,
                            suggestions: names,
                            decoration: const InputDecoration(
                              hintText: "Product Name",
                              labelText: "Product Name",
                            ),
                            //textChanged: (text) => this.textCurrent = text,
                            textSubmitted: (text) => setState(() {
                                  this.textCurrent = text;
                                }),
                            clearOnSubmit: false,
                            submitOnSuggestionTap: true,
                          ),
                          TextField(
                            controller: productQtyController,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: const InputDecoration(
                                hintText: "Qty", labelText: "Qty"),
                          ),
                          Container(
                            child: RaisedButton(
                              child: new Text(
                                'Save',
                                style: new TextStyle(color: Colors.blue),
                              ),
                              onPressed: () {
                                //Navigator.pop(context);
                                setState(() {
                                  var id = getProductByName(textCurrent).id;
                                  var price = getProductByName(textCurrent).price;
                                  var qty = int.parse(productQtyController.text);
                                  var product = Product();
                                  product.setData(id, textCurrent, price, qty);
                                  lisProduct.add(product);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        },
      ),
    );
  }

  Product getProductByName(String name){
    Product p = Product();
    for(Product product in localProductList){
      if(product.name == name){
        p = product;
      }
    }

    return p;
  }

}
