part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class CategorySelectedEvent extends CategoryEvent {
  final String categoryName;
  CategorySelectedEvent({this.categoryName});
}

class CategoryViewAllEvent extends CategoryEvent {}
