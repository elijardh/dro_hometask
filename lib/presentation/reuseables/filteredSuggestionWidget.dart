import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilteredSuggestionWidget extends StatelessWidget {
  final Items item;
  FilteredSuggestionWidget({this.item});

  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: config.sw(100),
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
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
                image: AssetImage(item.itemImage),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NormalText(
                    text: item.itemName,
                    textColor: HexColor("#797979"),
                    fontWeight: FontWeight.w600,
                  ),
                  //YMargin(5),
                  NormalText(
                    text: "Tablet ${item.itemMass}",
                    textColor: HexColor("#878787"),
                  ),
                  //YMargin(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "\u20A6",
                              style: TextStyle(color: HexColor("#363636")),
                              children: [
                            TextSpan(
                              text: item.itemCost.toString(),
                              style: TextStyle(color: HexColor("#363636")),
                            ),
                            TextSpan(
                              text: ".00",
                              style: TextStyle(color: HexColor("#363636")),
                            ),
                          ])),
                      // NormalText(
                      //   text: "\u20A6 " + item.itemCost.toString() + ".00",
                      //   textColor: HexColor("#363636"),
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 20,
                      // ),
                      Container(
                        height: config.sh(30),
                        width: config.sw(30),
                        decoration: BoxDecoration(
                            //color: Colors.red,
                            color: HexColor("#e5e5e5"),
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          Icons.favorite_outline_sharp,
                          color: XColors.purple,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  YMargin(8),
                  Container(
                    height: config.sh(30),
                    //width: config.sw(250),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: XColors.purple, width: 1.5),
                    ),
                    child: Center(
                      child: NormalText(
                        text: "ADD TO CART",
                        textColor: XColors.purple,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
