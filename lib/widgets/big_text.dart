import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tss_clubs/utils/dimensions.dart';

class bigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  bigText(
      {super.key,
      this.color = const Color(0xff332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow
          .ellipsis //elipsis means the dots that will be shown instaed of the text if its longer than the width
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: size == 0 ? Dimensions.font20 : size,
        color: color,
      ),
    );
  }
}
