import 'package:amr_rezk_education/core/intialization/init_di.dart';
import 'package:amr_rezk_education/core/sharedWidgets/app_snack_bar.dart';
import 'package:amr_rezk_education/core/sharedWidgets/main_wrapper.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/domain/use_cases/add_lecture_use_case.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/widgets/singlLecture/add_lecture.dart';
import 'package:amr_rezk_education/features/homePage/presentation/widgets/educationStages/stages_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/sharedWidgets/cust_admin_field.dart';
import '../../../../../../core/utils/custom_admin_buttons.dart';
import '../../../data/models/lecture_model.dart';
import '../../bloc/add_lecture_events.dart';
import '../../bloc/add_lecture_status.dart';
import '../../bloc/add_lectures_bloc.dart';

class AddLectureScreen extends StatefulWidget {
  AddLectureScreen({super.key, required this.isPlayList});

  final bool isPlayList;

  @override
  State<AddLectureScreen> createState() => _AddLectureScreenState();
}

class _AddLectureScreenState extends State<AddLectureScreen> {
  final addLectureItemKey = GlobalKey<AddLectureScreenState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController urlCtrl = TextEditingController();
  final TextEditingController codeCtrl = TextEditingController();

  void clearForm(BuildContext context) {
    addLectureItemKey.currentState?.formKey.currentState
        ?.reset(); //.currentState?.reset();
    nameCtrl.clear();
    descCtrl.clear();
    urlCtrl.clear();
    codeCtrl.clear();

    context.read<AddLectureBloc>().add(
      ChooseSectionEvent('المرحلة الدراسية', -1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          AddLectureBloc(addLectureUseCase: getIt<AddLectureUseCase>()),
      child: BlocConsumer<AddLectureBloc, AddLectureState>(
        listener: (context, state) {
          if (state is AddLectureLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Dialog(
                backgroundColor: Colors.transparent,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          if (state is AddLectureSuccess) {
            Navigator.pop(context);
            clearForm(context); // تغلق اللودينج
            AppSnackBar.showSuccess(context, "تم حفظ المحاضرة بنجاح");
          } else if (state is AddLectureFailure) {
            Navigator.pop(context); // تغلق اللودينج
            AppSnackBar.showError(context, state.error);
          }
        },
        builder: (context, state) {
          final bool isButtonEnabled = state.isValid;

          return MainWrapper(
            childWidget: Stack(
              children: [
                AddLectureScreenItem(
                  choose_stage: (compoundName, index) {
                    context.read<AddLectureBloc>().add(
                      ChooseSectionEvent(compoundName, index),
                    );
                  },
                  isValid: isButtonEnabled,
                  context: (lecture) {
                    context.read<AddLectureBloc>().add(
                      AddLecturePressed(lecture),
                    );
                  },
                  urlCtrl: urlCtrl,
                  stage: context.read<AddLectureBloc>().currentStage.toString(),
                  codeCtrl: codeCtrl,
                  descCtrl: descCtrl,
                  nameCtrl: nameCtrl,
                  onFormChanged: () {
                    context.read<AddLectureBloc>().add(
                      AddLectureFormChanged(
                        name: nameCtrl.text,
                        description: descCtrl.text,
                        videoUrl: urlCtrl.text,
                        stage: context.read<AddLectureBloc>().currentStage,
                      ),
                    );
                  },
                  key: addLectureItemKey,

                  isPlayList: widget.isPlayList,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
