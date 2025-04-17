class CartModel{
  List<ProductCart> productsCart;

  CartModel(this.productsCart);
}

class ProductCart{
  String image;
  String name;
  int quantity;
  double price;
  ProductCart({required this.name,required this.quantity,required this.image, required this.price});


}