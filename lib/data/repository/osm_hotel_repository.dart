import 'dart:convert';
import 'dart:math';

import 'package:buscatelo/data/network/failure_error_handler.dart';
import 'package:buscatelo/data/repository/hotel_repository.dart';
import 'package:buscatelo/model/hotel_model.dart';
import 'package:http/http.dart' as http;

/// Fetches hotels in Turkey from OpenStreetMap Overpass API
/// Known public data source, returns JSON
class OsmHotelRepository implements HotelRepository {
  static const String _endpoint = 'https://overpass-api.de/api/interpreter';

  @override
  Future<List<HotelModel>> fetchHotels() async {
    try {
      // Overpass query: all tourism=hotel within Turkey area (ISO3166-1=TR)
      // Limit output size by asking up to ~250 elements and including centers for ways/relations
      const String overpassQuery = '''
[out:json][timeout:25];
area["ISO3166-1"="TR"][admin_level=2]->.searchArea;
(
  node["tourism"="hotel"](area.searchArea);
  way["tourism"="hotel"](area.searchArea);
  relation["tourism"="hotel"](area.searchArea);
);
out center 250;
''';

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'data=${Uri.encodeQueryComponent(overpassQuery)}',
      );

      if (response.statusCode != 200) {
        throw Failure('Overpass API error: HTTP ${response.statusCode}', response.statusCode);
      }

      final Map<String, dynamic> jsonBody = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> elements = (jsonBody['elements'] as List<dynamic>? ?? <dynamic>[]);

      final Random rng = Random(42);
      final List<HotelModel> hotels = <HotelModel>[];

      for (final dynamic el in elements) {
        if (el is! Map<String, dynamic>) continue;
        final Map<String, dynamic> tags = (el['tags'] as Map<String, dynamic>? ?? <String, dynamic>{});
        if (tags.isEmpty) continue;

        final String name = (tags['name'] as String?)?.trim() ?? 'Unnamed Hotel';
        final String city = (tags['addr:city'] as String?)?.trim() ?? (tags['addr:place'] as String?)?.trim() ?? '';
        final String street = (tags['addr:street'] as String?)?.trim() ?? '';
        final String number = (tags['addr:housenumber'] as String?)?.trim() ?? '';
        final String full = (tags['addr:full'] as String?)?.trim() ?? '';
        final String address = full.isNotEmpty
            ? full
            : [street.isNotEmpty ? '$street $number'.trim() : null, city.isNotEmpty ? city : null]
                .whereType<String>()
                .join(', ');

        // Map OSM 'stars' tag if present (1..5)
        final int stars = int.tryParse((tags['stars'] ?? '').toString()) ?? 0;

        // Deterministic pseudo-price based on name hash (for demo purposes)
        final int price = 800 + (name.hashCode.abs() % 3200); // ₺800 - ₺4000

        // Provide a generic hotel image (Unsplash) – OSM doesn't include images reliably
        final String imageUrl = 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=1200&q=80&auto=format&fit=crop';

        final List<Room> rooms = <Room>[
          Room(name: 'Standard Room', imageUrl: imageUrl),
        ];

        final List<Review> reviews = <Review>[
          Review(
            user: 'StayVibe Guest',
            userImage: 'https://images.unsplash.com/photo-1502685104226-ee32379fefbe?w=100&q=80&auto=format&fit=crop',
            rate: stars > 0 ? stars.clamp(1, 5) : (4 + rng.nextInt(2)),
            message: stars > 0 ? 'Official star rating: $stars★' : 'Great stay and service!',
          ),
        ];

        final List<Amenitie> amenities = <Amenitie>[
          if ((tags['internet_access'] ?? '').toString().isNotEmpty)
            Amenitie(name: 'Wi‑Fi', imageUrl: 'https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color/254000/09-512.png'),
          Amenitie(name: 'Restaurant', imageUrl: 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=100&q=80&auto=format&fit=crop'),
          Amenitie(name: 'Gym', imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=100&q=80&auto=format&fit=crop'),
        ];

        hotels.add(
          HotelModel(
            name: name,
            address: address.isNotEmpty ? address : city.isNotEmpty ? city : 'Turkey',
            description: 'Listed on OpenStreetMap. Discover comfort at $name.',
            price: price,
            imageUrl: imageUrl,
            rooms: rooms,
            reviews: reviews,
            amenities: amenities,
          ),
        );
      }

      // Deduplicate by name + address (OSM can return duplicates across types)
      final Map<String, HotelModel> unique = <String, HotelModel>{};
      for (final HotelModel h in hotels) {
        unique['${h.name}|${h.address}'] = h;
      }

      // Limit to a reasonable number for UI performance
      final List<HotelModel> result = unique.values.take(250).toList();
      if (result.isEmpty) {
        throw Failure('No hotels found from Overpass', 404);
      }
      return result;
    } catch (e) {
      if (e is Failure) rethrow;
      throw Failure('Failed to fetch hotels: $e', 500);
    }
  }
}


