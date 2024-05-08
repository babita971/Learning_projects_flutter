import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({super.key});

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void submitMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    _messageController.clear();
    FocusScope.of(context).unfocus();
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final userData =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    print(userData.data());
    FirebaseFirestore.instance.collection("chat").add({
      "text": enteredMessage,
      "createdAt": DateTime.now(),
      "userId": userId,
      "userName": userData.data()!["user_name"],
      "userImage": userData.data()!["image_url"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                label: Text("Send a message"),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: submitMessage,
            icon: const Icon(
              Icons.send,
              color: Colors.pinkAccent,
            ),
          ),
        ],
      ),
    );
  }
}
