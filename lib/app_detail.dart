import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDetail extends StatefulWidget {
  const AppDetail({super.key});

  @override
  State<AppDetail> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AppDetail> {
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 20.0,
    );
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                "https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1472&q=80",
                fit: BoxFit.cover,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4),
            AnimatedTextKit(repeatForever: true, animatedTexts: [
              ColorizeAnimatedText(
                'Hasib Hossain Abir',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
              ColorizeAnimatedText(
                'Checkout my profile',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 165,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          RotateAnimatedText('Full Stack Web'),
                          RotateAnimatedText('Android/ IOS'),
                          RotateAnimatedText('System Design +'),
                        ],
                      ),
                    ),
                    const Text(" Developer"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextLiquidFill(
              text: 'About this app:',
              waveColor: Colors.blueAccent,
              boxBackgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              boxHeight: 50.0,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Task of Clans: Conquer Tasks Online and Offline! Unleash your productivity power with our web and mobile app. Battle your to-dos, complete missions, and lead your clan to victory in both the digital and real worlds. Explore our Clash of Clans-themed to-do app with a web version you can check out at your convenience!",
                style: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (!await launchUrl(
                      Uri.parse("https://coc-todo.netlify.app/"),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch url');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Web Version',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!await launchUrl(
                      Uri.parse(
                          "https://www.facebook.com/hasibhossain.abir.7/"),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch url');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Dev Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    ));
  }
}
