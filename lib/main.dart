import 'package:flutter/material.dart';
import 'package:hearthstone_cards/utils/constants.dart';
import 'card_text.dart';

void main() => runApp(const HearthstoneApp());

class HearthstoneApp extends StatelessWidget {
  const HearthstoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appTitle,
      theme: ThemeData(
        fontFamily: Constants.appFont,
        scaffoldBackgroundColor: Constants.appBackgroundColor,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _likeCounter = 0;

  void addLike(){
    setState(() {
      _likeCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        color: Colors.pink,
                        size: Constants.likeIconSize,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: Constants.iconPadding ),
                        child: Text(
                          "$_likeCounter",
                          style: const TextStyle(
                              color: Colors.black,
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
                            CardText(text: Constants.cardName),
                            CardText(text: Constants.cardType),
                            CardText(text: Constants.cardFaction,),
                            CardText(text: Constants.cardRarity),
                            CardText(text: Constants.cardCost),
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
                              CardText(text: Constants.cardAttack),
                              CardText(text: Constants.cardHealth),
                              Padding(
                                padding: EdgeInsets.all(Constants.cardTextPadding),
                                child: Text(
                                    Constants.cardAbility,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addLike,
        backgroundColor: Constants.likeButtonColor,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
