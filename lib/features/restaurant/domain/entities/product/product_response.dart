class ProductResponse {
  final int id;
  final Title title;
  final Title description;
  final int price;
  final ProductImage imageUrl;
  ProductResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int,
      title: Title.fromJson(json['title']),
      description: Title.fromJson(json['description']),
      price: json['price'] as int,
      imageUrl: ProductImage.fromJson(json['last_image']),
    );
  }
}
class Title{
  final String en;
  final String ar;
  Title({required this.en, required this.ar});
  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      en: json['en'] as String,
      ar: json['ar'] as String,
    );
  }
}
class ProductImage{
  final String image;
  final int id;
  ProductImage({required this.image, required this.id});
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      image: json['image'] as String,
      id: json['id'] as int,
    );
  }
}