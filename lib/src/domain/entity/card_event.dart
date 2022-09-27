import '../../data/model/card_model.dart';

class CardEvent {
  List<CardModel>? cards;
  Status status;
  String? errorMsg;
  bool? isFavorite;

  CardEvent({
    this.cards,
    required this.status,
    this.errorMsg,
    this.isFavorite,
  });
}

enum Status {
  loading,
  success,
  initial,
  error,
  empty,
}
