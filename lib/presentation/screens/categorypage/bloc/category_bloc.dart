import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      if (event is CategorySelectedEvent) {
        emit(CategorySelected(categoryName: event.categoryName));
      } else if (event is CategoryViewAllEvent) {
        emit(CategoryInitial());
      }
    });
  }
}
