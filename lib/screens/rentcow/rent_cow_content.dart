import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../ui/common/app_colors.dart';
import '../../screens/rentcow/DateField.dart';
import '../../screens/rentcow/TimeField.dart';
import '../../screens/rentcow/EventDropdown.dart';
import '../../screens/rentcow/cow_type_selector.dart';
import '../../screens/rentcow/address_field.dart';
import '../rentcow/SelectButton.dart';

class RentCowContent extends StatefulWidget {
  const RentCowContent({super.key});

  @override
  State<RentCowContent> createState() => _RentCowContentState();
}

class _RentCowContentState extends State<RentCowContent> {
  int currentImageIndex = 0;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scheduleKey = GlobalKey();

  /// ✅ CONTROLLERS (Needed for Backend Integration)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController additionalController = TextEditingController();

  String selectedCow = 'Type of cow';
  List<String> selectedCowImages = [];

  String selectedFloor = 'Floor';
  String selectedHouseType = '';
  final TextEditingController customFloorController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final cart = Provider.of<CartProvider>(context, listen: false);

    if (cart.cowItem != null) {
      selectedCow = cart.cowItem!.name;
      selectedCowImages =
      cart.cowItem!.image.isNotEmpty ? [cart.cowItem!.image] : [];
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

          /// 🔹 HERO SECTION
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
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Scrollable.ensureVisible(
                            _scheduleKey.currentContext!,
                            duration: const Duration(milliseconds: 600),
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
              ],
            ),
          ),

          /// 🔹 FORM SECTION
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                Container(
                  key: _scheduleKey,
                  alignment: Alignment.center,
                  child: const Text(
                    'Schedule your visit',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 16),

                /// ✅ FIXED INPUTS
                _input('Name', controller: nameController),
                _input('Mobile Number', controller: mobileController),

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

                /// 🔹 FLOOR + HOUSE TYPE
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedFloor,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: const [
                              DropdownMenuItem(
                                  value: 'Floor', child: Text('Floor')),
                              DropdownMenuItem(
                                  value: '1st floor',
                                  child: Text('1st floor')),
                              DropdownMenuItem(
                                  value: '2nd floor',
                                  child: Text('2nd floor')),
                              DropdownMenuItem(
                                  value: '3rd floor',
                                  child: Text('3rd floor')),
                              DropdownMenuItem(
                                  value: 'Custom quantity',
                                  child: Text('Custom quantity')),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedFloor = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SelectButton(
                        text: 'Individual house',
                        isSelected:
                        selectedHouseType == 'Individual house',
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

                const SizedBox(height: 12),

                _bigInput('Additional details (if any)',
                    controller: additionalController),

                const EventDropdown(),

                /// 🔹 SELECT COW TYPE
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return CowTypeSelector(
                          onSelect: (name, images) {
                            setState(() {
                              selectedCow = name;
                              selectedCowImages = images;
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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedCow,
                            style: const TextStyle(color: Colors.grey)),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// 🔥 ADD TO CART BUTTON
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
                    onPressed: cart.cowItem != null
                        ? null
                        : () {
                      if (selectedCow == 'Type of cow') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content:
                            Text('Please select cow type'),
                          ),
                        );
                        return;
                      }

                      final image =
                      selectedCowImages.isNotEmpty
                          ? selectedCowImages[
                      currentImageIndex]
                          : '';

                      Provider.of<CartProvider>(context,
                          listen: false)
                          .addCowToCart(
                          selectedCow, image, 470);
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
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

  /// ✅ UPDATED INPUT METHOD (NOW SUPPORTS CONTROLLER)
  static Widget _input(String hint,
      {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  static Widget _bigInput(String hint,
      {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
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
