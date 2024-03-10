import 'package:bloc/bloc.dart';
import 'package:compasia/Screens/Album/album.dart';
import 'package:meta/meta.dart';

part 'edit_album_state.dart';

class EditAlbumCubit extends Cubit<EditAlbumState> {
  EditAlbumCubit() : super(EditAlbumInitial());

  Future<void> editAlbum(String title, String id) async {
    emit(EditAlbumLoading());
    await Future.delayed(Duration(seconds: 2));

    await AlbumRepo.editAlbum(title, id);
    emit(EditAlbumFinish());
  }
}
