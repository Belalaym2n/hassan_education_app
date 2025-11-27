abstract class GetLecturesEvent {}

class LoadLecturesEvent extends GetLecturesEvent {}

abstract class PlaylistEvent {}

class GetPlaylistsEvent extends GetLecturesEvent {}

class GetLecturesOnPlaylistsEvent extends GetLecturesEvent {
  String id;

  GetLecturesOnPlaylistsEvent(this.id);
}

class ChangeTapEvent extends GetLecturesEvent {
  int index;

  ChangeTapEvent(this.index);
}
