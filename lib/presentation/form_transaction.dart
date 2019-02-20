import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_exercise/actions/action.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/bill.dart';
import 'package:redux_exercise/models/product.dart';
import 'package:redux_exercise/models/transaction.dart';
import 'package:redux_exercise/presentation/bottomsheet.dart';

typedef OnSaveCallback = Function(List<Product> products, int total);

class DataTransaction extends StatelessWidget{

  final Function setUp;

  DataTransaction({this.setUp});

  @override
  Widget build(BuildContext context) {
   
     return StoreConnector<AppState, OnSaveCallback>(
       converter: (Store<AppState> store){
          return (list, total){
           print("list product "+list.length.toString());
           var date = new DateTime.now().millisecondsSinceEpoch;
           var bill = new Bill(id:0, date:date, totalPrice: total);
           var listBill = [bill];
            store.dispatch(BillLoadedAction(listBill));

            var listTransaction = List<TransactionData>();
        
            for(int i=0; i < list.length ; i++){
                var product =list[i];
                var itemCount =product.qty * product.price;
                var transc = new TransactionData(id: i, productId: product.id, count: product.qty, itemPrice: itemCount);
                listTransaction.add(transc);
            }

            print("list transaction "+listTransaction.length.toString()); 

            store.dispatch(TransactionLoadedAction(listTransaction));
          };
       },
       builder: (context, onSave){
         return FormTransaction(
           onSave: onSave,
         );
       },
     );
  }
 
}




class FormTransaction extends StatefulWidget {
  
  final OnSaveCallback onSave;

  FormTransaction({this.onSave});

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

  var totalNota = 0;

  @override
  void initState() {
    print("started " + localProductList.length.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> names = List<String>();
    localProductList = StoreProvider.of<AppState>(context).state.products;
    localProductList.forEach((d) => names.add(d.name));

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Transaction"),
        actions: <Widget>[
          IconButton(
            icon: Text("save"),
            onPressed: () {
              if (lisProduct.length > 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.75),
                    body:Center(
                      child:CircularProgressIndicator(),
                    ),
                  );
                }));

                widget.onSave(lisProduct, countTotal());

                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Container(
          margin:
              EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0, bottom: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Text("Product",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Price",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)))
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: lisProduct.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  var totalItem = lisProduct[index].price;
                  var price = "(x" +
                      lisProduct[index].qty.toString() +
                      ") Rp." +
                      totalItem.toString();
                  var name = lisProduct[index].name;

                  print("item " + price.toString());
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 0, top: 5.0, right: 0, bottom: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child:
                                Text(name, style: TextStyle(fontSize: 16.0))),
                        Expanded(
                            child:
                                Text(price, style: TextStyle(fontSize: 16.0))),
                      ],
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Text("Total",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Rp" + totalNota.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)))
                ],
              )
            ],
          )),
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
                                  var price =
                                      getProductByName(textCurrent).price;
                                  var qty =
                                      int.parse(productQtyController.text);
                                  print("qty " + qty.toString());
                                  var product = Product();
                                  product.setData(id, textCurrent, price, qty);
                                  lisProduct.add(product);
                                  totalNota = countTotal();
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

  Product getProductByName(String name) {
    Product p = Product();
    for (Product product in localProductList) {
      if (product.name == name) {
        p = product;
      }
    }
    return p;
  }

  bool isAnyResult() {
    bool anyTotal = false;
    for (Product product in localProductList) {
      if (product.id == 0) anyTotal = true;
    }
    return anyTotal;
  }

  int countTotal() {
    var count = 0;
    for (Product product in lisProduct) {
      print("qty : " +
          product.qty.toString() +
          " price : " +
          product.price.toString());
      var item = (product.qty * product.price);
      count += item;
    }
    print("total count : " +
        count.toString() +
        " " +
        lisProduct.length.toString());
    return count;
  }
}


