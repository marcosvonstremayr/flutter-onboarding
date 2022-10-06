import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../config/notification_service/local_notification_service.dart';
import '../../core/util/assets_constants.dart';
import '../../core/util/dimensions_constants.dart';
import '../../core/util/string_constants.dart';
import '../../data/model/card_model.dart';
import '../../core/util/constants.dart';
import '../../domain/entity/card_event.dart';
import '../bloc/favorites_bloc/favorite_bloc.dart';
import '../bloc/favorites_bloc/favorites_list_bloc.dart';
import '../widget/show_card_properties.dart';
import '../widget/show_img.dart';

class CardDetail extends StatefulWidget {
  final CardModel cardInfo;

  const CardDetail({Key? key, required this.cardInfo}) : super(key: key);

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail> {
  late bool isFavorite;
  late int counter;
  late LocalNotificationService service;
  late FavoritesListBloc favoritesListBloc;
  late FavoritesBloc favoriteBloc;
  bool isBack = false;
  double angle = DimensionsConstants.originalAngle;

  void flipCard() {
    setState(() {
      angle = (angle + pi) % (2 * pi);
    });
  }

  @override
  void initState() {
    Provider.of<FavoritesBloc>(
      context,
      listen: false,
    ).isCardFavorite(widget.cardInfo);
    counter = 0;
    service = Provider.of<LocalNotificationService>(
      context,
      listen: false,
    );
    favoritesListBloc = Provider.of<FavoritesListBloc>(
      context,
      listen: false,
    );
    favoriteBloc = Provider.of<FavoritesBloc>(
      context,
      listen: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Constants.iconThemeColor,
          ),
          title: Text(
            widget.cardInfo.name ?? StringConstants.unknownCardName,
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
                child: GestureDetector(
                  onTap: () => flipCard(),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: DimensionsConstants.originalAngle,
                      end: angle,
                    ),
                    duration: const Duration(
                      seconds: DimensionsConstants.cardFlipAnimationSeconds,
                    ),
                    builder: (
                      BuildContext context,
                      double val,
                      _,
                    ) {
                      if (val >= (pi / 2)) {
                        isBack = false;
                      } else {
                        isBack = true;
                      }
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(
                            DimensionsConstants.matrixSetEntryRow,
                            DimensionsConstants.matrixSetEntryCol,
                            DimensionsConstants.matrixSetEntryV,
                          )
                          ..rotateY(val),
                        child: SizedBox(
                          height: DimensionsConstants.cardHeightContainer,
                          width: DimensionsConstants.cardWidthContainer,
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
                                  blurRadius:
                                      DimensionsConstants.cardShadowBlurRadius,
                                  spreadRadius: DimensionsConstants
                                      .cardShadowSpreadRadius,
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
                            child: isBack
                                ? widget.cardInfo.img != null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.cardInfo.img!,
                                        progressIndicatorBuilder: (
                                          context,
                                          url,
                                          downloadProgress,
                                        ) =>
                                            Center(
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                          ),
                                        ),
                                        errorWidget: (
                                          context,
                                          url,
                                          error,
                                        ) =>
                                            Image.asset(
                                          AssetsConstants.backCardImage,
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset(
                                        AssetsConstants.backCardImage,
                                      )
                                : Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.identity()..rotateY(pi),
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
                                            blurRadius: DimensionsConstants
                                                .cardShadowBlurRadius,
                                            spreadRadius: DimensionsConstants
                                                .cardShadowSpreadRadius,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(
                                          DimensionsConstants.cardBorderRadius,
                                        ),
                                        border: Border.all(
                                          color: Constants.cardBorderColor,
                                          width: DimensionsConstants
                                              .cardBorderWidth,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: DimensionsConstants
                                              .cardInfoContainerHorizontalPadding,
                                          right: DimensionsConstants
                                              .cardInfoContainerHorizontalPadding,
                                          bottom: DimensionsConstants
                                              .cardInfoContainerBottomPadding,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                showPropertyIfExists(
                                                  widget.cardInfo.cardSet,
                                                  StringConstants.cardSetTitle,
                                                ),
                                                showPropertyIfExists(
                                                  widget.cardInfo.type,
                                                  StringConstants.typeTitle,
                                                ),
                                                showPropertyIfExists(
                                                  widget.cardInfo.rarity,
                                                  StringConstants.rarityTitle,
                                                ),
                                                showPropertyIfExists(
                                                  widget.cardInfo.playerClass,
                                                  StringConstants
                                                      .playerClassTitle,
                                                ),
                                                showPropertyIfExists(
                                                  widget.cardInfo.artist,
                                                  StringConstants.artistTitle,
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  showPropertyIfExists(
                                                    widget.cardInfo.cardSet,
                                                  ),
                                                  showPropertyIfExists(
                                                    widget.cardInfo.type,
                                                  ),
                                                  showPropertyIfExists(
                                                    widget.cardInfo.rarity,
                                                  ),
                                                  showPropertyIfExists(
                                                    widget.cardInfo.playerClass,
                                                  ),
                                                  showPropertyIfExists(
                                                    widget.cardInfo.artist,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: DimensionsConstants.iconPadding,
                ),
                child: StreamBuilder<CardEvent>(
                  stream: favoriteBloc.getStream(),
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
                              await favoriteBloc
                                  .saveFavoriteCard(widget.cardInfo);
                              isFavorite
                                  ? await service.showNotification(
                                      id: counter,
                                      title:
                                          "${widget.cardInfo.name!} ${StringConstants.favoritesRemovedNotificationTitle}",
                                      body: StringConstants
                                          .favoritesRemovedNotificationBody,
                                    )
                                  : await service.showNotification(
                                      id: counter,
                                      title:
                                          "${widget.cardInfo.name!} ${StringConstants.favoritesAddedNotificationTitle}",
                                      body: StringConstants
                                          .favoritesAddedNotificationBody,
                                    );
                              await favoritesListBloc.getFavoriteCards();
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
