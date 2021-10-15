import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
