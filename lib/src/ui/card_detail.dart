import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../../utils/constants.dart';
import 'components/card_text.dart';

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
            cardInfo.name,
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
                      )),
                  child: Column(
                    children: [
                      Image.asset(
                        Constants.pathToImageCard,
                        height: Constants.cardHeight,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal:
                                Constants.cardInfoContainerHorizontalPadding,
                            vertical:
                                Constants.cardInfoContainerVerticalPadding),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Constants.cardInfoContainerColor,
                            borderRadius: BorderRadius.circular(
                                Constants.cardInfoContainerBorderRadius),
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
                                  const CardText(
                                    text: "ID",
                                    isTitle: Constants.titleIsTrue,
                                  ),
                                  const CardText(
                                    text: "Name",
                                    isTitle: Constants.titleIsTrue,
                                  ),
                                  const CardText(
                                    text: "Card Set",
                                    isTitle: Constants.titleIsTrue,
                                  ),
                                  const CardText(
                                    text: "Type",
                                    isTitle: Constants.titleIsTrue,
                                  ),
                                  cardInfo.text != null
                                      ? const CardText(
                                          text: "Text",
                                          isTitle: Constants.titleIsTrue,
                                        )
                                      : const SizedBox.shrink(),
                                  cardInfo.health != null
                                      ? const CardText(
                                          text: "Health",
                                          isTitle: Constants.titleIsTrue,
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CardText(text: cardInfo.cardId),
                                    CardText(text: cardInfo.cardSet),
                                    CardText(text: cardInfo.type),
                                    CardText(text: cardInfo.playerClass),
                                    cardInfo.text != null
                                        ? CardText(text: cardInfo.text!)
                                        : const SizedBox.shrink(),
                                    cardInfo.health != null
                                        ? CardText(
                                            text: cardInfo.health.toString())
                                        : const SizedBox.shrink(),
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
