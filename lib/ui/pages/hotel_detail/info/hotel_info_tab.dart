import 'package:buscatelo/model/hotel_model.dart';
import 'package:flutter/material.dart';

class HotelInformationTab extends StatelessWidget {
  const HotelInformationTab({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final HotelModel hotel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description Section
          _buildSection(
            title: 'About',
            child: Text(
              hotel.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Colors.grey[700],
              ),
            ),
          ),
          
          SizedBox(height: 30),
          
          // Amenities Section
          _buildSection(
            title: 'Amenities',
            child: _buildAmenitiesGrid(),
          ),
          
          SizedBox(height: 30),
          
          // Location Section
          _buildSection(
            title: 'Location',
            child: _buildLocationCard(),
          ),
          
          SizedBox(height: 30),
          
          // Policies Section
          _buildSection(
            title: 'Hotel Policies',
            child: _buildPoliciesList(),
          ),
          
          SizedBox(height: 100), // Bottom padding for booking bar
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildAmenitiesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: hotel.amenities.length,
      itemBuilder: (context, index) {
        final amenity = hotel.amenities[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6732c1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getAmenityIcon(amenity.name),
                  color: Color(0xFF6732c1),
                  size: 20,
                ),
              ),
              Expanded(
                child: Text(
                  amenity.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getAmenityIcon(String amenityName) {
    switch (amenityName.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'pool':
        return Icons.pool;
      case 'gym':
        return Icons.fitness_center;
      case 'spa':
        return Icons.spa;
      case 'restaurant':
        return Icons.restaurant;
      case 'bar':
        return Icons.local_bar;
      case 'parking':
        return Icons.local_parking;
      case 'room service':
        return Icons.room_service;
      case 'air conditioning':
        return Icons.ac_unit;
      case 'tv':
        return Icons.tv;
      default:
        return Icons.check_circle;
    }
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF6732c1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.location_on,
              color: Color(0xFF6732c1),
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hotel Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  hotel.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey[400],
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildPoliciesList() {
    final policies = [
      {'title': 'Check-in', 'time': '3:00 PM', 'icon': Icons.login},
      {'title': 'Check-out', 'time': '11:00 AM', 'icon': Icons.logout},
      {'title': 'Cancellation', 'time': 'Free until 24h before', 'icon': Icons.cancel},
      {'title': 'Pets', 'time': 'Not allowed', 'icon': Icons.pets},
    ];

    return Column(
      children: policies.map((policy) {
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF6732c1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  policy['icon'] as IconData,
                  color: Color(0xFF6732c1),
                  size: 20,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      policy['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      policy['time'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
