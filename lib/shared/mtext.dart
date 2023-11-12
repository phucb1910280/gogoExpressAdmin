import 'package:flutter/material.dart';
import 'package:gogo_admin/shared/mcolors.dart';

class MText extends StatelessWidget {
  final String title;
  final String content;
  final double? size;
  final bool? bold;
  final bool? italic;
  const MText({
    super.key,
    required this.title,
    required this.content,
    this.size,
    this.bold,
    this.italic,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size ?? 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: SizedBox(
              child: Text(
                content,
                style: TextStyle(
                  fontSize: size ?? 16,
                  color: MColors.darkBlue,
                  fontWeight:
                      bold == true ? FontWeight.bold : FontWeight.normal,
                  fontStyle:
                      italic == true ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
