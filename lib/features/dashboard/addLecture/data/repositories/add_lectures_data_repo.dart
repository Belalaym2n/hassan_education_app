
import 'package:amr_rezk_education/features/dashboard/addLecture/data/data_sources/remote/add_lecture_ds.dart';

import '../../../../../core/handleErrors/result_pattern.dart';
import '../../domain/repositories/add_lecture_domain_repo.dart';
import '../models/lecture_model.dart';

class AddLectureDataRepo implements AddLectureDomainRepo {
  final AddSingleLectureDS   addLectureDS;
  AddLectureDataRepo(this.addLectureDS);

  @override
  Future<Result> addLecture({required LectureModel lecture}) {
    return addLectureDS.addLecture(lecture);
  }
}
