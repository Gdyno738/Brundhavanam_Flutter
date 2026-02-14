import 'dart:ui';
import 'package:flutter/material.dart';
import '../common/app_colors.dart';
import '../../models/review.dart';

class ReviewCard extends StatefulWidget {
  final Review review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _expanded ? 1.05 : 1.0, // 🔥 POP OUT EFFECT
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 171,
        height: _expanded ? 290 : 261, // 🔥 OUTER CARD GROWS
        child: Stack(
          children: [

            /// 🔹 Background Image (DO NOT CHANGE SIZE)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.review.backgroundImage,
                width: 171,
                height: 261,
                fit: BoxFit.cover,
              ),
            ),

            /// 🔹 Gradient Overlay
            Container(
              height: 261,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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

            /// 🔹 Glass Card
            Positioned(
              left: 7,
              right: 7,
              bottom: 10,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: _expanded ? 14 : 8, // 🔥 MORE PADDING
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(18),
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
                                NetworkImage(widget.review.userImage),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.review.userName,
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

                          /// STAR RATING
                          Row(
                            children: List.generate(
                              5,
                                  (index) => Padding(
                                padding:
                                const EdgeInsets.only(right: 3),
                                child: Image.asset(
                                  index < widget.review.rating
                                      ? 'assets/icons/star_filled.png'
                                      : 'assets/icons/star_outlined.png',
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// REVIEW TEXT (CLICK HERE)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                            child: Text(
                              widget.review.reviewText,
                              maxLines: _expanded ? 5 : 2,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
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
      ),
    );
  }
}
