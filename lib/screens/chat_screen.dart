import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF003E5F),
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: kBoxDecoration,
          child: Column(
            children: [
              const MessagesStream(),

              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        style: const TextStyle(color: Colors.black),
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),

                    TextButton(
                      child: const Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                      onPressed: () async {
                        final text = messageTextController.text.trim();
                        messageTextController.clear();

                        if (loggedInUser == null || text.isEmpty) return;

                        await _fireStore.collection('messages').add({
                          'text': text,
                          'sender': loggedInUser!.email,
                          'createdAt': DateTime.now()
                              .millisecondsSinceEpoch, // 👈 IMPORTANT
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _fireStore
            .collection('messages')
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final messages = snapshot.data!.docs;
          final currentUser = loggedInUser?.email ?? '';

          List<MessageBubble> messageWidgets = [];

          for (var message in messages) {
            final data = message.data() as Map<String, dynamic>;

            final messageText = data['text'] ?? '';
            final messageSender = data['sender'] ?? '';

            messageWidgets.add(
              MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            children: messageWidgets,
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
  });

  final bool isMe;
  final String sender;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black45,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
              bottomLeft: Radius.circular(isMe ? 30 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 30),
            ),
            elevation: 5,
            color: isMe ? const Color(0xFFD08C60) : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}