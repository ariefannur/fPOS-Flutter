class Product{
  final int id;
  final String name;
  final int price;
  final int qty;
  Product({this.id, this.name, this.price, this.qty});

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
        id: json["id"],
        name: json["product_name"],
        price: json["price"],
        qty: json["qty"]
      );
}