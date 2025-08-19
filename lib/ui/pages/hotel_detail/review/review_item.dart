import 'package:buscatelo/model/hotel_model.dart';
import 'package:flutter/material.dart';

class ReviewItem extends StatelessWidget {
  final Review review;
  const ReviewItem({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[100]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Row(
            children: [
              // User Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.grey[200]!,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    review.userImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          color: Colors.grey[500],
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              SizedBox(width: 16),
              
              // User Name and Rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < review.rate 
                                ? Icons.star 
                                : Icons.star_border,
                            color: index < review.rate 
                                ? Colors.amber 
                                : Colors.grey[400],
                            size: 16,
                          );
                        }),
                        SizedBox(width: 8),
                        Text(
                          '${review.rate}.0',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Date
              Text(
                '2 days ago',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 16),
          
          // Review Message
          Text(
            review.message,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
          
          SizedBox(height: 16),
          
          // Review Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildReviewTag('Cleanliness', Icons.cleaning_services),
              _buildReviewTag('Service', Icons.room_service),
              _buildReviewTag('Location', Icons.location_on),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTag(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFF6732c1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF6732c1).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Color(0xFF6732c1),
            size: 14,
          ),
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF6732c1),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
