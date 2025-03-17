// StartPage는 onBoarding Widget을 사용해 앱을 첫 실행했을때 보여지는 화면을 구성할예정입니다.

import 'package:flutter/material.dart';
import 'package:practice/pages/todoListScreen.dart';

class MyOnboarding extends StatefulWidget {
  const MyOnboarding({super.key});

  @override
  State<MyOnboarding> createState() => _MyOnboardingState();
}

class _MyOnboardingState extends State<MyOnboarding> {
  final String imageUrl =
      'https://www.baudville.com/cdn/shop/products/BV_93296_FRONT.jpg?v=1689972793';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Hello',
                style: TextStyle(fontSize: 40),
              ),
              const Text('This is My first TodoList!!'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoListScreen()));
                  });
                },
                child: const Icon(
                  Icons.skip_next,
                ),
              ),
              const Spacer(),
              const Text(
                'A river cuts throught rock not becauser of its power but because of its persistence',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const Text('Jim Watkins'),
            ],
          ),
        ),
      ),
    );
  }
}
