import 'package:amr_rezk_education/core/sharedWidgets/custom_form_field.dart';
import 'package:amr_rezk_education/core/utils/app_validator.dart';
import 'package:amr_rezk_education/features/lectures/data/models/play_list_model.dart';
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
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();

  Widget _add_play_list() {
    return SizedBox(
      width: AppConstants.w * 0.7,
      child: large_admin_button(
        text: "إدارة المحاضرات",
        onTap: () {
          if (_formKey.currentState!.validate() &&
              context.read<PlaylistBloc>().currentStage != 'المرحلة الدراسية') {
            PlaylistModel model = PlaylistModel(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              name: _nameCtrl.text,
              price: _priceCtrl.text,
              playListFirstVideo: "I WILL SET LINK ON DS REMOTE IMPL",
              description: _descCtrl.text,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<PlaylistBloc>(),
                  child: PlaylistScreen(playlistModel: model),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _play_list_name(),
          const SizedBox(height: 20),

          _play_list_description(),
          const SizedBox(height: 20),

          _play_list_pricing(),
          const SizedBox(height: 20),

          _select_satege(),
          const SizedBox(height: 30),
          _add_play_list(),
        ],
      ),
    );
  }

  Widget _play_list_name() {
    return SizedBox(
      width: AppConstants.w * 0.95,
      child: admin_field(
        "اسم الـ Playlist",
        _nameCtrl,
        maxLines: 1,

        validator: Validators.requiredField,
      ),
    );
  }

  Widget _play_list_description() {
    return SizedBox(
      width: AppConstants.w * 0.95,
      child: admin_field(
        "وصف الـ Playlist",
        _descCtrl,
        maxLines: 3,

        validator: Validators.requiredField,
      ),
    );
  }

  Widget _play_list_pricing() {
    return SizedBox(
      width: AppConstants.w * 0.95,
      child: admin_field(
        textInput: TextInputType.number,

        "سعر الـ Playlist",
        _priceCtrl,
        maxLines: 1,

        validator: Validators.numberField,
      ),
    );
  }

  Widget _select_satege() {
    return SizedBox(
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
    );
  }
}
