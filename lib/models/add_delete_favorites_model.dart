class AddDeleteFavModel {
  bool? status;
  String? message;

  AddDeleteFavModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}

