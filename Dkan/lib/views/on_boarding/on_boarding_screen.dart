import 'package:dkan/components/const.dart';
import 'package:dkan/components/default_text_button.dart';
import 'package:dkan/helpers/local/chache_helper.dart';
import 'package:dkan/models/boarding_model.dart';
import 'package:dkan/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController boardController = PageController();

  bool isLast = false;
  Icon icon = const Icon(Icons.arrow_forward_ios);

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/lang', (Route<dynamic> route) => false);
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/shop.png',
        title: 'Welcome to Dkan',
        body: 'Dkan as The Real Old Way'),
    BoardingModel(
        image: 'assets/images/1.png',
        body: 'The best offers you will ever see',
        title: 'Easy & Helpful'),
    BoardingModel(
        image: 'assets/images/3.png',
        body: 'You can buy and sell anything you want',
        title: 'Be The Seller & The Customer'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              function: submit,
              text: 'skip',
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                        icon = const Icon(Icons.login);
                      });
                    } else {
                      setState(() {
                        isLast = false;
                        icon = const Icon(Icons.arrow_forward_ios);
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                        dotWidth: 10.0,
                        radius: 16.0,
                        dotHeight: 12.0,
                        dotColor: Colors.grey,
                        strokeWidth: 10,
                        activeDotColor: defaultColor1,
                      )),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: const Duration(microseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: icon,
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          Text(
            model.title,
            style: const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      );
}
