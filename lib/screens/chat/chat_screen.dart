import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          /// 🔝 CHAT HEADER
          Container(
            padding: EdgeInsets.fromLTRB(
              16,
              topPadding + 12,
              16,
              16,
            ),
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// ⬅ BACK BUTTON
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                /// 🧑‍💼 TITLE + STATUS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customer Support',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),

                    /// 🟢 ACTIVE BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFD7FFEB),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          /// DOT
                          SizedBox(
                            width: 8,
                            height: 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// 💬 CHAT BODY (PLACEHOLDER FOR NOW)
          const Expanded(
            child: Center(
              child: Text(
                'Chat messages will appear here',
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
