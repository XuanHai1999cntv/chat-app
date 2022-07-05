import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/helper/helper.dart';
import 'package:demo/pages/chat_detail_page/chat_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatScreen extends GetView<ChatController> {
  ChatScreen({Key? key}) : super(key: key);
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
            stream: db
                .collection("user")
                .doc(controller.friendProfile.value!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              } else {
                return Column(
                  children: [
                    Text(
                      snapshot.data!["name"],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      snapshot.data!["status"],
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                );
              }
            }),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: StreamBuilder(
            stream: db
                .collection("chatrooms")
                .doc(controller.conversationId)
                .collection("chats")
                .orderBy("time", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          controller: controller.scrollController,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final control = snapshot.data!.docs[index];
                            return _buildMessage(
                                text: control["message"],
                                isSentByMe: control["sendBy"] ==
                                    controller.myProfile.value!.email);
                          }),
                    ),
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.black, width: 2)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                focusNode: controller.textFocusNode,
                                controller: controller.messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Helper.hintTextMessage,
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                                minLines: 1,
                                maxLines: 5,
                                onTap: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  controller.scrollController.animateTo(
                                      controller.scrollController.position
                                          .minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.fastOutSlowIn);
                                },
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  controller.addMessage();
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  controller.scrollController.animateTo(
                                      controller.scrollController.position
                                          .minScrollExtent,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.fastOutSlowIn);
                                },
                                child: const Icon(Icons.send)),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }

  Widget _buildMessage({required String text, required bool isSentByMe}) {
    return Padding(
      padding: EdgeInsets.only(
        left: (isSentByMe) ? 100 : 0,
        right: (isSentByMe) ? 0 : 100,
      ),
      child: Row(
        mainAxisAlignment:
            (isSentByMe) ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: (isSentByMe) ? Colors.blue.shade200 : Colors.black26,
              ),
              child: Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
