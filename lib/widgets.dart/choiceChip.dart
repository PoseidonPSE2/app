import 'package:flutter/material.dart';

class MyChoiceChip extends StatefulWidget {
  final List<String> choiceItems;
  final ValueChanged<String> onSelected;
  const MyChoiceChip(
      {required this.choiceItems, required this.onSelected, super.key});

  @override
  State<MyChoiceChip> createState() => _MyChoiceChipState();
}

class _MyChoiceChipState extends State<MyChoiceChip> {
  String? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.choiceItems.map((choice) {
        return ChoiceChip(
          label: Text(choice),
          selected: selectedChoice == choice,
          onSelected: (selected) {
            setState(() {
              selectedChoice = choice;
              widget.onSelected(selectedChoice!);
            });
          },
        );
      }).toList(),
    );
  }
}
