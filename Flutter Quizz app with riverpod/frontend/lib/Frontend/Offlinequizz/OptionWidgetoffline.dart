import 'package:flutter/material.dart';

class OptionWidgetoffline extends StatelessWidget {
  final String optionText;
  final int index;
  final int? selectedOptionIndex;
  final Function(int) onSelectOption;
  final bool? isCorrect;

  const OptionWidgetoffline({
    Key? key,
    required this.optionText,
    required this.index,
    required this.selectedOptionIndex,
    required this.onSelectOption,
    this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getOptionColor() {
      if (selectedOptionIndex == index) {
        return isCorrect ?? false ? Colors.green : Colors.red;
      }
      return Colors.black; // Default color when not selected
    }

    Icon getOptionIcon() {
      if (selectedOptionIndex == index) {
        return isCorrect == true
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.remove_circle, color: Colors.red);
      }
      return const Icon(Icons.radio_button_unchecked);
    }

    return GestureDetector(
      onTap: () => onSelectOption(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: getOptionColor()),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(color: getOptionColor()),
              ),
            ),
            getOptionIcon(),
          ],
        ),
      ),
    );
  }
}
