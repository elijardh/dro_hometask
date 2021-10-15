import 'package:dro_hometask/common/hex_color.dart';
import 'package:dro_hometask/common/navigator.dart';
import 'package:dro_hometask/common/placeholder.dart';
import 'package:dro_hometask/common/size_config.dart';
import 'package:dro_hometask/presentation/reuseables/categorywidget.dart';
import 'package:dro_hometask/presentation/reuseables/suggestionwidget.dart';
import 'package:dro_hometask/presentation/reuseables/texts.dart';
import 'package:dro_hometask/presentation/reuseables/x_margin.dart';
import 'package:dro_hometask/presentation/reuseables/y_margin.dart';
import 'package:dro_hometask/presentation/screens/categorypage/bloc/category_bloc.dart';
import 'package:dro_hometask/presentation/screens/pharmacy_screen/bloc/phamarcy_bloc.dart';
import 'package:dro_hometask/presentation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  SizeConfig config = SizeConfig();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SizedBox(),
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
                      text: "Category",
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
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (BuildContext context, state) {
            if (state is CategoryInitial) {
              return Container(
                height: config.sh(400),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: GridView.builder(
                  //shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: categoryModelList.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<CategoryBloc>().add(CategorySelectedEvent(
                            categoryName:
                                categoryModelList[index].categoryName));
                      },
                      child: CategoryWidget(
                        categoryImage: categoryModelList[index].categoryImage,
                        categoryName: categoryModelList[index].categoryName,
                      ),
                    );
                  },
                ),
              );
            } else if (state is CategorySelected) {
              return Container(
                //height: SizeConfig.screenHeightDp,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          YMargin(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                context
                                    .read<CategoryBloc>()
                                    .add(CategoryViewAllEvent());
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
                                      textColor:
                                          HexColor("#9f5de2").withOpacity(0.7)),
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
                                text: state.categoryName,
                                textColor: HexColor("#b9b9b9"),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          YMargin(15),
                          //List of products
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: suggestionItems.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                              itemBuilder: (BuildContext context, index) {
                                return SuggestionWidget(
                                  itemImage: suggestionItems[index].itemImage,
                                  itemMass: suggestionItems[index].itemMass,
                                  itemName: suggestionItems[index].itemName,
                                  itemCost: suggestionItems[index]
                                      .itemCost
                                      .toString(),
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
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
