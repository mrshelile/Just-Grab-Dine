class ProductModel {
  String name;
  String description;
  double price;
  String restaurant_phone_number;
  String restaurant_email_address;
  String restaurant_name;
  String productId;
  var restaurant_location;
  String imageUrl;
  ProductModel(
      {required this.restaurant_location,
      required this.description,
      required this.imageUrl,
      required this.productId,
      required this.restaurant_name,
      required this.restaurant_email_address,
      required this.price,
      required this.name,
      required this.restaurant_phone_number});
}
