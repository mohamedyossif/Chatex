import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDatabaseMethods {
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  void upLoadProfile(Map<String, dynamic> userInfo) {
    _fireStore.collection('users').add(userInfo);
  }
/// searching by sub email
  Future<QuerySnapshot<Map<String, dynamic>>> getDataBySubString(
      String name) async {
    return await _fireStore
        .collection('users')

        /// search email
        .where('email', isGreaterThanOrEqualTo: name)
        .where('email', isLessThan: name + 'z')

        ///not search about currentUser(myself)
        .where('email', isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
  }
 /// searching by all email
  Future<QuerySnapshot<Map<String, dynamic>>> getDataByAllString(
      String userEmail) async {
    return await _fireStore
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }
 /// to open chat
  createChatRoom(String chatRoomId, chatRoomMap) {
    _fireStore
        .collection('chatRoom')
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) => print(e.toString()));
  }

  /// to set data
  setConversationMessage(String chatRoomId, messageMap) {
    _fireStore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }
/// to get data
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationMessages(
      String chatRoomId) {
    return _fireStore
        .collection('chatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time',descending: true)
        .snapshots();
  }
/// to get contacts
  getChatRooms(String myName) {
    return _fireStore
        .collection('chatRoom')
        .where('users', arrayContains: myName)
        .snapshots();
  }

  ///to delete contact
  deleteContact(String chatRoomId)
  {
    return _fireStore.collection('chatRoom')
        .doc(chatRoomId).delete();
  }
}
