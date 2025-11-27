import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/app_images.dart';

class StagesModel {
  final String imagePath;
  final String description;
  final String title;
  final IconData icon;

  StagesModel({
    required this.imagePath,
    required this.description,
    required this.title,
    required this.icon,
  });
}

final List<String> months = [
  'يناير',
  'فبراير',
  'مارس',
  'أبريل',
  'مايو',
  'يونيو',
  'يوليو',
  'أغسطس',
  'سبتمبر',
  'أكتوبر',
  'نوفمبر',
  'ديسمبر',
];
List<StagesModel> stages = [
  // ----------------------- المرحلة الإعدادية -----------------------
  StagesModel(
    imagePath: "assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.bookOpen,
    title: "الصف الأول الإعدادي",
    description:
        'ابدأ الإعدادية بثقة! شروحات مبسطة وتمارين تساعدك تبني أساس قوي في كل المواد.',
  ),

  StagesModel(
    imagePath: "assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.lightbulb,
    title: "الصف الثاني الإعدادي",
    description:
        'طور مستواك خطوة بخطوة مع دروس تفاعلية تشرح لك الفكرة بطريقة سهلة وواضحة.',
  ),

  StagesModel(
    imagePath: "assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.award,
    title: "الصف الثالث الإعدادي",
    description:
        'استعد للشهادة الإعدادية مع مراجعات مركزة، تدريبات تطبيقية، وأدوات تساعدك تحقق أعلى الدرجات.',
  ),

  // ----------------------- المرحلة الثانوية -----------------------
  StagesModel(
    imagePath: "assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.chalkboardTeacher,
    title: "الصف الأول الثانوي",
    description:
        'ابدأ الثانوية بأسلوب تعليم ذكي يعتمد على الفهم العميق وتطبيق الأفكار بسهولة.',
  ),

  StagesModel(
    imagePath: "assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.pencilRuler,
    title: "الصف الثاني الثانوي",
    description:
        'طور مهاراتك التعليمية مع شروحات متقدمة، تدريبات، ونظام يقيس مستواك بدقة.',
  ),
];
