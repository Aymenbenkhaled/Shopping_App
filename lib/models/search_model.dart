class SearchModel {
  bool? status;
  String? message;
  DataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }

}

class DataModel {
  List<ProductModel> data = [];

  DataModel.fromJson(Map<String, dynamic> json){
    json['data'].forEach((element) =>
        data.add(ProductModel.fromJson(element)));
  }
}


class ProductModel {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    //images = json['images'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }

}

