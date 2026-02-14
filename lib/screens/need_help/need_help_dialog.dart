import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../ui/common/app_colors.dart';
import '../../models/orders_model.dart';

void showNeedHelpDialog(BuildContext context, OrderModel order) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Need Help",
    barrierColor: AppColors.black.withValues(alpha: 0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) => const SizedBox(),
    transitionBuilder: (context, animation, __, ___) {
      final curved =
      CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: curved,
          child: _NeedHelpContent(order: order),
        ),
      );
    },
  );
}


//need help content
class _NeedHelpContent extends StatefulWidget {
  final OrderModel order;
  const _NeedHelpContent({required this.order});

  @override
  State<_NeedHelpContent> createState() => _NeedHelpContentState();
}

class _NeedHelpContentState extends State<_NeedHelpContent> {
  String? selectedIssue;

  @override
  Widget build(BuildContext context) {
    final item = widget.order.items.first;

    final screen = MediaQuery.of(context).size;

    final dialogWidth = screen.width * 0.92;
    final dialogHeight = screen.height * 0.85;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dialogWidth,
          height: dialogHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [

              /// PRODUCT CARD


            Positioned(
            left: dialogWidth * 0.03,
            right: dialogWidth * 0.03,
            top: dialogHeight * 0.10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE7E7E7)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: item.image.startsWith("http")
                        ? Image.network(
                      item.image,
                      width: 104,
                      height: 104,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      item.image,
                      width: 104,
                      height: 104,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// DETAILS
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(
                            color: Color(0xFF252525),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            color: Color(0xFF595959),
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${item.price} x${item.quantity}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF252525),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Delivered on 24 Dec 2025",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          widget.order.address,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// HEADER
              Positioned(
                left: 20,
                top: 20,
                child: const Text(
                  "Need Help?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              /// CLOSE
              Positioned(
                right: 16,
                top: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),

              /// ISSUES SECTION
              Positioned(
                left: dialogWidth * 0.05,
                right: dialogWidth * 0.05,
                top: dialogHeight * 0.38,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "What is the issue with the product?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),

                    _issue("Product no longer required"),
                    _issue("Damage product"),
                    _issue("Sent Wrong Product"),
                    _issue("Others"),
                  ],
                ),
              ),

              /// ADD IMAGE
              Positioned(
                left: dialogWidth * 0.05,
                top: dialogHeight * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add Images",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 136,
                      height: 105,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.5),
                          width: 0.5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// BUTTONS
              Positioned(
                left: dialogWidth * 0.08,
                right: dialogWidth * 0.08,
                bottom: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Refund",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Replace",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _issue(String title) {
    final selected = selectedIssue == title;

    return GestureDetector(
      onTap: () => setState(() => selectedIssue = title),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 1,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
