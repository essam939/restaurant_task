class CategoriesResponse {
 final int id;
  final String image;

  const CategoriesResponse({
    required this.id,
    required this.image,
  });
  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    return CategoriesResponse(
      id: json['id'] as int,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}
