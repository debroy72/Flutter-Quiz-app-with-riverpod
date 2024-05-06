import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String optionText;
  final int index;
  final bool isSelected;
  final bool? isCorrect;
  final bool isOptionCorrect;
  final VoidCallback onSelectOption;

  const OptionWidget({
    Key? key,
    required this.optionText,
    required this.index,
    required this.isSelected,
    required this.isCorrect,
    required this.isOptionCorrect,
    required this.onSelectOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (isSelected) {
        return isCorrect != null
            ? (isCorrect! ? Colors.green : Colors.red)
            : Colors.grey; // selected but not yet validated
      } else if (!isSelected && isCorrect == false && isOptionCorrect) {
        return Colors
            .green; // correct answer should be shown in green if wrong option was selected
      } else {
        return Colors.grey; // option not selected
      }
    }

    return GestureDetector(
      onTap: onSelectOption,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: getColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(optionText),
            if (isSelected || (isCorrect == false && isOptionCorrect))
              Icon(
                isCorrect != null
                    ? (isCorrect! ? Icons.check_circle : Icons.cancel)
                    : Icons.circle,
                color: getColor(),
              ),
          ],
        ),
      ),
    );
  }
}
