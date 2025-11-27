import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/pages/playList/add_play_list.dart';
import 'package:amr_rezk_education/features/dashboard/addLecture/presentation/widgets/singlLecture/add_lecture.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
 import '../../pages/singleLecture/add_lecture_screen.dart';
import 'optional_card.dart';

class LecturesTypeQuestion extends StatelessWidget {
  const LecturesTypeQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ماذا تريد أن تنشئ؟',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionCard(
                      icon: Icons.play_circle_fill,
                      title: 'إنشاء محاضرة منفردة',
                      subtitle: 'إضافة محاضرة واحدة مع جميع التفاصيل',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>
                            AddLectureScreen(
                          isPlayList: false,
                        )),
                      ),
                    ),

                    const SizedBox(width: 20),

                    OptionCard(
                      icon: Icons.queue_music,
                      title: 'إنشاء Playlist شهرية',
                      subtitle: 'قائمة محاضرات لشهر كامل',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) =>
                        const AddPlaylistScreen()),
                      ),                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
