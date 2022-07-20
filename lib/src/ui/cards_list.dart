import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../repositories/cards_repository.dart';
import '../../utils/constants.dart';
import 'card_detail.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<CardModel>>(
          future: getCards(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<CardModel>> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Text(Constants.errorMsg);
            } else if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Card(
                      child: ListTile(
                        tileColor: Constants.cardColor,
                        title: Text(
                          snapshot.data![index].name,
                          style: const TextStyle(
                            fontSize: Constants.cardTileTitle,
                          ),
                        ),
                        subtitle: Text(
                          snapshot.data![index].cardSet,
                          style: const TextStyle(
                            fontSize: Constants.subtitleFontSize,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CardDetail(),
                              settings: RouteSettings(
                                  arguments: snapshot.data![index]),
                            ),
                          );
                        },
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Future<List<CardModel>> getCards() async {
    CardRepository cardRepository = CardRepository();
    List<CardModel> cards = await cardRepository.fetchCards();
    return cards;
  }
}
