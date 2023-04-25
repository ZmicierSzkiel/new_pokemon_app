import 'package:flutter/material.dart';

class WidthGap extends StatelessWidget {
  final double size;
  const WidthGap(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
    );
  }
}

class HeightGap extends StatelessWidget {
  final double size;
  const HeightGap(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
