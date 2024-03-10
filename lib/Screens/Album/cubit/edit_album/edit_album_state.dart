part of 'edit_album_cubit.dart';

@immutable
sealed class EditAlbumState {
  const EditAlbumState();
}

final class EditAlbumInitial extends EditAlbumState {
  const EditAlbumInitial();
}

final class EditAlbumLoading extends EditAlbumState {
  const EditAlbumLoading();
}

final class EditAlbumFinish extends EditAlbumState {
  const EditAlbumFinish();
}
