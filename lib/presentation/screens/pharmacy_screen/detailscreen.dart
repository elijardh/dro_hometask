import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/navigator.dart';
import 'package:dro_hometask/common/placeholder.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:dro_hometask/presentation/reuseables/suggestionwidget.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cartBloc/cartbloc_bloc.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cart_page.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  final Items item;

  DetailScreen({
    this.item,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int itemCount = 1;
  int tempItemCost = 0;
  bool loading = false;

  SizeConfig config = SizeConfig();
  @override
  void initState() {
    super.initState();
    tempItemCost = widget.item.itemCost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(
          height: 0,
          width: 0,
        ),
        toolbarHeight: config.sh(60),
        flexibleSpace: Container(
          height: config.sh(200),
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                XColors.purpleGradientLeft,
                XColors.purpleGradientRight
              ])),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        popView(context);
                      },
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.arrow_back_ios_new_outlined,
                          size: 18, color: Colors.white),
                    ),
                    XMargin(5),
                    NormalText(
                      text: "Pharmacy",
                      fontSize: 20,
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                      Positioned(
                        left: 15,
                        bottom: 21,
                        child: Container(
                          height: config.sh(7),
                          width: config.sw(7),
                          decoration: BoxDecoration(
                              color: HexColor("#f2c94c"),
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YMargin(10),
            Image.asset(widget.item.itemImage),
            YMargin(10),
            NormalText(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              textColor: Colors.black,
              text: widget.item.itemName,
            ),
            YMargin(10),
            NormalText(
              textAlign: TextAlign.center,
              fontSize: 18,
              textColor: XColors.middleBlue.withOpacity(0.5),
              text: "Tablet - " + widget.item.itemMass + "mg",
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: config.sh(35),
                        width: config.sw(35),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                                color: HexColor("#878787"),
                              )
                            ]),
                        child: Transform.scale(
                          scale: 0.6,
                          child: Image.asset(
                            widget.item.itemImage,
                            scale: 9,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      XMargin(20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "SOLD BY",
                            textColor: XColors.middleBlue.withOpacity(0.5),
                            textAlign: TextAlign.left,
                            fontSize: 12,
                          ),
                          TitleText(
                            fontSize: 15,
                            text: widget.item.itemName + " Pharmaceuticals",
                            textColor: XColors.middleBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
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
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: config.sh(40),
                        width: config.sw(100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                                color: HexColor("#878787"),
                              )
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (itemCount > 0) {
                                      itemCount--;
                                      tempItemCost =
                                          widget.item.itemCost * itemCount;
                                    }
                                  });
                                },
                                child: NormalText(
                                  text: "-",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            NormalText(
                              text: itemCount.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (itemCount <= 7) {
                                    itemCount++;
                                    tempItemCost =
                                        widget.item.itemCost * itemCount;
                                  }
                                });
                              },
                              child: NormalText(
                                text: "+",
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      XMargin(20),
                      NormalText(
                        text: "Pack(s)",
                        textColor: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: "\u20A6",
                          children: [
                        TextSpan(
                            text: tempItemCost.toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 25)),
                        TextSpan(
                            text: ".00", style: TextStyle(color: Colors.black)),
                      ]))
                ],
              ),
            ),
            YMargin(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Align(
                alignment: Alignment.centerLeft,
                child: NormalText(
                  text: "PRODUCT DETAILS",
                  textColor: XColors.middleBlue.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        color: XColors.purple,
                      ),
                      XMargin(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "Pack Size",
                            textColor: XColors.middleBlue.withOpacity(0.5),
                          ),
                          NormalText(
                            text: "8 X 12 tablets(96)",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textColor: XColors.middleBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_outlined,
                        color: XColors.purple,
                      ),
                      XMargin(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "Product ID",
                            textColor: XColors.middleBlue.withOpacity(0.5),
                          ),
                          NormalText(
                            text: "PRO23648856",
                            textColor: XColors.middleBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.medical_services_outlined,
                        color: XColors.purple,
                      ),
                      XMargin(10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "Constituents",
                            textColor: XColors.middleBlue.withOpacity(0.5),
                          ),
                          NormalText(
                            text: widget.item.itemName,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textColor: XColors.middleBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner_outlined,
                        color: XColors.purple,
                      ),
                      XMargin(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            text: "DISPENSED IN",
                            textColor: XColors.middleBlue.withOpacity(0.5),
                          ),
                          NormalText(
                            text: "Packs",
                            textColor: XColors.middleBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            YMargin(20),
            NormalText(
              text:
                  "1 pack of ${widget.item.itemName} contains  8 units of 12 tablets.",
              maxLines: 2,
              textColor: XColors.middleBlue.withOpacity(0.5),
              textAlign: TextAlign.left,
            ),
            YMargin(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TitleText(
                  fontSize: 20,
                  text: "Similar Products",
                  textColor: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            YMargin(15),
            SizedBox(
              height: config.sh(220),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                //shrinkWrap: true,
                itemCount: suggestionItems.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    child: Transform.scale(
                      scale: 1.1,
                      child: SuggestionWidget(
                        itemCost: suggestionItems[index].itemCost.toString(),
                        itemImage: suggestionItems[index].itemImage,
                        itemMass: suggestionItems[index].itemMass,
                        itemName: suggestionItems[index].itemName,
                      ),
                    ),
                  );
                },
              ),
            ),
            YMargin(20),
            BlocListener<CartblocBloc, CartblocState>(
              listener: (context, state) {
                if (state is CartblocItemAdded) {
                  showDialog(
                      context: context,
                      builder: (BuildContext contex) {
                        return Dialog(
                          insetPadding: EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            height: config.sh(280),
                            child: Column(
                              children: [
                                YMargin(20),
                                SizedBox(
                                    height: config.sh(50),
                                    child: NormalText(
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                      text: "${widget.item.itemName}" +
                                          " has been successfully added to your cart!",
                                    )),
                                YMargin(50),
                                GestureDetector(
                                  onTap: () {
                                    popView(context);
                                    navigate(context, CartPage());
                                  },
                                  child: Container(
                                    height: config.sh(40),
                                    width: config.sw(330),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          XColors.purpleGradientLeft,
                                          XColors.purpleGradientRight
                                        ])),
                                    child: Center(
                                      child: NormalText(
                                        text: "VIEW CART",
                                        textColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                YMargin(30),
                                GestureDetector(
                                  onTap: () {
                                    popView(context);
                                  },
                                  child: Container(
                                    height: config.sh(40),
                                    width: config.sw(330),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: XColors.purple, width: 1.5),
                                    ),
                                    child: Center(
                                      child: NormalText(
                                        text: "CONTINUE SHOPPING",
                                        textColor: XColors.purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
              child: GestureDetector(
                onTap: () {
                  Items item = Items(
                      itemAmount: itemCount,
                      itemCost: widget.item.itemCost,
                      itemImage: widget.item.itemImage,
                      itemMass: widget.item.itemMass,
                      itemName: widget.item.itemName);
                  //DatabaseProvider.instance.delete();
                  context.read<CartblocBloc>().add(CartAddItem(items: item));
                },
                child: Container(
                  height: config.sh(40),
                  width: config.sw(330),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        XColors.purpleGradientLeft,
                        XColors.purpleGradientRight
                      ])),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        XMargin(10),
                        NormalText(
                          text: "Add to cart",
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            YMargin(80)
          ],
        ),
      ),
    );
  }
}
