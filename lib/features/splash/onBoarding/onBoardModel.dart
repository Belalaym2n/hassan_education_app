import 'package:amr_rezk_education/core/utils/app_images.dart';

class OnBoardModel {
  final String headline;     // العنوان الكبير
  final String description;  // الوصف التفصيلي
  final String imagePath;

  OnBoardModel({
    required this.headline,
    required this.description,
    required this.imagePath,
  });
}

// قائمة الشاشات (Onboarding Screens)
final List<OnBoardModel> onBoardList = [
  OnBoardModel(
    headline: "محاضراتك في مكان واحد!",
    description: "تابع كل محاضراتك بسهولة، نظّم دراستك، وشاهد محتواك التعليمي بطريقة ممتعة وتفاعلية تساعدك على الفهم والتركيز أكثر.",
    imagePath: AppImages.onBoardImage,
  ),

  OnBoardModel(
    headline: "اختبر نفسك بعد كل محاضرة!",
    description: "بعد كل محاضرة يوجد اختبار قصير يساعدك على مراجعة ما تعلمته، بالإضافة إلى اختبارات أخرى لتقييم مستواك وتعزيز فهمك خطوة بخطوة.",
    imagePath: AppImages.onBoardImage2,
  ),

];
