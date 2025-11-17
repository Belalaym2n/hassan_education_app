import 'package:amr_rezk_education/features/splash/onBoarding/onBoardItem.dart';
import 'package:flutter/cupertino.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardItem();
  }
}
