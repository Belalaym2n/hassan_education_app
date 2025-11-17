import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/core/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureModel {
  final String imagePath;     // مسار الصورة (من assets أو network)
   final String description;   // وصف تفصيلي للميزة
   final String tittle;   // وصف تفصيلي للميزة
   final IconData icon;   // وصف تفصيلي للميزة

  FeatureModel({
    required this.imagePath,
     required this.description,
     required this.tittle,
     required this.icon,
  });
}
List<FeatureModel> featuresList = [


  FeatureModel(
    imagePath: AppImages.feature1,
    icon: Icons.lightbulb_outline,
    tittle: "شرح مبسّط ومفهوم",
    description: 'أسلوب شرح واضح، بعيد عن التعقيد، يخلي حتى أصعب الدروس سهلة وسلسة.',
  ),



  FeatureModel(
    imagePath: AppImages.feature2,
    icon: Icons.person,
    tittle: "دروس أونلاين بجودة عالية",
    description: 'دروس تفاعلية مباشرة بجودة صوت وصورة ممتازة، تديك إحساس إنك في الفصل وأكتر.',
  ),
  FeatureModel(
    imagePath: AppImages.feature3,
    icon: Icons.quiz_outlined,
    tittle: "تدريبات وامتحانات شاملة",
    description: 'تدريبات متنوعة واختبارات تساعد الطالب يثبت المعلومة ويستعد لأي امتحان.',
  ),
  FeatureModel(
    imagePath: AppImages.feature4,
    icon: Icons.people_alt_outlined,
    tittle: "متابعة فردية لكل طالب",
    description: 'بنتابع مستوى كل طالب بشكل مستمر، ونوجّه الملاحظات والدعم حسب احتياجه',
  ),
];
