import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simply_news/lib/utils.dart';

enum Auth {
  SignedIn,
  NotSignedIn,
}

class UserState with ChangeNotifier {
  Auth _status = Auth.NotSignedIn;
  Map _data;
  String _email;
  DocumentReference _ref;

  Auth get status => _status;

  bool get isSignedIn => _status == Auth.SignedIn;

  String get email => _email;

  List get vocab => _data != null ? (_data['saved_vocab'] ?? []) : [];

  set status(Auth status) {
    _status = status;
    notifyListeners();
  }

  set data(Map data) {
    _data = data;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  void logout() {
    _ref = null;
    _data = null;
    _email = null;
    _status = Auth.NotSignedIn;
    notifyListeners();
  }

  Future<void> addVocab(Map token) async {
    // exit if token word already saved
    if (hasToken(vocab, token)) return;
    await getDocReference();
    await _ref.updateData({
      "saved_vocab": FieldValue.arrayUnion([token])
    });
    _data['saved_vocab'] = [...vocab, token];
    data = _data;
  }

  Future<void> getData() async {
    await getDocReference();
    final result = await _ref.get();
    data = result.data;
  }

  Future<dynamic> getDocReference() {
    Completer _completer = new Completer();
    Function _resolve = _completer.complete;
    Function _reject = _completer.completeError;
    
    if (_email == null) {
      _reject('No email identifier passed');
    } else if (_ref != null) {
      // no need to pass anything to resolve 
      // as we'll use the _ref class property
      _resolve();
    } else {
      Firestore.instance
          .collection('users')
          .where("email", isEqualTo: _email)
          .snapshots()
          .handleError(_reject)
          .listen((data) {
        // if we got the ref already
        if (_completer.isCompleted) return;
        final docs = data.documents;
        if (docs.length < 1) {
          _reject('No data found.');
          return;
        }
        _ref = docs[0].reference;
        _resolve();
      }).onError(_reject);
    }

    return _completer.future;
  }
}
