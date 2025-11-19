import 'dart:convert';

class Product {
  String model;
  String pk;
  Fields fields;

  Product({required this.model, required this.pk, required this.fields});

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int? user;
  String name;
  int price;
  String description;
  String? thumbnail;
  String category;
  bool isFeatured;
  int stock;
  String brand;
  double rating;
  DateTime createdAt;

  Fields({
    required this.user,
    required this.name,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.stock,
    required this.brand,
    required this.rating,
    required this.createdAt,
  });

  factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    price: json["price"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    stock: json["stock"],
    brand: json["brand"],
    rating: json["rating"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "price": price,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "stock": stock,
    "brand": brand,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
  };
}
