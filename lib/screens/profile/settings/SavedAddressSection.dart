import 'package:flutter/material.dart';
import '../../../models/SavedAddress.dart';
import '../../../services/mock_profile_service.dart';


class SavedAddressSection extends StatefulWidget {
  const SavedAddressSection({super.key});

  @override
  State<SavedAddressSection> createState() => _SavedAddressSectionState();
}

class _SavedAddressSectionState extends State<SavedAddressSection> {
  bool expanded = false;
  List<SavedAddress> addresses = [];

  @override
  void initState() {
    super.initState();
    loadAddresses();
  }

  Future<void> loadAddresses() async {
    final data = await MockProfileService.getSavedAddresses();
    setState(() => addresses = data);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => expanded = !expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Saved Address",
                    style: TextStyle(color: Colors.grey)),
                Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),

        if (expanded)
          Wrap(
            spacing: 10,
            children: addresses.map(_addressCard).toList(),
          ),
      ],
    );
  }

  Widget _addressCard(SavedAddress address) {
    return SizedBox(
      width: 160,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(address.address,
                style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
