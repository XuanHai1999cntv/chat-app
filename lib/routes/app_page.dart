import 'package:demo/pages/chat_detail_page/chat_binding.dart';
import 'package:demo/pages/chat_detail_page/chat_controller.dart';
import 'package:demo/pages/chat_detail_page/chat_screen.dart';
import 'package:demo/pages/home_page/home_binding.dart';
import 'package:demo/pages/home_page/home_screen.dart';
import 'package:demo/pages/signup_page/signup_screen.dart';
import 'package:get/get.dart';

import '../pages/login_page/login_binding.dart';
import '../pages/login_page/login_screen.dart';

part 'app_route.dart';

class AppPage {
  static const initial = Routes.login;
  static const currentLogin = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.signup,
      page: () => const SignupScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
  ];
}
