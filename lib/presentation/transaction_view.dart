import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:redux_exercise/actions/action.dart';
import 'package:redux_exercise/presentation/detail_bill.dart';
import 'package:redux_exercise/models/bill.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:intl/intl.dart';

class TransactionView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _TransactionState();

}


class _TransactionState extends State<TransactionView>{


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, ViewModel>(
            converter: ViewModel.fromStore,
            builder: (context, vm){
              //print("list all bills "+vm.bills.length.toString());
              return RefreshIndicator(
              
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  itemCount: vm.bills != null ? vm.bills.length : 0,
                  itemBuilder: (BuildContext context, int index){
                    final bill = vm.bills[index];
                    return GestureDetector(
                      onTap: (){
                          print("detail : "+bill.id.toString());
                          StoreProvider.of<AppState>(context).dispatch(InsertedIdBill(bill.id));
                          Navigator.push(context,MaterialPageRoute(builder: (context) => DetailBill(setUp: (){
                            StoreProvider.of<AppState>(context).dispatch(GetDetailTranscationAction(idBill:bill.id));
                          },)
                          ));

                      },
                      child: ItemList(
                        bill: bill,
                      ),
                    );
                    
                  },
                  ),
              );
              
              
            }
          );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 2));
    var action = LoadBills();
    StoreProvider.of<AppState>(context).dispatch(action);
  
    return null;
  }

}

class ViewModel{
  final List<Bill> bills;

  ViewModel({this.bills});
  static ViewModel fromStore(Store<AppState> store){
  
    return new ViewModel(bills:store.state.bills);
  }

}

class ItemList extends StatelessWidget{
  final Bill bill;
  ItemList({this.bill});

  @override
  Widget build(BuildContext context) {
  int epoch = bill.date * 1000;
  var now = new DateTime.fromMicrosecondsSinceEpoch(epoch);
  var formatter = new DateFormat('dd-MM-yyy H:m');
  String date = formatter.format(now);

    return Container(
          margin: new EdgeInsets.only(top: 8.0, left:16.0, right:16.0, bottom:8.0) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               
              Text("Rp. "+bill.totalPrice.toString(), style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Text("No bill : "+bill.id.toString()),
              Text(date),
            ],
          )
        
        );
  }

  }