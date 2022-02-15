import 'package:flutter/material.dart';

class IconButtons extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const IconButtons({
    Key? key,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          icon,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff3b3b3b),
        ),
      ),
      onTap: onTap,
    );
  }
}
