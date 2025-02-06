class Service {
  final String title;
  final String imageUrl;
  final double price;
  int quantity;

  Service({
    required this.title,
    required this.imageUrl,
    required this.price,
    this.quantity = 0,
  });
}
