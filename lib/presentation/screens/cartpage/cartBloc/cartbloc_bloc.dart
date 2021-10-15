import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dro_hometask/data/local/database.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:meta/meta.dart';

part 'cartbloc_event.dart';
part 'cartbloc_state.dart';

class CartblocBloc extends Bloc<CartblocEvent, CartblocState> {
  List<Items> itemList = [];
  CartblocBloc() : super(CartblocInitial()) {
    on<CartblocEvent>((event, emit) async {
      on<CartStarted>(getCartItems);
      on<CartAddItem>(addItems);
      on<CartDeleteItem>(deleteItems);
      on<CartAdjustItemAmount>(adjustAmount);
    });
  }
  void addItems(CartAddItem event, Emitter<CartblocState> emit) async {
    try {
      emit(CartblocLoading());
      await DatabaseProvider.instance.addToCart(event.items);
      emit(CartblocItemAdded());
    } catch (error) {
      log(error.toString());
    }
  }

  void deleteItems(CartDeleteItem event, Emitter<CartblocState> emit) async {
    try {
      await DatabaseProvider.instance.deleteCart(event.id);
    } catch (error) {
      emit(CartblocError(errorMessage: error));
    }
  }

  void adjustAmount(CartAdjustItemAmount event, Emitter<CartblocState> emit) {
    try {
      Items tempItem = itemList[event.index];
      log("hwloo");
      tempItem.itemAmount = event.amount;
      itemList[event.index] = tempItem;
      int totalCost = 0;
      for (int i = 0; i < itemList.length; i++) {
        log(totalCost.toString() + "wahala");
        if (itemList[i].itemAmount > 1) {
          int tempPriceHolder = itemList[i].itemAmount * itemList[i].itemCost;
          totalCost += tempPriceHolder;
        } else {
          totalCost += itemList[i].itemCost;
        }
        log(totalCost.toString() + "okay");
      }
      emit(CartblocLoaded(itemList: itemList, totalPrice: totalCost));
    } catch (error) {
      log(error.toString());
    }
  }

  void getCartItems(CartStarted event, Emitter<CartblocState> emit) async {
    emit(CartblocLoading());
    try {
      List<Items> cartItems = await DatabaseProvider.instance.getCart();
      if (cartItems.isEmpty) {
        emit(CartblocInitial());
      } else {
        int totalCost = 0;
        for (int i = 0; i < cartItems.length; i++) {
          if (cartItems[i].itemAmount > 1) {
            int tempPriceHolder =
                cartItems[i].itemAmount * cartItems[i].itemCost;
            totalCost += tempPriceHolder;
          } else {
            totalCost += cartItems[i].itemCost;
          }
        }
        itemList = cartItems;
        emit(CartblocLoaded(itemList: cartItems, totalPrice: totalCost));
      }
    } catch (error) {
      log(error.toString());
      emit(CartblocError(errorMessage: error.toString()));
    }
  }
}
