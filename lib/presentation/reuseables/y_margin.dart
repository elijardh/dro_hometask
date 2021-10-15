import 'package:flutter/material.dart';
import 'package:dro_hometask/common/size_config.dart';

class YMargin extends StatelessWidget {
  final double height;

  const YMargin(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig().sh(height).toDouble(),
    );
  }
}
