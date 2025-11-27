import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';

class LectureNameItem extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final bool isExpanded;

  const LectureNameItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.isExpanded,
  });

  @override
  State<LectureNameItem> createState() => _LectureNameItemState();
}

class _LectureNameItemState extends State<LectureNameItem> {
  bool isUnlocked = false;
  bool isExpanded = false;
  final TextEditingController promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
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
      child: Column(
        children: [
          // رأس المحاضرة
          _buildLectureHeader(),

          // التفاصيل (الوصف + الوقت + كود الخصم)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _buildLectureDetails(),
            crossFadeState:
            isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildLectureHeader() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.04),
      title: Text(
        widget.title,
        textAlign: TextAlign.end,
        style: TextStyle(
          color: const Color(0xFF333C45),
          fontWeight: FontWeight.bold,
          fontSize: AppConstants.w * 0.045,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isUnlocked ? Icons.check_circle_outline : Icons.lock_outline,
            color: isUnlocked ? Colors.green : Colors.grey[500],
          ),
          SizedBox(width: AppConstants.w * 0.02),
          GestureDetector(
            onTap: () {
              setState(() => isExpanded = !isExpanded);
            },
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 250),
              turns: isExpanded ? 0.5 : 0,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryColor,
                size: AppConstants.w * 0.08,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLectureDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.05,
        vertical: AppConstants.h * 0.018,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentColor.withOpacity(0.12),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppConstants.w * 0.04),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget.description,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: AppConstants.w * 0.036,
              color: Colors.grey[800],
              height: 1.6,
            ),
          ),
          SizedBox(height: AppConstants.h * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.timer_outlined, size: 18, color: Colors.black54),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  widget.time,

                  style: TextStyle(
                    overflow: TextOverflow.ellipsis ,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.h * 0.018),

          // ✅ كود الخصم لكل محاضرة
          if (!isUnlocked) _buildPromoCodeField(),

          if (isUnlocked)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم فتح ${widget.title}"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                label: const Text(
                  "ابدأ الدرس",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.w * 0.03),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPromoCodeField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: promoController,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              hintText: "ادخل كود المحاضرة هنا",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.w * 0.03),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: AppConstants.w * 0.03),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.w * 0.045,
              vertical: AppConstants.h * 0.012,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.w * 0.03),
            ),
          ),
          onPressed: () {
            // ✅ تحقق من الكود الصحيح لكل محاضرة
            String correctCode = _getCorrectCodeForLecture(widget.title);

            if (promoController.text.trim() == correctCode) {
              setState(() => isUnlocked = true);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("تم تفعيل الكود لمحاضرة ${widget.title} ✅"),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("الكود غير صحيح ❌"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: const Text("تفعيل", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  String _getCorrectCodeForLecture(String title) {
    if (title.contains("الأول")) return "MATH1";
    if (title.contains("الثاني")) return "MATH2";
    if (title.contains("الثالث")) return "MATH3";
    if (title.contains("الرابع")) return "MATH4";
    return "MATH"; // default fallback
  }
}
