import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  final TextEditingController overallCtrl = TextEditingController();

  /// per-product review controller
  final TextEditingController productCtrl = TextEditingController();
  bool showProductReviewBox = false;

  void submitFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback submitted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      /// 🔝 APP BAR WITH BACK
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Feedback',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      /// ✅ SCROLLABLE
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ⭐ OVERALL EXPERIENCE
            const Center(
              child: Text(
                'Rate your overall experience',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 16),

            /// ⭐ STAR RATING (UPDATED)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isFilled = index < rating;

                return GestureDetector(
                  onTap: () => setState(() => rating = index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // ⭐ GOLD FILLED BACK STAR
                        if (isFilled)
                          Icon(
                            Icons.star,
                            size: 30,
                            color: const Color(0xFFFFC107), // GOLD
                          ),

                        // ⭐ YOUR OUTLINE PNG ON TOP
                        Image.asset(
                          'assets/icons/star_outlined.png',
                          width: 30,
                          height: 30,
                          color: isFilled
                              ? const Color(0xFFFFC107) // gold outline
                              : const Color(0xFFBDBDBD), // grey outline
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            /// ✍️ OVERALL REVIEW
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFB7B1B1)),
              ),
              child: TextField(
                controller: overallCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write a review (Optional)',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// ✅ SUBMIT FEEDBACK
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: submitFeedback,
                child: const Text(
                  'Submit Feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// ================= FRAME 1219 INLINE =================

            const Text(
              'Write a review on your purchase',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4D4D4D),
              ),
            ),

            const SizedBox(height: 16),

            _productCard(),

            if (showProductReviewBox) _productReviewBox(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// 🧾 PRODUCT CARD
  Widget _productCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://placehold.co/62x62',
                  width: 62,
                  height: 62,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Low-Fat Buffalo Milk 500 ML',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rich taste with reduced fat',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    SizedBox(height: 6),
                    Text('₹ 470/-', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order Placed on 23 Jan',
                style: TextStyle(fontSize: 12),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  setState(() => showProductReviewBox = true);
                },

                /// 🖊 CUSTOM ICON (YOUR IMAGE)
                icon: Image.asset(
                  'assets/icons/edit.png',
                  width: 16,
                  height: 16,
                  color: Colors.white, // keeps it white
                ),

                label: const Text(
                  'Write a review',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }

  /// ✍️ PRODUCT REVIEW BOX
  Widget _productReviewBox() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          TextField(
            controller: productCtrl,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your product review...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                setState(() => showProductReviewBox = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Review submitted')),
                );
              },
              child: const Text(
                'Submit Review',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
