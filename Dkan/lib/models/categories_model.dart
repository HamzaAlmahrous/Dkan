class Categories
{
   bool? status;
  late CategoriesData ?data;

  Categories.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData
{
  late int currentPage;
  late List<Categore> data = [];

  CategoriesData.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    json['data'].forEach((element)
    {
      data.add(Categore.fromJson(element));
    });
  }
}

class Categore
{
  int ?id;
  String? name;
  String ?image;



  Categore.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];

  }
}