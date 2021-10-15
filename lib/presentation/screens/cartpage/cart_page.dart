import 'package:dro_hometask/common/navigator.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/cartwidget.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cartBloc/cartbloc_bloc.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  SizeConfig config = SizeConfig();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartblocBloc>(context, listen: false).add(CartStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: SizedBox(
          height: 0,
          width: 0,
        ),
        elevation: 0,
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
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                        XMargin(20),
                        NormalText(
                          text: "Cart",
                          fontSize: 20,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 10),
                //   child: Stack(
                //     clipBehavior: Clip.none,
                //     children: [
                //       Icon(
                //         Icons.favorite_outline_sharp,
                //         color: Colors.white,
                //       ),
                //       Positioned(
                //         left: 18,
                //         child: Container(
                //           height: config.sh(8),
                //           width: config.sw(8),
                //           decoration: BoxDecoration(
                //               color: HexColor("#f2c94c"),
                //               shape: BoxShape.circle),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CartblocBloc, CartblocState>(
                builder: (BuildContext context, state) {
              if (state is CartblocLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is CartblocLoaded) {
                return Column(
                  children: [
                    Container(
                      height: SizeConfig.screenHeightDp * 0.78,
                      width: SizeConfig.screenWidthDp,
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: ListView.separated(
                          itemBuilder: (BuildContext context, index) {
                            return CartWidget(
                              item: state.itemList[index],
                              id: index + 1,
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                                thickness: 2,
                                color: Color.fromRGBO(229, 229, 229, 1),
                              ),
                          itemCount: state.itemList.length),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: 50, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                NormalText(
                                  text: "Total:",
                                  fontSize: 20,
                                ),
                                XMargin(5),
                                Text(
                                  "\u20A6" +
                                      state.totalPrice.toString() +
                                      ".00",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Container(
                              height: config.sh(45),
                              width: config.sw(160),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    XColors.purpleGradientLeft,
                                    XColors.purpleGradientRight
                                  ])),
                              child: Center(
                                child: NormalText(
                                  text: "CHECK OUT",
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    YMargin(20),
                  ],
                );
              } else if (state is CartblocInitial) {
                return Center(
                  child: NormalText(
                    text: "Your Cart is empty",
                    textColor: Colors.black,
                  ),
                );
              } else if (state is CartblocError) {
                return Center(
                  child: NormalText(
                    text: state.errorMessage,
                    textColor: Colors.black,
                  ),
                );
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
