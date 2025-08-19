import 'package:buscatelo/model/hotel_model.dart';
import 'package:buscatelo/ui/pages/hotel_detail/review/review_item.dart';
import 'package:flutter/material.dart';

class HotelReviewTab extends StatelessWidget {
  final List<Review> reviews;
  const HotelReviewTab({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 100), // Bottom padding for booking bar
      itemCount: reviews.length,
      itemBuilder: (context, index) => ReviewItem(review: reviews[index]),
    );
  }
}
