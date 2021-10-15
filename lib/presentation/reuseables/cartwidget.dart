import 'dart:developer';

import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cartBloc/cartbloc_bloc.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'y_margin.dart';

class CartWidget extends StatefulWidget {
  final int id;
  final List<Items> itemsList;
  final Items item;
  CartWidget({this.item, this.id, this.itemsList});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  String initialValue = "1";
  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "${widget.item.itemImage}",
                height: config.sh(100),
                width: config.sw(100),
                fit: BoxFit.contain,
              ),
              XMargin(15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                    text: widget.item.itemName,
                    fontSize: 18,
                    textColor: Color.fromRGBO(54, 54, 54, 1),
                  ),
                  YMargin(8),
                  NormalText(
                    text: "Tablet " + widget.item.itemMass,
                    fontSize: 16,
                    textColor: Color.fromRGBO(189, 189, 189, 1),
                  ),
                  YMargin(7),
                  NormalText(
                    textColor: Color.fromRGBO(54, 54, 54, 0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    text: "\u20A6" + widget.item.itemCost.toString() + ".00",
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: config.sh(25),
                width: config.sw(45),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.5,
                        color: HexColor("#878787"),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      iconEnabledColor: XColors.purple,
                      onChanged: (value) {
                        log(value);
                        setState(() {
                          initialValue = value;
                        });
                        log("before");
                        BlocProvider.of<CartblocBloc>(context).add(
                            CartAdjustItemAmount(
                                amount: int.parse(value),
                                index: widget.id - 1,
                                items: widget.itemsList));
                        log("after");
                      },
                      style: TextStyle(color: HexColor("#878787")),
                      value: widget.item.itemAmount.toString(),
                      items: <String>["1", "2", "3", "4", "5", "6", "7", "8"]
                          .map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          child: NormalText(
                            text: val,
                            textColor: Colors.black,
                          ),
                          value: val,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              YMargin(13),
              InkWell(
                onTap: () {
                  BlocProvider.of<CartblocBloc>(context)
                      .add(CartDeleteItem(id: widget.id));
                  BlocProvider.of<CartblocBloc>(context).add(CartStarted());
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: XColors.purple,
                      size: 16,
                    ),
                    NormalText(
                      text: "Remove",
                      fontSize: 11,
                      textColor: XColors.purple,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
