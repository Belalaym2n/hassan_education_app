import 'package:amr_rezk_education/core/utils/app_constants.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/bloc/add_lecture_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/sharedWidgets/buttons.dart';
import '../../../../../../core/sharedWidgets/selected_section.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_validator.dart';
import '../../../../../../core/sharedWidgets/cust_admin_field.dart';
import '../../../data/models/lecture_model.dart';
import '../../bloc/add_lecture_status.dart';
import '../../bloc/add_lectures_bloc.dart';

class AddLectureScreenItem extends StatefulWidget {
  AddLectureScreenItem({
    super.key,
    required this.onFormChanged,
    required this.context,
    required this.nameCtrl,
    required this.isValid,
    required this.descCtrl,
    required this.codeCtrl,
    required this.isPlayList,
    required this.stage,
    required this.choose_stage,
    required this.urlCtrl,
  });

  final TextEditingController nameCtrl;
  String stage;
  bool isValid;
  final TextEditingController descCtrl;

  final TextEditingController urlCtrl;

  final TextEditingController codeCtrl;
  Function(LectureModel lecture) context;
  Function(String, int) choose_stage;

  bool isPlayList = false;
  Function onFormChanged;

  @override
  State<AddLectureScreenItem> createState() => AddLectureScreenState();
}

class AddLectureScreenState extends State<AddLectureScreenItem> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.nameCtrl.addListener(_onFormChanged);
    widget.descCtrl.addListener(_onFormChanged);
    widget.urlCtrl.addListener(_onFormChanged);
    widget.codeCtrl.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    widget.onFormChanged();
  }

  void _onSaveLecture() {
    print("saving...");

    if (!formKey.currentState!.validate()) {
      print("validation failed");
      return;
    }

    print("validation passed");

    final lecture = LectureModel(
      duration: "12123",
      id: '',
      name: widget.nameCtrl.text.trim(),
      description: widget.descCtrl.text.trim(),
      videoUrl: widget.urlCtrl.text.trim(),
      stage: widget.stage,
      isPlayList: widget.isPlayList,
    );

    widget.context(lecture);
  }

  @override
  void dispose() {
    widget.nameCtrl.dispose();
    widget.descCtrl.dispose();
    widget.urlCtrl.dispose();
    widget.codeCtrl.dispose();
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
      child: BlocBuilder<AddLectureBloc, AddLectureState>(
        builder: (context, state) {
          final bool isButtonEnabled = state.isValid;
          return Card(
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
                    custom_admin_field(
                      widget.nameCtrl,
                      'اسم المحاضرة',
                      validator: Validators.requiredField,
                    ),

                    SizedBox(height: AppConstants.h * 0.04),

                    custom_admin_field(widget.descCtrl, 'الوصف', maxLines: 3),

                    SizedBox(height: AppConstants.h * 0.04),

                    custom_admin_field(
                      widget.urlCtrl,
                      'رابط الفيديو',
                      validator: Validators.youtubeUrl,
                    ),

                    SizedBox(height: AppConstants.h * 0.04),
                    if (!widget.isPlayList)
                      SelectedSection(
                        isDesktop: true,
                        items: StaticList.sections,

                        index: context.watch<AddLectureBloc>().index,
                        itemName: context.watch<AddLectureBloc>().currentStage,
                        selectItem: (compoundName, index) {
                          widget.choose_stage(compoundName, index);

                          print(compoundName);
                        },
                      ),
                    if (widget.isPlayList) ...[
                      SizedBox(height: AppConstants.h * 0.03),
                      custom_admin_field(
                        widget.codeCtrl,
                        'كود البلاي ليست (اختياري)',
                      ),
                    ],
                    SizedBox(height: AppConstants.h * 0.05),
                    large_button(
                      isDesktop: true,
                      buttonName: 'حفظ المحاضرة',
                      isDisable: !widget.isValid,
                      onPressed: isButtonEnabled
                          ? () => _onSaveLecture()
                          : () {
                              print("null");
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
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
