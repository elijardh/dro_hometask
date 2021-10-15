import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SuggestionWidget extends StatelessWidget {
  final String itemName;
  final String itemMass;
  final String itemCost;
  final String itemImage;
  SuggestionWidget(
      {this.itemCost, this.itemMass, this.itemName, this.itemImage});

  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: config.sw(150),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 0.5,
              color: HexColor("#878787"),
            )
          ]),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(itemImage),
              ),
            ),
          ),
          YMargin(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NormalText(
                    text: itemName,
                    textColor: HexColor("#797979"),
                    fontWeight: FontWeight.w600,
                  ),
                  YMargin(5),
                  NormalText(
                    text: "Tablet $itemMass",
                    textColor: HexColor("#878787"),
                  ),
                  YMargin(5),
                  RichText(
                      text: TextSpan(
                          text: "\u20A6",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: HexColor(
                                "#363636",
                              )),
                          children: [
                        TextSpan(
                          text: itemCost.toString(),
                          style: TextStyle(color: HexColor("#363636")),
                        ),
                        TextSpan(
                          text: ".00",
                          style: TextStyle(color: HexColor("#363636")),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
