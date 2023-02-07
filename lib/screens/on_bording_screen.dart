import 'package:finelproject/components/bulid_page.dart';
import 'package:finelproject/screens/login_screen.dart';
import 'package:finelproject/sharedPreferans/sharedPreferance.dart';
import 'package:finelproject/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          controller: controller,
          children: [
            buildPage(
                celor: Color(0xffffffff),
                image: 'assets/4.jpg',
                title: 'title1',
                subtitle: ' subtitle subtitle subtitle subtitle subtitle'),
            buildPage(
                celor: Color(0xffffffff),
                image: 'assets/2.jpg',
                title: 'title1',
                subtitle: ' subtitle subtitle subtitle subtitle subtitle'),
            buildPage(
                celor: Color(0xffffffff),
                image: 'assets/3.jpg',
                title: 'title1',
                subtitle: ' subtitle subtitle subtitle subtitle subtitle'),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xff),
                  minimumSize: Size.fromHeight(80),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () async{
                AppNavigator.appNavigator(context, true, LoginScreen());
                bool? prefs = await SharedPrefrenceHelper.saveData(key: 'onbording', value: true);
                print(prefs);
              },
              child: Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ))
          : Container(
              color: Color(0xffffffff),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('SKIP', style: TextStyle(fontSize: 20)),
                    onPressed: () => controller.jumpToPage(2),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: Colors.teal.shade700),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'NEXT',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                  )
                ],
              ),
            ),
    );
  }
}
