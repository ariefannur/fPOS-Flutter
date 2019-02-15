class Product{
   int id;
   String name;
   int price;
   int qty;
  Product({this.id, this.name, this.price, this.qty});

  factory Product.fromMap(Map<String, dynamic> json) => new Product(
        id: json["id"],
        name: json["product_name"],
        price: json["price"],
        qty: json["qty"]
      );

  void setData(int id, String name, int price, int qty){
    this.id = id;
    this.name= name;
    this.price = price;
    this.qty = qty;
  }
}