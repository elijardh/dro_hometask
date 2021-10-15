part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySelected extends CategoryState {
  final String categoryName;
  CategorySelected({this.categoryName});
}
