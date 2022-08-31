import '../../data/model/card_model.dart';

class CardEvent {
  List<CardModel>? cards;
  Status status;
  String? errorMsg;

  CardEvent({
    this.cards,
    required this.status,
    this.errorMsg,
  });
}

enum Status {
  loading,
  success,
  initial,
  error,
  empty,
}
