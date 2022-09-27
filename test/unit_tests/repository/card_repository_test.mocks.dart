// Mocks generated by Mockito 5.3.0 from annotations
// in hearthstone_cards/test/unit_tests/repository/card_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:cloud_firestore/cloud_firestore.dart' as _i3;
import 'package:hearthstone_cards/src/data/datasource/local/DAOs/database.dart'
    as _i6;
import 'package:hearthstone_cards/src/data/datasource/remote/cards_api_service.dart'
    as _i4;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeQuerySnapshot_1<T extends Object?> extends _i1.SmartFake
    implements _i3.QuerySnapshot<T> {
  _FakeQuerySnapshot_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [CardsApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardsApiService extends _i1.Mock implements _i4.CardsApiService {
  MockCardsApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Response> callApi({dynamic endpoint}) => (super.noSuchMethod(
          Invocation.method(#callApi, [], {#endpoint: endpoint}),
          returnValue: _i5.Future<_i2.Response>.value(_FakeResponse_0(
              this, Invocation.method(#callApi, [], {#endpoint: endpoint}))))
      as _i5.Future<_i2.Response>);
}

/// A class which mocks [Database].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabase extends _i1.Mock implements _i6.Database {
  MockDatabase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void> addCard(
          {List<dynamic>? cards,
          String? mainCollectionDocument,
          String? subcollection}) =>
      (super.noSuchMethod(
              Invocation.method(#addCard, [], {
                #cards: cards,
                #mainCollectionDocument: mainCollectionDocument,
                #subcollection: subcollection
              }),
              returnValue: _i5.Future<void>.value(),
              returnValueForMissingStub: _i5.Future<void>.value())
          as _i5.Future<void>);
  @override
  _i5.Future<_i3.QuerySnapshot<Object?>> readCards(
          {String? mainCollectionDocument, String? subcollection}) =>
      (super.noSuchMethod(Invocation.method(#readCards, [], {#mainCollectionDocument: mainCollectionDocument, #subcollection: subcollection}),
          returnValue: _i5.Future<_i3.QuerySnapshot<Object?>>.value(
              _FakeQuerySnapshot_1<Object?>(
                  this,
                  Invocation.method(#readCards, [], {
                    #mainCollectionDocument: mainCollectionDocument,
                    #subcollection: subcollection
                  })))) as _i5.Future<_i3.QuerySnapshot<Object?>>);
  @override
  _i5.Future<void> deleteCard({String? docId}) => (super.noSuchMethod(
      Invocation.method(#deleteCard, [], {#docId: docId}),
      returnValue: _i5.Future<void>.value(),
      returnValueForMissingStub: _i5.Future<void>.value()) as _i5.Future<void>);
}
