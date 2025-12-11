import 'package:cloud_firestore/cloud_firestore.dart';

/// FirestoreService centralizes calls to Firestore for users and news.
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Stream user profile document for [uid]
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserProfile(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }

  /// Create or update user profile (map should contain fields like 'name','bio')
  Future<void> setUserProfile(String uid, Map<String, dynamic> map) async {
    await _db.collection('users').doc(uid).set(map, SetOptions(merge: true));
  }

  /// Get news list as a stream. Each doc expected to have 'title' and 'summary'.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamNews() {
    return _db.collection('news').orderBy('createdAt', descending: true).snapshots();
  }

  /// Add a news item (helper for tests/dummy)
  Future<DocumentReference> addNews(Map<String, dynamic> data) async {
    data['createdAt'] = FieldValue.serverTimestamp();
    return await _db.collection('news').add(data);
  }
}
