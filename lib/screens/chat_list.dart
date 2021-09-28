import 'package:chat_app/component/reused_delete_dialog.dart';
import 'package:chat_app/component/reused_icon_button_appbar.dart';
import '../component/chat_title.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/search.dart';
import 'package:chat_app/services/shared_preferences.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ChatList extends StatefulWidget {
  static const id = '/chatList';
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatStream;
  @override
  void initState() {
    super.initState();
    getUserName();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: MediaQuery.of(context).size * 0.11,
        child: AppBar(
          leadingWidth: 0,
          leading: Container(),
          title: isCheck
              ? Transform.translate(
                  offset: Offset(0, 7),
                  child: Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text("Chats", style: kChatText)),
                )
              : Center(
                  child: getIconButton(Icons.delete, () {
                    reusedDeleteDialog(context, ChatRoomID2);
                    setState(() {
                      isCheck = true;
                    });
                  }, 7.0),
                ),
          actions: [
            isCheck
                ? Transform.translate(
                    offset: Offset(0, 7),
                    child: IconButton(
                      onPressed: () {
                        authFirebaseMethods.signOut().then((value) {
                          SharedPreferencesDatabase.saveUserLoggedInKey(true);
                          Navigator.pushReplacementNamed(context, Login.id);
                        });
                      },
                      icon: Icon(
                        Icons.logout,
                      ),
                    ),
                  )
                : getIconButton(Icons.close, () {
                    setState(() {
                      isCheck = true;
                    });
                  }, 0.0)
          ],
        ),
      ),
      body: SafeArea(
        child: streamChatList(),
      ),

      /// to go search Screen
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () => Navigator.pushNamed(context, Search.id),
      ),
    );
  }

  getUserName() async {
    myName = (await SharedPreferencesDatabase.getUserNameKey())!;
    setState(() {
      /// to get contacts
      chatStream = fireStoreDatabaseMethods.getChatRooms(myName);
    });
  }
  Widget streamChatList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chatStream,
        builder: (context, snapshots) {
          return snapshots.hasData
              ? ListView.builder(
                  reverse: true,
                  ///to make ListView only occupies the space it needs
                  shrinkWrap: true,
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (c, index) {
                    String chatRoomId =
                        snapshots.data!.docs[index].data()['chatRoomId'];
                    //  getLastMessage(chatRoomId);
                    return ChatTitle(
                      snapshots.data!.docs[index]
                          .data()['chatRoomId']
                          .toString()
                          .replaceAll('_', "")
                          .replaceAll(myName, ""),
                      chatRoomId,
                    );
                  })
              : Container();
        });
  }
}


