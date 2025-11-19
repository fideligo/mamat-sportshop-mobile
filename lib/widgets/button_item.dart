import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color warna;
  final VoidCallback? onTap;

  const ButtonItem({
    super.key,
    required this.title,
    required this.icon,
    required this.warna,
    this.onTap,
  });

  void _defaultAction(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text("Kamu telah menekan tombol $title")),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3F5F7),
      elevation: 0,
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else {
            _defaultAction(context);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            color: warna,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(icon), const SizedBox(width: 8), Text(title)],
            ),
          ),
        ),
      ),
    );
  }
}
