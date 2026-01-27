import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../ui/common/app_colors.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  int productRating = 0;

  final TextEditingController overallCtrl = TextEditingController();
  final TextEditingController productCtrl = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  void submitFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback submitted successfully')),
    );
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void _openReviewBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// product info
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/cow.jpg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Low-Fat Buffalo Milk 500 ML',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// stars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        return IconButton(
                          onPressed: () {
                            setModalState(() => productRating = i + 1);
                          },
                          icon: Icon(
                            Icons.star,
                            color: i < productRating
                                ? Colors.amber
                                : Colors.grey.shade400,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 12),

                    /// review box
                    TextField(
                      controller: productCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Write a Review (Optional)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// upload image
                    GestureDetector(
                      onTap: () async {
                        await pickImage();
                        setModalState(() {});
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: selectedImage == null
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.image_outlined),
                            SizedBox(height: 6),
                            Text('Upload Image'),
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// submit button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Review submitted')),
                          );
                        },
                        child: const Text('Submit Feedback'),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Feedback',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                'Rate your overall experience',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => rating = index + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.star,
                      size: 30,
                      color: index < rating
                          ? Colors.amber
                          : Colors.grey.shade400,
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

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
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Write a review on your purchase',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 16),

            _productCard(),
          ],
        ),
      ),
    );
  }

  Widget _productCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/cow.jpg',
                  width: 62,
                  height: 62,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Low-Fat Buffalo Milk 500 ML'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Order Placed on 23 Jan, 7:46 AM'),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _openReviewBottomSheet,
                icon: const Icon(Icons.edit, color: Colors.white, size: 16),
                label: const Text('Write a review'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
