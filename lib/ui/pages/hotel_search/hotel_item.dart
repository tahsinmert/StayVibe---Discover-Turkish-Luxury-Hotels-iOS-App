import 'package:buscatelo/commons/theme.dart';
import 'package:buscatelo/model/hotel_model.dart';
import 'package:buscatelo/ui/pages/hotel_detail/hotel_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:buscatelo/ui/pages/profile/favorite_hotels_page.dart';
import 'package:buscatelo/ui/widgets/weather_widget.dart';

class HotelItem extends StatefulWidget {
  final HotelModel hotel;

  const HotelItem({Key? key, required this.hotel}) : super(key: key);

  @override
  State<HotelItem> createState() => _HotelItemState();
}

class _HotelItemState extends State<HotelItem> with TickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _favoriteController;
  late AnimationController _cardController;
  late Animation<double> _cardScaleAnimation;
  final FavoriteHotelsManager _favoriteManager = FavoriteHotelsManager();

  @override
  void initState() {
    super.initState();
    _favoriteController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _cardScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _cardController,
      curve: Curves.easeInOut,
    ));
    
    // Check if hotel is already in favorites
    isFavorite = _favoriteManager.isFavorite(widget.hotel.name);
  }

  @override
  void dispose() {
    _favoriteController.dispose();
    _cardController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    
    if (isFavorite) {
      _favoriteController.forward();
      
      // Add to favorites manager
      _favoriteManager.addToFavorites({
        'id': widget.hotel.name, // Using name as ID for simplicity
        'name': widget.hotel.name,
        'location': widget.hotel.address,
        'rating': 4.8, // Default rating
        'price': '₺${widget.hotel.price}',
        'image': widget.hotel.imageUrl,
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.hotel.name} favorilere eklendi'),
          backgroundColor: const Color(0xFF667eea),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      _favoriteController.reverse();
      
      // Remove from favorites manager
      _favoriteManager.removeFromFavorites(widget.hotel.name);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.hotel.name} favorilerden çıkarıldı'),
          backgroundColor: Colors.grey[600],
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _cardController.forward(),
      onTapUp: (_) => _cardController.reverse(),
      onTapCancel: () => _cardController.reverse(),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HotelDetailPage(widget.hotel),
        ),
      ),
      child: AnimatedBuilder(
        animation: _cardScaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _cardScaleAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32), // More oval
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 40,
                    offset: const Offset(0, 16),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Image with Enhanced Design
                  Stack(
                    children: [
                      Hero(
                        tag: 'hotel_${widget.hotel.name}',
                        child: Container(
                          height: 220, // Slightly taller
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(widget.hotel.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.2),
                                  Colors.black.withOpacity(0.6),
                                ],
                                stops: [0.0, 0.6, 1.0],
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          // Availability Badge
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF667eea),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF667eea).withOpacity(0.3),
                                                  blurRadius: 8,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              'Müsait',
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          _buildRatingBadge(),
                                        ],
                                      ),
                                      
                                      // Weather Widget
                                      CompactWeatherWidget(
                                        cityName: _extractCityFromAddress(widget.hotel.address),
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  
                                  // Location Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 14,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            widget.hotel.address,
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Favorite Button with Enhanced Design
                      Positioned(
                        top: 16,
                        right: 16,
                        child: GestureDetector(
                          onTap: _toggleFavorite,
                          child: AnimatedBuilder(
                            animation: _favoriteController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: 1.0 + (_favoriteController.value * 0.2),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    isFavorite ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorite ? Colors.red : Colors.grey[600],
                                    size: 22,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Hotel Info with Enhanced Design
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hotel Name
                        Text(
                          widget.hotel.name,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1A1A1A),
                            height: 1.2,
                          ),
                        ),
                        
                        const SizedBox(height: 12),
                        
                        // Description
                        Text(
                          widget.hotel.description,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Price and Action Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price Section
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '₺${widget.hotel.price}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF667eea),
                                  ),
                                ),
                                Text(
                                  '/gece',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            
                            // Book Now Button
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF667eea),
                                    const Color(0xFF764ba2),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF667eea).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Rezervasyon',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildRatingBadge() {
    final double avg = _calculateAverageRating();
    final int count = widget.hotel.reviews.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star_rounded,
            color: Colors.amber[600],
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            avg.toStringAsFixed(1),
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          if (count > 0) ...[
            const SizedBox(width: 6),
            Text(
              '($count)',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }
  
  double _calculateAverageRating() {
    if (widget.hotel.reviews.isEmpty) return 0.0;
    final int sum = widget.hotel.reviews.fold<int>(0, (prev, r) => prev + r.rate);
    return sum / widget.hotel.reviews.length;
  }

  String _extractCityFromAddress(String address) {
    // Extract city name from address
    final parts = address.split(',');
    if (parts.isNotEmpty) {
      final city = parts.last.trim();
      
      // Map specific cities to their Turkish names
      final cityMappings = {
        'Istanbul': 'İstanbul',
        'Antalya': 'Antalya',
        'Bodrum': 'Bodrum',
        'Goreme': 'Kapadokya',
        'Fethiye': 'Fethiye',
        'Alanya': 'Alanya',
        'Cesme': 'Çeşme',
      };
      
      return cityMappings[city] ?? city;
    }
    return 'İstanbul'; // Default city
  }

  final TextStyle titleTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
}
