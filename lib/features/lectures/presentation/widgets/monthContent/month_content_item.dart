import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import 'lecture_name_item.dart';

class  ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController promoController = TextEditingController();
  bool isPromoValid = false;

   final List<Map<String, String>> lectures = [
    {
      "title": "الدرس الأول: الأعداد الحقيقية",
      "description": "مقدمة في الأعداد الحقيقية وتمارين تطبيقية.",
      "time": "المدة: 35 دقيقة",
    },
    {
      "title": "الدرس الثاني: الدوال والمتغيرات",
      "description": "شرح مفصل للدوال وأنواعها واستخدامها في الرياضيات.",
      "time": "المدة: 42 دقيقة",
    },
    {
      "title": "الدرس الثالث: المعادلات الخطية",
      "description": "كيفية حل المعادلات باستخدام أساليب متعددة.",
      "time": "المدة: 38 دقيقة",
    },
    {
      "title": "الدرس الرابع: الهندسة التحليلية",
      "description": "مراجعة عامة مع تطبيقات واقعية على المفاهيم السابقة.",
      "time": "المدة: 50 دقيقة",
    },
  ];

  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();
    expanded = List.generate(lectures.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return
    // ✅ قائمة المحاضرات
     Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.06,
        vertical: AppConstants.h * 0.02,
    ),
    child:  ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          final lecture = lectures[index];
          final isExpanded = expanded[index];

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(bottom: AppConstants.h * 0.015),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.w * 0.04),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child:LectureNameItem(
              title: lecture['title'].toString(),
              time: lecture['time'].toString(),
              description: lecture['description'].toString(),
               isExpanded: isExpanded,

            )
          );
        },
      ),)

      // 🧾 كود الخصم
    );
  }
}
