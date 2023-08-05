import 'package:flutter/material.dart';
import 'package:ishopit/modules/login/shop_login_screen.dart';
import 'package:ishopit/shared/components/components.dart';
import 'package:ishopit/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class boardingModel {
  final String image;
  final String text;
  final String body;

  boardingModel({
    required this.image,
    required this.text,
    required this.body,
  });
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  int index = 0;

  List<boardingModel> onboarding = [
    boardingModel(
        image: 'assets/images/onboarding.png',
        text: 'On Boarding 1 Screen 1',
        body: 'Body 1 Screen 1'),
    boardingModel(
        image: 'assets/images/onboarding.png',
        text: 'On Boarding 2 Screen 2',
        body: 'Body 2 Screen 2'),
    boardingModel(
        image: 'assets/images/onboarding.png',
        text: 'On Boarding 3 Screen 3',
        body: 'Body 3 Screen 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.saveData(key: 'skip', value: true).then((value) {
                if (value) navPushAndFinish(context, ShopLoginScreen());
              });
            },
            child: Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    BuildOnboardingItem(onboarding[index]),
                itemCount: 3,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onboarding.length,
                  effect: ExpandingDotsEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      spacing: 5,
                      activeDotColor: Colors.blue,
                      expansionFactor: 3),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (index < onboarding.length - 1) {
                      boardController.nextPage(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    } else {
                      CacheHelper.saveData(key: 'skip', value: true)
                          .then((value) {
                        if (value) navPushAndFinish(context, ShopLoginScreen());
                      });
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget BuildOnboardingItem(boardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 17,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
