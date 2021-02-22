import 'package:chatting_app/widgets/chat/messages.dart';
import 'package:chatting_app/widgets/chat/new_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (msg){
      print(msg);
      return;
    }, onLaunch: (msg){
      print(msg);
      return;
    },
    onResume: (msg){
      print(msg);
      return;
    });
    fbm.subscribeToTopic('chat');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatting App'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessages(),
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Firestore.instance
//              .collection('chats/FxRzEaSYczOnUKsEi0If/messages')
//              .add({'text': 'hello'});
//        },
//        child: Icon(Icons.add),
//      ),
    );
  }
}
