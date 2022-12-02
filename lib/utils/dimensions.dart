import 'package:get/get.dart';

class Dimensions {
  static double screenheight = Get.context!.height;
  static double screenwidth = Get.context!.width;

  static double pageView = screenheight / 2.66;
  static double pageViewContainer = screenheight / 3.87;
  static double pageViewTextContainer = screenheight / 6.56;

  static double height5 = screenheight / 170.66;
  static double height9 = screenheight / 94.81;
  static double height10 = screenheight / 85.33;
  static double height15 = screenheight / 56.88;
  static double height20 = screenheight / 42.65;
  static double height30 = screenheight / 28.44;
  static double height45 = screenheight / 18.96;
  static double height100 = screenheight / 8.533;
  static double height120 = screenheight / 7.11;

  static double width5 = screenwidth / 96;
  static double width10 = screenwidth / 48;
  static double width15 = screenwidth / 32;
  static double width20 = screenwidth / 24;
  static double width30 = screenwidth / 16;
  static double width45 = screenwidth / 10.66;
  static double width120 = screenwidth / 4;

  static double font13 = screenheight / 65.63;
  static double font20 = screenheight / 42.65;
  static double font30 = screenheight / (screenheight / 35);

  static double radius15 = screenheight / 56.88;
  static double radius20 = screenheight / 42.65;
  static double radius30 = screenheight / 28.44;
  static double iconSize24 = screenheight / 35.55;

  static double hsize(double factor) {
    return screenheight / (screenheight / factor);
  }

  static double wsize(double factor) {
    return screenwidth / (screenwidth / factor);
  }

  static double phsize(double factor) {
    return screenheight * (factor / 100);
    //return screenheight / (screenheight / factor);
  }

  static double pwsize(double factor) {
    return screenwidth * (factor / 100);
    //return screenwidth / (screenwidth / factor);
  }
}
