import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/models/transaction.dart';



class DetailBill extends StatefulWidget{

  final Function setUp;
  DetailBill({this.setUp});

  @override
  State<StatefulWidget> createState() => new _DetailBillState();

}

class _DetailBillState extends State<DetailBill>{

 var total = 0;
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
            converter: ViewModel.fromStore,
            builder: (context, vm){
            var detailTransactionList = vm.transactions;
            if(detailTransactionList != null ){
              print("Detail transaction : "+detailTransactionList.length.toString());
            }
            detailTransactionList.forEach((p){
                      total+= p.itemPrice * p.count;
                  });

            return Scaffold(
              appBar: AppBar(
                title: Text("Detail Transaction"),
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
                itemCount: detailTransactionList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                
                var totalItem = detailTransactionList[index].itemPrice;
              
                  var price = "(x" +
                      detailTransactionList[index].count.toString() +
                      ") Rp." +
                      totalItem.toString();
                  var name = detailTransactionList[index].productName.toString();

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
                }
                ),
                 Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Text("Total",
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text("Rp." + total.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)))
                ],
              )
              ]
              ),
            )
          );   

     });
  }
  

}

class ViewModel{
  final List<TransactionData> transactions;

  ViewModel({this.transactions});
  static ViewModel fromStore(Store<AppState> store){
  
    return new ViewModel(transactions:store.state.transactions);
  }

}