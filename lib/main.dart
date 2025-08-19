import 'dart:io';

import 'package:buscatelo/bloc/hotel_bloc.dart';
import 'package:buscatelo/commons/theme.dart';
import 'package:buscatelo/ui/pages/splash/splash_screen.dart';
import 'package:buscatelo/ui/pages/home/home_page.dart';
import 'package:buscatelo/ui/pages/explore/explore_page.dart';
import 'package:buscatelo/ui/utils/error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  ErrorWidget.builder = (FlutterErrorDetails details) => CustomErrorWidget();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HotelFinder',
      theme: ThemeData(
        primarySwatch: primarySwatch,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: accentColor),
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => ChangeNotifierProvider(
          create: (_) => HotelBloc(),
          child: const ExplorePage(),
        ),
        '/explore': (context) => ChangeNotifierProvider(
          create: (_) => HotelBloc(),
          child: const ExplorePage(),
        ),
      },
    );
  }
}
