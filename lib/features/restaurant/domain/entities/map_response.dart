class MapResponse {
  final int id;
  final Language title;
  final String phone;
  final String image;
  final String lat;
  final String long;
  final Language address;

  const MapResponse({
    required this.id,
    required this.title,
    required this.phone,
    required this.image,
    required this.lat,
    required this.long,
    required this.address,
  });

  factory MapResponse.fromJson(Map<String, dynamic> json) {
    return MapResponse(
      id: json['id'] as int,
      title: Language.fromJson(json['title'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      image: json['image'] as String,
      lat: json['lat'] as String,
      long: json['long'] as String,
      address: Language.fromJson(json['address'] as Map<String, dynamic>),
    );
  }
}
class Language{
  final String en;
  final String ar;
  const Language({
    required this.en,
    required this.ar,
  });
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      en: json['en'] as String,
      ar: json['ar'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}