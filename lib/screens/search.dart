import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  static final id = '/search';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ///variables
  final _searchController = TextEditingController();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _listSnapShots = [];

  ///build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 22,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back)),

        ///textField for searching
        title: Container(
          height: 40,
          margin: EdgeInsets.all(10.0),
          child: TextFormField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: kFieldTextStyle(context).copyWith(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.green[50], fontSize: 20.0),
              contentPadding: EdgeInsets.only(top: 3.0, left: 8.0),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                getDataFromFireBase();
              } else {
                setState(() {
                  _listSnapShots.clear();
                });
              }
            },
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => showDataSearch(index),
          separatorBuilder: (context, index) => Divider(
                thickness: 1.0,
              ),
          itemCount: _listSnapShots.length),
    );
  }

  /// Methods

  /// getting data from fireBase by Searching
  void getDataFromFireBase() {
    fireStoreDatabaseMethods
        .getDataBySubString(_searchController.text)
        .then((snapshots) {
      setState(() {
        _listSnapShots = snapshots.docs;
      });
    });
  }

  ///  to get name and email who u search him .
  Widget showDataSearch(int index) {
    String userName = _listSnapShots[index].data()['name'];
    return ListTile(
      title: Text(userName, style: kResultSearch),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.person,color: Colors.white,),
      ),
      subtitle: Text(_listSnapShots[index].data()['email']),
      onTap: () => createChatRoomAndStartConversation(userName),
    );
  }

  /// to start conversation and store data in firebase
  void createChatRoomAndStartConversation(String userName) {
    String chatRoomId = getChatRoomId(userName, myName);
    List<String> users = [userName, myName];
    Map<String, dynamic> chatRoomMap = {
      'users': users,
      'chatRoomId': chatRoomId,
    };

    /// to open chat
    fireStoreDatabaseMethods.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (c) => Chat(
          chatRoomId: chatRoomId,
          userName: userName,
        ),
      ),
    );
  }

  String getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return '$a\_$b';
    } else {
      return '$b\_$a';
    }
  }
}
