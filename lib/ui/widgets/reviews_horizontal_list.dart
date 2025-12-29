import 'package:flutter/material.dart';
import '../../models/review.dart';
import 'review_card.dart';

class ReviewsHorizontalList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsHorizontalList({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 261,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return ReviewCard(review: reviews[index]);
        },
      ),
    );
  }
}
