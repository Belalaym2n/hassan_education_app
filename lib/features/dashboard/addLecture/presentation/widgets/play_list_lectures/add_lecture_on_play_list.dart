import 'package:amr_rezk_education/core/utils/app_validator.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/sharedWidgets/buttons.dart';
import '../../../../../../core/sharedWidgets/custom_form_field.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';
import '../../bloc/playListBloc/play_list_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/lecture_model.dart';

class AddLectureScreenOnPlayList extends StatefulWidget {
  final bool isPlayList;

  const AddLectureScreenOnPlayList({super.key, required this.isPlayList});

  @override
  State<AddLectureScreenOnPlayList> createState() => _AddLectureScreenState();
}

class _AddLectureScreenState extends State<AddLectureScreenOnPlayList> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _url = TextEditingController();
  final _time = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Add Lecture"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              admin_field(
                "Lecture Name",
                _name,
                validator: Validators.requiredField,
              ),
              const SizedBox(height: 16),
              admin_field(
                "Description",
                _desc,
                maxLines: 3,
                validator: Validators.requiredField,
              ),
              const SizedBox(height: 16),
              admin_field("Video URL", _url, validator: Validators.validUrl),
              const SizedBox(height: 16),
              admin_field("Duration", _time, validator: Validators.requiredField),
              const SizedBox(height: 30),
              _saveBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _saveBtn(BuildContext context) {
    return SizedBox(
      width: AppConstants.w * 0.7,
      child: large_button(
        isDesktop: true,
        buttonName: "Save Lecture",
        isDisable: false,
        onPressed: () {
      if (_formKey.currentState!.validate()&& context.read<PlaylistBloc>().currentStage!='المرحلة الدراسية'
      ) {
        final lecture = LectureModel(
          id: DateTime.now().millisecondsSinceEpoch
              .toString() ,
          name: _name.text.trim(),
          description: _desc.text.trim(),
          videoUrl: _url.text.trim(),
          duration: _time.text.trim().toString(),
          stage: context
              .read<PlaylistBloc>()
              .currentStage,
          isPlayList: widget.isPlayList,
        );

        context.read<PlaylistBloc>().add(AddLocalLectureEvent(lecture));

        Navigator.pop(context, true);
      }},
      ),
    );
  }
}
