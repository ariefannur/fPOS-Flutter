
class TransactionData{
  final int id;
  final int productId;
  final int count;
  final int itemPrice;
  final String productName;
  int billId;

  TransactionData({this.id, this.productId, this.count, this.itemPrice, this.billId, this.productName});

  factory TransactionData.fromMap(Map<String, dynamic> json) => new TransactionData(
    id: json['id'],
    productId: json['product_id'],
    count: json['count'],
    itemPrice: json['item_price'],
    billId: json['bill_id'],
    productName: json['name']
  );
}