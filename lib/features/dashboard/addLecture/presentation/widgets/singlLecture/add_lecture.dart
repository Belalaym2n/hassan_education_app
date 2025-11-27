import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/bloc/lectureBloc/add_lecture_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/sharedWidgets/buttons.dart';
import '../../../../../../core/sharedWidgets/custom_form_field.dart';
import '../../../../../../core/sharedWidgets/selected_section.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../../../core/sharedWidgets/cust_admin_field.dart';
import '../../../data/models/lecture_model.dart';
import '../../bloc/lectureBloc/add_lecture_status.dart';
import '../../bloc/lectureBloc/add_lectures_bloc.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';

class AddLectureScreenItem extends StatefulWidget {
  AddLectureScreenItem({
    super.key,
    required this.context,
    required this.nameCtrl,
    required this.descCtrl,
    required this.isPlayList,
      required this.urlCtrl,
    required this.pricing,
    required this.duration,
  });

  final TextEditingController nameCtrl;
  final TextEditingController duration;
  final TextEditingController pricing;
   final TextEditingController descCtrl;

  final TextEditingController urlCtrl;

  Function(LectureModel lecture) context;

  bool isPlayList = false;

  @override
  State<AddLectureScreenItem> createState() => AddLectureScreenState();
}

class AddLectureScreenState extends State<AddLectureScreenItem> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _onSaveLecture() {
    print("saving...");

    if (!formKey.currentState!.validate() ||
        context.read<AddLectureBloc>().currentStage == 'المرحلة الدراسية') {
      print("validation failed");
      return;
    }

    print("validation passed");

    final lecture = LectureModel(
      price: widget.pricing.text,
      duration: widget.duration.text,
      id: 'we will add on ds remote impl',
      name: widget.nameCtrl.text.trim(),
      description: widget.descCtrl.text.trim(),
      videoUrl: widget.urlCtrl.text.trim(),
      stage:         context.watch<AddLectureBloc>().currentStage,

      isPlayList: widget.isPlayList,
    );

    widget.context(lecture);
  }

  @override
  void dispose() {
    widget.nameCtrl.dispose();
    widget.descCtrl.dispose();
    widget.urlCtrl.dispose();
    widget.pricing.dispose();
    widget.duration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _build_app_bar(),

      body: _build_screen_content(),
    );
  }

  _build_screen_content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child:   Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    admin_field(
                      'اسم المحاضرة',
                      widget.nameCtrl,
                      validator: Validators.requiredField,
                    ),

                    SizedBox(height: AppConstants.h * 0.04),

                    admin_field(
                      'الوصف',
                      widget.descCtrl,
                      validator: Validators.requiredField,
                      maxLines: 3,
                    ),

                    SizedBox(height: AppConstants.h * 0.04),
                    admin_field(
                      textInput: TextInputType.number,

                      "سعر الـمحاضرة ",
                      widget.pricing,
                      maxLines: 1,

                      validator: Validators.numberField,
                    ),
                    SizedBox(height: AppConstants.h * 0.04),
                    admin_field(
                      textInput: TextInputType.number,

                      "المدة",
                      widget.duration,
                      maxLines: 1,

                      validator: Validators.numberField,
                    ),
                    SizedBox(height: AppConstants.h * 0.04),

                    admin_field(
                      'رابط الفيديو',
                      widget.urlCtrl,

                      validator: Validators.youtubeUrl,
                    ),

                    SizedBox(height: AppConstants.h * 0.04),

                SelectedSection(
            isDesktop: true,
            items: StaticList.sections,

            index: context.watch<AddLectureBloc>().index,
            itemName: context.watch<AddLectureBloc>().currentStage,
            selectItem: (compoundName, index) {
            context.read<AddLectureBloc>().add(
              ChooseSectionEvent(compoundName, index),
            );
              }),


                    SizedBox(height: AppConstants.h * 0.05),
                    large_button(
                      isDesktop: true,
                      buttonName: 'حفظ المحاضرة',
                      isDisable: false,
                      onPressed: () => _onSaveLecture(),
                    ),
                  ],
                ),
              ),


    )));
  }

  AppBar _build_app_bar() {
    return AppBar(
      title: const Text(
        'إضافة محاضرة جديدة',
        style: TextStyle(color: AppColors.textPrimary),
      ),
      backgroundColor: AppColors.cardColor,
      elevation: 0,
    );
  }
}
