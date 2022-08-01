import 'package:flutter/material.dart';
import '../../data/model/card_model.dart';
import '../../core/util/constants.dart';
import '../widget/show_card_properties.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({Key? key}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  int _likeCounter = 0;

  void addLike() {
    setState(() {
      _likeCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardInfo = ModalRoute.of(context)!.settings.arguments as CardModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Constants.iconThemeColor,
          ),
          title: Text(
            cardInfo.name ?? Constants.unknownCardName,
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
              Padding(
                padding: const EdgeInsets.all(Constants.cardPadding),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Constants.cardGradientColor1,
                        Constants.cardGradientColor2
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.cardShadowColor,
                        blurRadius: Constants.cardShadowBlurRadius,
                        spreadRadius: Constants.cardShadowSpreadRadius,
                      )
                    ],
                    borderRadius:
                        BorderRadius.circular(Constants.cardBorderRadius),
                    border: Border.all(
                      color: Constants.cardBorderColor,
                      width: Constants.cardBorderWidth,
                    ),
                  ),
                  child: Column(
                    children: [
                      cardInfo.img != null
                          ? Image.network(
                              cardInfo.img!,
                              height: Constants.cardHeight,
                            )
                          : Image.asset(
                              Constants.pathToImageCard,
                              height: Constants.cardHeight,
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              Constants.cardInfoContainerHorizontalPadding,
                          vertical: Constants.cardInfoContainerVerticalPadding,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.cardInfoContainerColor,
                            borderRadius: BorderRadius.circular(
                              Constants.cardInfoContainerBorderRadius,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Constants.cardInfoContainerShadowColor,
                                spreadRadius:
                                    Constants.cardInfoContainerSpreadRadius,
                                blurRadius:
                                    Constants.cardInfoContainerBlurRadius,
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  showPropertyIfExists(
                                    cardInfo.cardSet,
                                    Constants.cardSetTitle,
                                  ),
                                  showPropertyIfExists(
                                    cardInfo.type,
                                    Constants.typeTitle,
                                  ),
                                  showPropertyIfExists(
                                    cardInfo.rarity,
                                    Constants.rarityTitle,
                                  ),
                                  showPropertyIfExists(
                                    cardInfo.playerClass,
                                    Constants.playerClassTitle,
                                  ),
                                  showPropertyIfExists(
                                    cardInfo.artist,
                                    Constants.artistTitle,
                                  ),
                                ],
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    showPropertyIfExists(cardInfo.cardSet),
                                    showPropertyIfExists(cardInfo.type),
                                    showPropertyIfExists(cardInfo.rarity),
                                    showPropertyIfExists(cardInfo.playerClass),
                                    showPropertyIfExists(cardInfo.artist),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Constants.iconPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Constants.iconFavoriteColor,
                      size: Constants.likeIconSize,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: Constants.iconPadding),
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
