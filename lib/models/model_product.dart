class ModelProduct {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  ModelProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory ModelProduct.fromMap(Map json) {
    return ModelProduct(
      id: json['id'],
      title: json['title'] ?? '',
      price: (json['price'] != null)
          ? double.tryParse(json['price'].toString()) ?? 0.0
          : 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };
  }
}
