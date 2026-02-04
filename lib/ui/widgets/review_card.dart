import 'dart:ui';

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

          /// 🔹 Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              review.backgroundImage,
              width: 171,
              height: 261,
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 Gradient Overlay
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

          /// 🔹 Glass Review Info Card
          /// 🔹 Review info glass card
          Positioned(
            left: 7,
            right: 7,
            bottom: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.3),
                      width: 0.8,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// USER ROW
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
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
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// ⭐ STAR RATING (Use your PNG icons)
                      Row(
                        children: List.generate(
                          5,
                              (index) => Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Image.asset(
                              index < review.rating
                                  ? 'assets/icons/star_filled.png'
                                  : 'assets/icons/star_outlined.png',
                              width: 12,
                              height: 12,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

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
            ),
          ),

        ],
      ),
    );
  }
}
