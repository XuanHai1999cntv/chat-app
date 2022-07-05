import 'package:demo/pages/chat_detail_page/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ChatController());
  }
}