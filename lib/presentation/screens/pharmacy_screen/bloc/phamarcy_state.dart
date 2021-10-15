part of 'phamarcy_bloc.dart';

@immutable
abstract class PhamarcyState {}

class PhamarcyInitial extends PhamarcyState {
  final List<Items> suggestionList;
  PhamarcyInitial({this.suggestionList});
}

class PhamarcyNoKeyWordMatch extends PhamarcyState {
  final String errorMessage;
  PhamarcyNoKeyWordMatch({this.errorMessage});
}

class PhamarcyKeyWordMatch extends PhamarcyState {
  final List<Items> matchedItemList;
  PhamarcyKeyWordMatch({this.matchedItemList});
}
