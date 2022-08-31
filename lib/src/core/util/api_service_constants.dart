abstract class ApiServiceConstants {
  static const String apiBaseUrl =
      'https://omgvamp-hearthstone-v1.p.rapidapi.com/cards';
  static const Map<String, String> apiCardsQualityEndpoint = {
    "Free": "/qualities/free",
    "Common": "/qualities/common",
    "Rare": "/qualities/rare",
    "Epic": "/qualities/epic",
    "Legendary": "/qualities/legendary",
  };
  static const Map<String, String> apiCardsClassesEndpoint = {
    "Demon Hunter": "/classes/demon%20hunter",
    "Druid": "/classes/druid",
    "Hunter": "/classes/hunter",
    "Mage": "/classes/mage",
    "Paladin": "/classes/paladin",
    "Priest": "/classes/priest",
    "Rogue": "/classes/rogue",
    "Shaman": "/classes/shaman",
    "Warlock": "/classes/warlock",
    "Warrior": "/classes/warrior",
    "Neutral": "/classes/neutral",
  };
  static const Map<String, String> apiCardsHeaders = {
    "X-RapidAPI-Key": "5fe37a276amshfec3e4c596327f6p1bb718jsn208633f44431",
    "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com",
  };
}
