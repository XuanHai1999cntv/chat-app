import 'package:demo/helper/helper.dart';
import 'package:demo/pages/login_page/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SignupScreen extends GetView<LoginController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    Helper.createAccount,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: controller.usernameSignupController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Helper.hintTextUserName,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailSignupController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Helper.email,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: controller.passwordSignupController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Helper.password,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      controller: controller.phoneSignupController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: Helper.phone,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.emailSignupController.text.isNotEmpty &&
                            controller
                                .passwordSignupController.text.isNotEmpty &&
                            controller.phoneSignupController.text.isNotEmpty &&
                            controller
                                .usernameSignupController.text.isNotEmpty) {
                          final user = await controller.signup(
                              userName:
                                  controller.usernameSignupController.text,
                              email: controller.emailSignupController.text,
                              password:
                                  controller.passwordSignupController.text,
                              phone: controller.phoneSignupController.text);
                          if (user != null) {
                            controller.logOut();
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title:
                                          const Text(Helper.createSuccessful),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(Helper.login),
                                          onPressed: () {
                                            Get.offAllNamed('/login');
                                          },
                                        ),
                                      ],
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text(Helper.createFailed),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(Helper.retry),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: const Text(Helper.createFailed),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: const <Widget>[
                                          Text(Helper.enterInfo),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text(Helper.retry),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ));
                        }
                      },
                      child: const Text(
                        Helper.create,
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
