import 'package:flutter/material.dart';

class TimeField extends StatefulWidget {
  const TimeField({super.key});

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  TimeOfDay? selectedTime;

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickTime,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFB7B1B1)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime == null
                  ? 'Time'
                  : selectedTime!.format(context),
              style: const TextStyle(
                color: Color(0xFF888888),
                fontSize: 14,
                fontFamily: 'Arimo',
              ),
            ),
            const Icon(Icons.access_time, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
