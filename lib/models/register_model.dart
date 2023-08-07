class RegisterModel{
  bool? status;
  String? message;
  UserRegisterData? data;

  RegisterModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] !=null ? UserRegisterData.fromJson(json['data']) : null;
  }

}

class UserRegisterData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserRegisterData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }

}