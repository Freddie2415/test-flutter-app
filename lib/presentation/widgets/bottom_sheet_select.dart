import 'package:app/presentation/pages/guest/success_page.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class BottomSheetSelect extends StatefulWidget {
  final String title;
  final String? selected;
  final List<String> items;
  final ScrollController scrollController;

  const BottomSheetSelect({
    super.key,
    required this.scrollController,
    required this.items,
    required this.selected,
    required this.title,
  });

  static Future showSelectBottomSheet({
    required context,
    required String title,
    required List<String> items,
    required String? selectedItem,
    double initialChildSize = 0.8,
  }) {
    return showModalBottomSheet(
      showDragHandle: false,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          expand: false,
          maxChildSize: 0.8,
          builder: (
            BuildContext context,
            ScrollController scrollController,
          ) {
            return BottomSheetSelect(
              title: title,
              scrollController: scrollController,
              items: items,
              selected: selectedItem,
            );
          },
        );
      },
    );
  }

  @override
  State<BottomSheetSelect> createState() => _BottomSheetSelectState();
}

class _BottomSheetSelectState extends State<BottomSheetSelect> {
  int? selectedIndex;

  @override
  void initState() {
    if (widget.selected != null) {
      selectedIndex =
          widget.items.indexWhere((element) => element == widget.selected);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemCount: widget.items.length,
              controller: widget.scrollController,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    setState(() => selectedIndex = index);
                  },
                  title: Text(widget.items.elementAt(index)),
                  trailing: SizedBox.square(
                    dimension: 24,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          width: index == selectedIndex ? 7 : 1,
                          color: index == selectedIndex
                              ? AppColor.mainBlue
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 0);
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyles.primary(),
            onPressed: () {
              Navigator.pop(context, selectedIndex);
            },
            child: const Text("Выбрать"),
          ),
        ],
      ),
    );
  }
}
