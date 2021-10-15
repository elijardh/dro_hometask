part of 'cartbloc_bloc.dart';

@immutable
abstract class CartblocEvent {}

class CartStarted extends CartblocEvent {}

class CartAddItem extends CartblocEvent {
  final Items items;
  CartAddItem({this.items});
}

class CartUpdateItem extends CartblocEvent {
  final Items items;
  CartUpdateItem({this.items});
}

class CartDeleteItem extends CartblocEvent {
  final int id;
  CartDeleteItem({this.id});
}

class CartAdjustItemAmount extends CartblocEvent {
  final List<Items> items;
  final int index;
  final int amount;
  CartAdjustItemAmount({this.index, this.amount, this.items});
}
