class HomeModel {
  bool? status;
  String? message;
  DataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }

}

class DataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  DataModel.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element) =>
        banners.add(BannerModel.fromJson(element)));
    json['products'].forEach((element) =>
        products.add(ProductModel.fromJson(element)));
    }
}


class BannerModel {
  int? id;
  String? image;
  String? category;
  String? product;

  BannerModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }

}

