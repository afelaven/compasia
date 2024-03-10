import 'package:bloc/bloc.dart';
import 'package:compasia/Screens/Album/album.dart';
import 'package:meta/meta.dart';

part 'get_album_state.dart';

class GetAlbumCubit extends Cubit<GetAlbumState> {
  GetAlbumCubit() : super(GetAlbumInitial());

  Future<void> getAlbum(int page) async {
    print('calling get album');
    emit(GetAlbumLoading());

    await Future.delayed(Duration(seconds: 2));

    List<AlbumList> albumListRepo = await AlbumRepo.getAlbum();

    List<AlbumList> albumListLimit =
        albumListRepo.sublist((page * 10) - 10, page * 10);

    // albumList.addAll(albumListRepo);

    emit(GetAlbumLoaded(albumListLimit));
  }

  Future<void> deleteAlbum(String id) async {
    emit(GetAlbumLoading());
    await Future.delayed(Duration(seconds: 2));
    await AlbumRepo.deleteAlbum(id);
    getAlbum(0);
  }
}
