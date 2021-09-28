import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/utilities/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatTitle extends StatefulWidget {
  final String userName;
  final String chatRoomId;
  ChatTitle(this.userName, this.chatRoomId);
  @override
  _ChatTitleState createState() => _ChatTitleState();
}

class _ChatTitleState extends State<ChatTitle> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? lastMessages;
  @override
  void initState() {
    super.initState();
    lastMessages =
        fireStoreDatabaseMethods.getConversationMessages(widget.chatRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: lastMessages,
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Container();
          }
          return Column(
            children: [
              Container(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      widget.userName.substring(0, 1),
                    ),
                  ),
                  title: Text(widget.userName),

                  /// check if there`s data
                  trailing: snapshots.data!.docs.isEmpty
                      ? Text("")
                      : Text(snapshots.data!.docs[0]
                          .data()['time']
                          .toString()
                          .substring(11, 16)),

                  subtitle: snapshots.data!.docs.isEmpty
                      ? Text("")
                      : Text(snapshots.data!.docs[0].data()['message']),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (c) {
                      return Chat(
                        chatRoomId: widget.chatRoomId,
                        userName: widget.userName,
                      );
                    }),
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 2,
              ),
            ],
          );
        });
  }
}
