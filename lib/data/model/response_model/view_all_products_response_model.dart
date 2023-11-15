// To parse this JSON data, do
//
//     final viewAllProductsResponseModel = viewAllProductsResponseModelFromJson(jsonString);

import 'dart:convert';

ViewAllProductsResponseModel viewAllProductsResponseModelFromJson(String str) => ViewAllProductsResponseModel.fromJson(json.decode(str));

String viewAllProductsResponseModelToJson(ViewAllProductsResponseModel data) => json.encode(data.toJson());

class ViewAllProductsResponseModel {
  final Data? data;

  ViewAllProductsResponseModel({
    this.data,
  });

  factory ViewAllProductsResponseModel.fromJson(Map<String, dynamic> json) => ViewAllProductsResponseModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  final List<ProductData>? productsList;
  final dynamic total;
  final dynamic skip;
  final dynamic limit;

  Data({
    this.productsList,
    this.total,
    this.skip,
    this.limit,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productsList: json["products"] == null ? [] : List<ProductData>.from(json["products"]!.map((x) => ProductData.fromJson(x))),
    total: json["total"],
    skip: json["skip"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "products": productsList == null ? [] : List<dynamic>.from(productsList!.map((x) => x.toJson())),
    "total": total,
    "skip": skip,
    "limit": limit,
  };
}

class ProductData {
  final dynamic id;
  final dynamic title;
  final dynamic description;
  final dynamic price;
  final dynamic discountPercentage;
  final dynamic rating;
  final dynamic stock;
  final dynamic brand;
  final dynamic category;
  final dynamic thumbnail;
  final List<String>? images;
  bool? isFavorite = false;
  bool? isShopping = false;
  dynamic productQuantity;

  ProductData({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
    this.isFavorite,
    this.isShopping,
    this.productQuantity,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    price: json["price"],
    discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    stock: json["stock"],
    brand: json["brand"],
    category: json["category"],
    thumbnail: json["thumbnail"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    isFavorite: json['isFavorite'] ?? false,
    isShopping: json['isShopping'] ?? false,
    productQuantity: json['productQuantity'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "brand": brand,
    "category": category,
    "thumbnail": thumbnail,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "isFavorite": isFavorite ?? false,
    "isShopping": isShopping ?? false,
    "productQuantity": productQuantity,
  };
}
