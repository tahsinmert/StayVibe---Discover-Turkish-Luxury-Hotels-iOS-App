import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({Key? key}) : super(key: key);

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Tümü',
      'icon': Icons.all_inclusive,
      'color': const Color(0xFF667eea),
    },
    {
      'name': 'Lüks',
      'icon': Icons.diamond,
      'color': const Color(0xFFFFD700),
    },
    {
      'name': 'Ekonomik',
      'icon': Icons.attach_money,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'Sahil',
      'icon': Icons.beach_access,
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'Dağ',
      'icon': Icons.landscape,
      'color': const Color(0xFF795548),
    },
    {
      'name': 'Şehir',
      'icon': Icons.location_city,
      'color': const Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategoriler',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedIndex == index;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? category['color'] : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected ? category['color'] : Colors.grey[300]!,
                      width: 1.5,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: category['color'].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ] : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category['icon'],
                        size: 20,
                        color: isSelected ? Colors.white : category['color'],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
