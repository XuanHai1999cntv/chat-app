import 'package:demo/helper/helper.dart';
import 'package:demo/pages/login_page/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Obx(
        () => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: (controller.isLoading)
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 200),
                        const Text(
                          Helper.welcome,
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
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
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
                            controller: controller.passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Helper.password,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (controller.emailController.text.isNotEmpty &&
                                  controller
                                      .passwordController.text.isNotEmpty) {
                                final user = await controller.logIn(
                                    controller.emailController.text,
                                    controller.passwordController.text);
                                if (user != null) {
                                  Get.toNamed('/home');
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title:
                                                const Text(Helper.loginFailed),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: const <Widget>[
                                                  Text(Helper.incorrectLogin),
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
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          title: const Text(Helper.loginFailed),
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
                              Helper.login,
                              style: TextStyle(fontSize: 20),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade800),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed('/signup');
                            },
                            child: Text(
                              Helper.signup,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade800),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                side: BorderSide(
                                  width: 3.0,
                                  color: Colors.blue.shade800,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
