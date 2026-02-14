// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../ui/common/app_colors.dart';
// import 'orders_model.dart';
//
// void showCancelOrderDialog(BuildContext context, OrderModel order) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "Cancel Order",
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (_, __, ___) => const SizedBox(),
//     transitionBuilder: (context, animation, _, child) {
//       final curved = CurvedAnimation(
//         parent: animation,
//         curve: Curves.easeOutCubic,
//       );
//
//       return Transform.scale(
//         scale: curved.value,
//         child: Opacity(
//           opacity: animation.value,
//           child: CancelOrderDialog(order: order),
//         ),
//       );
//     },
//   );
// }
//
//
// //cancelorderdialogcontent
//
// class CancelOrderDialog extends StatefulWidget {
//   final OrderModel order;
//
//   const CancelOrderDialog({super.key, required this.order});
//
//   @override
//   State<CancelOrderDialog> createState() => _CancelOrderDialogState();
// }
//
// class _CancelOrderDialogState extends State<CancelOrderDialog> {
//   String? selectedReason;
//
//   final List<String> reasons = [
//     'Product no longer required',
//     'Others',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           width: MediaQuery.of(context).size.width * 0.92,
//           constraints: const BoxConstraints(maxHeight: 600),
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 /// 🔹 HEADER
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Need Help?',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.black,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const Icon(Icons.close),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 /// 🔹 PRODUCT CARD (FIGMA STYLE)
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF6F6F6),
//                     borderRadius: BorderRadius.circular(24),
//                     border: Border.all(color: const Color(0xFFE7E7E7)),
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       /// IMAGE
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image(
//                           image: widget.order.image.startsWith('http')
//                               ? NetworkImage(widget.order.image)
//                               : AssetImage(widget.order.image)
//                           as ImageProvider,
//                           width: 104,
//                           height: 104,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//
//                       const SizedBox(width: 12),
//
//                       /// DETAILS
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//
//                             Text(
//                               widget.order.title,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0xFF252525),
//                               ),
//                             ),
//
//                             const SizedBox(height: 6),
//
//                             Text(
//                               widget.order.subtitle,
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 color: Color(0xFF595959),
//                               ),
//                             ),
//
//                             const SizedBox(height: 8),
//
//                             Text(
//                               widget.order.price,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 color: Color(0xFF252525),
//                               ),
//                             ),
//
//                             const SizedBox(height: 8),
//
//                             const Text(
//                               'Delivered on 24 Dec 2025',
//                               style: TextStyle(fontSize: 12),
//                             ),
//
//                             const Text(
//                               'Gachibowli, Hyd...',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 const Text(
//                   'What is the issue with the product?',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 /// 🔹 RADIO OPTIONS (FIGMA STYLE)
//                 Column(
//                   children: reasons.map((reason) {
//                     final isSelected = selectedReason == reason;
//
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() => selectedReason = reason);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8),
//                         child: Row(
//                           children: [
//
//                             Container(
//                               width: 14,
//                               height: 14,
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFEFEFEF),
//                                 borderRadius: BorderRadius.circular(6),
//                                 border: Border.all(
//                                   color: AppColors.primary,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: isSelected
//                                   ? Container(
//                                 margin: const EdgeInsets.all(3),
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors.primary,
//                                 ),
//                               )
//                                   : null,
//                             ),
//
//                             const SizedBox(width: 10),
//
//                             Text(
//                               reason,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 /// 🔹 BUTTONS (FIGMA STYLE)
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () => Navigator.pop(context),
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(
//                               color: AppColors.primary, width: 2),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         child: const Text(
//                           'Back',
//                           style: TextStyle(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: selectedReason == null ? null : () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                         ),
//                         child: const Text(
//                           'Cancel Order',
//                           style: TextStyle(
//                             color: AppColors.white,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import '../../utils/date_utils.dart';
import '../../models/orders_model.dart'; // use the one your screen uses

void showCancelOrderDialog(BuildContext context, OrderModel order) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Cancel Order",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: CancelOrderDialog(order: order),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      );

      return ScaleTransition(
        scale: curved,
        child: child,
      );
    },
  );
}

class CancelOrderDialog extends StatefulWidget {
  final OrderModel order;

  const CancelOrderDialog({super.key, required this.order});

  @override
  State<CancelOrderDialog> createState() => _CancelOrderDialogState();
}

class _CancelOrderDialogState extends State<CancelOrderDialog> {
  String? selectedReason;
  final TextEditingController descriptionController =
  TextEditingController();

  final List<String> reasons = [
    'Product no longer required',
    'Others',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Cancel Order",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// 🔹 ORDER CARD (Figma Style)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE7E7E7)),
                ),
                child: Column(
                  children: [

                    /// 🔹 LOOP THROUGH ALL ITEMS
                    ...widget.order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: item.image.startsWith('http')
                                  ? Image.network(
                                item.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                item.image,
                                width: 80,
                                height: 80,
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
                                    style: const TextStyle(fontSize: 14),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFF595959),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    "${item.price} x${item.quantity}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),

                    const Divider(),

                    /// 🔹 DELIVERY STATUS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.order.status == OrderStatus.completed
                            ? 'Delivered on $AppDateUtils.formatDate(widget.order.orderDate)'
                            : 'On the way',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// 🔹 ADDRESS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.order.address,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 20),

              /// 🔹 REASON TITLE
              const Text(
                "What is the issue with the product?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 15),

              /// 🔹 RADIO OPTIONS
              Column(
                children: reasons.map((reason) {
                  final isSelected = selectedReason == reason;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedReason = reason);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                                : null,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            reason,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              /// 🔹 DESCRIPTION
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                height: 105,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Reason to cancel order",
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// 🔹 BUTTONS (Exactly Figma Layout)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Back",
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: selectedReason == null
                          ? null
                          : () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Cancel Order",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
