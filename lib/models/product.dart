class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double rating;
  final int reviewCount;
  final bool inStock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['image'],
      category: json['category'],
      rating: json['rating']['rate'].toDouble(),
      reviewCount: json['rating']['count'],
      inStock: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': imageUrl,
      'category': category,
      'rating': {
        'rate': rating,
        'count': reviewCount,
      },
    };
  }
} 