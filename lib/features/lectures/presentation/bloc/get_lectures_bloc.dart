import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard/addLecture/data/models/lecture_model.dart';
import '../../data/models/play_list_model.dart';
import '../../domain/use_cases/get_all_play_lists.dart';
import '../../domain/use_cases/get_lectures_use_case.dart';
import 'get_lectures_events.dart';
import 'get_lectures_states.dart';

class GetLecturesBloc extends Bloc<GetLecturesEvent, GetLecturesState> {
  final GetLecturesUseCase useCase;
  final GetPlaylistsUseCase getPlaylistsUseCase;
  int selectedIndex = 0;
  static List<LectureModel>? cachedLectures;
  static List<PlaylistModel>? cachedPlaylists;
  static GetLecturesBloc? _instance;

  bool isLoadedLecturesBefore = false;
  bool isLoadedPlayListBefore = false;

  factory GetLecturesBloc(
    GetLecturesUseCase useCase,
    GetPlaylistsUseCase getPlaylistsUseCase,
  ) {
    _instance ??= GetLecturesBloc._internal(useCase, getPlaylistsUseCase);
    return _instance!;
  }

  GetLecturesBloc._internal(this.useCase, this.getPlaylistsUseCase)
    : super(GetLecturesInitial()) {
    on<LoadLecturesEvent>((event, emit) async {
      if (isLoadedLecturesBefore && cachedLectures != null) {
        emit(GetLecturesLoaded(cachedLectures!));
        return;
      }

      emit(GetLecturesLoading());

      final result = await useCase();
      if (result.isSuccess) {
        cachedLectures = result.data!;
        isLoadedLecturesBefore = true;
        emit(GetLecturesLoaded(result.data!));
      } else {
        emit(GetLecturesError(result.error ?? "Unknown Error"));
      }
    });

    on<GetPlaylistsEvent>(_loadPlaylists);
    on<GetLecturesOnPlaylistsEvent>(_load_lectures_on_playlist);
    on<ChangeTapEvent>(_changeTapIndex);
  }

  Future<void> _changeTapIndex(
    ChangeTapEvent event,
    Emitter<GetLecturesState> emit,
  ) async {
    selectedIndex = event.index;
    if (selectedIndex == 1 && !isLoadedPlayListBefore) {
      add(GetPlaylistsEvent());
    }
    if (selectedIndex == 0 && !isLoadedPlayListBefore) {
      add(LoadLecturesEvent());
    }
    emit(
      ChangeTapSuccess(
        index: event.index,
        lectures: cachedLectures ?? [],
        playLists: cachedPlaylists ?? [],
      ),
    );
  }


  Future<void> _loadPlaylists(
    GetPlaylistsEvent event,
    Emitter<GetLecturesState> emit,
  ) async {
    if (isLoadedPlayListBefore && cachedPlaylists != null) {
      emit(PlaylistLoaded(cachedPlaylists!));
      return;
    }

    emit(PlaylistLoading());

    final result = await getPlaylistsUseCase.get_play_list_call();

    if (result.isSuccess) {
      cachedPlaylists = result.data;
      isLoadedPlayListBefore = true;

      print(cachedPlaylists?.length);
      print("object");
      emit(PlaylistLoaded(result.data));
    } else {
      emit(PlaylistError(result.error ?? "Error while loading playlists"));
    }
  }


  Future<void> _load_lectures_on_playlist(
    GetLecturesOnPlaylistsEvent event,
    Emitter<GetLecturesState> emit,
  ) async {
    emit(LectureOnPlaylistLoading());

    final result = await getPlaylistsUseCase.get_lectures_on_play_list_call(
      event.id,
    );

    if (result.isSuccess) {
      emit(LectureOnPlaylistLoaded(result.data));
    } else {
      emit(PlaylistError(result.error ?? "Error while loading playlists"));
    }
  }

  static void disposeInstance() {
    _instance?.close();
    cachedLectures = null;
    _instance = null;
  }
}
