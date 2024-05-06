import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String optionText;
  final int index;
  final int? selectedOptionIndex;
  final bool? isCorrect;
  final Function(int) onSelectOption;

  OptionWidget({
    Key? key,
    required this.optionText,
    required this.index,
    required this.selectedOptionIndex,
    this.isCorrect,
    required this.onSelectOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (selectedOptionIndex == index) {
        // Correct answer
        return isCorrect! ? Colors.green : Colors.red;
      } else if (isCorrect != null &&
          isCorrect! &&
          index == selectedOptionIndex) {
        return Colors.green;
      }
      // Default case
      return Colors.grey;
    }

    return ListTile(
      title: Text(optionText),
      leading: Radio<int>(
        value: index,
        groupValue: selectedOptionIndex,
        onChanged: (int? value) {
          onSelectOption(value!);
        },
        activeColor: getColor(),
      ),
    );
  }
}
