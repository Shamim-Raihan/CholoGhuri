import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helpers/color_helper.dart';

Widget loadingWidget({double size = 20}) {
  return Center(
    child: LoadingAnimationWidget.hexagonDots(
      color: ColorHelper.primary,
      size: size,
    ),
  );
}
