import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../../models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 171,
      height: 261,
      child: Stack(
        children: [
          /// 🔹 Background image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              review.backgroundImage,
              width: 171,
              height: 261,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),

          /// 🔹 Review info glass card
          Positioned(
            left: 7,
            bottom: 10,
            child: Container(
              width: 157,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFCCCCCC)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// USER ROW
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage:
                        NetworkImage(review.userImage),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          review.userName,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// ⭐ STAR RATING
                  Row(
                    children: List.generate(
                      5,
                          (index) => Icon(
                        Icons.star,
                        size: 12,
                        color: index < review.rating
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// REVIEW TEXT
                  Text(
                    review.reviewText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
