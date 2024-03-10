part of 'add_album_cubit.dart';

@immutable
sealed class AddAlbumState {
  const AddAlbumState();
}

final class AddAlbumInitial extends AddAlbumState {
  const AddAlbumInitial();
}

final class AddAlbumLoading extends AddAlbumState {
  const AddAlbumLoading();
}

final class AddAlbumFinish extends AddAlbumState {
  const AddAlbumFinish();
}
