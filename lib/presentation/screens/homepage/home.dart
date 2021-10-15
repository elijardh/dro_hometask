import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/navigator.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cartBloc/cartbloc_bloc.dart';
import 'package:dro_hometask/presentation/screens/cartpage/cart_page.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/bloc/phamarcy_bloc.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/detailscreen.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/pharmacyscreen.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dro_hometask/common/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller;
  int index = 2;
  SizeConfig config = SizeConfig();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: index == 2
          ? GestureDetector(
              onTap: () {
                navigate(context, CartPage());
              },
              child: BlocBuilder<PhamarcyBloc, PhamarcyState>(
                builder: (BuildContext context, state) {
                  if (state is PhamarcyInitial) {
                    return Container(
                      height: config.sh(40),
                      width: config.sw(130),

                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            XColors.redGradientLeft,
                            XColors.redGradientRight
                          ]),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          )),
                      //padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NormalText(
                            text: "Checkout",
                            textColor: Colors.white,
                          ),
                          XMargin(5),
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                          XMargin(5),
                          Container(
                            height: config.sh(20),
                            width: config.sw(20),
                            decoration: BoxDecoration(
                                color: HexColor("#f2c94c"),
                                shape: BoxShape.circle),
                            child: Center(
                              child: NormalText(
                                text: "2",
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: config.sh(40),
                      width: config.sw(40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          XColors.redGradientLeft,
                          XColors.redGradientRight
                        ]),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Positioned(
                              left: 15,
                              bottom: 20,
                              child: Container(
                                height: config.sh(15),
                                width: config.sw(15),
                                child: Center(
                                  child: NormalText(
                                    text: "2",
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: HexColor("#f2c94c"),
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          : SizedBox(
              height: 0,
              width: 0,
            ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeightDp,
          width: SizeConfig.screenWidthDp,
          child: PageView(
            controller: controller,
            onPageChanged: (val) {
              setState(() {
                index = val;
              });
            },
            children: [
              Container(
                child: Center(
                  child: NormalText(
                    text: "Coming Soon",
                    textColor: Colors.black,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: NormalText(
                    text: "Coming Soon",
                    textColor: Colors.black,
                  ),
                ),
              ),
              PharmacyScreen(),
              Container(
                child: Center(
                  child: NormalText(
                    text: "Coming Soon",
                    textColor: Colors.black,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: NormalText(
                    text: "Coming Soon",
                    textColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: XColors.purple,
        unselectedItemColor: Colors.black,
        //backgroundColor: XColors.middleBlue.withOpacity(0.4),
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (val) {
          setState(() {
            index = val;
            controller.jumpToPage(index);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: "Doctors"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_outlined), label: "Pharmacy"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Community"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_off_rounded,
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
