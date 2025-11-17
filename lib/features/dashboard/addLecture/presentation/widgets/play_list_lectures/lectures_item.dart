import 'package:amr_rezk_education/features/dashboard/addLecture/data/models/lecture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_constants.dart';
import '../../bloc/playListBloc/play_list_bloc.dart';
import '../../bloc/playListBloc/play_list_events.dart';

class LecturesOnPlayListItem extends StatefulWidget {
  LecturesOnPlayListItem({super.key, required this.lectures});

  final List<LectureModel> lectures;

  @override
  State<LecturesOnPlayListItem> createState() => _LecturesOnPlayListItemState();
}

class _LecturesOnPlayListItemState extends State<LecturesOnPlayListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.lectures.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.video_library_outlined,
                  size: AppConstants.w * 0.05, color: Colors.grey.shade400),
              SizedBox(height: 16),
              Text(
                "لا توجد محاضرات حتى الآن",
                style: TextStyle(
                  fontSize: AppConstants.w * 0.012,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                "اضغط على زر إضافة لإضافة أول محاضرة.",
                style: TextStyle(
                  fontSize: AppConstants.w * 0.01,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: widget.lectures.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final l = widget.lectures[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: ListTile(
             contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(

              l.name,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: AppConstants.w * 0.015,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              textAlign: TextAlign.right,
              l.description,
              style: TextStyle(
                fontSize: AppConstants.w * 0.01,
                color: Colors.grey.shade700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.play_circle_outline,
                  size: 28, color: Colors.blueGrey.shade400),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red.shade400,
                size: 26,
              ),
              onPressed: () {
                context.read<PlaylistBloc>().add(
                  RemoveLocalLectureEvent(l.id),
                );
              },
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
