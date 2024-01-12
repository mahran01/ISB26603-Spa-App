import 'package:flutter/material.dart';

class facial_Decoration extends StatelessWidget {
  final void Function()? onTap;
  final String text1;
  final String text2;
  final IconData icon;
  final Color color_shceme;
  final Color color_icon;
  final Color color_text;
  final Color color_text1;
  final double width;

  facial_Decoration({
    super.key,
    required this.onTap,
    required this.text1,
    required this.text2,
    required this.icon,
    required this.color_shceme,
    required this.color_icon,
    required this.color_text,
    required this.color_text1,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color_shceme,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color_icon,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: 35,
              ),
            ),
            SizedBox(height: 30),
            Text(
              text1,
              style: TextStyle(
                fontSize: 18,
                color: color_text,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color_text1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
