import 'package:buscatelo/model/hotel_model.dart';
import 'package:buscatelo/data/network/failure_error_handler.dart';
import 'package:buscatelo/data/network/hotel_api.dart';
import 'package:buscatelo/data/repository/hotel_repository.dart';

class TurkeyHotelsRepository implements HotelRepository {
  @override
  Future<List<HotelModel>> fetchHotels() async {
    print('TurkeyHotelsRepository: fetchHotels called');
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      final hotels = [
        // Istanbul Hotels
        HotelModel(
          name: 'Çırağan Palace Kempinski',
          address: 'Çırağan Caddesi 32, Beşiktaş, İstanbul',
          description: 'Osmanlı sarayından dönüştürülmüş lüks otel, Boğaz manzarası',
          price: 2500,
          imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
          rooms: [
            Room(
              name: 'Deluxe Boğaz View',
              imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
            ),
            Room(
              name: 'Palace Suite',
              imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Ahmet Y.',
              userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
              rate: 5,
              message: 'Muhteşem bir deneyim! Boğaz manzarası nefes kesici.',
            ),
            Review(
              user: 'Maria S.',
              userImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
              rate: 5,
              message: 'Tarihi atmosfer ve modern konfor mükemmel birleşmiş.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
            Amenitie(name: 'Concierge', imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=100'),
          ],
        ),
        
        HotelModel(
          name: 'Four Seasons Bosphorus',
          address: 'Çırağan Caddesi 28, Beşiktaş, İstanbul',
          description: 'Boğaz kıyısında 5 yıldızlı lüks otel',
          price: 3000,
          imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
          rooms: [
            Room(
              name: 'Bosphorus View Room',
              imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Fatma K.',
              userImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
              rate: 5,
              message: 'Hizmet kalitesi gerçekten 5 yıldız!',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
            Amenitie(name: 'Concierge', imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=100'),
          ],
        ),

        // Antalya Hotels
        HotelModel(
          name: 'Calista Luxury Resort',
          address: 'Kemer, Antalya',
          description: 'Akdeniz kıyısında lüks resort',
          price: 1800,
          imageUrl: 'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800',
          rooms: [
            Room(
              name: 'Sea View Suite',
              imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Mehmet A.',
              userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
              rate: 5,
              message: 'Muhteşem deniz manzarası ve temiz plaj.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
            Amenitie(name: 'Beach Access', imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=100'),
          ],
        ),

        // Bodrum Hotels
        HotelModel(
          name: 'Amanruya',
          address: 'Bodrum, Muğla',
          description: 'Ege Denizi kıyısında özel lüks resort',
          price: 4000,
          imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
          rooms: [
            Room(
              name: 'Private Pool Villa',
              imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Elif D.',
              userImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
              rate: 5,
              message: 'Gizlilik ve lüksün mükemmel birleşimi.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
            Amenitie(name: 'Private Beach', imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=100'),
          ],
        ),

        // Cappadocia Hotels
        HotelModel(
          name: 'Museum Hotel',
          address: 'Göreme, Nevşehir',
          description: 'Peribacaları arasında tarihi otel',
          price: 2200,
          imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
          rooms: [
            Room(
              name: 'Cave Suite',
              imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Can Ö.',
              userImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
              rate: 5,
              message: 'Eşsiz bir deneyim, peribacaları manzarası muhteşem.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Terrace', imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=100'),
            Amenitie(name: 'Hot Air Balloon Tours', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=100'),
          ],
        ),

        // Fethiye Hotels
        HotelModel(
          name: 'D-Resort Göcek',
          address: 'Göcek, Fethiye',
          description: 'Göcek koyunda lüks marina resort',
          price: 1600,
          imageUrl: 'https://images.unsplash.com/photo-1571003123894-1f0594d2b5d9?w=800',
          rooms: [
            Room(
              name: 'Marina View Room',
              imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Zeynep K.',
              userImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
              rate: 5,
              message: 'Marina manzarası ve yat turları harika.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Marina', imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=100'),
            Amenitie(name: 'Yacht Tours', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=100'),
          ],
        ),

        // Alanya Hotels
        HotelModel(
          name: 'Kleopatra Royal Hotel',
          address: 'Alanya, Antalya',
          description: 'Kleopatra plajında lüks resort',
          price: 1400,
          imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
          rooms: [
            Room(
              name: 'Beach Front Suite',
              imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Deniz Y.',
              userImage: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100',
              rate: 5,
              message: 'Kleopatra plajının hemen yanında, muhteşem.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Beach Access', imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=100'),
            Amenitie(name: 'Water Sports', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
          ],
        ),

        // Çeşme Hotels
        HotelModel(
          name: 'Sheraton Çeşme Hotel',
          address: 'Çeşme, İzmir',
          description: 'Ege Denizi kıyısında lüks otel',
          price: 2000,
          imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
          rooms: [
            Room(
              name: 'Aegean View Room',
              imageUrl: 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800',
            ),
          ],
          reviews: [
            Review(
              user: 'Burak T.',
              userImage: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
              rate: 5,
              message: 'Çeşme\'nin en güzel koyunda, rüzgar sörfü için ideal.',
            ),
          ],
          amenities: [
            Amenitie(name: 'Spa', imageUrl: 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100'),
            Amenitie(name: 'Pool', imageUrl: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=100'),
            Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100'),
            Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100'),
            Amenitie(name: 'Water Sports', imageUrl: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=100'),
          ],
        ),
      ];
      
      print('TurkeyHotelsRepository: Created ${hotels.length} hotels');
      return hotels;
    } catch (e) {
      print('TurkeyHotelsRepository: Error - $e');
      throw Failure('Türkiye otelleri yüklenirken hata oluştu: ${e.toString()}', 500);
    }
  }
}
