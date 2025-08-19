import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:buscatelo/bloc/hotel_bloc.dart';
import 'package:buscatelo/ui/pages/hotel_search/hotel_item.dart';
import 'package:buscatelo/ui/pages/profile/profile_page.dart';
import 'package:buscatelo/model/hotel_model.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Istanbul', 'Antalya', 'Bodrum', 'Cappadocia', 'Fethiye', 'Alanya', 'Cesme'];
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    _fadeController.forward();
    _slideController.forward();
    
    // Load hotels
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HotelBloc>().retrieveHotels();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<HotelModel> _getFilteredHotels(List<HotelModel> hotels) {
    List<HotelModel> filtered = hotels;

    String normalize(String input) {
      final map = {
        'İ': 'I', 'I': 'I', 'ı': 'i', 'i': 'i', 'Ş': 'S', 'ş': 's', 'Ğ': 'G', 'ğ': 'g',
        'Ü': 'U', 'ü': 'u', 'Ö': 'O', 'ö': 'o', 'Ç': 'C', 'ç': 'c', 'Â': 'A', 'â': 'a',
      };
      final buffer = StringBuffer();
      for (final ch in input.characters) {
        buffer.write(map[ch] ?? ch);
      }
      return buffer.toString().toLowerCase().trim();
    }

    final normalizedCategory = normalize(_selectedCategory);
    final normalizedQuery = normalize(_searchQuery);

    // Filter by category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((hotel) {
        final name = normalize(hotel.name);
        final address = normalize(hotel.address);
        return address.contains(normalizedCategory) || name.contains(normalizedCategory);
      }).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((hotel) {
        final name = normalize(hotel.name);
        final address = normalize(hotel.address);
        final description = normalize(hotel.description);
        return name.contains(normalizedQuery) ||
               address.contains(normalizedQuery) ||
               description.contains(normalizedQuery);
      }).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/anasayfa-arka-plan.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Main Title with Profile Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Left Spacer
                                const SizedBox(width: 60),
                                
                                // Center Title
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'STAYVIBE',
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 42,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(0, 2),
                                              blurRadius: 10,
                                              color: Colors.black.withOpacity(0.5),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Discover Turkish Luxury',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white.withOpacity(0.9),
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Profile Button - Modern & Minimal
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(24),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => const ProfilePage(),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: const Offset(1.0, 0.0),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              );
                                            },
                                            transitionDuration: const Duration(milliseconds: 300),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        child: const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 25),
                            
                            // Search Bar
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(32),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                    size: 24,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        setState(() {
                                          _searchQuery = value;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search for hotel, city or destination...',
                                        hintStyle: GoogleFonts.montserrat(
                                          color: Colors.grey[500],
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
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

                  // Category Filters
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          itemBuilder: (context, index) {
                            final category = _categories[index];
                            final isSelected = _selectedCategory == category;
                            
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? Colors.white.withOpacity(0.9)
                                      : Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: isSelected 
                                        ? const Color(0xFF667eea)
                                        : Colors.white.withOpacity(0.3),
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: isSelected ? [
                                    BoxShadow(
                                      color: const Color(0xFF667eea).withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ] : null,
                                ),
                                child: Text(
                                  category,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    color: isSelected ? const Color(0xFF667eea) : Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Hotels List
                  Expanded(
                    child: Consumer<HotelBloc>(
                      builder: (context, hotelBloc, child) {
                        if (hotelBloc.failure != null) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'An error occurred',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    hotelBloc.failure!.message,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (hotelBloc.hotels.isEmpty) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      const Color(0xFF667eea),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Loading the finest hotels in Turkey...',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        final filteredHotels = _getFilteredHotels(hotelBloc.hotels);

                        if (filteredHotels.isEmpty) {
                          return Center(
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              margin: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No results found',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Try changing your search criteria',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          itemCount: filteredHotels.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(40),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: HotelItem(
                                  hotel: filteredHotels[index],
                                  key: ValueKey(filteredHotels[index].name),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
