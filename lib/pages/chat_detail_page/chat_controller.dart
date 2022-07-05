import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final RxString _conversationId = ''.obs;
  final Rxn<UserModel> myProfile = Rxn();
  final Rxn<UserModel> friendProfile = Rxn();
  TextEditingController messageController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  ScrollController scrollController = ScrollController();
  FocusNode textFocusNode = FocusNode();

  String get conversationId => _conversationId.value;
  late Map<String, dynamic> argument;

  @override
  void onInit() {
    super.onInit();
    argument = Get.arguments;
    myProfile.value = argument["myProfile"];
    friendProfile.value = argument["friendProfile"];
    _conversationId.value = argument["conversationId"];
  }

  addMessage() async {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageInfoMap = {
        "message": messageController.text,
        "sendBy": myProfile.value!.email,
        "time": FieldValue.serverTimestamp(),
      };
      await db
          .collection("chatrooms")
          .doc(conversationId)
          .collection("chats")
          .doc()
          .set(messageInfoMap);
      messageController.clear();
    } else {
      print('Enter some text');
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }
}
