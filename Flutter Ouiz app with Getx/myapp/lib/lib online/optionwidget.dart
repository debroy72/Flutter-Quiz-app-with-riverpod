import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String optionText;
  final int index;
  final int? selectedOptionIndex;
  final bool? isCorrect;
  final Function(int) onSelectOption;

  const OptionWidget({
    Key? key,
    required this.optionText,
    required this.index,
    required this.selectedOptionIndex,
    required this.onSelectOption,
    this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the color of the option based on the current state
    Color _determineColor() {
      if (selectedOptionIndex == index) {
        if (isCorrect == true) {
          return Colors.green; // Correct answer
        } else if (isCorrect == false) {
          return Colors.red; // Incorrect answer
        }
      }
      return Colors.grey; // Default color for non-selected options
    }

    return GestureDetector(
      onTap: () => onSelectOption(index),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: _determineColor().withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _determineColor()),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                optionText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _determineColor(),
                ),
              ),
            ),
            Icon(
              selectedOptionIndex == index
                  ? (isCorrect == true
                      ? Icons.check_circle_outline
                      : Icons.highlight_off)
                  : Icons.radio_button_off,
              color: _determineColor(),
            ),
          ],
        ),
      ),
    );
  }
}
