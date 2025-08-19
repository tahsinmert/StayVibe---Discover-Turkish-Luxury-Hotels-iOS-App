import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Notification Settings
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool smsNotifications = false;
  bool bookingUpdates = true;
  bool promotionalOffers = true;
  bool priceAlerts = false;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
  }

  @override
  void dispose() {
    _fadeController.dispose();
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
                  const Color(0xFF667eea).withOpacity(0.1),
                  const Color(0xFF764ba2).withOpacity(0.05),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
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
                                borderRadius: BorderRadius.circular(15),
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds),
                            child: Text(
                              'Bildirimler',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(width: 50),
                        ],
                      ),
                    ),
                  ),

                  // Settings List
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: ListView(
                            children: [
                              // General Notifications Section
                              _buildSectionHeader('Genel Bildirimler'),
                              _buildNotificationItem(
                                icon: Icons.notifications,
                                title: 'Push Bildirimleri',
                                subtitle: 'Mobil cihazınızda bildirim alın',
                                value: pushNotifications,
                                onChanged: (value) {
                                  setState(() {
                                    pushNotifications = value;
                                  });
                                },
                              ),
                              _buildNotificationItem(
                                icon: Icons.email,
                                title: 'E-posta Bildirimleri',
                                subtitle: 'E-posta adresinize bildirim gönderin',
                                value: emailNotifications,
                                onChanged: (value) {
                                  setState(() {
                                    emailNotifications = value;
                                  });
                                },
                              ),
                              _buildNotificationItem(
                                icon: Icons.sms,
                                title: 'SMS Bildirimleri',
                                subtitle: 'Telefon numaranıza SMS gönderin',
                                value: smsNotifications,
                                onChanged: (value) {
                                  setState(() {
                                    smsNotifications = value;
                                  });
                                },
                              ),

                              const SizedBox(height: 20),

                              // Content Notifications Section
                              _buildSectionHeader('İçerik Bildirimleri'),
                              _buildNotificationItem(
                                icon: Icons.book_online,
                                title: 'Rezervasyon Güncellemeleri',
                                subtitle: 'Rezervasyon durumu değişikliklerini alın',
                                value: bookingUpdates,
                                onChanged: (value) {
                                  setState(() {
                                    bookingUpdates = value;
                                  });
                                },
                              ),
                              _buildNotificationItem(
                                icon: Icons.local_offer,
                                title: 'Promosyon Teklifleri',
                                subtitle: 'Özel indirim ve teklifleri kaçırmayın',
                                value: promotionalOffers,
                                onChanged: (value) {
                                  setState(() {
                                    promotionalOffers = value;
                                  });
                                },
                              ),
                              _buildNotificationItem(
                                icon: Icons.trending_down,
                                title: 'Fiyat Uyarıları',
                                subtitle: 'Takip ettiğiniz otellerdeki fiyat düşüşleri',
                                value: priceAlerts,
                                onChanged: (value) {
                                  setState(() {
                                    priceAlerts = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildSectionHeader(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF2D3748),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF667eea).withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF667eea).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF667eea),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D3748),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: const Color(0xFF718096),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF667eea),
              activeTrackColor: const Color(0xFF667eea).withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}
