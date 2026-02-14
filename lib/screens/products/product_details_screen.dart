import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/dummy_reviews.dart';
import '../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/wish_list_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../ui/common/base_screen.dart';
import '../../ui/widgets/about_us_section.dart';
import '../../ui/widgets/most_popular_products_section.dart';
import '../../ui/widgets/reviews_horizontal_list.dart';
import '../location/location_header.dart';
import '../popularproducts/popular_products_screen.dart';
import '../../screens/products/premiumTag.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = '1 liter';
  TextEditingController customQtyController = TextEditingController();


  final List<String> sizes = [
    '500 ml',
    '1 liter',
    '2 liter',
    'Custom quantity',
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BaseScreen(
      child: Column(
        children: [
          /// 🔝 HEADER
          LocationHeader(
            title: product.title,
            subtitle: '',
            showBack: true,
            showDropdown: false,
            onBack: () => Navigator.pop(context),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🖼 PRODUCT IMAGE
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          product.image,
                          height: 261,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// ❤️ WISHLIST ICON
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Consumer<WishlistProvider>(
                          builder: (_, wishlist, __) {
                            final isWishlisted =
                            wishlist.isWishlisted(product);

                            return GestureDetector(
                              onTap: () => wishlist.toggle(product),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFF3EBDD)
                                      .withValues(alpha: 0.85),
                                ),
                                child: Image.asset(
                                  isWishlisted
                                      ? 'assets/icons/wishlist_filled.png'
                                      : 'assets/icons/wishlist_outlined.png',
                                  width: 22,
                                  height: 22,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                        ),
                      ),


                    ],
                  ),


                  const SizedBox(height: 16),

                  const SizedBox(height: 16),

                  /// 🧾 PRODUCT DETAILS SECTION
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// LEFT SIDE (TITLE + PRICE + CATEGORY + RATING)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// TITLE
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),

                            const SizedBox(height: 5),

                            /// PRICE ROW
                            Row(
                              children: [
                                Text(
                                  '₹${product.originalPrice}/-',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '₹${product.price}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 5),

                            /// CATEGORY
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                product.category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),

                            /// RATING
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                      (i) => Padding(
                                    padding: const EdgeInsets.only(right: 3),
                                    child: Image.asset(
                                      i < product.rating.round()
                                          ? 'assets/icons/star_filled.png'
                                          : 'assets/icons/star_outlined.png',
                                      width: 14,
                                      height: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width:16),

                      /// RIGHT SIDE (QUANTITY DROPDOWN)
                      _sizeDropdown(),
                    ],
                  ),


                  const SizedBox(height: 10),


                      /// DESCRIPTION
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: AppColors.grey,
                        ),
                      ),


                  const SizedBox(height: 10),

                  const PremiumTag(),
                  const SizedBox(height: 15),

                  /// 🛒 ADD TO CART / QUANTITY
                  Consumer<CartProvider>(
                    builder: (_, cart, __) {
                      final isInCart = cart.isInCart(product);
                      final qty = cart.quantity(product);

                      /// ADD TO CART
                      if (!isInCart) {
                        return SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: () => cart.addToCart(product),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        );
                      }

                      /// ➖➕ QUANTITY CONTROLLER (IMPROVED UI)
                      return Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _qtyButton(
                              icon: Icons.remove,
                              onTap: () => cart.decrease(product),
                            ),

                            Text(
                              qty.toString(),
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            _qtyButton(
                              icon: Icons.add,
                              onTap: () => cart.increase(product),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  /// 🧾 ABOUT US
                  const AboutUsSection(),

                  const SizedBox(height: 24),

                  /// 🔥 MOST POPULAR

                  MostPopularProductsSection(
                    onViewAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MostPopularProductsScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  /// ⭐ CUSTOMER REVIEWS TITLE
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ratings & Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ReviewsHorizontalList(
                    reviews: dummyReviews,
                  ),

                  const SizedBox(height: 32),


        ],
              ),
              ),
            ),

        ],
      ),
    );
  }
  @override
  void dispose() {
    customQtyController.dispose();
    super.dispose();
  }


  /// 🔽 SIZE DROPDOWN (THEMED)
  Widget _sizeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedSize,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.black,
              ),
              dropdownColor: AppColors.white,
              borderRadius: BorderRadius.circular(14),
              items: sizes.map((size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(
                    size,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => selectedSize = value!);
              },
            ),
          ),
        ),

        /// 🔥 SHOW INPUT IF CUSTOM SELECTED
        if (selectedSize == 'Custom quantity') ...[
          const SizedBox(height: 8),
          SizedBox(
            width: 100,
            height: 40,
            child: TextField(
              controller: customQtyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter qty",
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ],
    );
  }



  /// ➖➕ ROUND BUTTON
  Widget _qtyButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 52,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppColors.white,
          size: 22,
        ),
      ),
    );


  }


}
