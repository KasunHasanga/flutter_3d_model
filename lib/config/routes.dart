import 'package:get/get.dart';

import '../features/home/home_page_binding.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/onboarding/onboard_binding.dart';

import '../features/onboarding/presentation/pages/splash.dart';

class Routers {
  static final route = [
    GetPage(
        name: SplashPage.routeName,
        page: () => const SplashPage(),
        bindings: [OnBoardingBinding()]),

    //Home Page
    GetPage(
        name: HomePage.routeName,
        page: () => const HomePage(),
        bindings: [HomePageBinding()]),
  ];
}
