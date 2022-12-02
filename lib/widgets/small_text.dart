import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class smallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  TextOverflow overflow;
  smallText(
      {super.key,
      this.color = const Color(0xffccc7c5),
      required this.text,
      this.size = 12,
      this.height = 1.2,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: overflow,
      style: TextStyle(fontSize: size, color: color, height: height),
    );
  }
}
