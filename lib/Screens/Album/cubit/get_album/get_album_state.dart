part of 'get_album_cubit.dart';

@immutable
sealed class GetAlbumState {
  const GetAlbumState();
}

final class GetAlbumInitial extends GetAlbumState {
  const GetAlbumInitial();
}

final class GetAlbumLoading extends GetAlbumState {
  const GetAlbumLoading();
}

final class GetAlbumLoadingNew extends GetAlbumState {
  const GetAlbumLoadingNew();
}

final class GetAlbumLoaded extends GetAlbumState {
  final List<AlbumList> album;

  GetAlbumLoaded(this.album);
}
