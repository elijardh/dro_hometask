part of 'cartbloc_bloc.dart';

@immutable
abstract class CartblocState {}

class CartblocInitial extends CartblocState {}

class CartblocLoading extends CartblocState {}

//class CartblocEmpty extends CartblocState{}
class CartblocLoaded extends CartblocState {
  final List<Items> itemList;
  final int totalPrice;
  CartblocLoaded({this.itemList, this.totalPrice});
}

class CartblocItemAdded extends CartblocState {}

class CartblocError extends CartblocState {
  final String errorMessage;
  CartblocError({this.errorMessage});
}
