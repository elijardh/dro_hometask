part of 'phamarcy_bloc.dart';

@immutable
abstract class PhamarcyEvent {}

class SearchPharmacyEvent extends PhamarcyEvent {
  final String keyword;
  SearchPharmacyEvent({this.keyword});
}
