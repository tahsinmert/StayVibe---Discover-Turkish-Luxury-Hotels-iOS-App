class HotelModel {
  String name;
  String address;
  String description;
  String imageUrl;
  int price;
  List<Room> rooms;
  List<Review> reviews;
  List<Amenitie> amenities;

  HotelModel({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rooms,
    required this.reviews,
    required this.price,
    required this.description,
    required this.amenities,
  });

  HotelModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        price = json['price'] ?? 0,
        description = json['description'] ?? '',
        imageUrl = json['imageUrl'] ?? '',
        address = json['address'] ?? '',
        rooms = (json['rooms'] as List<dynamic>?)
                ?.map((v) => Room.fromJson(v))
                .toList() ??
            <Room>[],
        reviews = (json['reviews'] as List<dynamic>?)
                ?.map((v) => Review.fromJson(v))
                .toList() ??
            <Review>[],
        amenities = (json['amenities'] as List<dynamic>?)
                ?.map((v) => Amenitie.fromJson(v))
                .toList() ??
            <Amenitie>[];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['address'] = address;
    data['imageUrl'] = imageUrl;
    data['rooms'] = rooms.map((v) => v.toJson()).toList();
    data['reviews'] = reviews.map((v) => v.toJson()).toList();
    data['amenities'] = amenities.map((v) => v.toJson()).toList();
    return data;
  }
}

class Room {
  String imageUrl;
  String name;

  Room({required this.imageUrl, required this.name});

  Room.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'] ?? '',
        name = json['name'] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    return data;
  }
}

class Review {
  String message;
  String user;
  String userImage;
  int rate;

  Review({
    required this.message,
    required this.user,
    required this.userImage,
    required this.rate,
  });

  Review.fromJson(Map<String, dynamic> json)
      : message = json['message'] ?? '',
        user = json['user'] ?? '',
        userImage = json['userImage'] ?? '',
        rate = json['rate'] ?? 0;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['user'] = user;
    data['userImage'] = userImage;
    data['rate'] = rate;
    return data;
  }
}

class Amenitie {
  String name;
  String imageUrl;

  Amenitie({required this.name, required this.imageUrl});

  Amenitie.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        imageUrl = json['imageUrl'] ?? '';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
