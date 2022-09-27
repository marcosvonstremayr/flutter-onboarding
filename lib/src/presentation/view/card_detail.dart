import 'package:flutter/material.dart';

import '../../config/notification_service/local_notification_service.dart';
import '../../core/util/dimensions_constants.dart';
import '../../core/util/string_constants.dart';
import '../../data/model/card_model.dart';
import '../../core/util/constants.dart';
import '../../domain/entity/card_event.dart';
import '../bloc/blocs.dart';
import '../bloc/favorites_bloc/favorite_bloc.dart';
import '../widget/show_card_properties.dart';
import '../widget/show_img.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({
    Key? key,
    required this.blocs,
    required this.favoriteBloc,
    required this.service,
  }) : super(key: key);

  final LocalNotificationService service;
  final Blocs blocs;
  final FavoritesBloc favoriteBloc;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  late bool isFavorite;
  late int counter;

  @override
  void initState() {
    counter = 0;
    super.initState();
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
                        spreadRadius:
                            DimensionsConstants.cardShadowSpreadRadius,
                      )
                    ],
                    borderRadius: BorderRadius.circular(
                      DimensionsConstants.cardBorderRadius,
                    ),
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
                          left: DimensionsConstants
                              .cardInfoContainerHorizontalPadding,
                          right: DimensionsConstants
                              .cardInfoContainerHorizontalPadding,
                          bottom: DimensionsConstants
                              .cardInfoContainerBottomPadding,
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
                padding: const EdgeInsets.only(
                  bottom: DimensionsConstants.iconPadding,
                ),
                child: StreamBuilder<CardEvent>(
                  stream: widget.favoriteBloc.getStream(),
                  initialData: CardEvent(status: Status.initial),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot snapshot,
                  ) {
                    switch (snapshot.data!.status) {
                      case Status.success:
                        {
                          isFavorite = snapshot.data!.isFavorite!;
                          return InkWell(
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Constants.likeColor,
                              size: DimensionsConstants.likeIconSize,
                            ),
                            onTap: () async {
                              await widget.favoriteBloc
                                  .saveFavoriteCard(cardInfo);
                              isFavorite
                                  ? await widget.service.showNotification(
                                      id: counter,
                                      title:
                                          "${cardInfo.name!} ${StringConstants.favoritesRemovedNotificationTitle}",
                                      body: StringConstants
                                          .favoritesRemovedNotificationBody,
                                    )
                                  : await widget.service.showNotification(
                                      id: counter,
                                      title:
                                          "${cardInfo.name!} ${StringConstants.favoritesAddedNotificationTitle}",
                                      body: StringConstants
                                          .favoritesAddedNotificationBody,
                                    );
                              setState(() {
                                counter++;
                              });
                              await widget.blocs.favoritesListBloc
                                  .getFavoriteCards();
                            },
                          );
                        }
                      case Status.error:
                        {
                          return const Text(
                            StringConstants.favoritesUnavailable,
                            style: TextStyle(
                              color: Constants.favoritesUnavailableTextColor,
                            ),
                          );
                        }
                      default:
                        {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
