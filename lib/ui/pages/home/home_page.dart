import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:buscatelo/ui/pages/explore/explore_page.dart';
import 'package:buscatelo/ui/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _scaleController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
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
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.blue.withOpacity(0.05),
                  Colors.purple.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Top Bar with Profile Button
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          // Welcome Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hoş Geldiniz',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: const Color(0xFF4A5568),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Lüks deneyiminizi keşfedin',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: const Color(0xFF718096),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Profile Button - BELİRGİN VE BÜYÜK
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF667eea).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(25),
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
                                  padding: const EdgeInsets.all(16),
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Main Content
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            // Logo and Title
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.95),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 20,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    // Diamond Logo
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF667eea).withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.diamond,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    
                                                                         // Title with Shader and Profile Button
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         ShaderMask(
                                           shaderCallback: (bounds) => const LinearGradient(
                                             colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                             begin: Alignment.topLeft,
                                             end: Alignment.bottomRight,
                                           ).createShader(bounds),
                                           child: Text(
                                             'STAYVIBE',
                                             style: GoogleFonts.playfairDisplay(
                                               fontSize: 36,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ),
                                         const SizedBox(width: 15),
                                                                                   Container(
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF667eea).withOpacity(0.3),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(20),
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
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                       ],
                                     ),
                                    const SizedBox(height: 8),
                                    
                                    Text(
                                      'LUXURY REDEFINED',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFF4A5568),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            // Action Buttons
                            Column(
                              children: [
                                // Explore Button
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF667eea).withOpacity(0.3),
                                        blurRadius: 15,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => const ExplorePage(),
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return SlideTransition(
                                                position: Tween<Offset>(
                                                  begin: const Offset(0, 1.0),
                                                  end: Offset.zero,
                                                ).animate(animation),
                                                child: child,
                                              );
                                            },
                                            transitionDuration: const Duration(milliseconds: 400),
                                          ),
                                        );
                                      },
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.explore,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              'EXPLORE DESTINATIONS',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Secondary Buttons Row
                                Row(
                                  children: [
                                    // Wishlist Button
                                    Expanded(
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.08),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(18),
                                            onTap: () {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Wishlist feature coming soon!'),
                                                  backgroundColor: Color(0xFF667eea),
                                                ),
                                              );
                                            },
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.favorite,
                                                    color: Color(0xFF667eea),
                                                    size: 22,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'WISHLIST',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF667eea),
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 15),

                                    // Profile Button
                                    Expanded(
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.08),
                                              blurRadius: 10,
                                              offset: const Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.circular(18),
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
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    color: Color(0xFF667eea),
                                                    size: 22,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'PROFILE',
                                                    style: GoogleFonts.montserrat(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: const Color(0xFF667eea),
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
