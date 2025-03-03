// StartPage는 onBoarding Widget을 사용해 앱을 첫 실행했을때 보여지는 화면을 구성할예정입니다.

import 'package:flutter/material.dart';

class MyOnboarding extends StatefulWidget {
  const MyOnboarding({super.key});

  @override
  State<MyOnboarding> createState() => _MyOnboardingState();
}

class _MyOnboardingState extends State<MyOnboarding> {
  final controller = PageController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          children: [
            //First page
            Container(
              color: Colors.red,
              child: const Center(
                child: Text('page1'),
              ),
            ),

            //Second page
            Container(
              color: Colors.blue,
              child: const Center(
                child: Text('page2'),
              ),
            ),

            //third page
            Container(
              color: Colors.yellow,
              child: const Center(
                child: Text('page3'),
              ),
            ),

            //last page
            Container(
              color: Colors.green,
              child: const Center(
                child: Text('page4'),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
