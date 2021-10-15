import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dro_hometask/common/extensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class CategoryWidget extends StatefulWidget {
  final String categoryName;
  final String categoryImage;
  bool isSelected;
  CategoryWidget({this.categoryImage, this.categoryName, this.isSelected});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            widget.categoryImage,
            fit: BoxFit.cover,
            height: 200,
            width: 150,
            //colorBlendMode: BlendMode.darken,
            //color: Colors.black.withOpacity(0.5),
          ),
          NormalText(
            text: widget.categoryName,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            textColor: Colors.white,
          )
        ],
      ),
    );
  }
}
