import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/util/dimensions_constants.dart';
import '../../../../core/util/string_constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection =
    _firestore.collection(StringConstants.firestoreMainCollection);

class Database {
  Future<void> addCard({
    required List<dynamic> cards,
    required String mainCollectionDocument,
    required String subcollection,
  }) async {
    WriteBatch batch = _firestore.batch();
    int counter = 0;
    cards.forEach((card) {
      DocumentReference documentReferencer = _mainCollection
          .doc(mainCollectionDocument)
          .collection(subcollection)
          .doc(card[StringConstants.cardIdProperty]);
      if (counter >= DimensionsConstants.batchMaxSize) {
        batch.commit();
        batch = _firestore.batch();
      }
      batch.set(
        documentReferencer,
        card,
        SetOptions(merge: true),
      );
      counter++;
    });
    batch.commit();
  }

  Future<QuerySnapshot> readCards({
    required String mainCollectionDocument,
    required String subcollection,
  }) async {
    CollectionReference cardsCollection =
        _mainCollection.doc(mainCollectionDocument).collection(subcollection);
    var response = await cardsCollection.get();
    return response;
  }

  Future<void> deleteCard({
    required String docId,
  }) async {
    DocumentReference documentReferencer = _mainCollection
        .doc(StringConstants.favoritesDocument)
        .collection(StringConstants.favoritesSubcollection)
        .doc(docId);

    await documentReferencer.delete();
  }
}
