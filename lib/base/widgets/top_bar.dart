import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final String? buttonText;
  final VoidCallback? onTap;
  final VoidCallback? actionLeft;
  final IconData? iconActionLeft;

  const TopBar({
    super.key,
    required this.title,
    this.buttonText,
    this.onTap,
    this.actionLeft,
    this.iconActionLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (actionLeft != null)
              IconButton(onPressed: actionLeft, icon: Icon(iconActionLeft)),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (buttonText != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              buttonText!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white70, // Personalizzabile
              ),
            ),
          ),
      ],
    );
  }
}
