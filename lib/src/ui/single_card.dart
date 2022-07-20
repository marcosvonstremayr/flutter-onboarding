import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'components/card_text.dart';

class SingleCard extends StatefulWidget {
  const SingleCard({Key? key}) : super(key: key);

  @override
  State<SingleCard> createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  int _likeCounter = 0;

  void addLike(){
    setState(() {
      _likeCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
              Constants.singleCardAppBarTitle,
            style: TextStyle(
              color: Constants.iconThemeColor,
              fontSize: Constants.titleFontSize,
            ),
          ),
          backgroundColor: Constants.appBarBackgroundColor,
        ),
        body: Center(
          child: ListView(
            children: [
              Image.asset(
                Constants.pathToImageCard,
                height: Constants.cardHeight,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: Constants.iconPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Constants.iconFavoriteColor,
                      size: Constants.likeIconSize,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: Constants.iconPadding ),
                      child: Text(
                        "$_likeCounter",
                        style: const TextStyle(
                          color: Constants.likeCounterNumberColor,
                          fontSize: Constants.likeCounterFontSize,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CardText(text: "Name: Ysera"),
                          CardText(text: "Type: Minion"),
                          CardText(text: "Faction: Neutral",),
                          CardText(text: "Rarity: Legendary"),
                          CardText(text: "Cost: 9"),
                        ],
                      ),
                      const VerticalDivider(
                        color: Constants.verticalDividerColor,
                        thickness: Constants.verticalDividerThickness,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CardText(text: "Atack: 4"),
                            CardText(text: "Health: 12"),
                            Padding(
                              padding: EdgeInsets.all(Constants.cardTextPadding),
                              child: Text(
                                "Ability: At the end of your turn, add a Dream Card to your hand",
                                style: TextStyle(
                                  color: Constants.cardTextColor,
                                  fontSize: Constants.cardTextFontSize,
                                  overflow: Constants.cardTextAbilityOverflow,
                                ),
                                maxLines: Constants.cardTextAbilityMaxLines,
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),
              const SizedBox(height: Constants.sizedBoxHeight)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addLike,
          backgroundColor: Constants.likeButtonColor,
          child: const Icon(Icons.favorite),
        ),
      ),
    );
  }
}
