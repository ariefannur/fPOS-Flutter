import 'package:redux/redux.dart';
import 'package:redux_exercise/models/app_state.dart';
import 'package:redux_exercise/repository/data_repo.dart';
import 'package:redux_exercise/repository/local_repository.dart';
import 'package:redux_exercise/actions/action.dart';

var billId = 0;

List<Middleware<AppState>> createStoreMiddleware([
  DataRepository dataRepo = const LocalRepository()
]){

  final saveProduct = _createProduct(dataRepo);
  final loadProducts = _loadProducts(dataRepo);
  final searchProducts = _searchProduct(dataRepo);
  final getProduct = _getProduct(dataRepo);
  final saveTransaction = _saveTransaction(dataRepo);
  final saveBill = _saveBill(dataRepo);
  final getBills = _getBills(dataRepo);
  final getTransactions = _getTransactions(dataRepo);
  
  return[
    TypedMiddleware<AppState, AddProductAction>(saveProduct),
    TypedMiddleware<AppState, LoadProductAction>(loadProducts),
    TypedMiddleware<AppState, SearchProductAction>(searchProducts),
    TypedMiddleware<AppState, TransactionLoadedAction>(saveTransaction),
    TypedMiddleware<AppState, GetProductAction>(getProduct),
    TypedMiddleware<AppState, BillInsertAction>(saveBill),
    TypedMiddleware<AppState, LoadBills>(getBills),
    TypedMiddleware<AppState, GetDetailTranscationAction>(getTransactions),
  ];
}

Middleware<AppState> _createProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    final allProduct =  store.state.products;
  
    final product = allProduct[allProduct.length-1];
    print("save product qty : "+product.qty.toString()+" price : "+product.price.toString());
    dataRepo.saveProduct(
       product
    );
  };
}

Middleware<AppState> _saveTransaction(DataRepository dataRepo){
return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    var idBill = store.state.idBill;
    var idproduct =store.state.transactions[0].productId;
    print("save id id bill "+idBill.toString()+" id product "+idproduct.toString());
    dataRepo.saveItemTransaction(store.state.transactions);
  };
}

Middleware<AppState> _saveBill(DataRepository dataRepo){
return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
     dataRepo.saveBill(store.state.insertedBill).then( (id) {
        print("save id bill "+id.toString());
        //store.dispatch(InsertedIdBill(id));
        
        var list =store.state.transactions;
        list.forEach((transaction){
          transaction.billId = id;
        });
        store.dispatch(TransactionLoadedAction(list));
        
     }
     );
  };
}


Middleware<AppState> _loadProducts(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    
    dataRepo.loadAllProducts().then(
      (products){
        products.forEach((p){
            print("pruduct all "+p.id.toString());
        });
        store.dispatch(
          ProductLoadedAction(
              products
          )
        );
      }
    );
  };
}

Middleware<AppState> _getBills(DataRepository dataRepo){
 return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.getBills().then(
      (bills){
        store.dispatch(BillLoadedAction(bills));
      }
    );
  };
}

Middleware<AppState> _getTransactions(DataRepository dataRepo){
 return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    dataRepo.getTransactionDetail(store.state.idBill).then(
      (products){
        store.dispatch(
          TransactionLoadedAction(products)
        );
      }
    );
  };
}

Middleware<AppState> _searchProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    print("load product");
    dataRepo.searchProducts(store.state.query);
  };

}

Middleware<AppState> _getProduct(DataRepository dataRepo){
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);
    print("get product");
    dataRepo.getProducts(store.state.query).then(
      (product){
        store.dispatch(
          GetOneProductAction(product)
        );
      }
    );
  };

}