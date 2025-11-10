import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color warna;

  const ButtonItem({
    super.key,
    required this.title,
    required this.icon,
    required this.warna,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF3F5F7),
      elevation: 0,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol $title")),
            );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: warna,
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Center(child: Row(children: [Icon(icon), Text(title)])),
          ),
        ),
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color warna;
  final Widget route;

  const NavigationButton({
    super.key,
    required this.title,
    required this.icon,
    required this.warna,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF3F5F7),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol $title")),
            );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            color: warna,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
            child: Center(child: Row(children: [Icon(icon), Text(title)])),
          ),
        ),
      ),
    );
  }
}
