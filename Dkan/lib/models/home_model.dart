import 'package:dkan/models/product_model.dart';

class Home {
    late bool status;
    HomeData? data;
    Home.fromJson(Map<String, dynamic> json){
      status = json['status'];
      data = HomeData.fromJson(json['data']);
    }
}

class HomeData{
  List<Banner> banners = [];
  List<Product> products = [];

  HomeData.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(Banner.fromJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(Product.fromJson(element));
    });
  }
}

class Banner{
  int? id;
  String? image;

  Banner.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}
