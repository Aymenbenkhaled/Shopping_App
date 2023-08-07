class CategoriesModel{
  bool? status;
  String? message;
  DataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);
  }

}

class DataModel{
  int? current_page;
  List<CategoriesDataModel>? data = [];

  DataModel.fromJson(Map<String,dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((element)=>data!.add(CategoriesDataModel.fromJson(element)));
  }

}

class CategoriesDataModel{
  int? id;
  String? name;
  String? image;

  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}