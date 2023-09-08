class Advertisement {
  final String name;
  final String slug;
  final List<String> photos;
  final int id;
  final String currency;
  final int price;
  final String description;
  final List<AdvertisementImage> images;

  Advertisement({
    required this.name,
    required this.slug,
    required this.photos,
    required this.id,
    required this.currency,
    required this.price,
    required this.description,
    required this.images,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    List<AdvertisementImage> advertisementImages = [];

    if (json['images'] != null && json['images'] is List) {
      advertisementImages = (json['images'] as List)
          .map((imageJson) => AdvertisementImage.fromJson(imageJson))
          .toList();
    }

    return Advertisement(
      name: json['name'] as String,
      slug: json['slug'] as String,
      photos: List<String>.from(json['photos']),
      id: json['id'] as int,
      currency: json['currency'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      images: advertisementImages,
    );
  }
}

class AdvertisementImage {
  final int id;
  final Uri imageUri;

  AdvertisementImage({
    required this.id,
    required this.imageUri,
  });

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      id: json['id'] as int,
      imageUri: Uri.parse(json['image'] as String),
    );
  }
}
