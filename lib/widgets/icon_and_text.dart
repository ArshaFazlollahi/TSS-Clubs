import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tss_clubs/utils/appcolors.dart';
import 'package:tss_clubs/utils/dimensions.dart';

class iconAndText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const iconAndText({
    super.key,
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.hsize(24),
        ),
        SizedBox(
          width: Dimensions.wsize(5),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: Dimensions.hsize(13)),
        ),
      ],
    );
  }
}
