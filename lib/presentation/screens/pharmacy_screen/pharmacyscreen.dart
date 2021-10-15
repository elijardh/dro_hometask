import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/navigator.dart';
import 'package:dro_hometask/common/placeholder.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/categorywidget.dart';
import 'package:dro_hometask/presentation/reuseables/filteredSuggestionWidget.dart';
import 'package:dro_hometask/presentation/reuseables/suggestionwidget.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:dro_hometask/presentation/screens/categorypage/categoryscreen.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/bloc/phamarcy_bloc.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/detailscreen.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:dro_hometask/common/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({Key key}) : super(key: key);

  @override
  _PharmacyScreenState createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  SizeConfig config = SizeConfig();
  var blocProv;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocProv = BlocProvider.of<PhamarcyBloc>(context, listen: false).state;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              collapsedHeight: config.sh(120),
              expandedHeight: config.sh(150),
              backgroundColor: HexColor("#e5e5e5").withOpacity(0.3),
              elevation: 0,
              flexibleSpace: Container(
                height: config.sh(300),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YMargin(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NormalText(
                              text: "Pharmacy",
                              textColor: Colors.white,
                              fontSize: 25,
                            ),
                            Row(
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    SvgPicture.asset("vehicle".toSVG()),
                                    Positioned(
                                      left: 18,
                                      child: Container(
                                        height: config.sh(8),
                                        width: config.sw(8),
                                        decoration: BoxDecoration(
                                            color: HexColor("#f2c94c"),
                                            shape: BoxShape.circle),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      YMargin(30),
                      BlocConsumer<PhamarcyBloc, PhamarcyState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          double width;
                          bool keyWordExist;
                          bool WordDoNotExist;

                          if (state is PhamarcyKeyWordMatch) {
                            width = config.sw(200);
                            keyWordExist = true;
                          } else {
                            keyWordExist = false;
                            width = config.sw(300);
                          }
                          if (state is PhamarcyNoKeyWordMatch) {
                            width = config.sw(250);
                            WordDoNotExist = true;
                          } else {
                            width = config.sw(300);
                            WordDoNotExist = false;
                          }
                          if (state is PhamarcyInitial) {
                            width = config.sw(300);
                            keyWordExist = false;
                            WordDoNotExist = false;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              children: [
                                Container(
                                  height: config.sh(40),
                                  width: width,
                                  child: Center(
                                    child: TextField(
                                      cursorColor: Colors.white,
                                      onChanged: (val) {
                                        context.read<PhamarcyBloc>().add(
                                            SearchPharmacyEvent(keyword: val));
                                      },
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                          contentPadding: keyWordExist
                                              ? null
                                              : EdgeInsets.zero,
                                          prefixIcon: keyWordExist
                                              ? null
                                              : Icon(
                                                  Icons.search_outlined,
                                                  color: Colors.white,
                                                ),
                                          filled: true,
                                          fillColor:
                                              Colors.white.withOpacity(0.5),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.transparent))),
                                    ),
                                  ),
                                ),
                                XMargin(WordDoNotExist ? 10 : 0),
                                WordDoNotExist
                                    ? NormalText(
                                        text: "Cancel",
                                        textColor: Colors.white,
                                      )
                                    : SizedBox(
                                        height: 0,
                                        width: 0,
                                      )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      XColors.purpleGradientLeft,
                      XColors.purpleGradientRight
                    ]),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: BlocBuilder<PhamarcyBloc, PhamarcyState>(
            builder: (BuildContext context, state) {
              if (state is PhamarcyInitial) {
                return Container(
                  //height: SizeConfig.screenHeightDp,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: config.sh(45),
                        //color: HexColor("#f2f2f2"),
                        color: HexColor("#e5e5e5").withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: HexColor("#5b5b5b"),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: "Delivery in ",
                                    children: [
                                  TextSpan(
                                      text: "Lagos, NG",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ])),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            YMargin(10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  navigate(context, CategoryScreen());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    NormalText(
                                      text: "CATEGORIES",
                                      textColor: HexColor("#b9b9b9"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    NormalText(
                                        fontSize: 20,
                                        text: "VIEW ALL",
                                        fontWeight: FontWeight.w500,
                                        textColor: HexColor("#9f5de2")
                                            .withOpacity(0.7)),
                                  ],
                                ),
                              ),
                            ),
                            YMargin(10),
                            Container(
                              height: config.sh(100),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView(
                                  children: categoryList,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            YMargin(20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: NormalText(
                                  text: "Suggestion",
                                  textColor: HexColor("#b9b9b9"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            YMargin(15),
                            //List of products
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.suggestionList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.8,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      navigate(
                                          context,
                                          DetailScreen(
                                            item: state.suggestionList[index],
                                          ));
                                    },
                                    child: SuggestionWidget(
                                      itemImage:
                                          state.suggestionList[index].itemImage,
                                      itemMass:
                                          state.suggestionList[index].itemMass,
                                      itemName:
                                          state.suggestionList[index].itemName,
                                      itemCost: state
                                          .suggestionList[index].itemCost
                                          .toString(),
                                    ),
                                  );
                                },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              ),
                            ),
                            YMargin(100)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is PhamarcyKeyWordMatch) {
                return Container(
                  //height: SizeConfig.screenHeightDp,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: config.sh(45),
                        //color: HexColor("#f2f2f2"),
                        color: HexColor("#e5e5e5").withOpacity(0.3),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: HexColor("#5b5b5b"),
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: "Delivery in ",
                                    children: [
                                  TextSpan(
                                      text: "Lagos, NG",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ])),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            YMargin(20),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: NormalText(
                                  text: "Suggestion",
                                  textColor: HexColor("#b9b9b9"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            YMargin(15),
                            //List of products
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.matchedItemList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemBuilder: (BuildContext context, index) {
                                  return FilteredSuggestionWidget(
                                    item: state.matchedItemList[index],
                                  );
                                },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              ),
                            ),
                            YMargin(100)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (state is PhamarcyNoKeyWordMatch) {
                return Container(
                  color: Colors.white,
                  height: SizeConfig.screenHeightDp,
                  width: SizeConfig.screenWidthDp,
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SvgPicture.asset("error".toSVG()),
                      YMargin(20),
                      Center(
                        child: NormalText(
                          textColor: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          maxLines: 3,
                          text: "No result found for ${state.errorMessage}",
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
