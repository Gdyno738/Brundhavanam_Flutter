// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../data/dummy_products.dart';
// // import '../../models/product.dart';
// // import '../../ui/common/app_colors.dart';
// // import '../../ui/common/base_screen.dart';
// //
// // class FeedbackScreen extends StatefulWidget {
// //   const FeedbackScreen({super.key});
// //
// //   @override
// //   State<FeedbackScreen> createState() => _FeedbackScreenState();
// // }
// //
// // class _FeedbackScreenState extends State<FeedbackScreen> {
// //   int rating = 0;
// //   int productRating = 0;
// //   bool showReviewPanel = false;
// //   Product? selectedProduct;
// // on
// //
// //   final TextEditingController overallCtrl = TextEditingController();
// //   final TextEditingController productCtrl = TextEditingController();
// //
// //   final ImagePicker picker = ImagePicker();
// //   File? selectedImage;
// //
// //   void submitFeedback() {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Feedback submitted successfully')),
// //     );
// //   }
// //
// //   Future<void> pickImage() async {
// //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       setState(() {
// //         selectedImage = File(image.path);
// //       });
// //     }
// //   }
// //
// //   void _openReviewBottomSheet(Product product) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       useSafeArea: true,
// //
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
// //       ),
// //       builder: (context) {
// //         return StatefulBuilder(
// //           builder: (context, setModalState) {
// //             return Padding(
// //               padding: EdgeInsets.only(
// //                 left: 16,
// //                 right: 16,
// //                 top: 20,
// //                 bottom: MediaQuery
// //                     .of(context)
// //                     .viewInsets
// //                     .bottom + 20,
// //               ),
// //               child: SingleChildScrollView(
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //
// //                     /// product info
// //                     Row(
// //                       children: [
// //                         ClipRRect(
// //                           borderRadius: BorderRadius.circular(12),
// //                           child: Image.network(
// //                             product.image,
// //                             width: 60,
// //                             height: 60,
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Text(
// //                             product.title,
// //                             style: const TextStyle(fontWeight: FontWeight.w600),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //
// //
// //                     const SizedBox(height: 16),
// //
// //                     /// stars
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: List.generate(5, (i) {
// //                         return IconButton(
// //                           onPressed: () {
// //                             setModalState(() => productRating = i + 1);
// //                           },
// //                           icon: Icon(
// //                             Icons.star,
// //                             color: i < productRating
// //                                 ? Colors.amber
// //                                 : Colors.grey.shade400,
// //                           ),
// //                         );
// //                       }),
// //                     ),
// //
// //                     const SizedBox(height: 12),
// //
// //                     /// review box
// //                     TextField(
// //                       controller: productCtrl,
// //                       maxLines: 4,
// //                       decoration: InputDecoration(
// //                         hintText: 'Write a Review (Optional)',
// //                         border: OutlineInputBorder(
// //                           borderRadius: BorderRadius.circular(16),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 12),
// //
// //                     /// upload image
// //                     GestureDetector(
// //                       onTap: () async {
// //                         await pickImage();
// //                         setModalState(() {});
// //                       },
// //                       child: Container(
// //                         height: 100,
// //                         width: double.infinity,
// //                         decoration: BoxDecoration(
// //                           color: const Color(0xFFfF2F2F2),
// //                           borderRadius: BorderRadius.circular(16),
// //                           border: Border.all(color: Colors.grey.shade300),
// //                         ),
// //                         child: selectedImage == null
// //                             ? Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: const [
// //                             Icon(Icons.image_outlined),
// //                             SizedBox(height: 6),
// //                             Text('Upload Image'),
// //                           ],
// //                         )
// //                             : ClipRRect(
// //                           borderRadius: BorderRadius.circular(16),
// //                           child: Image.file(
// //                             selectedImage!,
// //                             fit: BoxFit.cover,
// //                             width: double.infinity,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 16),
// //
// //                     /// submit button
// //                     SizedBox(
// //                       width: double.infinity,
// //                       height: 48,
// //                       child: ElevatedButton(
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: AppColors.primary,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(24),
// //                           ),
// //                         ),
// //                         onPressed: () {
// //                           Navigator.pop(context);
// //                           ScaffoldMessenger.of(context).showSnackBar(
// //                             const SnackBar(content: Text('Review submitted')),
// //                           );
// //                         },
// //                         child: const Text(
// //                           'Submit Feedback',
// //                           style: TextStyle(
// //                             color: AppColors.white,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //
// //                       ),
// //                     ),
// //
// //                     const SizedBox(height: 8),
// //
// //                     TextButton(
// //                       onPressed: () => Navigator.pop(context),
// //                       child: const Text('Cancel'),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BaseScreen(
// //
// //       statusBarColor: AppColors.white,
// //       statusBarIconBrightness: Brightness.dark,
// //       child: Column(
// //         children: [
// //
// //           /// 🔹 HEADER
// //           SafeArea(
// //             bottom: false,
// //             child: Container(
// //               height: 56,
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               decoration: const BoxDecoration(
// //                 color: AppColors.white,
// //                 border: Border(
// //                   bottom: BorderSide(color: Color(0xFFEAEAEA)),
// //                 ),
// //               ),
// //               child: Row(
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () => Navigator.pop(context),
// //                     child: const Icon(
// //                       Icons.arrow_back,
// //                       color: AppColors.black,
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   const Text(
// //                     'Feedback',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //           /// 🔹 BODY
// //           Expanded(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //
// //                   const Center(
// //                     child: Text(
// //                       'Rate your overall experience',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 16),
// //
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: List.generate(5, (index) {
// //                       return GestureDetector(
// //                         onTap: () => setState(() => rating = index + 1),
// //                         child: Padding(
// //                           padding:
// //                           const EdgeInsets.symmetric(horizontal: 6),
// //                           child: Icon(
// //                             Icons.star,
// //                             size: 30,
// //                             color: index < rating
// //                                 ? Colors.amber
// //                                 : Colors.grey.shade400,
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //                   ),
// //
// //                   const SizedBox(height: 20),
// //
// //                   Container(
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20),
// //                       border:
// //                       Border.all(color: const Color(0xFFB7B1B1)),
// //                     ),
// //                     child: TextField(
// //                       controller: overallCtrl,
// //                       maxLines: 4,
// //                       decoration: const InputDecoration(
// //                         hintText: 'Write a review (Optional)',
// //                         border: InputBorder.none,
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 24),
// //
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 56,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.primary,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius:
// //                           BorderRadius.circular(20),
// //                         ),
// //                       ),
// //                       onPressed: submitFeedback,
// //                       child: const Text(
// //                         'Submit Feedback',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 30),
// //
// //                   const Text(
// //                     'Write a review on your purchase',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 16),
// //
// //                   _productCard(popularProducts.first)
// //
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //
// //   Widget _productCard(Product product) {
// //     return Container(
// //       padding: const EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFF6F6F6),
// //         borderRadius: BorderRadius.circular(24),
// //       ),
// //       child: Column(
// //         children: [
// //
// //           /// 🔹 PRODUCT IMAGE + TITLE
// //           Row(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(16),
// //                 child: Image.network(
// //                   product.image,
// //                   width: 62,
// //                   height: 62,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Text(
// //                   product.title,
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //           const SizedBox(height: 12),
// //
// //           /// 🔹 ORDER INFO + BUTTON
// //           Row(
// //             children: [
// //               const Expanded(
// //                 child: Text(
// //                   'Order Placed on 23 Jan, 7:46 AM',
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //               ),
// //               const SizedBox(width: 8),
// //
// //               ElevatedButton.icon(
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: AppColors.primary,
// //                   padding: const EdgeInsets.symmetric(
// //                       horizontal: 12, vertical: 10),
// //                   minimumSize: Size.zero,
// //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(16),
// //                   ),
// //                 ),
// //                 onPressed: () {
// //                   setState(() {
// //                     selectedProduct = product;
// //                     showReviewPanel = true;
// //                   });
// //                 },
// //
// //                 icon: const Icon(
// //                   Icons.edit,
// //                   color: Colors.white,
// //                   size: 16,
// //                 ),
// //                 label: const Text(
// //                   'Write a review',
// //                   style: TextStyle(color: Colors.white),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   }
// //
// //
//
// //
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import '../../data/dummy_products.dart';
// // import '../../models/product.dart';
// // import '../../ui/common/app_colors.dart';
// // import '../../ui/common/base_screen.dart';
// //
// // class FeedbackScreen extends StatefulWidget {
// //   const FeedbackScreen({super.key});
// //
// //   @override
// //   State<FeedbackScreen> createState() => _FeedbackScreenState();
// // }
// //
// // class _FeedbackScreenState extends State<FeedbackScreen> {
// //   int rating = 0;
// //   int productRating = 0;
// //
// //   final TextEditingController overallCtrl = TextEditingController();
// //   final TextEditingController productCtrl = TextEditingController();
// //
// //   final ImagePicker picker = ImagePicker();
// //   File? selectedImage;
// //
// //    bool showReviewPanel = false;
// //   Product? selectedProduct;
// //   bool isReviewOpen = false;
// //
// //
// //   void submitFeedback() {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Feedback submitted successfully')),
// //     );
// //   }
// //
// //   Future<void> pickImage() async {
// //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// //     if (image != null) {
// //       setState(() {
// //         selectedImage = File(image.path);
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return BaseScreen(
// //       statusBarColor: AppColors.white,
// //       statusBarIconBrightness: Brightness.dark,
// //       child: Column(
// //         children: [
// //
// //           /// HEADER
// //           SafeArea(
// //             bottom: false,
// //             child: Container(
// //               height: 56,
// //               padding: const EdgeInsets.symmetric(horizontal: 16),
// //               decoration: const BoxDecoration(
// //                 color: AppColors.white,
// //                 border: Border(
// //                   bottom: BorderSide(color: Color(0xFFEAEAEA)),
// //                 ),
// //               ),
// //               child: Row(
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () => Navigator.pop(context),
// //                     child: const Icon(Icons.arrow_back,
// //                         color: AppColors.black),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   const Text(
// //                     'Feedback',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w600,
// //                       color: AppColors.black,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //
// //           /// BODY
// //           Expanded(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //
// //                   const Center(
// //                     child: Text(
// //                       'Rate your overall experience',
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 16),
// //
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: List.generate(5, (index) {
// //                       return GestureDetector(
// //                         onTap: () => setState(() => rating = index + 1),
// //                         child: Padding(
// //                           padding:
// //                           const EdgeInsets.symmetric(horizontal: 6),
// //                           child: Icon(
// //                             Icons.star,
// //                             size: 30,
// //                             color: index < rating
// //                                 ? Colors.amber
// //                                 : Colors.grey.shade400,
// //                           ),
// //                         ),
// //                       );
// //                     }),
// //                   ),
// //
// //                   const SizedBox(height: 20),
// //
// //                   Container(
// //                     padding: const EdgeInsets.all(16),
// //                     decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.circular(20),
// //                       border:
// //                       Border.all(color: const Color(0xFFB7B1B1)),
// //                     ),
// //                     child: TextField(
// //                       controller: overallCtrl,
// //                       maxLines: 4,
// //                       decoration: const InputDecoration(
// //                         hintText: 'Write a review (Optional)',
// //                         border: InputBorder.none,
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 24),
// //
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 56,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColors.primary,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                       ),
// //                       onPressed: submitFeedback,
// //                       child: const Text(
// //                         'Submit Feedback',
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           color: Colors.white,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 30),
// //
// //                   const Text(
// //                     'Write a review on your purchase',
// //                     style: TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //
// //                   const SizedBox(height: 16),
// //
// //                   _productCard(popularProducts.first),
// //
// //                   const SizedBox(height: 16),
// //
// //                   /// 🔥 Animated Review Panel
// //                   if (showReviewPanel && selectedProduct != null)
// //                     AnimatedSwitcher(
// //                       duration: const Duration(milliseconds: 400),
// //                       transitionBuilder: (child, animation) {
// //                         final offsetAnimation = Tween<Offset>(
// //                           begin: const Offset(-1, 0),
// //                           end: Offset.zero,
// //                         ).animate(animation);
// //
// //                         return SlideTransition(
// //                           position: offsetAnimation,
// //                           child: child,
// //                         );
// //                       },
// //                       child: _reviewPanel(selectedProduct!),
// //                     ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _productCard(Product product) {
// //     return AnimatedSize(
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //       child: Container(
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFFF6F6F6),
// //           borderRadius: BorderRadius.circular(24),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //
// //             /// 🔹 PRODUCT IMAGE + TITLE
// //             Row(
// //               children: [
// //                 ClipRRect(
// //                   borderRadius: BorderRadius.circular(16),
// //                   child: Image.network(
// //                     product.image,
// //                     width: 62,
// //                     height: 62,
// //                     fit: BoxFit.cover,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 12),
// //                 Expanded(
// //                   child: Text(
// //                     product.title,
// //                     style: const TextStyle(fontWeight: FontWeight.w500),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //
// //             const SizedBox(height: 12),
// //
// //             /// 🔹 ORDER INFO + BUTTON
// //             Row(
// //               children: [
// //                 const Expanded(
// //                   child: Text(
// //                     'Order Placed on 23 Jan, 7:46 AM',
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //
// //                 ElevatedButton.icon(
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: AppColors.primary,
// //                     padding: const EdgeInsets.symmetric(
// //                         horizontal: 12, vertical: 10),
// //                     minimumSize: Size.zero,
// //                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                     shape: RoundedRectangleBorder(
// //                       borderRadius: BorderRadius.circular(16),
// //                     ),
// //                   ),
// //                   onPressed: () {
// //                     setState(() {
// //                       isReviewOpen = !isReviewOpen;
// //                     });
// //                   },
// //                   icon: const Icon(Icons.edit,
// //                       color: Colors.white, size: 16),
// //                   label: Text(
// //                     isReviewOpen
// //                         ? 'Close'
// //                         : 'Write a review',
// //                     style: const TextStyle(color: Colors.white),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //
// //             /// 🔥 REVIEW SECTION INSIDE SAME CONTAINER
// //     if (isReviewOpen) ...[
// //     const SizedBox(height: 15),
// //
// //     AnimatedOpacity(
// //     duration: const Duration(milliseconds: 300),
// //     opacity: isReviewOpen ? 1 : 0,
// //     child: Column(
// //     crossAxisAlignment: CrossAxisAlignment.start,
// //     children: [
// //
// //     /// HEADER PILL
// //     // Container(
// //     // height: 38,
// //     // padding: const EdgeInsets.symmetric(horizontal: 16),
// //     // decoration: BoxDecoration(
// //     // color: const Color(0xFFD1D1D1),
// //     // borderRadius: BorderRadius.circular(16),
// //     // ),
// //     // alignment: Alignment.centerLeft,
// //     // child: const Text(
// //     // 'Write a review',
// //     // style: TextStyle(
// //     // color: Color(0xFF4F4F4F),
// //     // fontSize: 14,
// //     // fontWeight: FontWeight.w500,
// //     // ),
// //     // ),
// //     // ),
// //
// //     const SizedBox(height: 20),
// //
// //     /// ⭐ STAR RATING (Your PNG Images)
// //     Row(
// //     children: List.generate(5, (i) {
// //     return GestureDetector(
// //     onTap: () {
// //     setState(() => productRating = i + 1);
// //     },
// //     child: Padding(
// //     padding: const EdgeInsets.only(right: 8),
// //     child: Image.asset(
// //     i < productRating
// //     ? 'assets/icons/star_filled.png'
// //         : 'assets/icons/star_outlined.png',
// //     width: 28,
// //     height: 28,
// //     ),
// //     ),
// //     );
// //     }),
// //     ),
// //
// //     const SizedBox(height: 15),
// //
// //     /// REVIEW TEXT BOX
// //     Container(
// //     height: 130,
// //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
// //     decoration: BoxDecoration(
// //     border: Border.all(color: const Color(0xFFB7B1B1)),
// //     borderRadius: BorderRadius.circular(20),
// //     ),
// //     child: TextField(
// //     controller: productCtrl,
// //     maxLines: null,
// //     expands: true,
// //     decoration: const InputDecoration(
// //     hintText: 'Write a Review (Optional)',
// //     border: InputBorder.none,
// //     ),
// //     ),
// //     ),
// //
// //     const SizedBox(height: 20),
// //
// //     /// UPLOAD IMAGE BOX
// //     GestureDetector(
// //     onTap: pickImage,
// //     child: Container(
// //     height: 70,
// //     alignment: Alignment.center,
// //     decoration: BoxDecoration(
// //     color: const Color(0xFFEDEDED),
// //     borderRadius: BorderRadius.circular(11),
// //     border: Border.all(
// //     color: Colors.black.withValues(alpha: 0.30),
// //     width: 0.5,
// //     ),
// //     ),
// //     child: selectedImage == null
// //     ? Text(
// //     'Upload Image',
// //     style: TextStyle(
// //     color: Colors.black.withValues(alpha: 0.50),
// //     fontSize: 12,
// //     ),
// //     )
// //         : ClipRRect(
// //     borderRadius: BorderRadius.circular(11),
// //     child: Image.file(
// //     selectedImage!,
// //     fit: BoxFit.cover,
// //     width: double.infinity,
// //     ),
// //     ),
// //     ),
// //     ),
// //
// //     const SizedBox(height: 20),
// //
// //     /// SUBMIT BUTTON
// //     GestureDetector(
// //     onTapDown: (_) {},
// //     child: AnimatedContainer(
// //     duration: const Duration(milliseconds: 150),
// //     height: 60,
// //     alignment: Alignment.center,
// //     decoration: BoxDecoration(
// //     color: AppColors.primary,
// //     borderRadius: BorderRadius.circular(20),
// //     ),
// //     child: const Text(
// //     'Submit Feedback',
// //     style: TextStyle(
// //     color: AppColors.white,
// //     fontSize: 18,
// //     fontWeight: FontWeight.w600,
// //     ),
// //     ),
// //     ),
// //     ),
// //
// //     const SizedBox(height: 8),
// //
// //     GestureDetector(
// //     onTap: () {
// //     setState(() {
// //     isReviewOpen = false;
// //     });
// //     },
// //     child: const Center(
// //     child: Text(
// //     'Cancel',
// //     style: TextStyle(
// //     fontSize: 12,
// //     fontWeight: FontWeight.w300,
// //     ),
// //     ),
// //     ),
// //     ),
// //     ],
// //     ),
// //     ),
// //     ],
// //   ],
// //     ),
// //       ),
// //     );
// //   }
// //
// //
// //   Widget _reviewPanel(Product product) {
// //     return Container(
// //       key: ValueKey(product.id),
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(24),
// //         boxShadow: const [
// //           BoxShadow(color: Colors.black12, blurRadius: 10),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //
// //           Row(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image.network(
// //                   product.image,
// //                   width: 60,
// //                   height: 60,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Text(product.title,
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.w600)),
// //               ),
// //             ],
// //           ),
// //
// //           const SizedBox(height: 16),
// //
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: List.generate(5, (i) {
// //               return IconButton(
// //                 onPressed: () {
// //                   setState(() => productRating = i + 1);
// //                 },
// //                 icon: Icon(
// //                   Icons.star,
// //                   color: i < productRating
// //                       ? Colors.amber
// //                       : Colors.grey.shade400,
// //                 ),
// //               );
// //             }),
// //           ),
// //
// //           const SizedBox(height: 12),
// //
// //           TextField(
// //             controller: productCtrl,
// //             maxLines: 4,
// //             decoration: InputDecoration(
// //               hintText: 'Write a Review (Optional)',
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(16),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 16),
// //
// //           SizedBox(
// //             width: double.infinity,
// //             height: 48,
// //             child: ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: AppColors.primary,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(20),
// //                 ),
// //               ),
// //               onPressed: () {
// //                 setState(() {
// //                   showReviewPanel = false;
// //                   productRating = 0;
// //                   productCtrl.clear();
// //                 });
// //
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text('Review submitted')),
// //                 );
// //               },
// //               child: const Text(
// //                 'Submit Review',
// //                 style: TextStyle(color: Colors.white),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../data/dummy_products.dart';
// import '../../models/product.dart';
// import '../../ui/common/app_colors.dart';
// import '../../ui/common/base_screen.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   const FeedbackScreen({super.key});
//
//   @override
//   State<FeedbackScreen> createState() => _FeedbackScreenState();
// }
//
// class _FeedbackScreenState extends State<FeedbackScreen>
//     with TickerProviderStateMixin {
//   int rating = 0;
//   int productRating = 0;
//
//   final TextEditingController overallCtrl = TextEditingController();
//   final TextEditingController productCtrl = TextEditingController();
//
//   final ImagePicker picker = ImagePicker();
//   File? selectedImage;
//
//   bool isReviewOpen = false;
//
//   void submitFeedback() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Feedback submitted successfully')),
//     );
//   }
//
//   Future<void> pickImage() async {
//     final XFile? image =
//     await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     productCtrl.addListener(() {
//       setState(() {});
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return BaseScreen(
//       statusBarColor: AppColors.white,
//       statusBarIconBrightness: Brightness.dark,
//       child: Column(
//         children: [
//
//           /// HEADER
//           SafeArea(
//             bottom: false,
//             child: Container(
//               height: 56,
//               padding:
//               const EdgeInsets.symmetric(horizontal: 16),
//               decoration: const BoxDecoration(
//                 color: AppColors.white,
//                 border: Border(
//                   bottom:
//                   BorderSide(color: Color(0xFFEAEAEA)),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.arrow_back,
//                         color: AppColors.black),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Feedback',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           /// BODY
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//
//                   const Center(
//                     child: Text(
//                       'Rate your overall experience',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   /// ⭐ PNG STARS FOR OVERALL RATING
//                   Row(
//                     mainAxisAlignment:
//                     MainAxisAlignment.center,
//                     children: List.generate(5, (index) {
//                       return GestureDetector(
//                         onTap: () =>
//                             setState(() =>
//                             rating =
//                                 index + 1),
//                         child: Padding(
//                           padding:
//                           const EdgeInsets.symmetric(
//                               horizontal: 6),
//                           child: Image.asset(
//                             index < rating
//                                 ? 'assets/icons/star_filled.png'
//                                 : 'assets/icons/star_outlined.png',
//                             width: 30,
//                             height: 30,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   Container(
//                     padding:
//                     const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       BorderRadius.circular(20),
//                       border: Border.all(
//                           color:
//                           const Color(0xFFB7B1B1)),
//                     ),
//                     child: TextField(
//                       controller: overallCtrl,
//                       maxLines: 4,
//                       decoration:
//                       const InputDecoration(
//                         hintText:
//                         'Write a review (Optional)',
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       style:
//                       ElevatedButton.styleFrom(
//                         backgroundColor:
//                         AppColors.primary,
//                         shape:
//                         RoundedRectangleBorder(
//                           borderRadius:
//                           BorderRadius.circular(
//                               20),
//                         ),
//                       ),
//                       onPressed:
//                       submitFeedback,
//                       child: const Text(
//                         'Submit Feedback',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   const Text(
//                     'Write a review on your purchase',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   _productCard(
//                       popularProducts.first),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _productCard(Product product) {
//     return AnimatedSize(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           /// PRODUCT ROW
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   product.image,
//                   width: 70,
//                   height: 70,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),
//
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "₹ ${product.price}",
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     const Text(
//                       "Order Placed on 23 Jan, 7:46AM",
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.lightGrey,
//                   foregroundColor: AppColors.black,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                     BorderRadius.circular(20),
//                   ),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     isReviewOpen = true;
//                   });
//                 },
//                 icon: const Icon(Icons.edit, size: 16),
//                 label: const Text("Write a review"),
//               ),
//             ],
//           ),
//
//           if (isReviewOpen) ...[
//             const SizedBox(height: 25),
//
//             /// ⭐ CENTERED STARS
//             Row(
//               mainAxisAlignment:
//               MainAxisAlignment.center,
//               children: List.generate(5, (i) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() =>
//                     productRating = i + 1);
//                   },
//                   child: Padding(
//                     padding:
//                     const EdgeInsets.symmetric(
//                         horizontal: 6),
//                     child: Icon(
//                       i < productRating
//                           ? Icons.star
//                           : Icons.star_border,
//                       size: 32,
//                       color: AppColors.black,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// REVIEW BOX
//             Container(
//               height: 130,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 borderRadius:
//                 BorderRadius.circular(16),
//                 border: Border.all(
//                     color: AppColors.lightGrey),
//               ),
//               child: TextField(
//                 controller: productCtrl,
//                 maxLines: null,
//                 expands: true,
//                 decoration:
//                 const InputDecoration(
//                   hintText:
//                   "Write a Review (Optional)",
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// UPLOAD BOX
//             GestureDetector(
//               onTap: pickImage,
//               child: Container(
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: AppColors.lightGrey,
//                   borderRadius:
//                   BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                   child: selectedImage == null
//                       ? const Column(
//                     mainAxisAlignment:
//                     MainAxisAlignment
//                         .center,
//                     children: [
//                       Icon(Icons.image),
//                       SizedBox(height: 4),
//                       Text("Upload Image"),
//                     ],
//                   )
//                       : ClipRRect(
//                     borderRadius:
//                     BorderRadius.circular(
//                         12),
//                     child: Image.file(
//                       selectedImage!,
//                       fit: BoxFit.cover,
//                       width:
//                       double.infinity,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /// SUBMIT BUTTON
//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                   productRating == 0
//                       ? AppColors.lightGrey
//                       : AppColors.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius:
//                     BorderRadius.circular(20),
//                   ),
//                 ),
//                 onPressed: productRating == 0
//                     ? null
//                     : () {
//                   setState(() {
//                     isReviewOpen = false;
//                     productRating = 0;
//                     productCtrl.clear();
//                     selectedImage =
//                     null;
//                   });
//                 },
//                 child: const Text(
//                   "Submit Feedback",
//                   style: TextStyle(
//                     color: AppColors.white,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//
//             /// CANCEL
//             Center(
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     isReviewOpen = false;
//                   });
//                 },
//                 child: const Text(
//                   "cancel",
//                   style: TextStyle(
//                     color: AppColors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/dummy_products.dart';
import '../../models/product.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>
    with TickerProviderStateMixin {

  int rating = 0;
  int productRating = 0;

  final TextEditingController overallCtrl = TextEditingController();
  final TextEditingController productCtrl = TextEditingController();

  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  bool isReviewOpen = false;

  @override
  void initState() {
    super.initState();
    productCtrl.addListener(() {
      setState(() {});
    });
  }

  void submitFeedback() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback submitted successfully')),
    );
  }

  Future<void> pickImage() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      child: Column(
        children: [

          /// HEADER
          SafeArea(
            bottom: false,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEAEAEA)),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        color: AppColors.black),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BODY
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Center(
                    child: Text(
                      'Rate your overall experience',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ⭐ OVERALL RATING STARS (PNG)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () =>
                            setState(() => rating = index + 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Image.asset(
                            index < rating
                                ? 'assets/icons/star_filled.png'
                                : 'assets/icons/star_outlined.png',
                            width: 30,
                            height: 30,
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
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Write a review on your purchase',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _productCard(popularProducts.first),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productCard(Product product) {
    bool isReviewValid =
        productRating > 0 || productCtrl.text.trim().isNotEmpty;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// PRODUCT ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹ ${product.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Order Placed on 23 Jan, 7:46AM",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightGrey,
                  foregroundColor: AppColors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isReviewOpen = true;
                  });
                },
                icon: const Icon(Icons.edit, size: 16),
                label: const Text("Write a review"),
              ),
            ],
          ),

          /// REVIEW SECTION WITH SLIDE ANIMATION
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            child: isReviewOpen
                ? Container(
              key: const ValueKey("review_section"),
              child: Column(
                children: [

                  const SizedBox(height: 25),

                  /// ⭐ PRODUCT RATING STARS (PNG)
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: List.generate(5, (i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() =>
                          productRating = i + 1);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Image.asset(
                            i < productRating
                                ? 'assets/icons/star_filled.png'
                                : 'assets/icons/star_outlined.png',
                            width: 32,
                            height: 32,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 130,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: AppColors.lightGrey),
                    ),
                    child: TextField(
                      controller: productCtrl,
                      maxLines: null,
                      expands: true,
                      decoration: const InputDecoration(
                        hintText:
                        "Write a Review (Optional)",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: selectedImage == null
                            ? const Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Icon(Icons.image),
                            SizedBox(height: 4),
                            Text("Upload Image"),
                          ],
                        )
                            : ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                              12),
                          child: Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width:
                            double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isReviewValid
                            ? AppColors.primary
                            : AppColors.lightGrey,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: isReviewValid
                          ? () {
                        setState(() {
                          isReviewOpen =
                          false;
                          productRating =
                          0;
                          productCtrl
                              .clear();
                          selectedImage =
                          null;
                        });
                      }
                          : null,
                      child: const Text(
                        "Submit Feedback",
                        style: TextStyle(
                          color:
                          AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isReviewOpen =
                          false;
                        });
                      },
                      child: const Text(
                        "cancel",
                        style: TextStyle(
                          color:
                          AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
