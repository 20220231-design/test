class Product {
  String id;
  String name;
  int price;
  String image;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'],
      price: data['price'],
      image: data['image'],
      description: data['description'],
    );
  }
}