import 'package:buscatelo/data/network/failure_error_handler.dart';
import 'package:buscatelo/data/repository/hotel_repository.dart';
import 'package:buscatelo/data/repository/turkey_hotels_repository.dart';
import 'package:buscatelo/data/repository/osm_hotel_repository.dart';
import 'package:buscatelo/model/hotel_model.dart';
import 'package:flutter/material.dart';

class HotelBloc extends ChangeNotifier {
  HotelRepository repository = OsmHotelRepository();

  /// Private list of [HotelModel]
  List<HotelModel> _hotels = [];

  /// Public getter for hotels
  List<HotelModel> get hotels => _hotels;

  /// [Failure] instance
  Failure? _failure;
  Failure? get failure => _failure;

  void retrieveHotels() async {
    print('HotelBloc: retrieveHotels called');
    try {
      _hotels = await repository.fetchHotels();
      print('HotelBloc: Retrieved ${_hotels.length} hotels');
      for (var hotel in _hotels) {
        print('Hotel: ${hotel.name} - ${hotel.address}');
      }
    } on Failure catch (e) {
      print('HotelBloc: Error - ${e.message}');
      _failure = e;
    } catch (e) {
      print('HotelBloc: Unexpected error - $e');
      _failure = Failure('Beklenmeyen hata: $e', 500);
    }
    notifyListeners();
  }
}
