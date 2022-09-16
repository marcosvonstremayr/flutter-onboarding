import 'package:flutter/material.dart';

import '../../core/util/dimensions_constants.dart';
import '../../core/util/string_constants.dart';
import '../../data/model/card_model.dart';
import '../../core/util/constants.dart';
import '../widget/show_card_properties.dart';
import '../widget/show_img.dart';

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
          iconTheme: const IconThemeData(
            color: Constants.iconThemeColor,
          ),
          title: Text(
            cardInfo.name ?? StringConstants.unknownCardName,
            style: const TextStyle(
              color: Constants.iconThemeColor,
              fontSize: DimensionsConstants.titleFontSize,
            ),
          ),
          backgroundColor: Constants.appBarBackgroundColor,
        ),
        body: Center(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(DimensionsConstants.cardPadding),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Constants.cardDetailGradientColor1,
                        Constants.cardDetailGradientColor2,
                        Constants.cardDetailGradientColor1,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.cardShadowColor,
                        blurRadius: DimensionsConstants.cardShadowBlurRadius,
                        spreadRadius: DimensionsConstants.cardShadowSpreadRadius,
                      )
                    ],
                    borderRadius:
                        BorderRadius.circular(DimensionsConstants.cardBorderRadius),
                    border: Border.all(
                      color: Constants.cardBorderColor,
                      width: DimensionsConstants.cardBorderWidth,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: DimensionsConstants.cardDetailImagePadding,
                        ),
                        child: showImgIfExists(
                          cardInfo.img,
                          DimensionsConstants.cardHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: DimensionsConstants.cardInfoContainerHorizontalPadding,
                          right: DimensionsConstants.cardInfoContainerHorizontalPadding,
                          bottom: DimensionsConstants.cardInfoContainerBottomPadding,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                showPropertyIfExists(
                                  cardInfo.cardSet,
                                  StringConstants.cardSetTitle,
                                ),
                                showPropertyIfExists(
                                  cardInfo.type,
                                  StringConstants.typeTitle,
                                ),
                                showPropertyIfExists(
                                  cardInfo.rarity,
                                  StringConstants.rarityTitle,
                                ),
                                showPropertyIfExists(
                                  cardInfo.playerClass,
                                  StringConstants.playerClassTitle,
                                ),
                                showPropertyIfExists(
                                  cardInfo.artist,
                                  StringConstants.artistTitle,
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
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: DimensionsConstants.iconPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: Constants.likeColor,
                      size: DimensionsConstants.likeIconSize,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: DimensionsConstants.iconPadding),
                      child: Text(
                        "$_likeCounter",
                        style: const TextStyle(
                          color: Constants.likeCounterNumberColor,
                          fontSize: DimensionsConstants.likeCounterFontSize,
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
          backgroundColor: Constants.likeColor,
          child: const Icon(Icons.favorite),
        ),
      ),
    );
  }
}
