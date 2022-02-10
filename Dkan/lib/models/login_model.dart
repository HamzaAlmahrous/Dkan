import 'package:dkan/models/user.dart';

class DkanLoginModel{
  late bool status;
  late String message;
  User? data;

  DkanLoginModel.empty(){
    status = false;
    message = '';
    data = User.empty();
  }

  DkanLoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }
}