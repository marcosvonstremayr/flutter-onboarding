import 'package:flutter/material.dart';

import '../../core/util/api_service_constants.dart';
import '../../core/util/assets_constants.dart';
import '../../core/util/constants.dart';
import '../../core/util/dimensions_constants.dart';
import '../../core/util/string_constants.dart';
import '../../domain/entity/card_event.dart';
import '../bloc/cards_bloc/cards_bloc.dart';
import '../widget/error.dart';
import '../widget/grid_text.dart';
import '../widget/show_img.dart';
import 'card_detail.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CardsBloc bloc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Constants.iconThemeColor,
          ),
          backgroundColor: Constants.appBarBackgroundColor,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    AssetsConstants.pathToLogoImage,
                    height: DimensionsConstants.hearthstoneDrawerLogoHeight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimensionsConstants.drawerTilesPadding,
                ),
                child: ListTile(
                  title: const Text(
                    StringConstants.drawerListTileAllCards,
                    style: TextStyle(
                      fontSize: DimensionsConstants.drawerTilesFontSize,
                      color: Constants.listTilesDrawerColor,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    bloc.getAllCards();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimensionsConstants.drawerTilesPadding,
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Constants.listTilesDrawerColor,
                    dividerColor: Constants.drawerDividerColor,
                  ),
                  child: ExpansionTile(
                    title: const Text(
                      StringConstants.drawerListTileQualityCards,
                      style: TextStyle(
                        fontSize: DimensionsConstants.drawerTilesFontSize,
                        color: Constants.listTilesDrawerColor,
                      ),
                    ),
                    iconColor: Constants.listTilesDrawerColor,
                    children: [
                      for (var key
                          in ApiServiceConstants.apiCardsQualityEndpoint.keys)
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.getFilteredCards(
                              ApiServiceConstants.apiCardsQualityEndpoint[key],
                            );
                          },
                          child: Text(
                            key,
                            style: const TextStyle(
                              color: Constants.listTilesDrawerColor,
                              fontSize: DimensionsConstants
                                  .drawerSubcategoriesFontSize,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimensionsConstants.drawerTilesPadding,
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Constants.listTilesDrawerColor,
                    dividerColor: Constants.drawerDividerColor,
                  ),
                  child: ExpansionTile(
                    title: const Text(
                      StringConstants.drawerListTileClassCards,
                      style: TextStyle(
                        fontSize: DimensionsConstants.drawerTilesFontSize,
                        color: Constants.listTilesDrawerColor,
                      ),
                    ),
                    iconColor: Constants.listTilesDrawerColor,
                    children: [
                      for (var key
                          in ApiServiceConstants.apiCardsClassesEndpoint.keys)
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.getFilteredCards(
                              ApiServiceConstants.apiCardsClassesEndpoint[key],
                            );
                          },
                          child: Text(
                            key,
                            style: const TextStyle(
                              color: Constants.listTilesDrawerColor,
                              fontSize: DimensionsConstants
                                  .drawerSubcategoriesFontSize,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: Center(
          child: StreamBuilder<CardEvent>(
            stream: bloc.getStream(),
            initialData: CardEvent(status: Status.initial),
            builder: (
              BuildContext context,
              AsyncSnapshot<CardEvent> snapshot,
            ) {
              switch (snapshot.data!.status) {
                case Status.initial:
                  {
                    return Image.asset(
                      AssetsConstants.pathToPoster,
                      height: DimensionsConstants.homeImageHeight,
                      width: DimensionsConstants.homeImageWidth,
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    );
                  }
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
                                  builder: (context) => const CardDetail(),
                                  settings: RouteSettings(
                                    arguments: snapshot.data!.cards![index],
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
                case Status.error:
                  {
                    return error(snapshot.data!.errorMsg!);
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
              }
            },
          ),
        ),
      ),
    );
  }
}
