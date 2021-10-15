import 'package:dro_hometask/domain/categorymodel.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:dro_hometask/presentation/reuseables/categorywidget.dart';
import 'package:dro_hometask/presentation/reuseables/suggestionwidget.dart';
import 'package:flutter/material.dart';
import 'package:dro_hometask/common/extensions.dart';

List<Items> suggestionItems = [
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "paracetamol".toPNG(),
      itemMass: "500",
      itemName: "Paracetamol"),
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "doliprane".toPNG(),
      itemMass: "1000",
      itemName: "Doliprane"),
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "paracetamol2".toPNG(),
      itemMass: "500",
      itemName: "Paracetamol"),
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "ibuprofen".toPNG(),
      itemMass: "200",
      itemName: "Ibuprofen"),
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "ibuprofen2".toPNG(),
      itemMass: "400",
      itemName: "Ibuprofen"),
  Items(
      itemAmount: 1,
      itemCost: 350,
      itemImage: "panadol".toPNG(),
      itemMass: "500",
      itemName: "Panadol"),
];
List<Widget> suggestionList = [
  SuggestionWidget(
    itemCost: "350",
    itemMass: "500mg",
    itemName: "Paracetamol",
    itemImage: "paracetamol".toPNG(),
  ),
  SuggestionWidget(
    itemCost: "350",
    itemMass: "1000mg",
    itemName: "Doliprane",
    itemImage: "doliprane".toPNG(),
  ),
  SuggestionWidget(
    itemCost: "350",
    itemMass: "200mg",
    itemName: "Ibuprofen",
    itemImage: "ibuprofen".toPNG(),
  ),
  SuggestionWidget(
    itemCost: "350",
    itemMass: "500mg",
    itemName: "Panadol",
    itemImage: "panadol".toPNG(),
  ),
  SuggestionWidget(
    itemCost: "350",
    itemMass: "500mg",
    itemName: "Paracetamol",
    itemImage: "paracetamol".toPNG(),
  ),
];

List<Widget> categoryList = [
  CategoryWidget(
    categoryImage: "headache".toPNG(),
    categoryName: "Headche",
  ),
  CategoryWidget(
    categoryImage: "supplement".toPNG(),
    categoryName: "Supplement",
  ),
  CategoryWidget(
    categoryImage: "infants".toPNG(),
    categoryName: "Infants",
  ),
  CategoryWidget(
    categoryImage: "cough".toPNG(),
    categoryName: "Coughs",
  ),
];
List<CategoryModel> categoryModelList = [
  CategoryModel(
    categoryImage: "headache".toPNG(),
    categoryName: "Headche",
  ),
  CategoryModel(
    categoryImage: "supplement".toPNG(),
    categoryName: "Supplement",
  ),
  CategoryModel(
    categoryImage: "infants".toPNG(),
    categoryName: "Infants",
  ),
  CategoryModel(
    categoryImage: "cough".toPNG(),
    categoryName: "Coughs",
  )
];
