import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tss_clubs/utils/appcolors.dart';
import 'package:tss_clubs/utils/dimensions.dart';

class detailsPageText extends StatelessWidget {
  Color? color;
  final String text;
  final bool editable;
  double size;
  TextOverflow overflow;
  detailsPageText(
      {super.key,
      this.color = const Color(0xff332d2b),
      required this.text,
      this.size = 0,
      this.overflow = TextOverflow.ellipsis,
      required this.editable //elipsis means the dots that will be shown instaed of the text if its longer than the width
      });

  @override
  Widget build(BuildContext context) {
    if (editable == true && editable == false) {
      return TextField();
    } else {
      return ExpandableText(
        expandText: "tap to show more",
        collapseText: "tap to show less",
        text,
        maxLines: 4,
        linkColor: AppColor.purple,
        animation: true,
        animationDuration: Duration(milliseconds: 1900),
        collapseOnTextTap: true,
        expandOnTextTap: true,
        style: TextStyle(
          color: Color.fromARGB(255, 44, 4, 90),
          fontSize: size == 0 ? Dimensions.height15 : size,
          height: 1.4,
          letterSpacing: 0.5,
          wordSpacing: 1,
        ),
      );
    }
  }
}
