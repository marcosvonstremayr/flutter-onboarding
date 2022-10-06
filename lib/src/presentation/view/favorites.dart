import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/util/assets_constants.dart';
import '../../core/util/constants.dart';
import '../../core/util/dimensions_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/card_event.dart';
import '../bloc/favorites_bloc/favorites_list_bloc.dart';
import '../widget/error.dart';
import '../widget/grid_text.dart';
import '../widget/show_img.dart';
import 'card_detail.dart';

class Favorites extends StatefulWidget {
  const Favorites({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    Provider.of<FavoritesListBloc>(
      context,
      listen: false,
    ).getFavoriteCards();
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
          title: const Text(
            StringConstants.favoritesAppBarTitle,
            style: TextStyle(
              color: Constants.iconThemeColor,
              fontSize: DimensionsConstants.titleFontSize,
            ),
          ),
          backgroundColor: Constants.appBarBackgroundColor,
        ),
        body: Center(
          child: StreamBuilder<CardEvent>(
            stream: Provider.of<FavoritesListBloc>(context).getStream(),
            initialData: CardEvent(status: Status.loading),
            builder: (
              BuildContext context,
              AsyncSnapshot<CardEvent> snapshot,
            ) {
              switch (snapshot.data!.status) {
                case Status.loading:
                  {
                    return const CircularProgressIndicator();
                  }
                case Status.success:
                  {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: DimensionsConstants.numberOfGridColumns,
                        childAspectRatio:
                            DimensionsConstants.gridChildAspectRatio,
                      ),
                      itemCount: snapshot.data!.cards!.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return Padding(
                          padding: const EdgeInsets.all(
                            DimensionsConstants.paddingBetweenGrids,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardDetail(
                                    cardInfo: snapshot.data!.cards![index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  DimensionsConstants.gridContainerBorderRadius,
                                ),
                                color: Constants.gridCardColor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      DimensionsConstants.gridImagePadding,
                                    ),
                                    child: showImgIfExists(
                                      snapshot.data!.cards![index].img,
                                      DimensionsConstants.gridImageHeight,
                                    ),
                                  ),
                                  Expanded(
                                    child: gridCardText(
                                      snapshot.data!.cards![index].name,
                                    ),
                                  ),
                                  Expanded(
                                    child: gridCardText(
                                      snapshot.data!.cards![index].cardSet,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                case Status.empty:
                  {
                    return Column(
                      children: [
                        Image.asset(
                          AssetsConstants.emptyScreenImage,
                          height: DimensionsConstants.emptyImageHeight,
                        ),
                        const Text(
                          StringConstants.noCardsFound,
                          style: TextStyle(
                            color: Constants.emptyCardsColor,
                            fontSize: DimensionsConstants.emptyCardsFontSize,
                          ),
                        ),
                      ],
                    );
                  }
                case Status.error:
                  {
                    return error(snapshot.data!.errorMsg!);
                  }
                default:
                  {
                    return const CircularProgressIndicator();
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
