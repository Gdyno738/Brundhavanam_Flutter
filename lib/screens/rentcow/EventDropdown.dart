import 'package:flutter/material.dart';

class EventDropdown extends StatefulWidget {
  const EventDropdown({super.key});

  @override
  State<EventDropdown> createState() => _EventDropdownState();
}

class _EventDropdownState extends State<EventDropdown> {
  String? selectedEvent;

  final List<String> events = [
    'Pooja',
    'Griha Pravesham',
    'Satyanarayana Swamy Pooja',
    'Wedding Ceremony',
    'Temple Festival',
    'Vastu Pooja',
    'House Warming',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        // ✅ BACKGROUND COLOR (NOT DEFAULT WHITE)
        decoration: BoxDecoration(
          color: Colors.transparent, // 👈 change color here
          border: Border.all(color: const Color(0xFFB7B1B1)),
          borderRadius: BorderRadius.circular(20),
        ),

        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedEvent,

            // ✅ DROPDOWN LIST BACKGROUND
            dropdownColor: const Color(0xFFF2F2F2),

            hint: const Text(
              'Event',
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 14,
                fontFamily: 'Arimo',
              ),
            ),

            isExpanded: true,

            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ),

            items: events.map((event) {
              return DropdownMenuItem<String>(
                value: event,
                child: Text(
                  event,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),

            onChanged: (value) {
              setState(() {
                selectedEvent = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
