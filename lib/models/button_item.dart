import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {

  final String title;
  final IconData icon;
  final Color warna;

  const ButtonItem({super.key, required this.title, required this.icon, required this.warna});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF3F5F7),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text("Kamu telah menekan tombol $title")));
        },
        child: SizedBox(
          height: 100,
          width: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: warna),
                ),
                Icon(icon, color: warna,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
