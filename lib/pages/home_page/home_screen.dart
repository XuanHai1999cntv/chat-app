import 'package:demo/helper/helper.dart';
import 'package:demo/model/user_model.dart';
import 'package:demo/pages/home_page/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeScreen extends GetView<HomeController> with WidgetsBindingObserver {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(Helper.homePage),
              centerTitle: true,
              backgroundColor: Colors.blue.shade800,
              automaticallyImplyLeading: false,
              actions: [
                InkWell(
                  onTap: () {
                    controller.logOut();
                    Get.offAllNamed('/login');
                  },
                  child: const Icon(Icons.login_outlined),
                ),
                const SizedBox(width: 16),
              ],
              bottom: const TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  SizedBox(
                      height: 32,
                      child: Center(
                          child: Text(
                        Helper.listUser,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))),
                  SizedBox(
                      height: 32,
                      child: Center(
                          child: Text(
                        Helper.profile,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: _buildHome(),
          ),
        ),
      ),
    );
  }

  Widget _buildHome() {
    return TabBarView(
      children: [
        Obx(() => _buildListUserView()),
        Obx(() => _buildProfileView()),
      ],
    );
  }

  Widget _buildListUserView() {
    return (controller.isLoading)
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildListUser(controller.listUser),
                ],
              ),
            ),
          );
  }

  Widget _buildListUser(List<UserModel> listUser) {
    return ListView.builder(
        itemCount: listUser.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                String conversationId = controller.getConversationId(
                    email1: controller.userProfile.value!.email,
                    email2: listUser[index].email);
                String friendName = listUser[index].userName;
                Map<String, dynamic> argument = {
                  "conversationId": conversationId,
                  "friendProfile": listUser[index],
                  "myProfile": controller.userProfile.value,
                };
                Get.toNamed('/chat', arguments: argument);
              },
              child: ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(listUser[index].userName),
                subtitle: Text(listUser[index].email),
                trailing: const Icon(
                  Icons.message,
                  color: Colors.black,
                ),
              ),
            ));
  }

  Widget _buildProfileView() {
    return (controller.isLoading)
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 54, right: 54),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const SizedBox(
                    height: 64,
                    width: 64,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.userProfile.value!.userName,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.email, size: 32,),
                          const SizedBox(width: 12),
                          Text(controller.userProfile.value!.email,style: const TextStyle(fontSize: 16),),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 32,),
                          const SizedBox(width: 12),
                          Text(controller.userProfile.value!.phoneNumber,style: const TextStyle(fontSize: 16),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
