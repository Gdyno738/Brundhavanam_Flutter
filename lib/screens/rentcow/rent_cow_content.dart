import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../screens/rentcow/DateField.dart';
import '../../screens/rentcow/TimeField.dart';
import '../../screens/rentcow/EventDropdown.dart';
import '../../screens/rentcow/cow_type_selector.dart';
import '../../screens/rentcow/total_bill_bottom_sheet.dart';
import '../../screens/rentcow/address_field.dart';
import '../navigation/main_navigation.dart';
import '../rentcow/cart_payment.dart';
import '../rentcow/SelectButton.dart';

class RentCowContent extends StatefulWidget {
  const RentCowContent({super.key});

  @override
  State<RentCowContent> createState() => _RentCowContentState();
}

class _RentCowContentState extends State<RentCowContent> {
  int currentImageIndex = 0;
  double selectedCowPrice = 0;


  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scheduleKey = GlobalKey();



  String selectedCow = 'Type of cow';
  List<String> selectedCowImages = [];

  bool isNext = true;

  String selectedFloor = 'Floor';
  String selectedHouseType = '';
  final TextEditingController customFloorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cart = Provider.of<CartProvider>(context, listen: false);

    if (cart.cowItem != null) {
      selectedCow = cart.cowItem!.name;
      selectedCowImages = cart.cowItem!.image.isNotEmpty
          ? [cart.cowItem!.image]
          : [];
    }
  }


  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 HERO IMAGE WITH OVERLAYS
          SizedBox(
            height: 520,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/rentcow_banner.png',
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.20),
                  ),
                ),

                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 260,
                        child: Text(
                          'Pure Care. Ethical.\nPurpose-Driven.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w900,

                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(
                        width: 320,
                        child: Text(
                          'We offer healthy, well-maintained cows for rent for religious rituals, poojas, temple events, and traditional ceremonies. Our cows are raised with care, proper nutrition, and humane practices.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16,
                            fontFamily: 'Edu NSW ACT Foundation'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// ✅ BOOK NOW → SCROLL
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 10,
                          ),
                        ),
                        onPressed: () {
                          Scrollable.ensureVisible(
                            _scheduleKey.currentContext!,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 16,
                  bottom: 8,
                  child: Image.asset(
                    'assets/images/rentcowsmall02.png',
                    width: 140,
                    height: 150,
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 30,
                  child: Column(
                    children: const [
                      _InfoChip(text: '9:00 AM to 6:00 PM'),
                      SizedBox(height: 10),
                      _InfoChip(text: 'distance - bw range'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔹 FORM SECTION
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔑 SCROLL TARGET
                Container(
                  key: _scheduleKey,
                  alignment: Alignment.center,
                  child: const Text(
                    'Schedule your visit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                _input('Name'),
                _input('Mobile Number'),

                Row(
                  children: const [
                    Expanded(child: DateField()),
                    SizedBox(width: 10),
                    Expanded(child: TimeField()),
                  ],
                ),

                const SizedBox(height: 12),
                const AddressField(),

                const SizedBox(height: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 SCROLLABLE FLOOR + BUTTONS
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [

                          /// FLOOR DROPDOWN
                          Container(
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.transparent, // 👈 same as EventDropdown / CowTypeSelector
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedFloor,

                                // ✅ TEXT STYLE
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),

                                // ✅ DROPDOWN MENU BACKGROUND COLOR
                                dropdownColor: Colors.white,

                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                items: const [
                                  DropdownMenuItem(value: 'Floor', child: Text('Floor')),
                                  DropdownMenuItem(value: '1st floor', child: Text('1st floor')),
                                  DropdownMenuItem(value: '2nd floor', child: Text('2nd floor')),
                                  DropdownMenuItem(value: '3rd floor', child: Text('3rd floor')),
                                  DropdownMenuItem(
                                    value: 'Custom quantity',
                                    child: Text('Custom quantity'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedFloor = value!;
                                    if (value != 'Custom quantity') {
                                      customFloorController.clear();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          SelectButton(
                            text: 'Individual house',
                            isSelected: selectedHouseType == 'Individual house',
                            onTap: () {
                              setState(() {
                                selectedHouseType = 'Individual house';
                              });
                            },
                          ),

                          const SizedBox(width: 8),

                          SelectButton(
                            text: 'Apartment',
                            isSelected: selectedHouseType == 'Apartment',
                            onTap: () {
                              setState(() {
                                selectedHouseType = 'Apartment';
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    /// 🔹 CUSTOM ENTER (KEEP THIS EXACTLY AS YOU WROTE)
                    if (selectedFloor == 'Custom quantity') ...[
                      const SizedBox(height: 8),
                      Container(
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextField(
                          controller: customFloorController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'Enter quantity',
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),



                const SizedBox(height: 12),
                _bigInput('Additional details (if any)'),

                const EventDropdown(),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) {
                        return CowTypeSelector(
                          onSelect: (name, images, price) {
                            setState(() {
                              selectedCow = name;
                              selectedCowImages = images;
                              selectedCowPrice = price; // ✅ store price
                              currentImageIndex = 0;
                            });
                          },

                        );
                      },

                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCow,
                            style: const TextStyle(color: Colors.grey)),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                if (selectedCowImages.isNotEmpty) ...[
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        /// 🐄 PERFECTLY CENTERED IMAGE
                        GestureDetector(
                          onTap: () {
                            if (currentImageIndex < selectedCowImages.length - 1) {
                              setState(() {
                                currentImageIndex++;
                              });
                            }
                          },
                          child: Center(
                            child: SizedBox(
                              height: 220,
                              width: 320, // 👈 FIXED WIDTH FOR ALL IMAGES
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  selectedCowImages[currentImageIndex],
                                  fit: BoxFit.contain, // ✅ MOST IMPORTANT
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                        ),

                        /// ⬅ LEFT ARROW
                        if (currentImageIndex > 0)
                          Positioned(
                            left: 8,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentImageIndex--;
                                });
                              },
                              child: _arrowButton(Icons.chevron_left),
                            ),
                          ),

                        /// ➡ RIGHT ARROW
                        if (currentImageIndex < selectedCowImages.length - 1)
                          Positioned(
                            right: 8,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentImageIndex++;
                                });
                              },
                              child: _arrowButton(Icons.chevron_right),
                            ),
                          ),
                      ],
                    ),
                  ),


                  const SizedBox(height: 5),

                  /// DOT INDICATOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      selectedCowImages.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentImageIndex == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),

                ],



                const SizedBox(height: 40),

                // GestureDetector(
                //   onTap: () {
                //     showModalBottomSheet(
                //       context: context,
                //       isScrollControlled: true,
                //       backgroundColor: Colors.transparent,
                //       builder: (_) => const TotalBillBottomSheet(),
                //     );
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 16, vertical: 14),
                //     decoration: BoxDecoration(
                //       color: const Color(0xFFEDEDED),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: const Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text('Total',
                //                 style:
                //                 TextStyle(fontWeight: FontWeight.w600)),
                //             SizedBox(height: 4),
                //             Text(
                //               '₹470 + Delivery Charges',
                //               style: TextStyle(
                //                   fontSize: 12, color: Colors.grey),
                //             ),
                //           ],
                //         ),
                //         Icon(Icons.keyboard_arrow_up),
                //       ],
                //     ),
                //   ),
                // ),

                //const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cart.cowItem != null
                          ? Colors.grey
                          : AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (selectedCow == 'Type of cow') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select cow type'),
                          ),
                        );
                        return;
                      }

                      final image = selectedCowImages.isNotEmpty
                          ? selectedCowImages[currentImageIndex]
                          : '';

                      context.read<CartProvider>().addCowToCart(
                        selectedCow,
                        image,
                        selectedCowPrice,
                      );
                    },

                    child: cart.cowItem != null
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Added to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                        : const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _input(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  static Widget _bigInput(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        maxLines: 4,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

/// ================= INFO CHIP =================
class _InfoChip extends StatelessWidget {
  final String text;
  const _InfoChip({required this.text});

  @override
  Widget build(BuildContext context) {
    final bool isTime = text.contains('AM') || text.contains('PM');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isTime
                ? 'assets/icons/clock_symbol.png'
                : 'assets/icons/location_symbol.png',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


/// 🔹 CHIP BUTTON
class _ChipButton extends StatelessWidget {
  final String text;
  const _ChipButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}

Widget _arrowButton(IconData icon) {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 4),
      ],
    ),
    child: Icon(icon, size: 20),
  );
}

