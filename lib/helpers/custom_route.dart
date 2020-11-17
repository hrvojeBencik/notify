import 'package:flutter/material.dart';

class CustomRoute {
  static Route scaleFadeTransition(var screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = Curves.fastOutSlowIn;
        var curveTween = CurveTween(curve: curve);

        var sizeBegin = 0.4;
        var sizeEnd = 1.0;
        var tween = Tween(begin: sizeBegin, end: sizeEnd).chain(curveTween);
        var scaleAnimation = animation.drive(tween);

        var opacityBegin = 0.0;
        var opacityEnd = 1.0;
        var opacityTween =
            Tween(begin: opacityBegin, end: opacityEnd).chain(curveTween);
        var opacityAnimation = animation.drive(opacityTween);

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
