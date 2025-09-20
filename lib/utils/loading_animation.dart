import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helpers/color_helper.dart';

class LoadingAnimation extends StatelessWidget {
  final double size;
  const LoadingAnimation({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.flickr(
      leftDotColor: ColorHelper.primary,
      rightDotColor: ColorHelper.primary.withValues(alpha: 0.5),
      size: size,
    );
  }
}
