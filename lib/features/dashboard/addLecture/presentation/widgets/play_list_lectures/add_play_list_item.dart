import 'package:amr_rezk_education/core/sharedWidgets/custom_form_field.dart';
import 'package:amr_rezk_education/core/utils/app_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/sharedWidgets/selected_section.dart';
import '../../../../../../core/utils/app_constants.dart';
import '../../../../../../core/sharedWidgets/cust_admin_field.dart';
import '../../../../../../core/utils/custom_admin_buttons.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';
import '../../bloc/playListBloc/play_list_events.dart';
import '../../pages/playList/play_list_lectures_screen.dart';

class AddPlayListItem extends StatefulWidget {
  const AddPlayListItem({super.key});

  @override
  State<AddPlayListItem> createState() => _AddPlayListItemState();
}

class _AddPlayListItemState extends State<AddPlayListItem> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: AppConstants.w * 0.95,
            child: admin_field(
              "اسم الـ Playlist",
              _nameCtrl,
              maxLines: 1,

              validator: Validators.requiredField,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: AppConstants.w * 0.95,
            child: SelectedSection(
              isDesktop: true,
              items: StaticList.sections,

              index: context.watch<PlaylistBloc>().index,
              itemName: context.watch<PlaylistBloc>().currentStage,
              selectItem: (compoundName, index) {
                context.read<PlaylistBloc>().add(
                  ChooseStageEvent(compoundName, index),
                );
              },
            ),
          ),

          const SizedBox(height: 30),
          SizedBox(
            width: AppConstants.w * 0.7,
            child: large_admin_button(

              text: "إدارة المحاضرات",
              onTap: () {
                if (_formKey.currentState!.validate()&& context.read<PlaylistBloc>().currentStage!='المرحلة الدراسية'
                ) {
                  print(context.read<PlaylistBloc>().currentStage);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<PlaylistBloc>(),
                        child: PlaylistScreen(playlistId: DateTime.now().millisecondsSinceEpoch
                            .toString()),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
