import 'package:flutter/material.dart';
import '../../ui/common/app_colors.dart';
import 'goshala_section.dart';

class QuickLinks extends StatefulWidget {
  final GoshalaSection selected;
  final ValueChanged<GoshalaSection> onChanged;

  const QuickLinks({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  State<QuickLinks> createState() => _QuickLinksState();
}

class _QuickLinksState extends State<QuickLinks> {
  final ScrollController _scrollController = ScrollController();

  final Map<GoshalaSection, GlobalKey> _keys = {
    GoshalaSection.live: GlobalKey(),
    GoshalaSection.history: GlobalKey(),
    GoshalaSection.donate: GlobalKey(),
    GoshalaSection.gallery: GlobalKey(),
  };

  @override
  void didUpdateWidget(covariant QuickLinks oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selected != widget.selected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected(widget.selected);
      });
    }
  }

  void _scrollToSelected(GoshalaSection section) {
    final context = _keys[section]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _tab(GoshalaSection.live, 'Live'),
          _tab(GoshalaSection.history, 'History'),
          _tab(GoshalaSection.donate, 'Donate'),
          _tab(GoshalaSection.gallery, 'Gallery'),
        ],
      ),
    );
  }

  Widget _tab(GoshalaSection section, String label) {
    final bool isSelected = widget.selected == section;

    return Container(
      key: _keys[section],
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          widget.onChanged(section);
          _scrollToSelected(section);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.green),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
