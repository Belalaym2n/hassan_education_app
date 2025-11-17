import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/utils/app_images.dart';

// ✅ نموذج المراحل الدراسية
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
  // StagesModel(
  //   imagePath:"assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
  //   icon: FontAwesomeIcons.bookOpen,
  //   title: "الصف الثالث الإعدادي",
  //   description:
  //   'استعد لمرحلة الثانوية بأسلوب شرح مبسط ومراجعات دقيقة تغطي كل أجزاء المنهج.',
  // ),
  StagesModel(
    imagePath:"assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.chalkboardTeacher,
    title: "الصف الأول الثانوي",
    description:
    'ابدأ أولى خطوات الثانوية بتجربة تعليمية ذكية تعتمد على الفهم وليس الحفظ.',
  ),
  StagesModel(
    imagePath:"assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.pencilRuler,
    title: "الصف الثاني الثانوي",
    description:
    'طوّر مهاراتك التعليمية من خلال شروحات تفاعلية واختبارات تقيس مستوى تقدمك.',
  ),
  StagesModel(
    imagePath:"assets/images/ChatGPT Image Oct 19, 2025, 03_36_55 PM.png",
    icon: FontAwesomeIcons.graduationCap,
    title: "الصف الثالث الثانوي",
    description:
    'رحلة نحو التفوق! مراجعات مركزة، دعم متواصل، ونصائح لتحقيق حلمك في الثانوية العامة.',
  ),
];
