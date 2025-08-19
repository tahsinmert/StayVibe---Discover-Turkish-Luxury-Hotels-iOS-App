import 'package:buscatelo/data/repository/hotel_repository.dart';
import 'package:buscatelo/model/hotel_model.dart';

class MockHotelRepository extends HotelRepository {
  @override
  Future<List<HotelModel>> fetchHotels() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      HotelModel(
        name: 'ArtHouse New York City',
        address: '90% Upper West Side',
        price: 1440,
        imageUrl:
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        description: 'Luxury hotel in the heart of New York City',
        rooms: [
          Room(
            name: 'Standard Room',
            imageUrl: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
                      Room(
              name: 'Premium Room',
              imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
            ),
        ],
        reviews: [
          Review(
            message: 'Very comfortable rooms!',
            user: 'John Doe',
            userImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
            rate: 4,
          ),
          Review(
            message: 'Great service and amenities',
            user: 'Jane Smith',
            userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
            rate: 5,
          ),
        ],
        amenities: [
          Amenitie(
            name: 'WiFi',
            imageUrl: 'https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color/254000/09-512.png',
          ),
          Amenitie(
            name: 'Parking',
            imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Parking_icon.svg/1200px-Parking_icon.svg.png',
          ),
        ],
      ),
      HotelModel(
        name: 'Grand Plaza Hotel',
        address: 'Downtown Business District',
        price: 1200,
        imageUrl:
            'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        description: 'Modern luxury hotel with stunning city views',
        rooms: [
          Room(
            name: 'Business Suite',
            imageUrl: 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
          Room(
            name: 'Executive Room',
            imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
        ],
        reviews: [
          Review(
            message: 'Excellent business facilities',
            user: 'Business Traveler',
            userImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
            rate: 5,
          ),
        ],
        amenities: [
          Amenitie(
            name: 'Business Center',
            imageUrl: 'https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color/254000/09-512.png',
          ),
          Amenitie(
            name: 'Gym',
            imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Parking_icon.svg/1200px-Parking_icon.svg.png',
          ),
        ],
      ),
      HotelModel(
        name: 'Seaside Resort',
        address: 'Beachfront Paradise',
        price: 800,
        imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        description: 'Relaxing beachfront resort with ocean views',
        rooms: [
          Room(
            name: 'Ocean View Room',
            imageUrl: 'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
          Room(
            name: 'Beach Villa',
            imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
        ],
        reviews: [
          Review(
            message: 'Perfect beach getaway!',
            user: 'Beach Lover',
            userImage: 'https://cdn4.iconfinder.com/data/icons/summer-and-the-beach-in-filled-outline-style/512/Summer_and_The_Beach_in_Filled_Outline_Style-16-512.png',
            rate: 5,
          ),
        ],
        amenities: [
          Amenitie(
            name: 'Beach Access',
            imageUrl: 'https://cdn4.iconfinder.com/data/icons/summer-and-the-beach-in-filled-outline-style/512/Summer_and_The_Beach_in_Filled_Outline_Style-16-512.png',
          ),
          Amenitie(
            name: 'Pool',
            imageUrl: 'https://img.icons8.com/all/500/room.png',
          ),
        ],
      ),
      HotelModel(
        name: 'Mountain Lodge',
        address: 'Alpine Retreat',
        price: 600,
        imageUrl:
            'https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
        description: 'Cozy mountain lodge with scenic views',
        rooms: [
          Room(
            name: 'Mountain View Room',
            imageUrl: 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
          Room(
            name: 'Cabin Suite',
            imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
          ),
        ],
        reviews: [
          Review(
            message: 'Peaceful mountain retreat',
            user: 'Nature Enthusiast',
            userImage: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
            rate: 4,
          ),
        ],
        amenities: [
          Amenitie(
            name: 'Hiking Trails',
            imageUrl: 'https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color/254000/09-512.png',
          ),
          Amenitie(
            name: 'Spa',
            imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Parking_icon.svg/1200px-Parking_icon.svg.png',
          ),
        ],
      ),
    ];
  }
}
