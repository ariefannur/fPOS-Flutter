
class TransactionData{
  final int id;
  final int productId;
  final int count;
  final int itemPrice;

  TransactionData({this.id, this.productId, this.count, this.itemPrice});

  factory TransactionData.fromMap(Map<String, dynamic> json) => new TransactionData(
    id: json['id'],
    productId: json['product_id'],
    count: json['count'],
    itemPrice: json['item_price']
  );
}