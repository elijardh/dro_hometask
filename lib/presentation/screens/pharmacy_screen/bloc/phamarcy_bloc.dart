import 'package:bloc/bloc.dart';
import 'package:dro_hometask/common/placeholder.dart';
import 'package:dro_hometask/domain/item.dart';
import 'package:meta/meta.dart';

part 'phamarcy_event.dart';
part 'phamarcy_state.dart';

class PhamarcyBloc extends Bloc<PhamarcyEvent, PhamarcyState> {
  @override
  PhamarcyBloc() : super(PhamarcyInitial(suggestionList: suggestionItems)) {
    on<PhamarcyEvent>((event, emit) {
      if (event is SearchPharmacyEvent) {
        if (event.keyword.isEmpty) {
          emit(PhamarcyInitial(suggestionList: suggestionItems));
        } else {
          List<Items> filteredList = [];
          for (int i = 0; i < suggestionItems.length; i++) {
            if (suggestionItems[i]
                .itemName
                .toLowerCase()
                .contains(event.keyword.toLowerCase())) {
              filteredList.add(suggestionItems[i]);
            }
          }
          if (filteredList.isEmpty) {
            emit(PhamarcyNoKeyWordMatch(errorMessage: event.keyword));
          } else {
            emit(PhamarcyKeyWordMatch(matchedItemList: filteredList));
          }
        }
      }
    });
  }
}
