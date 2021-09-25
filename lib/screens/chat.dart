import 'package:chat_app/screens/chat_list.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String lastMessage = '';
String lastTime = '';

class Chat extends StatefulWidget {
  static const id = '/chat';
  final chatRoomId;
  final userName;

  Chat({this.chatRoomId, this.userName});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>>? chatsStream;
  @override
  void initState() {
    super.initState();
    setState(() {
      /// to get messages by ChatRoomId(you and another user)
      chatsStream =
          fireStoreDatabaseMethods.getConversationMessages(widget.chatRoomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Row(
        children: [
          Expanded(
            child: TextField(
                controller: messageController,
                decoration:
                kFieldTextStyle.copyWith(hintText: 'Type a message')),
          ),
          FloatingActionButton(
              onPressed: () {
                sendMessage();
                messageController.clear();
              },
              child: Icon(Icons.send_rounded)),
        ],
      ),
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (c) => ChatList(),
            ),
          ),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        title: Text(widget.userName),
      ),
      body: messageList(),
    );
  }

  ///methods

  ///send messages to firebase
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        'massage': messageController.text,
        'sender': myName,
        'time': DateTime.now().toString(),
      };
      fireStoreDatabaseMethods.setConversationMessage(
          widget.chatRoomId, messageMap);
    }
  }

  Widget messageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: chatsStream,
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          return ListView.builder(
            reverse: true,
           padding: EdgeInsets.only(bottom:65 ),
            ///to make ListView only occupies the space it needs
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (c, index) => MassageTitle(
              massage: snapshots.data!.docs[index].data()['massage'],
              isMe: snapshots.data!.docs[index].data()['sender'] == myName,
            ),
          );
        });
  }
}

class MassageTitle extends StatelessWidget {
  final massage;

  /// to determinate users
  final isMe;
  MassageTitle({required this.massage, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            color: isMe ? Colors.greenAccent : Colors.lightGreenAccent,
          ),
          child: Text(
            massage,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
