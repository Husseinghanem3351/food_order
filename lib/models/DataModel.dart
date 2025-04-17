
class CategoriesModel {
  int? id;
  String? categoryName;
  List<ProductModel> products=[];

  CategoriesModel({
    required this.id,
    required this.categoryName,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

}
class ProductModel {
  int? id;
  String? productName;
  int? price;
  String? description;
  String? image;
  int? categoryId;
  String? categoryName;
  int quantity=0;

  ProductModel(
      {required this.id,
        required this.productName,
        required this.price,
        required this.description,
        required this.image,
        required this.categoryId,
        required this.categoryName,
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}
